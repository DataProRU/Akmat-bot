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
from fastapi import Form
from datetime import datetime
from dependencies import get_token_from_cookie, get_current_user


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
            FlightTechniques.is_approved == False, # Фильтр по неподтверждённым записям
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
        "page": page,
        "techniques": techniques,
        "flights": flights,
        "routes": routes,
        "users": users,
        "payment_types": payment_types,
        "sources": sources,
    }


@router.get("/unapproved-days", response_class=HTMLResponse)
async def unapproved_days(request: Request, db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина
    # Получаем все уникальные даты с неподтверждёнными записями
    days_with_unapproved = db.query(
        extract('day', FlightTechniques.created_at).label('day'),
        extract('month', FlightTechniques.created_at).label('month'),
        extract('year', FlightTechniques.created_at).label('year')
    ).join(Flights, Flights.id == FlightTechniques.flight_id) \
     .filter(
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
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина
    # Передаем объект сессии в функцию get_filtered_flight_techniques
    result = get_filtered_flight_techniques(day=day, month=month, year=year, page=page, per_page=per_page, db=db)

    flights_techniques = result["flights_techniques"]
    techniques = result["techniques"]
    routes = result["routes"]
    users = result["users"]
    payment_types = result["payment_types"]
    sources = result["sources"]


    # Передаём отфильтрованные записи в шаблон
    return templates.TemplateResponse("unapproved_records.html", {

        "request": request,
        "flights_techniques": flights_techniques,
        "day": day,
        "month": month,
        "year": year,
        "page": page,
        "per_page": per_page,
        "total_pages": result["total_pages"],
        "users": users,
        "techniques": techniques,
        "payment_types": payment_types,
        "sources": sources,
        "routes": routes,
    })

@router.post("/approve-all", response_class=RedirectResponse)
async def approve_all_records(
    request: Request,
    day: int = Form(...),
    month: int = Form(...),
    year: int = Form(...),
    db: Session = Depends(get_db)
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина
    # Обновляем записи в Flights и устанавливаем confirmed в True
    db.query(Flights).filter(
        extract('day', Flights.flight_date) == day,
        extract('month', Flights.flight_date) == month,
        extract('year', Flights.flight_date) == year
    ).update({"confirmed": True}, synchronize_session="fetch")

    db.query(FlightTechniques).filter(
        extract('day', FlightTechniques.created_at) == day,
        extract('month', FlightTechniques.created_at) == month,
        extract('year', FlightTechniques.created_at) == year
    ).update({"is_approved": True}, synchronize_session="fetch")

    # Сохраняем изменения
    db.commit()

    # Перенаправляем обратно на страницу с неподтверждёнными записями
    return RedirectResponse(url=f"/unapproved-days", status_code=303)

@router.post("/delete_unapproved/")
async def delete_flight(
request: Request,
    id: int = Form(...),
    day: int = Form(...),
    month: int = Form(...),
    year: int = Form(...),
    db: Session = Depends(get_db)
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина
    flight = db.query(FlightTechniques).filter(FlightTechniques.id == id).first()

    if flight:
        db.delete(flight)
        db.commit()
        return RedirectResponse(url=f"/unapproved-records?day={day}&month={month}&year={year}", status_code=303)

    return JSONResponse({"status": "error", "message": "Flight not found"})

@router.post("/submit_unapproved")
async def submit_form(
request: Request,
    flight_number: int = Form(...),
    instructor_id: int = Form(...),
    date: str = Form(str(datetime.now())),
    route_id: int = Form(...),
    technique_id: int = Form(...),
    discount: float = Form(0),
    prepayment: bool = Form(False),
    price: float = Form(...),
    payment_type_id: int = Form(...),
    source_id: int = Form(...),
    note: str = Form(""),
    day: int = Form(...), #для того что бы остаться на той же странице
    month: int = Form(...),
    year: int = Form(...),
    db: Session = Depends(get_db)
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина
    try:
        # Создание новой записи в таблице Flights
        new_flight = Flights(
            flight_number=route_id,
            instructor_id=instructor_id,
            flight_date=date,
            route_id=route_id,
            manager_id=0,
            confirmed=False,
            source_id=source_id,
            source_data=note,
            created_at=date,
        )
        db.add(new_flight)
        db.flush()  # Это нужно для получения id нового рейса

        # Создание новой записи в таблице FlightTechniques
        new_flight_technique = FlightTechniques(
            created_at=date,
            flight_id=new_flight.id,
            technique_id=technique_id,
            discount=discount,
            prepayment=prepayment,
            price=price,
            payment_type_id=payment_type_id,
            source_id=source_id,
            note=note,
            is_approved=False,
            transfer=0,
        )
        db.add(new_flight_technique)
        db.commit()
        return RedirectResponse(url=f"/unapproved-records?day={day}&month={month}&year={year}", status_code=303)
    except Exception as e:
        db.rollback()
        return {"error": str(e)}
    finally:
        db.close()

@router.post("/update_unapproved_flight/")
async def update_flight(request: Request):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload
    form_data = await request.form()
    flight_id = form_data.get("id")

    # Извлечение данных из формы
    flight_date = form_data.get("date")
    flight_number = form_data.get("flight_number")
    technique_id = form_data.get("technique_id")
    instructor = form_data.get("edit-instructor")
    route_type = form_data.get("type-of-route")
    price = form_data.get("price")
    discount = form_data.get("discount")
    prepayment = form_data.get("prepayment")=="no"
    payment_type = form_data.get("payment_type")
    source_id = form_data.get("source_id")
    note = form_data.get("note")

    session = Session()
    flight_techniques = session.query(FlightTechniques).filter_by(id=flight_id).first()

    # Обновление записи в базе данных

    if flight_techniques:
        flight_techniques.created_at = flight_techniques.created_at
        flight_techniques.flight_number = flight_number
        flight_techniques.technique_id = technique_id
        flight_techniques.price = price
        flight_techniques.discount = discount
        flight_techniques.prepayment = prepayment
        flight_techniques.payment_type = payment_type
        flight_techniques.source_id = source_id
        flight_techniques.note = note

        session.commit()

    flight = session.query(Flights).filter_by(id=flight_id).first()
    if flight:
        flight.technique_id = technique_id
        flight.instructor_id = instructor
        flight.route_id = route_type
        flight.flight_number = route_type

        session.commit()

    day = ""
    month = ""
    year = ""
    if flight_techniques.created_at:
        try:
            flight_date_obj = datetime.fromisoformat(str(flight_techniques.created_at))
            day = flight_date_obj.day
            month = flight_date_obj.month
            year = flight_date_obj.year
        except ValueError:
            return {"error": "Неверный формат даты"}

    session.close()

    # Редирект с параметрами даты
    return RedirectResponse(url=f"/unapproved-records?day={day}&month={month}&year={year}", status_code=303)