from fastapi import FastAPI
from routes import auth_routes, user_routes, users
from fastapi.staticfiles import StaticFiles

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")
app.include_router(auth_routes.router)
app.include_router(user_routes.router)
app.include_router(users.router)
