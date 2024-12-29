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
        tg_username: str = Form(...),
        klichka: int = Form(...),
        terminal: str = Form(...),
        shift: str = Form(...),
        additional: str = Form(None),
        reason: str = Form(None),
        comment: str = Form(None),
):
    if not worksheet:
        return JSONResponse(content={"message": "Ошибка работы с таблицей"}, status_code=500)

    try:
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
        # Форматирование столбца A как "DATE_TIME"
        current_time = datetime.now(moscow_tz)
        new_row = [
            current_time.strftime("%d.%m.%Y %H:%M"),
            username,
            klichka,
            terminal,
            shift,
            additional,
            reason,
            comment,
        ]

        worksheet.append_row(new_row, value_input_option="USER_ENTERED")
        logger.info(f"Отчет успешно отправлен: {new_row}")

        return JSONResponse(content={"message": "Отчет успешно отправлен!"})
    except Exception as e:
        logger.error(f"Ошибка при отправке отчета: {str(e)}")
        return JSONResponse(content={"message": "Ошибка сервера"}, status_code=500)
