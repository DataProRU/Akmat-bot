from fastapi import Request, HTTPException, status
from fastapi.responses import RedirectResponse
from auth import decode_access_token


# Функция для получения токена из cookie
def get_token_from_cookie(request: Request):
    token = request.cookies.get("token")
    if not token:
        return RedirectResponse(url="/login", status_code=status.HTTP_303_SEE_OTHER)
    return token


# Функция для получения текущего пользователя из токена
def get_current_user(token: str):
    payload = decode_access_token(token)
    if not payload:
        return RedirectResponse(url="/login", status_code=status.HTTP_303_SEE_OTHER)
    return payload
