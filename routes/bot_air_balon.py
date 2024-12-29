from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse, JSONResponse
from database import Session
from models import AirBalonWeather
from typing import Optional
from pytz import timezone
from datetime import datetime
import gspread

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
    username: str = Form(...),
    nalchik: int = Form(...),
    terminal: str = Form(...),
    free_flight: bool = Form(False),  # Checkbox передает True/False
    nalchik_free_flight: Optional[str] = Form(None),  # Принимаем строку
    terminal_free_flight: Optional[str] = Form(None),  # Принимаем строку
    weather: str = Form(...),
    comment: Optional[str] = Form(None)
):
    worksheet.format('A:A', {
        "numberFormat": {
            "type": "DATE_TIME",
            "pattern": "dd.mm.yyyy hh:mm"
        }
    })
    # Обработка свободных полетов, приведение типов
    nalchik_free_flight = int(nalchik_free_flight) if nalchik_free_flight else None

    if free_flight == False:
        free_flight = "Нет"
    else:
        free_flight = "Да"

    current_time = datetime.now(moscow_tz)
    new_row = [
        current_time.strftime("%d-%m-%Y %H:%M"), username, nalchik, terminal, free_flight, nalchik_free_flight, terminal_free_flight,  weather, comment]
    worksheet.append_row(new_row, value_input_option="USER_ENTERED")

    return JSONResponse(content={"message": "Данные успешно отправлены"})