from fastapi import APIRouter, Request
from database import web_users, database, Session
from models import UpdateUserRole, Users
from fastapi.templating import Jinja2Templates
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
    session = Session()
    users_tg = session.query(Users).all()

    # Формируем список словарей с данными пользователей
    users_tg_data = []
    for user in users_tg:
        users_tg_data.append(
            {
                "id": user.id,
                "tg": user.tg,
                "full_name": user.full_name,
                "is_manager": user.is_manager,
                "is_instructor": user.is_instructor,
                "is_assistant": user.is_assistant,
                "send_button": user.send_button,
                "deposit_income": user.deposit_income,
                "enter_operation": user.enter_operation,
                "view_salary": user.view_salary,
                "contribute_expense": user.contribute_expense,
                "is_director": user.is_director,
                "chat_id": user.chat_id,
                "comission": user.comission,
                "penalty": user.penalty,
                "is_investor": user.is_investor,
            }
        )
    await database.disconnect()

    # Возвращаем HTML-шаблон с данными пользователей
    return templates.TemplateResponse(
        "access.html",
        {"request": request, "users": users_data, "users_tg": users_tg_data},
    )


# Обновление роли пользователя
@router.put("/users/{user_id}")
async def update_user_role(user_id: int, role_update: UpdateUserRole):
    query = (
        web_users.update()
        .where(web_users.c.id == user_id)
        .values(role=role_update.role)
    )
    await database.connect()
    await database.execute(query)
    await database.disconnect()
    return {"message": "User role updated"}


# Удаление пользователя
@router.delete("/users/{user_id}")
async def delete_user(user_id: int):
    await database.connect()
    query = web_users.delete().where(web_users.c.id == user_id)
    await database.execute(query)
    await database.disconnect()
    return {"message": "User deleted"}


# Подключение к базе данных при старте/остановке приложения
@router.on_event("startup")
async def startup():
    await database.connect()


@router.on_event("shutdown")
async def shutdown():
    await database.disconnect()
