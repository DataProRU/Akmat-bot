from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse, JSONResponse
from database import Session
from models import SwingShift, SwingReason
from pytz import timezone
import gspread
from datetime import datetime

router = APIRouter()
templates = Jinja2Templates(directory="templates")
moscow_tz = timezone('Europe/Moscow')


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()

# Инициализация gspread
try:
    gc = gspread.service_account(filename="credentials.json")
    sht2 = gc.open_by_url(
        'https://docs.google.com/spreadsheets/d/1tKxNewX91eNOHpYVqDy_EslNV2cSTf8w9lttXRucp6s/edit?gid=0#gid=0'
    )
    worksheet = sht2.get_worksheet(0)
except Exception as e:
    print(f"Ошибка при инициализации gspread: {str(e)}")


@router.get("/bot_swing", response_class=HTMLResponse)
async def directory(
    request: Request,
    db: Session = Depends(get_db),
):

    shifts = db.query(SwingShift).all()
    resons = db.query(SwingReason).all()
    return templates.TemplateResponse(
        "swing.html",
        {"request": request, "shifts": shifts, "reasons": resons},
    )

@router.post("/send_report")
async def send_report(
    username: str = Form(...),
    tg_username: str = Form(...),
    klichka: int = Form(...),
    terminal: str = Form(...),
    shift: str = Form(...),
    additional: str = Form(None),
    reason: str = Form(None),
    comment: str = Form(None)
):
    current_time = datetime.now(moscow_tz)
    new_row = [
        current_time.strftime("%d-%m-%Y %H:%M"), "tg_username", klichka, terminal, shift, additional, reason, comment
    ]

    worksheet.append_row(new_row)

    # Логика обработки данных или сохранения
    return JSONResponse(content={"message": "Отчет успешно отправлен!", "data": data})