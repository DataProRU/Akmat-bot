from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_authenticated_user
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
async def directory(
    request: Request,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user)
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    type_commissions = db.query(Commisions).all()
    return templates.TemplateResponse(
        "directory/commissions.html",
        {"request": request, "type_commisions": type_commissions},
    )

@router.post("/commissions/add", response_class=HTMLResponse)
async def add_commissions(
    request: Request,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user)
):
    if isinstance(user, RedirectResponse):
        return user

    new_commission = Commisions(title=title)
    db.add(new_commission)
    db.commit()

    return RedirectResponse(url="/commissions", status_code=303)

@router.post("/commissions/edit/{id}", response_class=HTMLResponse)
async def edit_commissions(
    request: Request,
    id: int,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user)
):
    if isinstance(user, RedirectResponse):
        return user

    # Поиск и обновление записи
    commission = db.query(Commisions).filter(Commisions.id == id).first()
    if commission:
        commission.title = title
        db.commit()

    return RedirectResponse(url="/commissions", status_code=303)

@router.post("/commissions/delete/{id}", response_class=HTMLResponse)
async def delete_commissions(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user)
):
    if isinstance(user, RedirectResponse):
        return user

    # Поиск и удаление записи
    commission = db.query(Commisions).filter(Commisions.id == id).first()
    if commission:
        db.delete(commission)
        db.commit()

    return RedirectResponse(url="/commissions", status_code=303)
