from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_authenticated_user
from models import Routes

router = APIRouter()

templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/flight_routers", response_class=HTMLResponse)
async def directory(
    request: Request,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    # Получаем токен
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    routers = db.query(Routes).all()

    return templates.TemplateResponse(
        "directory/flight_routers.html", {"request": request, "routers": routers}
    )


@router.post("/flight_routers/add", response_class=HTMLResponse)
async def add_type_routers(
    request: Request,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    new_type = Routes(title=title)
    db.add(new_type)
    db.commit()

    return RedirectResponse(url="/flight_routers", status_code=303)


@router.post("/flight_routers/edit/{id}", response_class=HTMLResponse)
async def edit_type_routers(
    request: Request,
    id: int,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    # Поиск записи по id
    type_to_edit = db.query(Routes).filter(Routes.id == id).first()
    if type_to_edit:
        type_to_edit.title = title  # Обновляем название
        db.commit()

    return RedirectResponse(url="/flight_routers", status_code=303)


@router.post("/flight_routers/delete/{id}", response_class=HTMLResponse)
async def delete_type_routers(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    type_to_delete = db.query(Routes).filter(Routes.id == id).first()
    if type_to_delete:
        db.delete(type_to_delete)
        db.commit()

    return RedirectResponse(url="/flight_routers", status_code=303)
