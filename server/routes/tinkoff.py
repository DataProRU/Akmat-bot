# /server/routes/tinkoff.py

# Стандартные модули Python
from server.models import ChatIdsRequest, SuccessAutoLoadRequest

# Сторонние модули
from fastapi import APIRouter

# Собственные модули
from app.tinkoff.utils import send_daily_expenses_miniapp, send_auto_save_expenses_error



router = APIRouter()


@router.post("/tinkoff/auto-save_mailing/")
async def auto_save_mailing(request: SuccessAutoLoadRequest):
    """
    Рассылка сообщений с токенизированным URL для пользователей.
    """
    notification_data = request.notification_data
    today_date = request.today_date
    results = []
    for chat_id, message in notification_data.items():
        results.append(await send_daily_expenses_miniapp(chat_id, today_date, message))

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