# app/tinkoff/utils.py

# Стандартные модули Python
import time 

# Собственные модули
from app.utils.token_utils import get_tokenized_url
from app.utils.ui_utils import generate_inline_buttons

from app.bot import bot

from app.config import TINKOFF_EXPENSES_URL


async def send_daily_expenses_miniapp(chat_id: str):
    """
    Рассылает сообщения о проставлении статей после автосохранения расходов.
    """
    try:
        # Генерация токенизированного URL
        tokenized_url = get_tokenized_url(TINKOFF_EXPENSES_URL, {"chat_id": chat_id, "auth_date": str(int(time.time()))}) + "&period=day"
        keyboard = generate_inline_buttons([{"text": "Открыть расходы по вашей карте", "url": tokenized_url}])
        
        # Отправка сообщения
        await bot.send_message(chat_id, "Автовыгрузка расходов завершена.", reply_markup=keyboard)
        return {"chat_id": chat_id, "status": "success"}
    except Exception as e:
        return {"chat_id": chat_id, "status": "error", "detail": str(e)}