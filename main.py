from fastapi import FastAPI, Depends, HTTPException, status, Request, Form
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates
from auth import verify_password, get_password_hash, create_access_token, decode_access_token
from schemas import UserCreate
from database import get_db
from fastapi.security import OAuth2PasswordRequestForm
import databases

app = FastAPI()
templates = Jinja2Templates(directory="templates")

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

# Роут для страницы регистрации
@app.get("/register", response_class=HTMLResponse)
async def get_register(request: Request):
    return templates.TemplateResponse("register.html", {"request": request})

# Роут для обработки регистрации
@app.post("/register")
async def post_register(
    request: Request,
    username: str = Form(...),
    password: str = Form(...),
    role: str = Form(),
    db: databases.Database = Depends(get_db)
):
    user = UserCreate(username=username, password=password, role=role)
    try:
        query = "INSERT INTO users (username, password, role) VALUES (:username, :password, :role)"
        values = {"username": user.username, "password": get_password_hash(user.password), "role": user.role}
        await db.execute(query=query, values=values)
        return RedirectResponse(url="/login", status_code=status.HTTP_303_SEE_OTHER)
    except Exception as e:
        return templates.TemplateResponse("register.html", {"request": request, "error": str(e)})

# Роут для страницы логина
@app.get("/login", response_class=HTMLResponse)
async def get_login(request: Request):
    return templates.TemplateResponse("login.html", {"request": request, "error": None})

# Роут для обработки логина
@app.post("/login", response_class=HTMLResponse)
async def login(
        request: Request,
        form_data: OAuth2PasswordRequestForm = Depends(),
        db: databases.Database = Depends(get_db)
):
    query = "SELECT * FROM users WHERE username = :username"
    user = await db.fetch_one(query=query, values={"username": form_data.username})

    if user and verify_password(form_data.password, user["password"]):
        token = create_access_token({"sub": form_data.username, "role": user["role"]})  # Включаем роль в токен
        response = RedirectResponse(url="/welcome", status_code=status.HTTP_303_SEE_OTHER)
        response.set_cookie(key="token", value=token, httponly=True)
        return response

    return templates.TemplateResponse("login.html", {"request": request, "error": "Invalid username or password"})

# Роут для приветственной страницы
@app.get("/welcome", response_class=HTMLResponse)
async def welcome(request: Request):
    token = get_token_from_cookie(request)  # Получаем токен из cookie
    payload = get_current_user(token)  # Декодируем токен
    username = payload.get("sub")
    role = payload.get("role")
    return templates.TemplateResponse("welcome.html", {"request": request, "username": username, "role": role})
