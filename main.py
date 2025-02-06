from fastapi import FastAPI
from threading import Thread
from routes import user_routes, users, incomes, auth_routes, unapproved, main_directory, bot, bot_swing, bot_air_balon, flight, balon_expenses
from routes.directory import (
    categories,
    technique,
    type_of_technique,
    investors,
    type_of_payments,
    sources_of_payments,
    flight_routers,
    operations,
    types_of_expenses,
    expenses_categories,
    positions,
    commissions,
    swing_shift,
    swing_reason,
    air_balon_weather,
)

from routes.tinkoff import (
    auth_tinkoff,
    expenses,
    general
)

from utils.tinkoff.fixed_time_import_expenses import start_scheduler


from fastapi.staticfiles import StaticFiles

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")
app.include_router(auth_routes.router)
app.include_router(user_routes.router)
app.include_router(users.router)
app.include_router(incomes.router)
app.include_router(unapproved.router)
app.include_router(bot_swing.router)
app.include_router(bot_air_balon.router)
app.include_router(flight.router)

app.include_router(main_directory.router)
app.include_router(categories.router)
app.include_router(technique.router)
app.include_router(type_of_technique.router)
app.include_router(investors.router)
app.include_router(type_of_payments.router)
app.include_router(sources_of_payments.router)
app.include_router(flight_routers.router)
app.include_router(operations.router)
app.include_router(types_of_expenses.router)
app.include_router(expenses_categories.router)
app.include_router(positions.router)
app.include_router(commissions.router)
app.include_router(swing_shift.router)
app.include_router(swing_reason.router)
app.include_router(air_balon_weather.router)
app.include_router(balon_expenses.router)

app.include_router(auth_tinkoff.router)
app.include_router(expenses.router)
app.include_router(general.router)

app.include_router(bot.router)

#update


# Запуск планировщика для автозагрузки в отдельном потоке
scheduler_thread = Thread(target=start_scheduler, daemon=True)
scheduler_thread.start()