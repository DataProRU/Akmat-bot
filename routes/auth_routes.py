from fastapi import APIRouter, Request, Depends, Form, status
from fastapi.responses import HTMLResponse,  RedirectResponse
from fastapi.templating import Jinja2Templates
from fastapi.security import OAuth2PasswordRequestForm
import databases
from services.auth_service import login_user, register_user
from dependencies import get_token_from_cookie, get_current_user
from database import get_db

router = APIRouter()
templates = Jinja2Templates(directory="templates")

@router.get("/register", response_class=HTMLResponse)
async def get_register(request: Request):
    return templates.TemplateResponse("register.html", {"request": request})

@router.post("/register")
async def post_register(
    request: Request,
    username: str = Form(...),
    password: str = Form(...),
    role: str = Form(),
    db: databases.Database = Depends(get_db),
):
    return await register_user(request, username, password, role, db, templates)



@router.get("/login", response_class=HTMLResponse)
@router.get("/", response_class=HTMLResponse)
async def get_login(request: Request):
    return templates.TemplateResponse("login.html", {"request": request, "error": None})



@router.post("/login", response_class=HTMLResponse)
async def login(
    request: Request,
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: databases.Database = Depends(get_db),
):
    return await login_user(request, form_data, db, templates)


@router.get("/welcome", response_class=HTMLResponse)
async def welcome(request: Request):
    # Получаем токен
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    # Извлекаем информацию о пользователе
    username = payload.get("sub")
    role = payload.get("role")

    # Возвращаем HTML-шаблон с данными пользователя
    return templates.TemplateResponse(
        "welcome.html", {"request": request, "username": username, "role": role}
    )


@router.get("/confirm", response_class=HTMLResponse)
async def confirm(request: Request):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

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
