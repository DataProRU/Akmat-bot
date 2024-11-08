from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_authenticated_user
from models import Ranks

router = APIRouter()

templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/positions", response_class=HTMLResponse)
async def directory(
    request: Request,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    ranks = db.query(Ranks).all()

    return templates.TemplateResponse(
        "directory/positions.html", {"request": request, "ranks": ranks}
    )


@router.post("/positions/add", response_class=HTMLResponse)
async def add_position(
    request: Request,
    rank: str = Form(...),
    salary: str = Form(...),
    percent: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    new_type = Ranks(rank=rank, salary=salary, percent=percent)
    db.add(new_type)
    db.commit()

    return RedirectResponse(url="/positions", status_code=303)


@router.post("/positions/edit/{id}", response_class=HTMLResponse)
async def edit_position(
    request: Request,
    id: int,
    rank: str = Form(...),
    salary: str = Form(...),
    percent: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    # Поиск записи по id
    type_to_edit = db.query(Ranks).filter(Ranks.id == id).first()
    if type_to_edit:
        type_to_edit.rank = rank
        type_to_edit.salary = salary
        type_to_edit.percent = percent
        db.commit()

    return RedirectResponse(url="/positions", status_code=303)


@router.post("/positions/delete/{id}", response_class=HTMLResponse)
async def delete_positions(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    type_to_delete = db.query(Ranks).filter(Ranks.id == id).first()
    if type_to_delete:
        db.delete(type_to_delete)
        db.commit()

    return RedirectResponse(url="/positions", status_code=303)
