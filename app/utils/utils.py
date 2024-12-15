# app/utils/utils.py

# Стандартные модули Python
import aiohttp

# Сторонние модули
from aiogram.types import Message

# Собственные модули
from app.utils.token_utils import prepare_user_info, generate_token
from app.config import ADD_CHAT_ID_URL


async def check_user_access(message: Message):
    """
    Отправляет запрос к API для проверки доступа.
    :param tg_nickname: Telegram никнейм.
    :param chat_id: Telegram chat_id.
    :return: Ответ от API.
    """
    user_info = prepare_user_info(message)
    token = generate_token(user_info)
    async with aiohttp.ClientSession() as session:
        async with session.post(ADD_CHAT_ID_URL, json={"token": token}) as response:
            if response.status == 403:
                raise Exception(await response.json())
            return await response.json()