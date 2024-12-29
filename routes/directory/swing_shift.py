from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_authenticated_user
from models import SwingShift

router = APIRouter()
templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/swing_shift", response_class=HTMLResponse)
async def directory(
    request: Request,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    type_swings = db.query(SwingShift).all()
    return templates.TemplateResponse(
        "directory/swing_shift.html",
        {"request": request, "type_swings": type_swings},
    )


@router.post("/swing_shift/add", response_class=HTMLResponse)
async def add_swing(
    request: Request,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user

    new_swing = SwingShift(title=title)
    db.add(new_swing)
    db.commit()

    return RedirectResponse(url="/swing_shift", status_code=303)


@router.post("/swing_shift/edit/{id}", response_class=HTMLResponse)
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
    swing = db.query(SwingShift).filter(SwingShift.id == id).first()
    if swing:
        swing.title = title
        db.commit()

    return RedirectResponse(url="/swing_shift", status_code=303)


@router.post("/swing_shift/delete/{id}", response_class=HTMLResponse)
async def delete_swing(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user

    # Поиск и удаление записи
    swing = db.query(SwingShift).filter(SwingShift.id == id).first()
    if swing:
        db.delete(swing)
        db.commit()

    return RedirectResponse(url="/swing_shift", status_code=303)
