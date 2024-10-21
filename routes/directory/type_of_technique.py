from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse
from database import Session
from dependencies import get_token_from_cookie, get_current_user
from fastapi.responses import RedirectResponse
from fastapi import APIRouter, Request, Depends
from models import TypeTechniques

router = APIRouter()

templates = Jinja2Templates(directory="templates")

def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()

@router.get("/type_of_technique", response_class=HTMLResponse)
async def directory(request: Request, db: Session = Depends(get_db)):
    # Получаем токен
    token = get_token_from_cookie(request)
    if isinstance(token, RedirectResponse):
        return token  # Если токен отсутствует, перенаправляем на страницу логина

    # Получаем информацию о текущем пользователе
    payload = get_current_user(token)
    if isinstance(payload, RedirectResponse):
        return payload  # Если токен недействителен, перенаправляем на страницу логина

    type_techniques = db.query(TypeTechniques).all()


    return templates.TemplateResponse("directory/type_of_technique.html", {
        "request": request,
        "type_techniques": type_techniques
    })
