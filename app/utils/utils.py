# app/utils/utils.py

# Стандартные модули Python
# import aiohttp

# # Сторонние модули
# from aiogram.types import Message

# # Собственные модули
# from app.utils.token_utils import prepare_user_info, generate_token
# from app.config import ADD_CHAT_ID_URL, BASE_URL, WEB_APP_URL

# from aiogram.types import KeyboardButton, ReplyKeyboardMarkup, WebAppInfo


# async def check_user_access(message: Message):
#     """
#     Отправляет запрос к API для проверки доступа.
#     """
#     try:
#         # Отправка запроса к API для проверки наличия пользователя в бд
#         user_info = prepare_user_info(message)
#         token = generate_token(user_info)
#         async with aiohttp.ClientSession() as session:
#             async with session.post(ADD_CHAT_ID_URL, json={"token": token}) as response:
#                 if response.status == 403:
#                     raise Exception(await response.json())
#                 return await response.json()
#     except Exception as e:
#         # Если возникла ошибка, отправляем сообщение об ошибке пользователю
#         error_detail = getattr(e, 'args', ["Ошибка без деталей"])[0]
#         if isinstance(error_detail, dict) and "detail" in error_detail:
#             error_message = error_detail["detail"]
#         else:
#             error_message = str(error_detail)

#         await message.answer(f"Ошибка: {error_message}")
#         return

# async def air_balon_and_swings(message: Message):
#     # Извлекаем username из объекта message
#     tg_username = message.from_user.username
#     chat_id = message.chat.id

#     # Создаем ссылку с параметром username
#     swing_url = f"{WEB_APP_URL}bot_swing?username={tg_username}"
#     air_ballon_url = f"{WEB_APP_URL}bot_air_balon?username={tg_username}"
#     flight_url = f"{WEB_APP_URL}flight?user_id={chat_id}"

#     # Создаем клавиатуру с кнопками в одну линию
#     keyboard = ReplyKeyboardMarkup(
#         keyboard=[
#             [
#                 KeyboardButton(
#                     text="Качели",
#                     web_app=WebAppInfo(url=swing_url)
#                 ),
#                 KeyboardButton(
#                     text="Воздушный шар",
#                     web_app=WebAppInfo(url=air_ballon_url)
#                 ),
#                 KeyboardButton(
#                     text="Доходы",
#                     web_app=WebAppInfo(url=flight_url)
#                 )
#             ]
#         ],
#         resize_keyboard=True
#     )

#     # Отправляем сообщение с кнопками в клавиатуре
#     await message.answer(
#         text="Внесите доход",
#         reply_markup=keyboard
#     )



# Стандартные модули Python
import aiohttp
# Сторонние модули
from aiogram.types import Message, KeyboardButton, ReplyKeyboardMarkup, WebAppInfo, InlineKeyboardButton
from aiogram import Bot, Dispatcher, types
# Собственные модули
from app.utils.token_utils import prepare_user_info, generate_token
from app.config import ADD_CHAT_ID_URL, BASE_URL, WEB_APP_URL, TOKEN

bot = Bot(token = TOKEN)
dp = Dispatcher()
# Список пользователей и их доступных кнопок
ALLOWED_USERS = {
    "heytward": "Запись рейсов",
    "axm9t": "Запись рейсов",
    "Vladislav_Arkhipov": "Шар",
    "qwert693126": "Качели",
    "Q5fantan": "Качели"
}

# Словарь для URL кнопок
BUTTON_URLS = {
    "Запись рейсов": lambda user_id: f"{WEB_APP_URL}flight?user_id={user_id}",
    "Шар": lambda username: f"{WEB_APP_URL}bot_air_balon?username={username}",
    "Качели": lambda username: f"{WEB_APP_URL}bot_swing?username={username}"
}

async def check_user_access(message: Message):
    """
    Проверяет доступ пользователя.
    """
    try:
        user_info = prepare_user_info(message)
        token = generate_token(user_info)

        async with aiohttp.ClientSession() as session:
            async with session.post(ADD_CHAT_ID_URL, json={"token": token}) as response:
                if response.status == 403:
                    raise Exception(await response.json())
                return await response.json()
    except Exception as e:
        error_detail = getattr(e, 'args', ["Ошибка без деталей"])[0]
        error_message = error_detail.get("detail", str(error_detail)) if isinstance(error_detail, dict) else str(error_detail)
        await message.answer(f"Ошибка: {error_message}")
        return



async def create_reply_markupButton(message: Message):
    # Получаем username пользователя
    tg_username = message.from_user.username

    # Проверяем, есть ли пользователь в списке ALLOWED_USERS
    if tg_username not in ALLOWED_USERS:
        return None  # Если пользователя нет в списке, возвращаем None

    # Получаем текст кнопки для данного пользователя
    button_text = ALLOWED_USERS[tg_username]

    # Генерируем URL для кнопки на основе текста и username
    if button_text in BUTTON_URLS:
        url = BUTTON_URLS[button_text](tg_username)
    else:
        return None  # Если текст кнопки не найден в BUTTON_URLS, возвращаем None

    # Создаем и возвращаем кнопку
    return InlineKeyboardButton(text=button_text, web_app=WebAppInfo(url=url))


async def get_income_keyboard(message: Message):
    
    keyboard = ReplyKeyboardMarkup(
        keyboard=[[KeyboardButton(text="Внести доход")]],
        resize_keyboard=True
    )
    await message.answer(
        text="Внесите доход:",
        reply_markup=keyboard
    )