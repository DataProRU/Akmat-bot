import datetime

from fastapi import Query, Request, HTTPException, Form, Depends
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from typing import Optional
from sqlalchemy import extract
from models import (
    FlightTechniques,
    Techniques,
    Flights,
    Routes,
    Users,
    PaymentTypes,
    Sources,
    FlightTechniqueUpdate,
)
from fastapi import APIRouter
from fastapi.templating import Jinja2Templates
from routes.incomes import get_filtered_flight_techniques


router = APIRouter()
templates = Jinja2Templates(directory="templates")

def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()
@router.get("/unapproved-days", response_class=HTMLResponse)
async def unapproved_days(request: Request, db: Session = Depends(get_db)):
    # Получаем все уникальные даты с неподтверждёнными записями
    days_with_unapproved = db.query(extract('day', FlightTechniques.created_at).label('day'),
                                    extract('month', FlightTechniques.created_at).label('month'),
                                    extract('year', FlightTechniques.created_at).label('year'))\
                            .filter(FlightTechniques.is_approved == False)\
                            .group_by('day', 'month', 'year').all()

    # Возвращаем шаблон с кнопками для каждого дня
    return templates.TemplateResponse("unapproved_days.html", {
        "request": request,
        "days_with_unapproved": days_with_unapproved
    })
@router.get("/unapproved-records", response_class=HTMLResponse)
async def unapproved_records(
    request: Request,
    day: int = Query(...),
    month: int = Query(...),
    year: int = Query(...),
    page: int = Query(1, ge=1),
    per_page: int = Query(30, ge=1, le=100),
    db: Session = Depends(get_db)
):
    # Фильтруем неподтверждённые записи по дате
    result = get_filtered_flight_techniques(day=day, month=month, year=year, page=page, per_page=per_page)
    flights_techniques = result["flights_techniques"]

    # Передаём отфильтрованные записи в шаблон
    return templates.TemplateResponse("unapproved_records.html", {
        "request": request,
        "flights_techniques": flights_techniques,
        "day": day,
        "month": month,
        "year": year,
        "page": page,
        "per_page": per_page,
        "total_pages": result["total_pages"]
    })
