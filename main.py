from fastapi import FastAPI, Depends, HTTPException, status, Request, Form
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates
from auth import verify_password, get_password_hash, create_access_token, decode_access_token
from schemas import UserCreate
from database import get_db
import sqlite3
from fastapi.security import OAuth2PasswordRequestForm

app = FastAPI()
templates = Jinja2Templates(directory="templates")

# Registration page
@app.get("/register", response_class=HTMLResponse)
async def get_register(request: Request):
    return templates.TemplateResponse("register.html", {"request": request})

# Add the missing '@' symbol here
@app.post("/register")
async def post_register(
    request: Request,
    username: str = Form(...),
    password: str = Form(...),
    role: str = Form(),
    db: sqlite3.Connection = Depends(get_db)
):
    user = UserCreate(username=username, password=password, role=role)
    try:
        db.execute(
            "INSERT INTO users (username, password, role) VALUES (?, ?, ?)",
            (user.username, get_password_hash(user.password), user.role)
        )
        db.commit()
        return RedirectResponse(url="/login", status_code=status.HTTP_303_SEE_OTHER)
    except sqlite3.IntegrityError:
        return templates.TemplateResponse("register.html", {"request": request, "error": "Username already registered"})

# Login page
@app.get("/login", response_class=HTMLResponse)
async def get_login(request: Request):
    return templates.TemplateResponse("login.html", {"request": request, "error": None})



@app.post("/login", response_class=HTMLResponse)
async def login(
        request: Request,
        form_data: OAuth2PasswordRequestForm = Depends(),
        db: sqlite3.Connection = Depends(get_db)
):
    cursor = db.execute("SELECT * FROM users WHERE username = ?", (form_data.username,))
    user = cursor.fetchone()

    if user and verify_password(form_data.password, user[2]):
        token = create_access_token({"sub": form_data.username, "role": user[3]})  # Include role in token
        response = RedirectResponse(url="/welcome", status_code=status.HTTP_303_SEE_OTHER)
        response.set_cookie(key="token", value=token, httponly=True)
        return response

    return templates.TemplateResponse("login.html", {"request": request, "error": "Invalid username or password"})

# Welcome page
def get_token_from_cookie(request: Request):
    token = request.cookies.get("token")
    if not token:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Token is missing in cookies")
    return token

def get_current_user(token: str):
    payload = decode_access_token(token)
    if not payload:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")
    return payload

@app.get("/welcome", response_class=HTMLResponse)
async def welcome(request: Request, token: str = Depends(get_token_from_cookie)):
    payload = get_current_user(token)
    username = payload.get("sub")
    role = payload.get("role")
    return templates.TemplateResponse("welcome.html", {"request": request, "username": username, "role": role})
