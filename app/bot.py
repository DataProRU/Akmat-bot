# app/bot.py

# Сторонние модули
from aiogram import Bot, Dispatcher
from aiogram.fsm.storage.memory import MemoryStorage

# Собственные модули
from app.config import TOKEN


bot = Bot(token=TOKEN)
storage = MemoryStorage()
dp = Dispatcher(storage=storage)