# /app/config.py

# Стандартные модули Python
import os

# Сторонние модули
from dotenv import load_dotenv


load_dotenv()


BASE_URL = os.getenv("BASE_URL")
TOKEN = os.getenv("BOT_TOKEN")

# Общие эндпоинты
ADD_CHAT_ID_URL = f"{BASE_URL}bot/check_access/"

# Эндпоинты для тинькофф
TINKOFF_EXPENSES_URL = f"{BASE_URL}bot/expenses/"