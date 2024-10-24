from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_token_from_cookie, get_current_user
from models import Investors

router = APIRouter()

templates = Jinja2Templates(directory="templates")

def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()

@router.get("/investors", response_class=HTMLResponse)
async def directory(request: Request, db: Session = Depends(get_db)):
    # Получаем токен
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    investors = db.query(Investors).all()

    return templates.TemplateResponse("directory/investors.html", {
        "request": request,
        "investors": investors
    })


@router.post("/investors/add", response_class=HTMLResponse)
async def add_investor(
    request: Request,
    title: str = Form(...),
    tg: str = Form(...),
    percent: str = Form(...),
    db: Session = Depends(get_db),
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    new_type = Investors(title=title, tg=tg, percent=percent)
    db.add(new_type)
    db.commit()

    return RedirectResponse(url="/investors", status_code=303)


@router.post("/investors/edit/{id}", response_class=HTMLResponse)
async def edit_investor(
    request: Request,
    id: int,
    title: str = Form(...),
    tg: str = Form(...),
    percent: str = Form(...),
    db: Session = Depends(get_db),
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    # Поиск записи по id
    type_to_edit = db.query(Investors).filter(Investors.id == id).first()
    if type_to_edit:
        type_to_edit.title = title
        type_to_edit.tg = tg
        type_to_edit.percent = percent
        db.commit()

    return RedirectResponse(url="/investors", status_code=303)


@router.post("/investors/delete/{id}", response_class=HTMLResponse)
async def delete_investor(request: Request, id: int, db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    type_to_delete = db.query(Investors).filter(Investors.id == id).first()
    if type_to_delete:
        db.delete(type_to_delete)
        db.commit()

    return RedirectResponse(url="/investors", status_code=303)
