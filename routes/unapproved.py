from fastapi import Query, Request, Form, Depends
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from models import (
    FlightTechniques,
    Techniques,
    Flights,
    Routes,
    Users,
    PaymentTypes,
    Sources,
)
from fastapi import APIRouter
from fastapi.templating import Jinja2Templates
from sqlalchemy import extract
from fastapi.responses import JSONResponse


router = APIRouter()
templates = Jinja2Templates(directory="templates")

def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()

def get_filtered_flight_techniques(day: int, month: int, year: int, page: int, per_page: int, db: Session):
    offset = (page - 1) * per_page

    # Выполняем запрос для получения данных о неподтверждённых записях полётов по дате и confirmed == False
    flights_techniques = (
        db.query(FlightTechniques)
        .join(Flights, Flights.id == FlightTechniques.flight_id)
        .filter(
            Flights.confirmed == False,  # Фильтр по неподтверждённым записям
            extract('day', FlightTechniques.created_at) == day,
            extract('month', FlightTechniques.created_at) == month,
            extract('year', FlightTechniques.created_at) == year
        )
        .offset(offset)
        .limit(per_page)
        .all()
    )

    # Подсчёт общего числа записей с confirmed == False
    total_count = (
        db.query(FlightTechniques)
        .join(Flights, Flights.id == FlightTechniques.flight_id)
        .filter(
            Flights.confirmed == False,
            extract('day', FlightTechniques.created_at) == day,
            extract('month', FlightTechniques.created_at) == month,
            extract('year', FlightTechniques.created_at) == year
        )
        .count()
    )
    total_pages = (total_count + per_page - 1) // per_page

    # Загружаем связанные данные и преобразуем результаты, как и ранее
    techniques = {tech.id: tech.title for tech in db.query(Techniques).all()}
    flights = {flight.id: flight for flight in db.query(Flights).all()}
    users = {user.id: user.full_name for user in db.query(Users).all()}
    payment_types = {ptype.id: ptype.title for ptype in db.query(PaymentTypes).all()}
    sources = {source.id: source.title for source in db.query(Sources).all()}
    routes = {route.id: route.title for route in db.query(Routes).all()}

    # Преобразуем данные о полётах и техниках
    results = []
    for flight_technique in flights_techniques:
        flight = flights.get(flight_technique.flight_id)
        if flight:
            technique_name = techniques.get(flight_technique.technique_id, "Unknown Technique")
            user_name = users.get(flight.instructor_id, "Unknown User")
            route_name = routes.get(flight.route_id, "Unknown Route")

            results.append(
                {
                    "id": flight_technique.id,
                    "created_at": flight_technique.created_at,
                    "flight_number": flight.id,
                    "flight_name": route_name,
                    "technique_name": technique_name,
                    "user_name": user_name,
                    "discount": flight_technique.discount,
                    "prepayment": "Yes" if flight_technique.prepayment else "No",
                    "price": flight_technique.price,
                    "payment_type": payment_types.get(flight_technique.payment_type_id, "Unknown Payment Type"),
                    "source": sources.get(flight_technique.source_id, "Unknown Source"),
                    "note": flight_technique.note,
                }
            )

    return {
        "flights_techniques": results,
        "total_pages": total_pages,
        "page": page
    }


@router.get("/unapproved-days", response_class=HTMLResponse)
async def unapproved_days(request: Request, db: Session = Depends(get_db)):
    # Получаем все уникальные даты с неподтверждёнными записями
    days_with_unapproved = db.query(
        extract('day', FlightTechniques.created_at).label('day'),
        extract('month', FlightTechniques.created_at).label('month'),
        extract('year', FlightTechniques.created_at).label('year')
    ).join(Flights, Flights.id == FlightTechniques.flight_id) \
     .filter(
         Flights.confirmed == False,           # Учитываем поле confirmed в таблице Flights
         FlightTechniques.is_approved == False
     ) \
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
    # Передаем объект сессии в функцию get_filtered_flight_techniques
    result = get_filtered_flight_techniques(day=day, month=month, year=year, page=page, per_page=per_page, db=db)

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

@router.post("/approve-all", response_class=RedirectResponse)
async def approve_all_records(
    day: int = Form(...),
    month: int = Form(...),
    year: int = Form(...),
    db: Session = Depends(get_db)
):
    # Обновляем записи в Flights и устанавливаем confirmed в True
    db.query(Flights).filter(
        extract('day', Flights.flight_date) == day,
        extract('month', Flights.flight_date) == month,
        extract('year', Flights.flight_date) == year
    ).update({"confirmed": True})

    # Сохраняем изменения
    db.commit()

    # Перенаправляем обратно на страницу с неподтверждёнными записями
    return RedirectResponse(url=f"/unapproved-days", status_code=303)

@router.post("/delete_unapproved/")
async def delete_flight(request: Request):
    form_data = await request.form()
    flight_id = form_data.get("id")

    page = request.query_params.get("page", 1)

    if not flight_id:
        return JSONResponse({"status": "error", "message": "ID not provided"})

    session = Session()
    flight = session.query(FlightTechniques).filter(FlightTechniques.id == flight_id).first()

    if flight:
        session.delete(flight)
        session.commit()
        session.close()
        return RedirectResponse(url=f"/income?page={page}", status_code=303)

    session.close()
    return JSONResponse({"status": "error", "message": "Flight not found"})