from fastapi import APIRouter, Request, Form, status, Depends
from fastapi.responses import HTMLResponse, RedirectResponse
from services.auth import get_password_hash
from services.db import get_db
from schemas import UserCreate
from sqlite3 import Connection
from fastapi.templating import Jinja2Templates
import sqlite3

router = APIRouter()
templates = Jinja2Templates(directory="templates")

@router.get("/register", response_class=HTMLResponse)
async def get_register(request: Request):
    return templates.TemplateResponse("register.html", {"request": request})

@router.post("/register")
async def post_register(
    request: Request,
    username: str = Form(...),
    password: str = Form(...),
    role: str = Form(),
    db: Connection = Depends(get_db),
):
    user = UserCreate(username=username, password=password, role=role)
    try:
        db.execute(
            "INSERT INTO users (username, password, role) VALUES (?, ?, ?)",
            (user.username, get_password_hash(user.password), user.role),
        )
        db.commit()
        return RedirectResponse(url="/login", status_code=status.HTTP_303_SEE_OTHER)
    except sqlite3.IntegrityError:
        return templates.TemplateResponse(
            "register.html",
            {"request": request, "error": "Username already registered"},
        )
