from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_token_from_cookie, get_current_user
from models import TypeOperations

router = APIRouter()

templates = Jinja2Templates(directory="templates")

def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()

@router.get("/operations", response_class=HTMLResponse)
async def directory(request: Request, db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    type_expenses = db.query(TypeOperations).all()

    return templates.TemplateResponse("directory/operations.html", {
        "request": request,
        "type_expenses":type_expenses
    })

@router.post("/operations/add", response_class=HTMLResponse)
async def add_operation(request: Request,
                             title: str = Form(...),
visible_type_technique:bool = Form(False),
visible_canisters:bool = Form(False),
visible_amount: bool = Form(False),
visible_cost_fuel: bool = Form(False),
visible_technique: bool = Form(False),
visible_description:bool = Form(False),
                             db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    new_type = TypeOperations(title=title,
                              visible_type_technique = visible_type_technique,
                              visible_canisters = visible_canisters,
                              visible_amount = visible_amount,
                              visible_cost_fuel = visible_cost_fuel,
                              visible_technique = visible_technique,
                              visible_description = visible_description)
    db.add(new_type)
    db.commit()

    return RedirectResponse(url="/operations", status_code=303)

@router.post("/operations/edit/{id}", response_class=HTMLResponse)
async def edit_type_payments(request: Request, id: int, title: str = Form(...),
visible_type_technique:bool = Form(False),
visible_canisters:bool = Form(False),
visible_amount: bool = Form(False),
visible_cost_fuel: bool = Form(False),
visible_technique: bool = Form(False),
visible_description:bool = Form(False),
                             db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    # Поиск записи по id
    type_to_edit = db.query(TypeOperations).filter(TypeOperations.id == id).first()
    if type_to_edit:
        type_to_edit.title = title
        type_to_edit.visible_type_technique = visible_type_technique
        type_to_edit.visible_canisters = visible_canisters
        type_to_edit.visible_amount = visible_amount
        type_to_edit.visible_cost_fuel = visible_cost_fuel
        type_to_edit.visible_technique = visible_technique
        type_to_edit.visible_description = visible_description
        db.commit()

    return RedirectResponse(url="/operations", status_code=303)

@router.post("/operations/delete/{id}", response_class=HTMLResponse)
async def delete_type_payments(request: Request, id: int, db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    type_to_delete = db.query(TypeOperations).filter(TypeOperations.id == id).first()
    if type_to_delete:
        db.delete(type_to_delete)
        db.commit()

    return RedirectResponse(url="/operations", status_code=303)