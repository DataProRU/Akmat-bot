# app/tinkoff/utils.py

# Модули Python
from datetime import datetime

# Собственные модули
from app.utils.ui_utils import send_miniapp

from app.config import TINKOFF_EXPENSES_URL, TINKOFF_LOGIN_URL


async def send_expenses_miniapp(chat_id: str):
    """
    Отправляет сообщение с расходами.
    """
    today = datetime.now()
    formatted_date = today.strftime("%Y-%m-%d")

    await send_miniapp(chat_id, 
                       "Ваши расходы.", 
                       TINKOFF_EXPENSES_URL + f"?rangeStart={formatted_date}&rangeEnd={formatted_date}&show_all_expenses=true", 
                       "Открыть расходы")
    

async def send_daily_expenses_miniapp(chat_id: str):
    """
    Рассылает сообщения о проставлении статей после автосохранения расходов.
    """
    today = datetime.now()
    formatted_date = today.strftime("%Y-%m-%d")

    await send_miniapp(chat_id, 
                       "Автовыгрузка расходов завершена.", 
                       TINKOFF_EXPENSES_URL + f"?rangeStart={formatted_date}&rangeEnd={formatted_date}&show_all_expenses=true", 
                       "Открыть расходы")


async def send_auto_save_expenses_error(chat_id: str):
    """
    Рассылает сообщение с миниапом на расходы.
    """
    await send_miniapp(chat_id,
                        "Произошла ошибка при автовыгрузке. Пожалуйста, повторите вход в аккаунт чтобы возобновить загрузку.", 
                        TINKOFF_LOGIN_URL, 
                        "Повторить вход")
    
