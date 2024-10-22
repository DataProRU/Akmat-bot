from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_token_from_cookie, get_current_user
from models import Commisions

router = APIRouter()

templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/commissions", response_class=HTMLResponse)
async def directory(request: Request, db: Session = Depends(get_db)):
    # Получаем токен
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    type_commisions = db.query(Commisions).all()

    return templates.TemplateResponse(
        "directory/commissions.html",
        {"request": request, "type_commisions": type_commisions},
    )


@router.post("/commissions/add", response_class=HTMLResponse)
async def add_commissions(
    request: Request, title: str = Form(...), db: Session = Depends(get_db)
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    new_type = Commisions(title=title)
    db.add(new_type)
    db.commit()

    return RedirectResponse(url="/commissions", status_code=303)


@router.post("/commissions/edit/{id}", response_class=HTMLResponse)
async def edit_commissions(
    request: Request, id: int, title: str = Form(...), db: Session = Depends(get_db)
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    # Поиск записи по id
    type_to_edit = db.query(Commisions).filter(Commisions.id == id).first()
    if type_to_edit:
        type_to_edit.title = title  # Обновляем название
        db.commit()

    return RedirectResponse(url="/commissions", status_code=303)


@router.post("/commissions/delete/{id}", response_class=HTMLResponse)
async def delete_commissions(request: Request, id: int, db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    type_to_delete = db.query(Commisions).filter(Commisions.id == id).first()
    if type_to_delete:
        db.delete(type_to_delete)
        db.commit()

    return RedirectResponse(url="/commissions", status_code=303)
