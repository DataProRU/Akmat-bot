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
import requests


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
        return sheet.get_worksheet(1)
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



# Настройки Telegram
TELEGRAM_BOT_TOKEN = "8125373869:AAFKywhECD_BqwUgaGvsQUpv_zSZeHiWDqI"
chat_ids = [1129601494, 702856294]  # Список chat_id получателей


@router.post("/send_report")
async def send_report(
        username: str = Form(None),
        klichka: int = Form(None),
        qr: int = Form(None),
        terminal: str = Form(None),
        shift: Union[str, List[str]] = Form(None),
        additional: str = Form(None),
        reason: str = Form(None),
        comment: str = Form(None),
        checksCount: int = Form(None)
):
    global worksheet
    if not worksheet:
        return JSONResponse(content={"message": "Ошибка работы с таблицей"}, status_code=500)

    try:
        if isinstance(shift, list):
            shift = ', '.join(shift)

        worksheet.format('C:C', {"numberFormat": {"type": "NUMBER"}})
        current_time = datetime.now(moscow_tz)
        new_date = format_date(current_time, "d MMMM", locale="ru")

        months_nom = [
            "ЯНВАРЬ", "ФЕВРАЛЬ", "МАРТ", "АПРЕЛЬ", "МАЙ", "ИЮНЬ",
            "ИЮЛЬ", "АВГУСТ", "СЕНТЯБРЬ", "ОКТЯБРЬ", "НОЯБРЬ", "ДЕКАБРЬ"
        ]
        months_dict = {
            "января": 1, "февраля": 2, "марта": 3, "апреля": 4, "мая": 5, "июня": 6,
            "июля": 7, "августа": 8, "сентября": 9, "октября": 10, "ноября": 11, "декабря": 12
        }

        dates_column = worksheet.col_values(1)
        if dates_column:
            last_date_str = dates_column[-1]
            day, month = last_date_str.split()
            month_number = months_dict[month]
            last_date_str_with_year = f"{day} {month_number} {current_time.year}"
            last_date = datetime.strptime(last_date_str_with_year, "%d %m %Y")
            last_date = moscow_tz.localize(last_date)
            if last_date.month != current_time.month or last_date.year != current_time.year:
                next_row = len(worksheet.get_all_values()) + 1
                worksheet.insert_row([f"{months_nom[current_time.month - 1]} {current_time.year}"], index=next_row,
                                     value_input_option="USER_ENTERED")

        if additional == "Работали":
            additional = "＋"
        else:
            additional = "－"

        next_row = len(worksheet.get_all_values()) + 1
        new_row = [
            new_date,
            username,
            klichka,
            qr,
            terminal,
            checksCount,
            shift,
            additional,
            reason,
            comment,
        ]
        worksheet.insert_row(new_row, index=next_row, value_input_option="USER_ENTERED")

        # Отправка сообщения в Telegram
        if additional == "＋":
            message = (
                "ВЫКОГОРНЫЕ КАЧЕЛИ\n"
                f"Отчет за {new_date}\n"
                f"Выручка {int(klichka) + int(terminal) + int(qr)} ₽\n"
                "Из них:\n"
                f"Наличка {klichka} ₽\n"
                f"Безнал {terminal} ₽\n"
                f"QR {qr}\n"
                f"Чеков {checksCount} шт\n"
                f"Работали:\n{shift}"
            )
        elif additional == "－":
            message = (
                "ВЫКОГОРНЫЕ КАЧЕЛИ\n"
                f"Отчет за {new_date}\n"
                "Не работали ❌\n"
                f"Причина:\n{reason}"
            )

        # Отправляем сообщение каждому chat_id из списка
        for chat_id in chat_ids:
            telegram_url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"
            data = {
                "chat_id": chat_id,
                "text": message,
                "parse_mode": "HTML"
            }
            response = requests.post(telegram_url, data=data)
            if response.status_code != 200:
                logger.error(f"Ошибка при отправке сообщения в Telegram (chat_id={chat_id}): {response.text}")

        # Расчет зарплаты сотрудников только если additional == "＋"
        if additional == "＋":
            salary_message = "Зарплата сотрудников:\n"
            total_salary = 0

            # Проверяем, был ли Аслан в смене
            if "Аслан" in shift:
                aslan_salary = 2000
                salary_message += f"Аслан: {aslan_salary} ₽\n"
                total_salary += aslan_salary

            # Проверяем, был ли Ренат в смене
            if "Ренат" in shift:
                # Расчет зарплаты Рената
                renat_salary = (
                        (klichka * 0.9 * 0.9) +  # Наличка - 10% - ещё 10%
                        (qr * 0.89 * 0.9) +  # QR - 11% - ещё 10%
                        (int(terminal) * 0.87 * 0.9) +  # Безнал - 13% - ещё 10%
                        ((checksCount * 450) * 0.9)  # Чеки × 450 - 10%
                )
                salary_message += f"Ренат: {renat_salary:.2f} ₽\n"
                total_salary += renat_salary

            # Добавляем общую сумму зарплат
            salary_message += f"\nОбщая сумма зарплат: {total_salary:.2f} ₽"

            # Отправляем сообщение о зарплатах
            for chat_id in chat_ids:
                data = {
                    "chat_id": chat_id,
                    "text": salary_message,
                    "parse_mode": "HTML"
                }
                response = requests.post(telegram_url, data=data)
                if response.status_code != 200:
                    logger.error(f"Ошибка при отправке сообщения о зарплатах (chat_id={chat_id}): {response.text}")

        return JSONResponse(content={"message": "Отчет успешно отправлен!"})

    except Exception as e:
        logger.error(f"Ошибка при отправке отчета: {str(e)}")
        return JSONResponse(content={"message": "Ошибка сервера"}, status_code=500)