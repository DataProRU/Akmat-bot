from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse, JSONResponse
from database import Session
from models import AirBalonWeather
from typing import Optional
from pytz import timezone
from datetime import datetime, timedelta
import gspread
from babel.dates import format_date


router = APIRouter()
templates = Jinja2Templates(directory="templates")
moscow_tz = timezone('Europe/Moscow')


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()

try:
    gc = gspread.service_account(filename="credentials.json")
    sht2 = gc.open_by_url(
        'https://docs.google.com/spreadsheets/d/1K5rBDV7QEHH1iROffqmuUxFvNn8kTbHe6DZ54MyPIqE/edit?gid=0#gid=0'
    )
    worksheet = sht2.get_worksheet(0)
except Exception as e:
    print(f"Ошибка при инициализации gspread: {str(e)}")


@router.get("/bot_air_balon", response_class=HTMLResponse)
async def directory(
    request: Request,
username: str,
    db: Session = Depends(get_db),
):

    weathers = db.query(AirBalonWeather).all()
    return templates.TemplateResponse(
        "air_balon.html",
        {"request": request, "weathers": weathers, "username": username},
    )


@router.post("/submit_balloon")
async def submit_balloon(
        username: str = Form(""),
        nalchik_tethered_flight: str = Form(""),
        terminal_tethered_flight: str = Form(""),
        nalchik_free_flight: str = Form(""),
        terminal_free_flight: str = Form(""),
        weather: str = Form(""),
        comment: Optional[str] = Form(None)
):
    if not worksheet:
        return JSONResponse(content={"message": "Ошибка работы с таблицей"}, status_code=500)

    try:
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
            nalchik_tethered_flight,
            terminal_tethered_flight,
            nalchik_free_flight,
            terminal_free_flight,
            weather,
            "",
            comment,
        ]

        # Добавить новую строку с данными отчета
        worksheet.append_row(new_row, value_input_option="USER_ENTERED")

        return JSONResponse(content={"message": "Отчет успешно отправлен!"})

    except Exception as e:
        return JSONResponse(content={"message": "Ошибка сервера"}, status_code=500)

    return JSONResponse(content={"message": "Данные успешно отправлены"})
