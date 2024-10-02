from fastapi import FastAPI, Depends, HTTPException, status, Request
from fastapi.responses import HTMLResponse
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.templating import Jinja2Templates
from auth import verify_password, get_password_hash, create_access_token, decode_access_token
from schemas import UserCreate
from database import get_db
import sqlite3
from fastapi import Form
from fastapi.responses import RedirectResponse

app = FastAPI()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")
templates = Jinja2Templates(directory="templates")


# Registration page
@app.get("/register", response_class=HTMLResponse)
async def get_register(request: Request):
    return templates.TemplateResponse("register.html", {"request": request})


@app.post("/register")
async def post_register(username: str = Form(...), password: str = Form(...), db: sqlite3.Connection = Depends(get_db)):
    user = UserCreate(username=username, password=password)
    try:
        db.execute(
            "INSERT INTO users (username, password) VALUES (?, ?)",
            (user.username, get_password_hash(user.password))
        )
        db.commit()
        return {"message": "User registered successfully"}
    except sqlite3.IntegrityError:
        raise HTTPException(status_code=400, detail="Username already registered")

# Login page
@app.get("/login", response_class=HTMLResponse)
async def get_login(request: Request):
    return templates.TemplateResponse("login.html", {"request": request, "error": None})


@app.post("/login", response_class=HTMLResponse)
async def login(request: Request, form_data: OAuth2PasswordRequestForm = Depends(),  db: sqlite3.Connection = Depends(get_db)):
    cursor = db.execute("SELECT * FROM users WHERE username = ?", (form_data.username,))
    user = cursor.fetchone()
    if user and verify_password(form_data.password, user[2]):
        token = create_access_token({"sub": form_data.username})
        return RedirectResponse(url=f"/welcome?token={token}", status_code=status.HTTP_303_SEE_OTHER)
    return templates.TemplateResponse("login.html", {"request": request, "error": "Invalid username or password"})


# Welcome page
@app.get("/welcome", response_class=HTMLResponse)
async def welcome(request: Request, token: str = None, db: sqlite3.Connection = Depends(get_db)):
    # Extract token from query parameters if it's not passed in headers
    if token is None:
        token = request.query_params.get("token")

    payload = decode_access_token(token)
    if not payload:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")

    username = payload.get("sub")
    if username:
        # Pass the username to the template
        return templates.TemplateResponse("welcome.html", {"request": request, "username": username})
    raise HTTPException(status_code=400, detail="User not found")