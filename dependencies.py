from fastapi import Request, HTTPException, status
from auth import decode_access_token

# Функция для получения токена из cookie
def get_token_from_cookie(request: Request):
    token = request.cookies.get("token")
    if not token:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail="Token is missing"
        )
    return token

# Функция для получения текущего пользователя из токена
def get_current_user(token: str):
    payload = decode_access_token(token)
    if not payload:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")
    return payload
