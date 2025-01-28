# app/utils/utils.py

# Стандартные модули Python
import aiohttp

# Сторонние модули
from aiogram.types import Message

# Собственные модули
from app.utils.token_utils import prepare_user_info, generate_token
from app.config import ADD_CHAT_ID_URL, BASE_URL, WEB_APP_URL

from aiogram.types import KeyboardButton, ReplyKeyboardMarkup, WebAppInfo


async def check_user_access(message: Message):
    """
    Отправляет запрос к API для проверки доступа.
    """
    try:
        # Отправка запроса к API для проверки наличия пользователя в бд
        user_info = prepare_user_info(message)
        token = generate_token(user_info)
        async with aiohttp.ClientSession() as session:
            async with session.post(ADD_CHAT_ID_URL, json={"token": token}) as response:
                if response.status == 403:
                    raise Exception(await response.json())
                return await response.json()
    except Exception as e:
        # Если возникла ошибка, отправляем сообщение об ошибке пользователю
        error_detail = getattr(e, 'args', ["Ошибка без деталей"])[0]
        if isinstance(error_detail, dict) and "detail" in error_detail:
            error_message = error_detail["detail"]
        else:
            error_message = str(error_detail)

        await message.answer(f"Ошибка: {error_message}")
        return

async def air_balon_and_swings(message: Message):
    # Извлекаем username из объекта message
    tg_username = message.from_user.username
    chat_id = message.chat.id

    # Создаем ссылку с параметром username
    swing_url = f"{WEB_APP_URL}bot_swing?username={tg_username}"
    air_ballon_url = f"{WEB_APP_URL}bot_air_balon?username={tg_username}"
    flight_url = f"{WEB_APP_URL}flight?user_id={chat_id}"

    # Создаем клавиатуру с кнопками в одну линию
    keyboard = ReplyKeyboardMarkup(
        keyboard=[
            [
                KeyboardButton(
                    text="Качели",
                    web_app=WebAppInfo(url=swing_url)
                ),
                KeyboardButton(
                    text="Воздушный шар",
                    web_app=WebAppInfo(url=air_ballon_url)
                ),
                KeyboardButton(
                    text="Доходы",
                    web_app=WebAppInfo(url=flight_url)
                )
            ]
        ],
        resize_keyboard=True
    )

    # Отправляем сообщение с кнопками в клавиатуре
    await message.answer(
        text="Внесите доход",
        reply_markup=keyboard
    )
