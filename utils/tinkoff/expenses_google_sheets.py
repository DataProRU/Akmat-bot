
import locale
import re

from pytz import timezone
from datetime import datetime
import gspread
from gspread_formatting import format_cell_range, CellFormat, Color, TextFormat

from routes.directory.tinkoff_expenses import get_expenses_from_db
from utils.tinkoff.time_utils import get_period_range

from config import GOOGLE_SHEETS_URL


moscow_tz = timezone('Europe/Moscow')
locale.setlocale(locale.LC_TIME, "ru_RU.utf8")  # Устанавливаем русскую локаль

try:
    gc = gspread.service_account(filename="credentials.json")
    sht2 = gc.open_by_url(GOOGLE_SHEETS_URL)
    worksheet = sht2.get_worksheet(0)
except Exception as e:
    print(f"Ошибка при инициализации gspread: {str(e)}")

MONTHS_NOMINATIVE = {
    "января": "ЯНВАРЬ", "февраля": "ФЕВРАЛЬ", "марта": "МАРТ",
    "апреля": "АПРЕЛЬ", "мая": "МАЙ", "июня": "ИЮНЬ",
    "июля": "ИЮЛЬ", "августа": "АВГУСТ", "сентября": "СЕНТЯБРЬ",
    "октября": "ОКТЯБРЬ", "ноября": "НОЯБРЬ", "декабря": "ДЕКАБРЬ"
}

DATE_ROW_COLOR = Color(67/255, 67/255, 67/255)
DATE_FONT_COLOR = Color(1, 1, 240/255)

def sync_expenses_to_sheet_no_id(db, period="week", timezone_str="Europe/Moscow"):
    """
    Синхронизация расходов из базы данных в Google Sheets. ВЕРСИЯ БЕЗ АЙДИШНИКОВ.
    Теперь поддерживает:
    - Группировку по датам
    - Дополнительные столбцы (Статья, Уточнение, Комментарий)
    - Учёт оплат задним числом
    - Вывод месяца при его смене
    - Вывод числа и месяца при смене дня
    - Закрашивание строк с датами
    """
    print("Начата выгрузка в гугл таблицу.")

    # Получаем расходы за нужный период
    unix_range_start, unix_range_end = get_period_range(timezone=timezone_str, period=period)

    expenses_data = get_expenses_from_db(
        db=db,
        unix_range_start=unix_range_start,
        unix_range_end=unix_range_end,
        timezone_str=timezone_str
    )

    # Получаем текущие данные
    existing_rows = worksheet.get_all_values()

    # Вставляем данные в таблицу
    last_month, last_date = get_last_month_and_date([row[0] for row in existing_rows])

    # Собираем существующие расходы, чтобы избежать дублирования
    existing_expenses = set()
    for row in existing_rows[1:]:  # Пропускаем заголовок
        if len(row) >= 4:  # Проверяем, что есть необходимые поля
            existing_expenses.add((row[1], row[2], row[3], row[5]))

    # Формируем данные для добавления
    expenses_to_add = []
    for expense in expenses_data["expenses"]:
        date_time = expense["date_time"]
        card_number = expense["card_number"]
        amount = "{:.2f}".format(expense["amount"]).rstrip('0').rstrip('.').replace('.', ',')
        description = expense["description"]
        category = expense["category"]
        article = expense.get("article", "")
        detail = expense.get("detail", "")
        comment = expense.get("comment", "")

        # Проверяем, есть ли запись
        if (card_number, amount, description, category) not in existing_expenses:
            expenses_to_add.append([date_time, card_number, amount, description, article, category, detail, comment])

    if not expenses_to_add:
        print("Нет новых расходов для добавления.")
        return

    # Группируем по дате
    expenses_to_add.sort(key=lambda x: datetime.strptime(x[0].split()[0], "%d.%m.%Y"))

    row_index = len(existing_rows) + 1  # Начальный индекс строки (без заголовка)

    for expense in expenses_to_add:
        date_str = expense[0].split()[0]  # Берём только дату без времени
        day, month_num, _ = date_str.split(".")
        month = datetime.strptime(date_str, "%d.%m.%Y").strftime("%B")
        day = f"{day} {month}"
        month = MONTHS_NOMINATIVE[month]

        print(month, last_month)
        # Если месяц изменился — записываем его
        if month != last_month:
            worksheet.append_row([month] + [""] * 7)
            black_fill = CellFormat(
                backgroundColor=DATE_ROW_COLOR,
                textFormat=TextFormat(bold=True, foregroundColor=Color(1, 1, 1))
            )
            format_cell_range(worksheet, f"A{row_index}:H{row_index}", black_fill)
            row_index += 1
            last_month = month

        print(day, last_date)
        # Если день изменился — записываем "02 февраля"
        if day != last_date:
            worksheet.append_row([day] + [""] * 7)
            black_fill = CellFormat(
                backgroundColor=DATE_ROW_COLOR,
                textFormat=TextFormat(bold=True, foregroundColor=Color(1, 1, 1))
            )
            format_cell_range(worksheet, f"A{row_index}:H{row_index}", black_fill)
            row_index += 1
            last_date = day

        print(expense, row_index)
        worksheet.append_row([""] + expense[1:])  # Вставляем сам расход
        white_fill = CellFormat(
            backgroundColor=Color(1, 1, 1),  # Без заливки (белый фон)
            textFormat=TextFormat(bold=False, foregroundColor=Color(0, 0, 0))
        )
        format_cell_range(worksheet, f"A{row_index}:H{row_index}", white_fill)

        row_index += 1

    print("Синхронизация завершена.")


def get_last_month_and_date(existing_rows):
    """
    Функция для извлечения последнего месяца и последней даты из строк таблицы,
    начиная с конца.

    :param existing_rows: Список строк таблицы (переданный через worksheet.get_all_values()).
    :return: Кортеж (last_month, last_date) или (None, None), если не найдено.
    """
    # Отфильтровываем пустые строки
    existing_rows = [row for row in existing_rows if row and len(row) > 0]

    last_date = None
    last_month = None

    # Проходим с конца
    for row in reversed(existing_rows):
        if row in MONTHS_NOMINATIVE.values():  # Если это месяц
            last_month = row
        elif is_date_string(row):  # Если это дата
            last_date = row
        if last_date and last_month:
            return last_month, last_date  # Как только нашли, возвращаем

    # Если ничего не нашли, возвращаем None
    return None, None


def is_date_string(date_str):
    """
    Проверяет, является ли строка датой в формате '1 мая' или '01 мая'.

    :param date_str: Строка для проверки.
    :return: True, если строка является датой, иначе False.
    """
    # Регулярное выражение для даты вида '1 мая' или '01 мая'
    date_pattern = r"^(0?\d{1,2})\s(" + "|".join(MONTHS_NOMINATIVE.keys()) + r")$"
    
    # Проверяем, соответствует ли строка регулярному выражению
    return bool(re.match(date_pattern, date_str))