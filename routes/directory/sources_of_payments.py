from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_authenticated_user
from models import Sources

router = APIRouter()

templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/sources_of_payments", response_class=HTMLResponse)
async def directory(
    request: Request,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    sources = db.query(Sources).all()

    return templates.TemplateResponse(
        "directory/sources_of_payments.html",
        {
            "request": request,
            "sources": sources,
        },
    )


@router.post("/sources_of_payments/add", response_class=HTMLResponse)
async def add_type_souce(
    request: Request,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    new_type = Sources(title=title)
    db.add(new_type)
    db.commit()

    return RedirectResponse(url="/sources_of_payments", status_code=303)


@router.post("/sources_of_payments/edit/{id}", response_class=HTMLResponse)
async def edit_type_source(
    request: Request,
    id: int,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    # Поиск записи по id
    type_to_edit = db.query(Sources).filter(Sources.id == id).first()
    if type_to_edit:
        type_to_edit.title = title  # Обновляем название
        db.commit()

    return RedirectResponse(url="/sources_of_payments", status_code=303)


@router.post("/sources_of_payments/delete/{id}", response_class=HTMLResponse)
async def delete_type_source(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    type_to_delete = db.query(Sources).filter(Sources.id == id).first()
    if type_to_delete:
        db.delete(type_to_delete)
        db.commit()

    return RedirectResponse(url="/sources_of_payments", status_code=303)
