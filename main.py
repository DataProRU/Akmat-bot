from fastapi import FastAPI, Depends, HTTPException, status, Request
from fastapi.responses import HTMLResponse
from fastapi.security import OAuth2PasswordRequestForm
from fastapi.templating import Jinja2Templates
from auth import verify_password, get_password_hash, create_access_token, decode_access_token
from schemas import UserCreate
from database import get_db
import sqlite3
from fastapi import Form
from fastapi.responses import RedirectResponse

app = FastAPI()
templates = Jinja2Templates(directory="templates")


# Registration page
@app.get("/register", response_class=HTMLResponse)
async def get_register(request: Request):
    return templates.TemplateResponse("register.html", {"request": request})


@app.post("/register")
async def post_register( request: Request, username: str = Form(...), password: str = Form(...), db: sqlite3.Connection = Depends(get_db)):
    user = UserCreate(username=username, password=password)
    try:
        db.execute(
            "INSERT INTO users (username, password) VALUES (?, ?)",
            (user.username, get_password_hash(user.password))
        )
        db.commit()
        return RedirectResponse(url="/login", status_code=status.HTTP_303_SEE_OTHER)
    except sqlite3.IntegrityError:
        return templates.TemplateResponse("register.html", {"request": request, "error": "Username already registered"})

# Login page
@app.get("/login", response_class=HTMLResponse)
async def get_login(request: Request):
    return templates.TemplateResponse("login.html", {"request": request, "error": None})


@app.post("/login", response_class=HTMLResponse)
async def login(
        request: Request,
        form_data: OAuth2PasswordRequestForm = Depends(),
        db: sqlite3.Connection = Depends(get_db)
):
    # Проверяем, существует ли пользователь в базе данных
    cursor = db.execute("SELECT * FROM users WHERE username = ?", (form_data.username,))
    user = cursor.fetchone()

    # Если пользователь найден и пароль верный
    if user and verify_password(form_data.password, user[2]):
        # Создаем токен
        token = create_access_token({"sub": form_data.username})
        # Перенаправляем на страницу welcome и сохраняем токен в cookies
        response = RedirectResponse(url="/welcome", status_code=status.HTTP_303_SEE_OTHER)
        response.set_cookie(key="token", value=token, httponly=True)  # Устанавливаем токен в cookies
        return response

    # Если имя пользователя или пароль неверны, показываем ошибку
    return templates.TemplateResponse("login.html", {"request": request, "error": "Invalid username or password"})


# Welcome page
# Функция для извлечения токена из cookies
def get_token_from_cookie(request: Request):
    token = request.cookies.get("token")
    if not token:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Token is missing in cookies")
    return token

@app.get("/welcome", response_class=HTMLResponse)
async def welcome(request: Request, db: sqlite3.Connection = Depends(get_db),
                  token: str = Depends(get_token_from_cookie)):
    # Декодирование токена
    payload = decode_access_token(token)
    if not payload:
        return templates.TemplateResponse("invalid_token.html", {"request": request})

    username = payload.get("sub")
    if username:
        # Передача имени пользователя в шаблон
        return templates.TemplateResponse("welcome.html", {"request": request, "username": username})

    raise HTTPException(status_code=400, detail="User not found")
