from fastapi import APIRouter, Request, Depends, Form, status
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from fastapi.security import OAuth2PasswordRequestForm
import databases
from services.auth_service import login_user, register_user
from dependencies import get_token_from_cookie, get_current_user
from database import get_db

router = APIRouter()
templates = Jinja2Templates(directory="templates")


# Роут для страницы регистрации
@router.get("/register", response_class=HTMLResponse)
async def get_register(request: Request):
    return templates.TemplateResponse("register.html", {"request": request})


# Роут для обработки регистрации
@router.post("/register")
async def post_register(
    request: Request,
    username: str = Form(...),
    password: str = Form(...),
    role: str = Form(),
    db: databases.Database = Depends(get_db),
):
    return await register_user(request, username, password, role, db, templates)


# Роут для страницы логина
@router.get("/login", response_class=HTMLResponse)
async def get_login(request: Request):
    return templates.TemplateResponse("login.html", {"request": request, "error": None})


# Роут для обработки логина
@router.post("/login", response_class=HTMLResponse)
async def login(
    request: Request,
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: databases.Database = Depends(get_db),
):
    return await login_user(request, form_data, db, templates)


# Роут для приветственной страницы
@router.get("/welcome", response_class=HTMLResponse)
async def welcome(request: Request):
    token = get_token_from_cookie(request)
    payload = get_current_user(token)
    username = payload.get("sub")
    role = payload.get("role")
    return templates.TemplateResponse(
        "welcome.html", {"request": request, "username": username, "role": role}
    )


@router.get("/confirm", response_class=HTMLResponse)
async def confirm(request: Request):
    token = get_token_from_cookie(request)
    payload = get_current_user(token)
    username = payload.get("sub")
    role = payload.get("role")
    return templates.TemplateResponse(
        "confirm.html", {"request": request, "username": username, "role": role}
    )


@router.get("/access", response_class=HTMLResponse)
async def access(request: Request):
    token = get_token_from_cookie(request)
    payload = get_current_user(token)
    username = payload.get("sub")
    role = payload.get("role")
    return templates.TemplateResponse(
        "access.html", {"request": request, "username": username, "role": role}
    )


"""'@router.get("/income", response_class=HTMLResponse)
async def income(request: Request):
    token = get_token_from_cookie(request)
    payload = get_current_user(token)
    username = payload.get("sub")
    role = payload.get("role")
    return templates.TemplateResponse("income.html", {"request": request, "username": username, "role": role})"""
