from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_token_from_cookie, get_current_user
from models import TypeTechniques

router = APIRouter()

templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/type_of_technique", response_class=HTMLResponse)
async def directory(request: Request, db: Session = Depends(get_db)):
    # Получаем токен
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    type_techniques = db.query(TypeTechniques).all()

    return templates.TemplateResponse(
        "directory/type_of_technique.html",
        {"request": request, "type_techniques": type_techniques},
    )


@router.post("/type_of_technique/add", response_class=HTMLResponse)
async def add_type_technique(
    request: Request, title: str = Form(...), db: Session = Depends(get_db)
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    new_type = TypeTechniques(title=title)
    db.add(new_type)
    db.commit()

    return RedirectResponse(url="/type_of_technique", status_code=303)


@router.post("/type_of_technique/edit/{id}", response_class=HTMLResponse)
async def edit_type_technique(
    request: Request, id: int, title: str = Form(...), db: Session = Depends(get_db)
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    # Поиск записи по id
    type_to_edit = db.query(TypeTechniques).filter(TypeTechniques.id == id).first()
    if type_to_edit:
        type_to_edit.title = title  # Обновляем название
        db.commit()

    return RedirectResponse(url="/type_of_technique", status_code=303)


@router.post("/type_of_technique/delete/{id}", response_class=HTMLResponse)
async def delete_type_technique(
    request: Request, id: int, db: Session = Depends(get_db)
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload

    type_to_delete = db.query(TypeTechniques).filter(TypeTechniques.id == id).first()
    if type_to_delete:
        db.delete(type_to_delete)
        db.commit()

    return RedirectResponse(url="/type_of_technique", status_code=303)
