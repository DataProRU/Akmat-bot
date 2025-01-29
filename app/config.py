# /app/config.py

# Стандартные модули Python
import os

# Сторонние модули
from dotenv import load_dotenv


load_dotenv()


BASE_URL = "https://flight-trip-pavel-ershov-12.amvera.io/"
WEB_APP_URL = "https://web-app-ax-pavel-ershov-12.amvera.io/"
TOKEN = "8125373869:AAFKywhECD_BqwUgaGvsQUpv_zSZeHiWDqI"

# Общие эндпоинты
ADD_CHAT_ID_URL = f"{BASE_URL}bot/check_access/"

# Эндпоинты для тинькофф
TINKOFF_EXPENSES_URL = f"{BASE_URL}bot/expenses/"
TINKOFF_LOGIN_URL = f"{BASE_URL}tinkoff/"