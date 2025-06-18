# /app/handlers.py

# Сторонние модули
from aiogram.types import Message, CallbackQuery, InlineKeyboardMarkup, InlineKeyboardButton
from aiogram import Router, F
from aiogram.enums import ParseMode
from aiogram.filters import Command
import gspread
from oauth2client.service_account import ServiceAccountCredentials
from datetime import datetime, timedelta
from app.tinkoff.utils import send_expenses_miniapp
import asyncio

# Собственные модули
from app.tinkoff.utils import send_expenses_miniapp, send_auto_save_expenses_error
from app.utils.utils import  get_income_keyboard, create_reply_markupButton

router = Router()

# Инициализация Google Sheets
try:
    scope = ["https://spreadsheets.google.com/feeds", "https://www.googleapis.com/auth/drive"]
    creds = ServiceAccountCredentials.from_json_keyfile_name("./app/credentials.json", scope)
    client = gspread.authorize(creds)
    spreadsheet_id = "1-6f7th7KbGT7xsY5whhzbrUinwoOdDT6asqvMVAJBto"
    sheet = client.open_by_key(spreadsheet_id).sheet1
except Exception as e:
    print(f"Ошибка при инициализации gspread: {str(e)}")

@router.message(Command("start"))
async def send_welcome(message: Message):
    """
    Обработка команды /start в боте
    """
    print(f"Пришел новый пользователь: user_id: {message.from_user.id}  chat_id: {message.chat.id}")
    await message.answer("Добро пожаловать! Доступ к боту открыт.")
    await get_income_keyboard(message)

@router.message(Command("report"))
async def send_expenses(message: Message):
    """
    Обработка команды /report в боте
    """
    await send_expenses_miniapp(chat_id=message.chat.id)
    await send_auto_save_expenses_error(chat_id=message.chat.id)


@router.callback_query(F.data == "send")
async def process_send(callback_query: CallbackQuery):
    message_text = callback_query.message.text

    # Разбиваем текст на строки
    data = message_text.split('\n')

    # Создаем словарь для хранения данных
    data_dict = {}
    for line in data:
        if ':' in line:
            key, value = line.split(':', 1)
            data_dict[key.strip()] = value.strip()

    # Преобразуем дату
    date_str = data_dict.get("Дата", "")
    try:
        clean_date = date_str.replace('-', '.').replace('/', '.').replace(' ', '')
        date_obj = datetime.strptime(clean_date, "%Y.%m.%d")
        formatted_date = date_obj.strftime("%d.%m.%Y")
    except ValueError:
        # Если не удалось распарсить, оставляем как есть
        formatted_date = date_str.replace('-', '.').replace('/', '.')
    # Извлекаем текущий номер рейса

    current_flight_number = data_dict.get("Номер рейса", "")

    # Получаем последнюю строку из Google Таблицы
    last_row = sheet.get_all_values()[-1] if sheet.get_all_values() else []
    previous_flight_number = last_row[1] if len(last_row) > 1 else None

    # Преобразуем суммы
    try:
        prepayment = int(float(data_dict.get("Сумма предоплаты", "0")))
    except ValueError:
        prepayment = 0

    try:
        discount = int(float(data_dict.get("Скидка", "0")))
    except ValueError:
        discount = 0

    try:
        cost = int(float(data_dict.get("Стоимость", "0").replace(" руб.", "")))
    except ValueError:
        cost = 0

    # Формируем данные для Google Таблицы
    other_data_row = [
        "",
        current_flight_number,
        data_dict.get("Маршрут", ""),
        data_dict.get("Машина", ""),
        data_dict.get("Инструктор", ""),
        discount,
        prepayment,
        cost,
        data_dict.get("Тип оплаты", ""),
        data_dict.get("Источник клиента", ""),
        data_dict.get("Комментарий", ""),
        "",
    ]

    # Проверяем условие для новой даты
    if current_flight_number == "1" and previous_flight_number != "1":
        sheet.append_row([formatted_date], value_input_option="USER_ENTERED")

    # Записываем данные в таблицу
    sheet.append_row(other_data_row, value_input_option="USER_ENTERED")

    # Функция для замены #текст# на <b>текст</b>
    def format_bold_text(text):
        return text.replace("#", "<b>").replace("#", "</b>")

    # Формируем финальное сообщение с HTML-разметкой
    formatted_message = (
        f"Дата: {formatted_date}\n"
        f"Номер рейса: {data_dict.get('Номер рейса', '')}\n\n"

        f"Инструктор:\n#{data_dict.get('Инструктор', '')}#\n\n"

        f"Маршрут:\n#{data_dict.get('Маршрут', '')}#\n\n"

        f"Техника:\n#{data_dict.get('Машина', '')} - {cost}# ₽💳\n\n"

        f"Предоплата в размере: {prepayment} ₽\n\n"

        f"Размер скидки {discount} ₽\n\n"

        f"Итоговая сумма {cost} ₽"
    )

    def format_bold_text(text):
        parts = []
        while "#" in text:
            before, rest = text.split("#", 1)
            parts.append(before)
            if "#" in rest:
                bold, after = rest.split("#", 1)
                parts.append(f"<b>{bold}</b>")
                text = after
            else:
                parts.append(rest)
                break
        else:
            parts.append(text)
        return "".join(parts)

    # Применяем форматирование только к тем частям, где есть решетки
    formatted_message = format_bold_text(formatted_message)

    # Отправляем сообщение
    await callback_query.message.edit_text(
        f"Вы внесли рейс ✅\n\n{formatted_message}",
        parse_mode="HTML"
    )


@router.callback_query(F.data == "delete")
async def process_delete(callback_query: CallbackQuery):
    await callback_query.answer("Вы нажали кнопку 'Удалить'")
    await callback_query.message.delete()

# Функция для форматирования даты
def format_date(date_str):
    date_obj = datetime.strptime(date_str, "%d-%m-%Y")
    return date_obj.strftime("%d %B").replace("January", "января").replace("February", "февраля").replace("March", "марта").replace("April", "апреля").replace("May", "мая").replace("June", "июня").replace("July", "июля").replace("August", "августа").replace("September", "сентября").replace("October", "октября").replace("November", "ноября").replace("December", "декабря")

# Функция для форматирования суммы
def format_amount(amount):
    return f"{amount:,} ₽".replace(",", " ")

# Функция для получения отчёта за день
def get_daily_report(date):
    records = sheet.get_all_records()
    daily_records = []
    start_collecting = False

    for record in records:
        if not any(record.values()):  # Проверка на полностью пустую строку
            break
        if record['Дата'] == date:
            start_collecting = True
        if start_collecting:
            daily_records.append(record)

    if not daily_records:
            return f"ПРОКАТ ТЕХНИКИ 🟢" + "\n" + "\n" + f"Отчёт за {date}" + "\n" + "\n" + "Не работали❌"

    total_revenue = 0
    qr_revenue = 0
    cash_revenue = 0
    transfer_revenue = 0
    post_revenue = 0
    instructors = set()

    for record in daily_records:
        cost = record['Стоимость']
        if isinstance(cost, int) or (isinstance(cost, str) and cost.replace(' ', '').isdigit()):
            cost_value = int(cost.replace(' ', '')) if isinstance(cost, str) else cost
            total_revenue += cost_value
            if record['Вид оплаты'] == 'QR':
                qr_revenue += cost_value
            elif record['Вид оплаты'] == 'Наличка':
                cash_revenue += cost_value
            elif record['Вид оплаты'] == 'Перевод':
                transfer_revenue += cost_value
            elif record['Вид оплаты'] == 'Постоплата':
                post_revenue += cost_value
            instructors.add(record['Инструктор'])
        else:
            print(f"Некорректное значение стоимости: {cost} в записи: {record}")

    report = f"<b>ПРОКАТ ТЕХНИКИ 🟢</b>\n"
    report += "\n"
    report += f"Отчет за <b>{format_date(date)}</b>\n"
    report += f"Выручка <b>{format_amount(total_revenue)}</b>\n\n"
    report += "<b>Из них:</b>\n"
    if qr_revenue > 0:
        report += f"QR <b>{format_amount(qr_revenue)}</b>\n"
    if cash_revenue > 0:
        report += f"Наличка <b>{format_amount(cash_revenue)}</b>\n"
    if transfer_revenue > 0:
        report += f"Перевод <b>{format_amount(transfer_revenue)}</b>\n"
    if post_revenue > 0:
        report += f"Постоплата <b>{format_amount(post_revenue)}</b>\n"
    report += "\n"
    report += "Инструктора:\n"
    report += "\n".join(f"<b>{instructor}</b>" for instructor in instructors)

    return report

# Функция для отправки отчёта по chat_id
async def send_daily_report(bot):
    today = (datetime.now() - timedelta(days=0)).strftime("%d-%m-%Y")
    report = get_daily_report(today)

    # Жестко заданные chat_id пользователей
    chat_ids = [1129601494, 702856294, 981977795]

    for chat_id in chat_ids:
        try:
            await bot.send_message(chat_id=chat_id, text=report, parse_mode=ParseMode.HTML)
        except Exception as e:
            print(f"Ошибка при отправке сообщения: {e}")

# Планирование отправки отчёта каждый день в определённое время
async def scheduler(bot):
    while True:
        now = datetime.now()
        if now.hour == 21 and now.minute == 0:
            await send_daily_report(bot)
        if now.hour == 22 and now.minute == 0:
            await send_expenses_miniapp("1129601494")

        await asyncio.sleep(60)

# Запуск бота и планировщика
async def main_scheduler(bot):
    asyncio.create_task(scheduler(bot))

@router.message(F.text == "Внести доход")
async def reply_keyboard(message: Message):
    markup = await create_reply_markupButton(message)
    if markup:
        await message.answer(text="Выберите действие:", reply_markup=markup)
    else:
        await message.answer(text="У вас нет доступа к специальным функциям.")


