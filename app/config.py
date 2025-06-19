import os
from dotenv import load_dotenv

load_dotenv()

BASE_URL = os.getenv('WEB_APP_URL')
WEB_APP_URL = os.getenv('WEB_APP_URL')
TOKEN = os.getenv('BOT_TOKEN')
ADD_CHAT_ID_URL = f"{BASE_URL}bot/check_access/"

# Эндпоинты для тинькофф
TINKOFF_EXPENSES_URL = f"{BASE_URL}tinkoff/expenses/"
TINKOFF_LOGIN_URL = f"{BASE_URL}tinkoff/"
