# /server/routes/tinkoff.py

# Стандартные модули Python
from server.models import ChatIdsRequest

# Сторонние модули
from fastapi import APIRouter

# Собственные модули
from app.tinkoff.utils import send_daily_expenses_miniapp


router = APIRouter()


@router.post("/tinkoff/auto-save_mailing/")
async def send_bulk_messages(request: ChatIdsRequest):
    """
    Рассылка сообщений с токенизированным URL для пользователей.
    """
    chat_ids = request.chat_ids
    results = []
    for chat_id in chat_ids:
        results.append(await send_daily_expenses_miniapp(chat_id))

    return {"results": results}

