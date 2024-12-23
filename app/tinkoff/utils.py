# app/tinkoff/utils.py

# Стандартные модули Python
import time 
from datetime import datetime

# Собственные модули
from app.utils.token_utils import get_tokenized_url
from app.utils.ui_utils import generate_inline_buttons

from app.bot import bot

from app.config import TINKOFF_EXPENSES_URL


async def send_daily_expenses_miniapp(chat_id: str):
    """
    Рассылает сообщения о проставлении статей после автосохранения расходов.
    """
    await send_expenses_miniapp(chat_id, "Автовыгрузка расходов завершена.")


async def send_expenses_miniapp(chat_id: str, message: str):
    """
    Рассылает сообщение с миниапом на расходы.
    """
    try:
        # Генерация токенизированного URL
        today = datetime.now()
        formatted_date = today.strftime("%Y-%m-%d")

        tokenized_url = get_tokenized_url(TINKOFF_EXPENSES_URL, {"chat_id": chat_id, "auth_date": str(int(time.time()))}) + f"&rangeStart={formatted_date}&rangeEnd={formatted_date}"
        keyboard = generate_inline_buttons([{"text": "Открыть расходы по вашей карте", "url": tokenized_url}])
        
        # Отправка сообщения
        await bot.send_message(chat_id, message, reply_markup=keyboard)
        return {"chat_id": chat_id, "status": "success"}
    except Exception as e:
        return {"chat_id": chat_id, "status": "error", "detail": str(e)}