from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_authenticated_user
from models import SwingReason

router = APIRouter()
templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/swing_reason", response_class=HTMLResponse)
async def directory(
    request: Request,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    type_swings = db.query(SwingReason).all()
    return templates.TemplateResponse(
        "directory/swing_reason.html",
        {"request": request, "swing_reason": type_swings},
    )


@router.post("/swing_reason/add", response_class=HTMLResponse)
async def add_swing(
    request: Request,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user

    new_swing_reason = SwingReason(title=title)
    db.add(new_swing_reason)
    db.commit()

    return RedirectResponse(url="/swing_reason", status_code=303)


@router.post("/swing_reason/edit/{id}", response_class=HTMLResponse)
async def edit_swing(
    request: Request,
    id: int,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user

    # Поиск и обновление записи
    swing = db.query(SwingReason).filter(SwingReason.id == id).first()
    if swing:
        swing.title = title
        db.commit()

    return RedirectResponse(url="/swing_reason", status_code=303)


@router.post("/swing_reason/delete/{id}", response_class=HTMLResponse)
async def delete_swing(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user

    # Поиск и удаление записи
    swing = db.query(SwingReason).filter(SwingReason.id == id).first()
    if swing:
        db.delete(swing)
        db.commit()

    return RedirectResponse(url="/swing_reason", status_code=303)
