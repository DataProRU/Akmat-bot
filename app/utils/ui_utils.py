# app/utils/ui_utils.py

# Стандартные модули Python
import time 
from datetime import datetime

# Сторонние модули
from aiogram.types import InlineKeyboardButton, InlineKeyboardMarkup, WebAppInfo

# Собственные модули
from app.utils.token_utils import get_tokenized_url

from app.bot import bot


def generate_webApp_inline_button(text: str, url: str) -> InlineKeyboardMarkup:
    """
    Генерирует разметку с одной миниап кнопкой.

    :param text: Текст кнопки
    :param url: URL для мини-приложения
    :return: InlineKeyboardMarkup
    """
    # Создаём клавиатуру
    keyboard = InlineKeyboardMarkup(
        inline_keyboard=[
            [
                InlineKeyboardButton(
                    text=text,
                    web_app=WebAppInfo(url=url)
                )
            ]
        ]
    )
    return keyboard


def generate_inline_button(text: str, callback_data: str) -> InlineKeyboardMarkup:
    """
    Генерирует разметку с одной кнопкой.

    :param text: Текст кнопки
    :param callback_data: Данные для обратного вызова
    :return: InlineKeyboardMarkup
    """
    # Создаём клавиатуру
    keyboard = InlineKeyboardMarkup(
        inline_keyboard=[
            [
                InlineKeyboardButton(
                    text=text,
                    callback_data=callback_data
                )
            ]
        ]
    )
    return keyboard


def combine_keyboards(keyboards: list) -> InlineKeyboardMarkup:
    """
    Объединяет несколько InlineKeyboardMarkup в одну.

    :param keyboards: Список InlineKeyboardMarkup
    :return: Объединённая InlineKeyboardMarkup
    """
    combined_keyboard = InlineKeyboardMarkup(
        inline_keyboard=[row for keyboard in keyboards for row in keyboard.inline_keyboard]
    )
    return combined_keyboard


async def send_miniapp(chat_id: str, message: str, miniapp_url: str, btn_text: str):
    """
    Отправляет сообщение с миниапом.

    :param chat_id: ID чата куда нужно отправить сообщение
    :param message: Сообщение
    :param miniapp_url: Url для миниапа
    :param btn_text: Сообщение на кнопке
    :return: Результат операции
    """
    try:
        # Генерация токенизированного URL
        today = datetime.now()

        tokenized_url = get_tokenized_url(miniapp_url, {"chat_id": chat_id, "auth_date": str(int(time.time()))})

        keyboard = generate_webApp_inline_button(btn_text, tokenized_url)
        
        # Отправка сообщения
        await bot.send_message(chat_id, message, reply_markup=keyboard)
        return {"chat_id": chat_id, "status": "success"}
    except Exception as e:
        return {"chat_id": chat_id, "status": "error", "detail": str(e)}