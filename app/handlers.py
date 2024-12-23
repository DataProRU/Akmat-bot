# /app/handlers.py

# Сторонние модули
from aiogram.types import Message
from aiogram import Router, F

# Собственные модули
from app.utils.utils import check_user_access

from app.tinkoff.utils import send_expenses_miniapp

router = Router()


@router.message(F.text == "/start")
async def send_welcome(message: Message):
    """
    Обработка команды /start в боте
    """
    try:
        # Отправка запроса к API для проверки наличия пользователя в бд
        api_response = await check_user_access(message)
        print(f"Пришел новый пользователь: user_id: {message.from_user.id}  chat_id: {message.chat.id}")
        await message.answer(api_response["detail"])
    except Exception as e:
        # Если пришла ошибка то обрабатываем отправляем сообщение об ошибке пользователю
        error_detail = getattr(e, 'args', ["Ошибка без деталей"])[0]
        if isinstance(error_detail, dict) and "detail" in error_detail:
            error_message = error_detail["detail"]
        else:
            error_message = str(error_detail)
        await message.answer(f"Ошибка: {error_message}")
        return


@router.message(F.text == "/report")
async def send_expenses(message: Message):
    """
    Обработка команды /report в боте
    """
    try:
        # Отправка запроса к API для проверки наличия пользователя в бд
        await check_user_access(message)
    except Exception as e:
        # Если пришла ошибка то обрабатываем отправляем сообщение об ошибке пользователю
        error_detail = getattr(e, 'args', ["Ошибка без деталей"])[0]
        if isinstance(error_detail, dict) and "detail" in error_detail:
            error_message = error_detail["detail"]
        else:
            error_message = str(error_detail)
        await message.answer(f"Ошибка: {error_message}")
        return
    await send_expenses_miniapp(chat_id=message.chat.id, message="Ваши расходы: ")