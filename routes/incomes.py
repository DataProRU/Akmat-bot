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
from dependencies import get_token_from_cookie, get_current_user
from fastapi.responses import JSONResponse

router = APIRouter()
templates = Jinja2Templates(directory="templates")
def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()

def get_flight_techniques(page: int = 1, per_page: int = 10):
    session = Session()
    try:
        offset = (page - 1) * per_page
        flights_techniques = (
            session.query(FlightTechniques).offset(offset).limit(per_page).all()
        )
        total_count = session.query(FlightTechniques).count()  # Подсчёт общего числа записей
        total_pages = (total_count + per_page - 1) // per_page  # Подсчёт числа страниц

        techniques = {tech.id: tech.title for tech in session.query(Techniques).all()}
        flights = {flight.id: flight for flight in session.query(Flights).all()}
        routes = {route.id: route.title for route in session.query(Routes).all()}
        users = {user.id: user.full_name for user in session.query(Users).filter(Users.is_instructor == True).all()}
        payment_types = {ptype.id: ptype.title for ptype in session.query(PaymentTypes)}
        sources = {source.id: source.title for source in session.query(Sources)}

        return {
            "flights_techniques": flights_techniques,
            "techniques": techniques,
            "flights": flights,
            "routes": routes,
            "users": users,
            "payment_types": payment_types,
            "sources": sources,
            "total_pages": total_pages,
            "page": page
        }
    finally:
        session.close()

@router.get("/income", response_class=HTMLResponse)
async def index(
        request: Request,
        page: int = Query(1, ge=1),
        per_page: int = Query(20, ge=1, le=100),
):
    # Получаем токен
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    # Извлекаем информацию о пользователе
    username = payload.get("sub")
    role = payload.get("role")

    # Получаем данные для отображения на странице
    result = get_flight_techniques(page, per_page)
    flights_techniques = result["flights_techniques"]
    techniques = result["techniques"]
    flights = result["flights"]
    routes = result["routes"]
    users = result["users"]
    payment_types = result["payment_types"]
    sources = result["sources"]
    total_pages = result["total_pages"]

    data = []
    for flight_technique in flights_techniques:
        flight = flights.get(flight_technique.flight_id)
        if flight:
            technique_name = techniques.get(
                flight_technique.technique_id, "Unknown Technique"
            )
            user_name = users.get(flight.instructor_id, "Unknown User")
            flight_name = routes.get(flight.flight_number, "Unknown Route")
            data.append(
                {
                    "id": flight_technique.id,
                    "created_at": flight_technique.created_at,
                    "flight_number": flight.id,
                    "flight_name": flight_name,
                    "technique_name": technique_name,
                    "user_name": user_name,
                    "discount": flight_technique.discount,
                    "prepayment": "Yes" if flight_technique.prepayment else "No",
                    "price": flight_technique.price,
                    "payment_type": payment_types.get(
                        flight_technique.payment_type_id, "Unknown Payment Type"
                    ),
                    "source": sources.get(flight_technique.source_id, "Unknown Source"),
                    "note": flight_technique.note,
                }
            )
    # Возвращаем HTML-шаблон с данными
    return templates.TemplateResponse(
        "income.html",
        {
            "request": request,
            "data": data,
            "page": page,
            "per_page": per_page,
            "total_pages": total_pages,
            "users": users,
            "techniques": techniques,
            "payment_types": payment_types,
            "sources": sources,
            "routes": routes,
        },
    )

def get_filtered_flight_techniques(day: Optional[int], month: Optional[int], year: Optional[int], page: int = 1, per_page: int = 30):
    session = Session()
    try:
        offset = (page - 1) * per_page
        query = session.query(FlightTechniques)

        # Фильтрация по дате
        if day is not None:
            query = query.filter(extract('day', FlightTechniques.created_at) == day)
        if month is not None:
            query = query.filter(extract('month', FlightTechniques.created_at) == month)
        if year is not None:
            query = query.filter(extract('year', FlightTechniques.created_at) == year)

        # Пагинация
        flights_techniques = query.offset(offset).limit(per_page).all()
        total_count = query.count()  # Подсчёт общего числа записей
        total_pages = (total_count + per_page - 1) // per_page  # Подсчёт числа страниц

        techniques = {tech.id: tech.title for tech in session.query(Techniques).all()}
        flights = {flight.id: flight for flight in session.query(Flights).all()}
        routes = {route.id: route.title for route in session.query(Routes).all()}
        users = {user.id: user.full_name for user in session.query(Users).all()}
        payment_types = {ptype.id: ptype.title for ptype in session.query(PaymentTypes)}
        sources = {source.id: source.title for source in session.query(Sources)}

        return {
            "flights_techniques": flights_techniques,
            "techniques": techniques,
            "flights": flights,
            "routes": routes,
            "users": users,
            "payment_types": payment_types,
            "sources": sources,
            "total_pages": total_pages,
            "page": page
        }
    finally:
        session.close()


@router.get("/filtered-income", response_class=HTMLResponse)
async def filtered_income(
    request: Request,
    day: Optional[int] = Query(None),  # Параметр фильтрации по дню (может быть пустым)
    month: Optional[int] = Query(None),  # Параметр фильтрации по месяцу (может быть пустым)
    year: Optional[int] = Query(None),  # Параметр фильтрации по году (может быть пустым)
    page: int = Query(1, ge=1),  # Параметр пагинации (страница)
    per_page: int = Query(30, ge=1, le=100),  # Параметр количества записей на страницу
):
    # Получаем токен и проверяем пользователя
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    # Получаем данные с учетом фильтрации по дате
    result = get_filtered_flight_techniques(day, month, year, page, per_page)
    flights_techniques = result["flights_techniques"]
    techniques = result["techniques"]
    flights = result["flights"]
    routes = result["routes"]
    users = result["users"]
    payment_types = result["payment_types"]
    sources = result["sources"]
    total_pages = result["total_pages"]

    # Формируем список данных для отображения
    data = []
    for flight_technique in flights_techniques:
        flight = flights.get(flight_technique.flight_id)
        if flight:
            technique_name = techniques.get(flight_technique.technique_id, "Unknown Technique")
            user_name = users.get(flight.instructor_id, "Unknown User")
            flight_name = routes.get(flight.flight_number, "Unknown Route")
            data.append(
                {
                    "id": flight_technique.id,
                    "created_at": flight_technique.created_at,
                    "flight_number": flight.id,
                    "flight_name": flight_name,
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

    # Возвращаем HTML-шаблон с отфильтрованными данными
    return templates.TemplateResponse(
        "income.html",
        {
            "request": request,
            "data": data,
            "page": page,
            "per_page": per_page,
            "total_pages": total_pages,
            "techniques": techniques,
        },
    )



@router.get("/api/flight_techniques")
async def flight_techniques_api(
    request: Request,
    page: int = Query(1, ge=1),
    per_page: int = Query(10, ge=1, le=100),
):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload
    role = payload.get("role")
    data = []
    if role == "admin" or role == "user":
        flights_techniques, techniques, flights, routes, users, payment_types, sources = (
            get_flight_techniques(page, per_page)
        )
        data = []
        for flight_technique in flights_techniques:
            flight = flights.get(flight_technique.flight_id)
            if flight:
                technique_name = techniques.get(
                    flight_technique.technique_id, "Unknown Technique"
                )
                user_name = users.get(flight.instructor_id, "Unknown User")
                flight_name = routes.get(flight.flight_number, "Unknown Route")
                data.append(
                    {
                        "id": flight_technique.id,
                        "created_at": flight_technique.created_at,
                        "flight_number": flight.id,
                        "flight_name": flight_name,
                        "technique_name": technique_name,
                        "user_name": user_name,
                        "discount": flight_technique.discount,
                        "prepayment": "Yes" if flight_technique.prepayment else "No",
                        "price": flight_technique.price,
                        "payment_type": payment_types.get(
                            flight_technique.payment_type_id, "Unknown Payment Type"
                        ),
                        "source": sources.get(flight_technique.source_id, "Unknown Source"),
                        "note": flight_technique.note,
                    }
                )
    return data


@router.put("/flight_techniques/{flight_technique_id}")
async def update_flight_technique(
    flight_technique_id: int, data: FlightTechniqueUpdate
):
    session = Session()
    try:
        flight_technique = (
            session.query(FlightTechniques)
            .filter(FlightTechniques.id == flight_technique_id)
            .first()
        )

        if not flight_technique:
            raise HTTPException(status_code=404, detail="Flight technique not found")

        flight_technique.flight_id = data.flight_id
        flight_technique.technique_id = data.technique_id
        flight_technique.discount = data.discount
        flight_technique.prepayment = data.prepayment
        flight_technique.price = data.price
        flight_technique.payment_type_id = data.payment_type_id
        flight_technique.source_id = data.source_id
        flight_technique.note = data.note

        session.commit()

        return RedirectResponse(url="/income", status_code=303)
    except Exception as e:
        session.rollback()
        raise HTTPException(
            status_code=500, detail="An error occurred while updating flight technique"
        )
    finally:
        session.close()


@router.post("/flight_techniques/{flight_technique_id}")
async def delete_flight_technique(flight_technique_id: int):
    session = Session()
    try:
        flight_technique = (
            session.query(FlightTechniques)
            .filter(FlightTechniques.id == flight_technique_id)
            .first()
        )

        if not flight_technique:
            raise HTTPException(status_code=404, detail="Flight technique not found")

        session.delete(flight_technique)
        session.commit()

        return RedirectResponse(url="/income", status_code=303)
    except Exception as e:
        session.rollback()
        raise HTTPException(
            status_code=500, detail="An error occurred while deleting flight technique"
        )
    finally:
        session.close()

@router.post("/submit")
async def submit_form(
    flight_number: int = Form(...),
    instructor_id: int = Form(...),
    date: str = Form(...),
    route_id: int = Form(...),  # Добавляем параметр route_id
    technique_id: int = Form(...),
    discount: float = Form(0),
    prepayment: bool = Form(False),
    price: float = Form(...),
    payment_type_id: int = Form(...),
    source_id: int = Form(...),
    note: str = Form(""),
    db: Session = Depends(get_db)
):
    try:
        # Создание новой записи в таблице Flights
        new_flight = Flights(
            flight_number=flight_number,
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
            created_at=datetime.datetime.now(),
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
        return RedirectResponse(url="/income", status_code=303)
    except Exception as e:
        db.rollback()
        return {"error": str(e)}
    finally:
        db.close()


@router.post("/delete_flight/")
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


@router.post("/update_flight/")
async def update_flight(request: Request):
    form_data = await request.form()
    flight_id = form_data.get("id")

    # Извлечение данных из формы
    flight_number = form_data.get("flight_number")
    technique_id = form_data.get("technique_id") #может падать если не ввести данные формы вручную
    instructor = form_data.get("edit-instructor")
    route_type = form_data.get("type-of-route")
    price = form_data.get("price")
    discount = form_data.get("discount")
    prepayment = form_data.get("prepayment") == "on"
    payment_type = form_data.get("payment_type")
    source_id = form_data.get("source_id")
    note = form_data.get("note")

    # Обновление записи в базе данных
    session = Session()
    flight_techniques = session.query(FlightTechniques).filter_by(id=flight_id).first()

    if flight_techniques:
        flight_techniques.flight_number = flight_number
        flight_techniques.technique_id = technique_id
        flight_techniques.price = price
        flight_techniques.discount = discount
        flight_techniques.prepayment = prepayment
        flight_techniques.payment_type = payment_type
        flight_techniques.source_id = source_id
        flight_techniques.note = note

        session.commit()
        session.close()

    flight_technique = session.query(Flights).filter_by(id=flight_id).first()
    if flight_technique:
        flight_technique.technique_id = technique_id
        flight_technique.instructor_id = instructor
        flight_technique.route_id = route_type

        session.commit()
        session.close()

    return RedirectResponse(url="/income", status_code=303)
