from fastapi import FastAPI
from routes import user_routes, users, incomes, auth_routes, unapproved, main_directory
from routes.directory import categories, technique, type_of_technique, investors, type_of_payments, sources_of_payments
from fastapi.staticfiles import StaticFiles

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")
app.include_router(auth_routes.router)
app.include_router(user_routes.router)
app.include_router(users.router)
app.include_router(incomes.router)
app.include_router(unapproved.router)

app.include_router(main_directory.router)
app.include_router(categories.router)
app.include_router(technique.router)
app.include_router(type_of_technique.router)
app.include_router(investors.router)
app.include_router(type_of_payments.router)
app.include_router(sources_of_payments.router)
