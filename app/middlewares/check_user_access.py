# middlewares/check_user_access.py

# Сторонние модули
from aiogram import BaseMiddleware
from aiogram.types import Message

# Собственные модули
from app.utils.utils import check_user_access


class CheckUserAccessMiddleware(BaseMiddleware):
    async def __call__(self, handler, event: Message, data: dict):
        api_response = await check_user_access(event)
        if not api_response:
            return
        return await handler(event, data)