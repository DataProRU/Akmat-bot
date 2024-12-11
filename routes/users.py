from fastapi import APIRouter, Request, Form, Depends
from database import web_users, database, Session
from models import UpdateUserRole, Users
from fastapi.templating import Jinja2Templates
from dependencies import get_token_from_cookie, get_current_user
from fastapi.responses import RedirectResponse, JSONResponse
from typing import Optional
from fastapi.responses import HTMLResponse

router = APIRouter()
templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/users/")
async def get_users(request: Request, db: Session = Depends(get_db)):
    # Получаем токен
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    role = payload.get("role")
    exp = payload.get("exp")

    # Проверка прав доступа
    if role != "admin":
        return templates.TemplateResponse("not_access.html", {"request": request})
    if exp <= 0:
        return templates.TemplateResponse("invalid_token.html", {"request": request})
    if not database.is_connected:
        await database.connect()
    # Подключение к базе данных и выбор всех пользователей
    query = web_users.select()
    users_data = await database.fetch_all(query)

    # Формируем список словарей с данными пользователей
    users_tg_data = db.query(Users).all()

    # Возвращаем HTML-шаблон с данными пользователей
    return templates.TemplateResponse(
        "access.html",
        {"request": request, "users": users_data, "users_tg": users_tg_data},
    )


@router.put("/users/{user_id}")
async def update_user_role(request: Request, user_id: int, role_update: UpdateUserRole):

    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

        # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина
    if not database.is_connected:
        await database.connect()
    query = (
        web_users.update()
        .where(web_users.c.id == user_id)
        .values(role=role_update.role)
    )
    await database.execute(query)
    return RedirectResponse("/users", status_code=303)


@router.post("/users_tg/edit/{id}", response_class=HTMLResponse)
async def update_users(
    request: Request,
    id: int,
    tg: str = Form(...),
    full_name: str = Form(...),
    is_manager: bool = Form(False),
    is_instructor: bool = Form(False),
    is_assistant: bool = Form(False),
    send_button: bool = Form(False),
    deposit_income: bool = Form(False),
    enter_operation: bool = Form(False),
    view_salary: bool = Form(False),
    contribute_expense: bool = Form(False),
    is_director: bool = Form(False),
    comission: bool = Form(False),
    penalty: bool = Form(False),
    is_investor: bool = Form(False),
    change_salary: bool = Form(False),
    card_number: str = Form(""),
    db: Session = Depends(get_db),
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload
    user = db.query(Users).filter(Users.id == id).first()
    if not user:
        return {"error": "User not found"}

    print(f"card_number is {card_number}")

    user.tg = tg
    user.full_name = full_name
    user.is_manager = is_manager
    user.is_instructor = is_instructor
    user.is_assistant = is_assistant
    user.send_button = send_button
    user.deposit_income = deposit_income
    user.enter_operation = enter_operation
    user.view_salary = view_salary
    user.contribute_expense = contribute_expense
    user.is_director = is_director
    user.chat_id = user.chat_id  # не меняем chat id
    user.comission = comission
    user.penalty = penalty
    user.is_investor = is_investor
    user.change_salary = change_salary
    user.card_number = card_number

    db.commit()

    return RedirectResponse("/users", status_code=303)


@router.post("/users_tg/delete/{id}", response_class=HTMLResponse)
async def delete_positions(request: Request, id: int, db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    type_to_delete = db.query(Users).filter(Users.id == id).first()
    if type_to_delete:
        db.delete(type_to_delete)
        db.commit()

    return RedirectResponse(url="/users", status_code=303)


@router.post("/users_tg/add")
async def add_user(
    request: Request,
    tg: str = Form(...),
    full_name: str = Form(...),
    is_manager: bool = Form(False),
    is_instructor: bool = Form(False),
    is_assistant: bool = Form(False),
    send_button: bool = Form(False),
    deposit_income: bool = Form(False),
    enter_operation: bool = Form(False),
    view_salary: bool = Form(False),
    contribute_expense: bool = Form(False),
    is_director: bool = Form(False),
    chat_id: Optional[int] = Form(1),
    comission: bool = Form(False),
    penalty: bool = Form(False),
    is_investor: bool = Form(False),
    change_salary: bool = Form(False),
    card_number: str = Form(""),
    db: Session = Depends(get_db),
):
    user = Users(
        tg=tg,
        full_name=full_name,
        is_manager=is_manager,
        is_instructor=is_instructor,
        is_assistant=is_assistant,
        send_button=send_button,
        deposit_income=deposit_income,
        enter_operation=enter_operation,
        view_salary=view_salary,
        contribute_expense=contribute_expense,
        is_director=is_director,
        chat_id=chat_id,
        comission=comission,
        penalty=penalty,
        is_investor=is_investor,
        change_salary=change_salary,
        card_number = card_number,
    )
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

        # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина
    if not database.is_connected:
        await database.connect()

    db.add(user)
    db.commit()
    db.refresh(user)

    return RedirectResponse("/users", status_code=303)


@router.on_event("startup")
async def startup():
    await database.connect()


@router.on_event("shutdown")
async def shutdown():
    await database.disconnect()
