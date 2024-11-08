from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_authenticated_user
from models import CategoryExpenses

router = APIRouter()

templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/expenses_categories", response_class=HTMLResponse)
async def directory(
    request: Request,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    category_expenses = db.query(CategoryExpenses).all()

    return templates.TemplateResponse(
        "directory/expenses_categories.html",
        {"request": request, "category_expenses": category_expenses},
    )


@router.post("/expenses_categories/add", response_class=HTMLResponse)
async def add_expenses_categories(
    request: Request,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    new_type = CategoryExpenses(title=title)
    db.add(new_type)
    db.commit()

    return RedirectResponse(url="/expenses_categories", status_code=303)


@router.post("/expenses_categories/edit/{id}", response_class=HTMLResponse)
async def edit_expenses_categories(
    request: Request,
    id: int,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    # Поиск записи по id
    type_to_edit = db.query(CategoryExpenses).filter(CategoryExpenses.id == id).first()
    if type_to_edit:
        type_to_edit.title = title  # Обновляем название
        db.commit()

    return RedirectResponse(url="/expenses_categories", status_code=303)


@router.post("/expenses_categories/delete/{id}", response_class=HTMLResponse)
async def delete_expenses_categories(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    type_to_delete = (
        db.query(CategoryExpenses).filter(CategoryExpenses.id == id).first()
    )
    if type_to_delete:
        db.delete(type_to_delete)
        db.commit()

    return RedirectResponse(url="/expenses_categories", status_code=303)
