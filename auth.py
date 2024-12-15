from jose import JWTError, jwt
from passlib.context import CryptContext
from datetime import datetime, timedelta
import hmac
import hashlib
import base64

from config import BOT_SECRET_KEY

from models import UserInDB

SECRET_KEY = "mysecretkey"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def get_user(db, username: str):
    user = db.execute("SELECT * FROM users WHERE username = ?", (username,)).fetchone()
    if user:
        return UserInDB(
            username=user["username"],
            hashed_password=user["password"],
            role=user["role"],
        )
    return None


def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def get_password_hash(password):
    return pwd_context.hash(password)


def create_access_token(data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)


def decode_access_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except JWTError:
        return None
#test


def create_temp_token(data: dict, expires_delta: timedelta = timedelta(minutes=15)):
    """
    Создаёт временный токен.
    """
    to_encode = data.copy()
    expire = datetime.utcnow() + expires_delta
    to_encode.update({"exp": expire})
    token = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return token

def verify_bot_token(token: str) -> dict:
    """
    Проверяет и декодирует токен с бота.
    """
    try:
        # Декодируем base64-строку
        decoded_data = base64.urlsafe_b64decode(token).decode()
        # Преобразуем строку в словарь
        data = dict(item.split('=') for item in decoded_data.split('&'))
        
        # Проверяем подпись
        data_check_string = "&".join(f"{k}={v}" for k, v in data.items() if k != "hash")
        expected_signature = hmac.new(BOT_SECRET_KEY, data_check_string.encode(), hashlib.sha256).hexdigest()

        if data["hash"] != expected_signature:
            raise ValueError("Подпись токена не совпадает.")
        
        return data
    except Exception as e:
        raise ValueError(f"Неверный токен: {str(e)}")