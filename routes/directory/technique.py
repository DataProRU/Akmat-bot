from fastapi import APIRouter, Request, Depends, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from database import Session
from dependencies import get_token_from_cookie, get_current_user
from models import Techniques, TypeTechniques, Investors


router = APIRouter()

templates = Jinja2Templates(directory="templates")

def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()

@router.get("/technique", response_class=HTMLResponse)
async def directory(request: Request, db: Session = Depends(get_db)):
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    techniques = db.query(Techniques).all()
    type_techniques = db.query(TypeTechniques).all()
    investors = db.query(Investors).all()

    return templates.TemplateResponse("directory/technique.html", {
        "request": request,
        "techniques": techniques,
        "type_techniques": type_techniques,
        "investors": investors
    })