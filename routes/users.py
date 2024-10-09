from fastapi import APIRouter, Request
from database import web_users, database
from models import UpdateUserRole
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse
from dependencies import get_token_from_cookie, get_current_user

router = APIRouter()
templates = Jinja2Templates(directory="templates")


@router.get("/users/")
async def get_users(request: Request):
    token = get_token_from_cookie(request)
    payload = get_current_user(token)
    role = payload.get("role")
    exp = payload.get("exp")

    # Проверка прав доступа
    if role != "admin":
        return templates.TemplateResponse("not_access.html", {"request": request})
    if exp <= 0:
        return templates.TemplateResponse("invalid_token.html", {"request": request})

    # Подключение к базе данных и выбор всех пользователей
    await database.connect()
    query = web_users.select()
    users_data = await database.fetch_all(query)
    await database.disconnect()

    # Возвращаем HTML-шаблон с данными пользователей
    return templates.TemplateResponse("access.html", {"request": request, "users": users_data})

# Обновление роли пользователя
@router.put("/users/{user_id}")
async def update_user_role(user_id: int, role_update: UpdateUserRole):
    query = web_users.update().where(web_users.c.id == user_id).values(role=role_update.role)
    await database.connect()
    await database.execute(query)
    await  database.disconnect()
    return {"message": "User role updated"}

# Удаление пользователя
@router.delete("/users/{user_id}")
async def delete_user(user_id: int):
    await database.connect()
    query = web_users.delete().where(web_users.c.id == user_id)
    await database.execute(query)
    await  database.disconnect()
    return {"message": "User deleted"}

# Подключение к базе данных при старте/остановке приложения
@router.on_event("startup")
async def startup():
    await database.connect()

@router.on_event("shutdown")
async def shutdown():
    await database.disconnect()