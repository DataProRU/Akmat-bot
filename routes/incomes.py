from fastapi import Query, Request, HTTPException
from fastapi.responses import HTMLResponse
from database import Session
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

router = APIRouter()
templates = Jinja2Templates(directory="templates")


def get_flight_techniques(page: int = 1, per_page: int = 10):
    session = Session()
    try:
        offset = (page - 1) * per_page
        flights_techniques = (
            session.query(FlightTechniques).offset(offset).limit(per_page).all()
        )
        techniques = {tech.id: tech.title for tech in session.query(Techniques).all()}
        flights = {flight.id: flight for flight in session.query(Flights).all()}
        routes = {route.id: route.title for route in session.query(Routes).all()}
        users = {user.id: user.full_name for user in session.query(Users).all()}
        payment_types = {ptype.id: ptype.title for ptype in session.query(PaymentTypes)}
        sources = {source.id: source.title for source in session.query(Sources)}
        return (
            flights_techniques,
            techniques,
            flights,
            routes,
            users,
            payment_types,
            sources,
        )
    finally:
        session.close()


@router.get("/income", response_class=HTMLResponse)
async def index(
    request: Request,
    page: int = Query(1, ge=1),
    per_page: int = Query(10, ge=1, le=100),
):
    token = get_token_from_cookie(request)
    payload = get_current_user(token)
    username = payload.get("sub")
    role = payload.get("role")
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
    return templates.TemplateResponse(
        "income.html",
        {"request": request, "data": data, "page": page, "per_page": per_page},
    )


@router.get("/api/flight_techniques")
async def flight_techniques_api(
    request: Request,
    page: int = Query(1, ge=1),
    per_page: int = Query(10, ge=1, le=100),
):
    token = get_token_from_cookie(request)
    payload = get_current_user(token)
    username = payload.get("sub")
    role = payload.get("role")
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
        flight_technique.transfer = data.transfer
        flight_technique.note = data.note

        session.commit()

        return {"message": "Flight technique updated successfully"}
    except Exception as e:
        session.rollback()
        raise HTTPException(
            status_code=500, detail="An error occurred while updating flight technique"
        )
    finally:
        session.close()


@router.delete("/flight_techniques/{flight_technique_id}")
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

        return {"message": "Flight technique deleted successfully"}
    except Exception as e:
        session.rollback()
        raise HTTPException(
            status_code=500, detail="An error occurred while deleting flight technique"
        )
    finally:
        session.close()
