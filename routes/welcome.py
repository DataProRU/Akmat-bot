from fastapi import APIRouter, Request, Depends
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from services.auth import get_token_from_cookie, get_current_user

router = APIRouter()
templates = Jinja2Templates(directory="templates")

@router.get("/welcome", response_class=HTMLResponse)
async def welcome(request: Request, token: str = Depends(get_token_from_cookie)):
    payload = get_current_user(token)
    username = payload.get("sub")
    role = payload.get("role")
    return templates.TemplateResponse("welcome.html", {"request": request, "username": username, "role": role})