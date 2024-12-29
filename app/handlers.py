# /app/handlers.py

# Сторонние модули
from aiogram.types import Message
from aiogram import Router, F

# Собственные модули
from app.tinkoff.utils import send_expenses_miniapp, send_auto_save_expenses_error
from app.utils.utils import air_balon_and_swings


router = Router()


@router.message(F.text == "/start")
async def send_welcome(message: Message):
    """
    Обработка команды /start в боте
    """
    print(f"Пришел новый пользователь: user_id: {message.from_user.id}  chat_id: {message.chat.id}")
    await message.answer("Добро пожаловать! Доступ к боту открыт.")
    await air_balon_and_swings(message)



@router.message(F.text == "/report")
async def send_expenses(message: Message):
    """
    Обработка команды /report в боте
    """
    await send_expenses_miniapp(chat_id=message.chat.id)
    await send_auto_save_expenses_error(chat_id=message.chat.id)
