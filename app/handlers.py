# /app/handlers.py

# Сторонние модули
from aiogram.types import Message
from aiogram import Router, F

# Собственные модули
from app.tinkoff.utils import send_expenses_miniapp, send_auto_save_expenses_error
from app.utils.utils import air_balon_and_swings
from aiogram.types import Message, CallbackQuery


router = Router()


@router.message(F.text == "/start")
async def send_welcome(message: Message):
    """
    Обработка команды /start в боте
    """
    print(f"Пришел новый пользователь: user_id: {message.from_user.id}  chat_id: {message.chat.id}")
    await message.answer("Добро пожаловать! Доступ к боту открыт.")
    await air_balon_and_swings(message)



@router.message(F.text == "/report")
async def send_expenses(message: Message):
    """
    Обработка команды /report в боте
    """
    await send_expenses_miniapp(chat_id=message.chat.id)
    await send_auto_save_expenses_error(chat_id=message.chat.id)

import gspread

try:
    gc = gspread.service_account(filename="./app/credentials.json")
    sht2 = gc.open_by_url(
        'https://docs.google.com/spreadsheets/d/1-6f7th7KbGT7xsY5whhzbrUinwoOdDT6asqvMVAJBto/edit?gid=0#gid=0'
    )
    worksheet = sht2.get_worksheet(0)
except Exception as e:
    print(f"Ошибка при инициализации gspread: {str(e)}")

from datetime import datetime  # Импортируем модуль datetime

@router.callback_query(F.data == "send")
async def process_send(callback_query: CallbackQuery):
    message_text = callback_query.message.text
    worksheet.format('A:A', {
        "numberFormat": {
            "type": "DATE",
            "pattern": "dd-mm-yyyy"
        }
    })

    # Разбиваем текст на строки
    data = message_text.split('\n')

    # Создаем словарь для хранения данных
    data_dict = {}
    for line in data:
        if ':' in line:
            key, value = line.split(':', 1)
            data_dict[key.strip()] = value.strip()

    # Преобразуем дату из формата "год-месяц-день" в "день-месяц-год"
    date_str = data_dict.get("Дата", "")
    try:
        date_obj = datetime.strptime(date_str, "%Y-%m-%d")  # Преобразуем строку в объект datetime
        formatted_date = date_obj.strftime("%d-%m-%Y")  # Форматируем дату в "день-месяц-год"
    except ValueError:
        formatted_date = date_str  # Если формат даты неверный, оставляем как есть

    # Извлекаем текущий номер рейса
    current_flight_number = data_dict.get("Номер рейса", "")

    # Получаем последнюю строку из Google Таблицы
    last_row = worksheet.get_all_values()[-1] if worksheet.get_all_values() else []
    previous_flight_number = last_row[1] if len(last_row) > 1 else None  # Номер рейса из предыдущей строки

    # Преобразуем сумму предоплаты и стоимость в целые числа
    try:
        prepayment = int(float(data_dict.get("Сумма предоплаты", "0")))
    except ValueError:
        prepayment = 0  # Если преобразование не удалось, устанавливаем значение по умолчанию

    try:
        discount = int(float(data_dict.get("Скидка", "0")))
    except ValueError:
        discount = 0  # Если преобразование не удалось, устанавливаем значение по умолчанию

    try:
        cost = int(float(data_dict.get("Стоимость", "0").replace(" руб.", "")))
    except ValueError:
        cost = 0  # Если преобразование не удалось, устанавливаем значение по умолчанию

    # Формируем список данных в нужном порядке для Google Таблицы
    other_data_row = [
        "",  # Первая ячейка пуста, чтобы сдвинуть данные вправо
        current_flight_number,  # № рейса
        data_dict.get("Маршрут", ""),  # Вид маршрута
        data_dict.get("Машина", ""),  # Вид техники
        data_dict.get("Инструктор", ""),  # Инструктор
        discount,
        prepayment,  # Сумма предоплаты (преобразованная в целое число)
        cost,  # Стоимость (преобразованная в целое число)
        data_dict.get("Тип оплаты", ""),  # Вид оплаты
        data_dict.get("Источник клиента", ""),  # Источник
        data_dict.get("Комментарий", ""),  # Примечание
        "",  # Дополнительно (если нет в данных, оставляем пустым)
    ]

    # Проверяем условие: текущий номер рейса равен 1, а предыдущий не равен 1
    if current_flight_number == "1" and previous_flight_number != "1":
        worksheet.append_row([formatted_date], value_input_option="USER_ENTERED")  # Записываем дату в отдельную строку

    # Записываем остальные данные в таблицу
    worksheet.append_row(other_data_row, value_input_option="USER_ENTERED")

    # Формируем финальное сообщение для пользователя в нужном формате
    formatted_message = (
        f"Дата: {formatted_date}\n"
        f"Номер рейса: {data_dict.get('Номер рейса', '')}\n"
        f"Инструктор: {data_dict.get('Инструктор', '')}\n"
        f"Маршрут: {data_dict.get('Маршрут', '')}\n"
        f"Техника: {data_dict.get('Машина', '')}\n"
        f"Сумма предоплаты: {prepayment}\n"
        f"Скидка: {data_dict.get('Скидка', '')}\n"
        f"Предоплата: {data_dict.get('Предоплата', '')}\n"
        f"Тип оплаты: {data_dict.get('Тип оплаты', '')}\n"
        f"Источник клиента: {data_dict.get('Источник клиента', '')}\n"
        f"Комментарий: {data_dict.get('Комментарий', '')}\n"
        f"Стоимость: {cost}"
    )

    # Отправляем сообщение пользователю
    await callback_query.message.edit_text(f"Данные успешно отправлены в Google Таблицу!\n\n{formatted_message}")

@router.callback_query(F.data == "delete")
async def process_delete(callback_query: CallbackQuery):
    await callback_query.answer("Вы нажали кнопку 'Удалить'")
    # Удаляем сообщение
    await callback_query.message.delete()