# general.py

# Сторонние модули
from fastapi import APIRouter

# Собственные модули
from routes.tinkoff.auth_tinkoff import get_browser


router = APIRouter()


@router.post("/tinkoff/disconnect/")
async def disconnect():
    """
    Пользователь перешел на другую страницу.
    """
    print("Пользователь покинул страницу. Закрываем context.")
    browser = get_browser()
    if browser:
        await browser.close_browser()
    return {"message": "Браузер закрыт"}
