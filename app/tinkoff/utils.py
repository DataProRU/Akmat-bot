# app/tinkoff/utils.py

# Собственные модули
from app.utils.ui_utils import send_miniapp

from app.config import TINKOFF_EXPENSES_URL, TINKOFF_LOGIN_URL


async def send_expenses_miniapp(chat_id: str):
    """
    Отправляет сообщение с расходами.
    """
    await send_miniapp(chat_id, 
                       "Ваши расходы.", 
                       TINKOFF_EXPENSES_URL, 
                       "Открыть расходы")
    

async def send_daily_expenses_miniapp(chat_id: str):
    """
    Рассылает сообщения о проставлении статей после автосохранения расходов.
    """
    await send_miniapp(chat_id, 
                       "Автовыгрузка расходов завершена.", 
                       TINKOFF_EXPENSES_URL, 
                       "Открыть расходы")


async def send_auto_save_expenses_error(chat_id: str):
    """
    Рассылает сообщение с миниапом на расходы.
    """
    await send_miniapp(chat_id,
                        "Произошла ошибка при автовыгрузке. Пожалуйста, повторите вход в аккаунт чтобы возобновить загрузку.", 
                        TINKOFF_LOGIN_URL, 
                        "Повторить вход")
    
