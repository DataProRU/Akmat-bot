# /server/routes/tinkoff.py

# Стандартные модули Python
from server.models import ChatIdsRequest
from fastapi import FastAPI, Form, Request

# Сторонние модули
from fastapi import APIRouter

# Собственные модули
from app.tinkoff.utils import send_daily_expenses_miniapp, send_auto_save_expenses_error
from fastapi.responses import HTMLResponse



router = APIRouter()


@router.post("/tinkoff/auto-save_mailing/")
async def auto_save_mailing(request: ChatIdsRequest):
    """
    Рассылка сообщений с токенизированным URL для пользователей.
    """
    chat_ids = request.chat_ids
    results = []
    for chat_id in chat_ids:
        results.append(await send_daily_expenses_miniapp(chat_id))

    return {"results": results}


@router.post("/tinkoff/auto-save_error_mailing/")
async def auto_save_error_mailing(request: ChatIdsRequest):
    """
    Рассылка сообщений с токенизированным URL для пользователей.
    """
    chat_ids = request.chat_ids
    results = []
    for chat_id in chat_ids:
        results.append(await send_auto_save_expenses_error(chat_id))

    return {"results": results}