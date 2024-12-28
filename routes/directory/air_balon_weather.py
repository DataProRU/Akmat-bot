from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_authenticated_user
from models import AirBalonWeather

router = APIRouter()
templates = Jinja2Templates(directory="templates")


def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()


@router.get("/air_balon_weather", response_class=HTMLResponse)
async def directory(
    request: Request,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user  # Если пользователь не аутентифицирован

    weather = db.query(AirBalonWeather).all()
    return templates.TemplateResponse(
        "directory/air_balon_weather.html",
        {"request": request, "weather": weather},
    )


@router.post("/air_balon_weather/add", response_class=HTMLResponse)
async def add_swing(
    request: Request,
    title: str = Form(...),
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user

    new_weather = AirBalonWeather(title=title)
    db.add(new_weather)
    db.commit()

    return RedirectResponse(url="/air_balon_weather", status_code=303)


@router.post("/air_balon_weather/edit/{id}", response_class=HTMLResponse)
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
    weather = db.query(AirBalonWeather).filter(SwingShift.id == id).first()
    if weather:
        weather.title = title
        db.commit()

    return RedirectResponse(url="/air_balon_weather", status_code=303)


@router.post("/air_balon_weather/delete/{id}", response_class=HTMLResponse)
async def delete_swing(
    request: Request,
    id: int,
    db: Session = Depends(get_db),
    user: dict = Depends(get_authenticated_user),
):
    if isinstance(user, RedirectResponse):
        return user

    # Поиск и удаление записи
    swing = db.query(AirBalonWeather).filter(AirBalonWeather.id == id).first()
    if swing:
        db.delete(swing)
        db.commit()

    return RedirectResponse(url="/air_balon_weather", status_code=303)
