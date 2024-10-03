import sqlite3
from sqlite3 import connect, Connection

def get_db():
    conn = connect('users.db', check_same_thread=False)
    try:
        yield conn
    finally:
        conn.close()
def create_user_table():
    # Получаем новое соединение с базой данных
    with sqlite3.connect('users.db') as conn:
        conn.execute('''
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT UNIQUE NOT NULL,
                password TEXT NOT NULL,
                role TEXT NOT NULL DEFAULT 'user'  -- Добавляем роль пользователя
            )
        ''')
        conn.commit()

# Вызов функции для создания таблицы пользователей
create_user_table()

create_user_table()