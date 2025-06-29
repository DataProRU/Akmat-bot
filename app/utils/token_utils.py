# app/utils/token_utils.py

# Стандартные модули Python
import hmac
import hashlib
import base64
import time
from urllib.parse import urlencode, urlparse, parse_qs, urlunparse

# Сторонние модули
from aiogram.types import Message

# Собственные модули
from app.config import TOKEN


SECRET_KEY = hashlib.sha256(TOKEN.encode()).digest()


def generate_token(data: dict) -> str:
    """
    Генерирует токен.
    """
    timestamp = int(time.time())
    data.setdefault("auth_date", str(timestamp))

    data_check_string = "&".join(f"{k}={v}" for k, v in data.items())
    signature = hmac.new(SECRET_KEY, data_check_string.encode(), hashlib.sha256).hexdigest()
    data["hash"] = signature

    encoded_init_data = base64.urlsafe_b64encode("&".join(f"{k}={v}" for k, v in data.items()).encode()).decode()
    return encoded_init_data


def get_tokenized_url(url: str, data: dict) -> str:
    """
    Добавляет к ссылке токен. Учитывает наличие параметров в исходной ссылке.
    """
    # Генерация токена
    token = generate_token(data)
    
    # Разбор URL на компоненты
    parsed_url = urlparse(url)
    query_params = parse_qs(parsed_url.query)  # Существующие параметры

    # Добавление токена к параметрам
    query_params['token'] = token

    # Формирование нового URL
    new_query = urlencode(query_params, doseq=True)
    new_url = urlunparse((
        parsed_url.scheme,
        parsed_url.netloc,
        parsed_url.path,
        parsed_url.params,
        new_query,
        parsed_url.fragment,
    ))

    return new_url


def prepare_user_info(message: Message) -> dict:
    """
    Извлекает основную информацию о пользователе из объекта Message.

    :param message: объект Message
    :return: словарь с информацией о пользователе
    """
    user = message.from_user
    chat = message.chat

    user_info = {
        "user_id": user.id,
        "first_name": user.first_name,
        "last_name": user.last_name or None,
        "username": user.username or None,
        "is_bot": user.is_bot,
        "chat_id": chat.id,
        "chat_type": chat.type,
    }

    return user_info


def create_tokenized_url_with_init_data(message: Message, url: str):
    """
    Делает ссылку с токеном, в токене основная информация о пользователе.
    """
    data = prepare_user_info(message)
    return get_tokenized_url(url, data)