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
        # Объединение массива в строку, если shift является списком
        if isinstance(shift, list):
            shift = ', '.join(shift)

        worksheet.format('A:A', {
            "numberFormat": {
                "type": "DATE_TIME",
                "pattern": "dd.mm.yyyy hh:mm"
            }
        })

        worksheet.format('C:C', {
            "numberFormat": {
                "type": "NUMBER"
            }
        })

        current_time = datetime.now(moscow_tz)
        new_date = current_time.strftime("%d.%m.%Y")
        new_row = [
            current_time.strftime("%d.%m.%Y %H:%M"),
            username,
            klichka,
            terminal,
            shift,
            additional,
            reason,
            checksCount,
            comment,
        ]

        # Получение всех данных из таблицы
        all_values = worksheet.get_all_values()
        if all_values:  # Если таблица не пустая
            last_row = all_values[-1]  # Последняя строка таблицы

            # Проверяем, чтобы значение даты не содержало текст
            try:
                last_date = last_row[0].split(" ")[0]  # Извлекаем дату последней записи
                last_date_obj = datetime.strptime(last_date, "%d.%m.%Y")  # Пробуем преобразовать в объект даты
            except ValueError:
                last_date_obj = None  # Если преобразование не удалось, пропускаем обработку даты

            if last_date_obj:  # Если дата успешно преобразована
                # Преобразуем даты в объекты datetime и получаем месяцы
                last_month = format_date(last_date_obj, "MMMM", locale="ru")  # Название месяца на русском
                new_month = format_date(current_time, "MMMM", locale="ru")

                if last_month != new_month:  # Если месяцы отличаются
                    # Добавляем строку с названием нового месяца
                    worksheet.append_row([new_month.capitalize()] + [""] * (len(last_row) - 1),
                                         value_input_option="USER_ENTERED")
                elif last_date < new_date:  # Если даты отличаются (новая больше)
                    # Добавляем строку с новой датой
                    worksheet.append_row([new_date] + [""] * (len(last_row) - 1), value_input_option="USER_ENTERED")

        # Добавление новой строки
        worksheet.append_row(new_row, value_input_option="USER_ENTERED")
        logger.info(f"Отчет успешно отправлен: {new_row}")

        return JSONResponse(content={"message": "Отчет успешно отправлен!"})
    except Exception as e:
        logger.error(f"Ошибка при отправке отчета: {str(e)}")
        return JSONResponse(content={"message": "Ошибка сервера"}, status_code=500)
