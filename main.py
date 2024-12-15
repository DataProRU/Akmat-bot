# main.py

# Стандартные модули Python
import asyncio

# Сторонние модули
from fastapi import FastAPI
from uvicorn import Config, Server

# Собственные модули
from app.bot import dp, bot

from app.handlers import router as general_router

from server.routes.tinkoff import router as tinkoff_router


async def start_bot():
    """
    Запуск Telegram-бота.
    """
    dp.include_router(general_router)
    print("Bot has started")

    await bot.delete_webhook(drop_pending_updates=True)
    await dp.start_polling(bot)


def create_app():
    """
    Создание приложения FastAPI.
    """
    app = FastAPI()
    app.include_router(tinkoff_router)

    print("Server has started")

    return app


async def start_server(app):
    """
    Запуск FastAPI через uvicorn.Server.
    """
    config = Config(app=app, host="0.0.0.0", port=8001, log_level="info")
    server = Server(config)
    await server.serve()


async def main():
    app = create_app()
    
    # Запускаем бота и FastAPI в одном процессе
    bot_task = asyncio.create_task(start_bot())
    server_task = asyncio.create_task(start_server(app))

    await asyncio.gather(bot_task, server_task)


if __name__ == "__main__":
    asyncio.run(main())
