from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_authenticated_user
from models import TypeExpenses, CategoryExpenses

router = APIRouter()

templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/types_of_expenses", response_class=HTMLResponse)
async def directory(
    request: Request,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    type_expenses = db.query(TypeExpenses).all()
    category_expenses = db.query(CategoryExpenses).all()

    return templates.TemplateResponse(
        "directory/types_of_expenses.html",
        {
            "request": request,
            "type_expenses": type_expenses,
            "category_expenses": category_expenses,
        },
    )


@router.post("/types_of_expenses/add", response_class=HTMLResponse)
async def add_expenses(
    request: Request,
    title: str = Form(...),
    category_exp_id: int = Form(...),
    visible_investor: bool = Form(False),
    visible_employee: bool = Form(False),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    new_exp = TypeExpenses(
        title=title,
        category_exp_id=category_exp_id,
        visible_investor=visible_investor,
        visible_employee=visible_employee,
    )
    db.add(new_exp)
    db.commit()

    return RedirectResponse(url="/types_of_expenses", status_code=303)


@router.post("/types_of_expenses/edit/{id}", response_class=HTMLResponse)
async def edit_types_of_expenses(
    request: Request,
    id: int,
    title: str = Form(...),
    category_exp_id: int = Form(...),
    visible_investor: bool = Form(False),
    visible_employee: bool = Form(False),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    # Поиск записи по id
    type_to_edit = db.query(TypeExpenses).filter(TypeExpenses.id == id).first()
    if type_to_edit:
        type_to_edit.title = title
        type_to_edit.category_exp_id = category_exp_id
        type_to_edit.visible_investor = visible_investor
        type_to_edit.visible_employee = visible_employee
        db.commit()

    return RedirectResponse(url="/types_of_expenses", status_code=303)


@router.post("/types_of_expenses/delete/{id}", response_class=HTMLResponse)
async def delete_expenses(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    exp_to_delete = db.query(TypeExpenses).filter(TypeExpenses.id == id).first()
    if exp_to_delete:
        db.delete(exp_to_delete)
        db.commit()

    return RedirectResponse(url="/types_of_expenses", status_code=303)
