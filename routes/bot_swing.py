from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, JSONResponse
from sqlalchemy.orm import Session
from database import Session as DatabaseSession
from models import SwingShift, SwingReason
from pytz import timezone
import gspread
from datetime import datetime
import logging
from typing import List, Union
from babel.dates import format_date
from typing import Optional


# Настройка логгера
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

router = APIRouter()
templates = Jinja2Templates(directory="templates")
moscow_tz = timezone('Europe/Moscow')


def get_db():
    db = DatabaseSession()
    try:
        yield db
    finally:
        db.close()


# Функция для получения worksheet
def init_gspread():
    try:
        gc = gspread.service_account(filename="credentials.json")
        sheet = gc.open_by_url(
            'https://docs.google.com/spreadsheets/d/1tKxNewX91eNOHpYVqDy_EslNV2cSTf8w9lttXRucp6s/edit?gid=0#gid=0'
        )
        return sheet.get_worksheet(0)
    except Exception as e:
        logger.error(f"Ошибка при инициализации gspread: {str(e)}")
        return None


worksheet = init_gspread()


@router.get("/bot_swing", response_class=HTMLResponse)
async def directory(request: Request, username: str, db: Session = Depends(get_db)):
    try:
        shifts = db.query(SwingShift).all()
        reasons = db.query(SwingReason).all()
        return templates.TemplateResponse(
            "swing.html",
            {"request": request, "shifts": shifts, "username": username, "reasons": reasons},
        )
    except Exception as e:
        logger.error(f"Ошибка при загрузке данных: {str(e)}")
        return JSONResponse(content={"message": "Ошибка сервера"}, status_code=500)

@router.post("/send_report")
async def send_report(
        username: str = Form(...),
        klichka: int = Form(...),
        terminal: str = Form(...),
        shift: Union[str, List[str]] = Form(...),
        additional: str = Form(None),
        reason: str = Form(None),
        comment: str = Form(None),
        checksCount: int = Form(...),
):
    if not worksheet:
        return JSONResponse(content={"message": "Ошибка работы с таблицей"}, status_code=500)

    try:
        if isinstance(shift, list):
            shift = ', '.join(shift)

            # Установим формат столбцов
            worksheet.format('C:C', {"numberFormat": {"type": "NUMBER"}})

            current_time = datetime.now(moscow_tz)
            new_date = format_date(current_time, "d MMMM", locale="ru")  # Формат: "5 января"

            # Массив месяцев в именительном падеже
            months_nom = [
                "ЯНВАРЬ", "ФЕВРАЛЬ", "МАРТ", "АПРЕЛЬ", "МАЙ", "ИЮНЬ",
                "ИЮЛЬ", "АВГУСТ", "СЕНТЯБРЬ", "ОКТЯБРЬ", "НОЯБРЬ", "ДЕКАБРЬ"
            ]

            # Формируем строку для месяца и года в именительном падеже
            new_month_year = f"{months_nom[current_time.month - 1]} {current_time.year}"

            # Словарь месяцев на русском языке (для старого кода с родительным падежом)
            months_dict = {
                "января": 1, "февраля": 2, "марта": 3, "апреля": 4, "мая": 5, "июня": 6,
                "июля": 7, "августа": 8, "сентября": 9, "октября": 10, "ноября": 11, "декабря": 12
            }

            # Получить все данные из столбца с датами
            dates_column = worksheet.col_values(1)  # Считать столбец A (с датами)
            if dates_column:
                last_date_str = dates_column[-1]  # Последняя дата

                # Разделяем строку на день и месяц
                day, month = last_date_str.split()  # "5 января" -> day = "5", month = "января"
                month_number = months_dict[month]  # Получаем номер месяца из словаря
                last_date_str_with_year = f"{day} {month_number} {current_time.year}"

                # Преобразуем строку в дату
                last_date = datetime.strptime(last_date_str_with_year, "%d %m %Y")

                # Добавим временную зону к last_date
                last_date = moscow_tz.localize(last_date)  # Преобразуем в aware datetime

                # Если месяц и год последней записи отличаются от текущего
                if last_date.month != current_time.month or last_date.year != current_time.year:
                    # Добавить месяц и год в новую строку
                    worksheet.append_row([new_month_year], value_input_option="USER_ENTERED")
                elif last_date.date() < current_time.date():
                    # Добавить пустую строку с текущей датой, если дата последней записи меньше текущей
                    worksheet.append_row([new_date], value_input_option="USER_ENTERED")

            # Подготовить данные для новой строки
            new_row = [
                new_date,
                username,
                klichka,
                terminal,
                checksCount,
                shift,
                additional,
                reason,
                comment,
            ]

            # Добавить новую строку с данными отчета
            worksheet.append_row(new_row, value_input_option="USER_ENTERED")

            return JSONResponse(content={"message": "Отчет успешно отправлен!"})

    except Exception as e:
        logger.error(f"Ошибка при отправке отчета: {str(e)}")
        return JSONResponse(content={"message": "Ошибка сервера"}, status_code=500)

