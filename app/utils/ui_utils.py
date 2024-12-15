# app/utils/ui_utils.py

# Сторонние модули
from aiogram.types import InlineKeyboardButton, InlineKeyboardMarkup, WebAppInfo


def generate_inline_buttons(buttons_data: list) -> InlineKeyboardMarkup:
    """
    Генерирует разметку с кнопками.

    :param buttons_data: список словарей вида {"text": "Название", "url": "https://..."}
    :return: InlineKeyboardMarkup
    """
    # Проверяем, есть ли данные для кнопок
    if not buttons_data:
        raise ValueError("Список buttons_data не должен быть пустым.")

    # Создаём клавиатуру
    keyboard = InlineKeyboardMarkup(
        inline_keyboard=[
            [
                InlineKeyboardButton(
                    text=button_data["text"],
                    web_app=WebAppInfo(url=button_data["url"])
                )
            ] for button_data in buttons_data
        ]
    )
    return keyboard
