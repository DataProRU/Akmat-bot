from fastapi import APIRouter, Request, Depends, status
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.security import OAuth2PasswordRequestForm
from services.auth import verify_password, create_access_token
from services.db import get_db
from sqlite3 import Connection
from fastapi.templating import Jinja2Templates

router = APIRouter()
templates = Jinja2Templates(directory="templates")

@router.get("/login", response_class=HTMLResponse)
async def get_login(request: Request):
    return templates.TemplateResponse("login.html", {"request": request, "error": None})

@router.post("/login", response_class=HTMLResponse)
async def login(
    request: Request,
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Connection = Depends(get_db),
):
    cursor = db.execute("SELECT * FROM users WHERE username = ?", (form_data.username,))
    user = cursor.fetchone()

    if user and verify_password(form_data.password, user[2]):
        token = create_access_token({"sub": form_data.username, "role": user[3]})
        response = RedirectResponse(url="/welcome", status_code=status.HTTP_303_SEE_OTHER)
        response.set_cookie(key="token", value=token, httponly=True)
        return response

    return templates.TemplateResponse(
        "login.html", {"request": request, "error": "Invalid username or password"}
    )
