import databases
import sqlalchemy
import asyncio

# Указываем URL для подключения к PostgreSQL
DATABASE_URL = "postgresql://ershov:pipe@localhost/my_test_db"

# Создаем подключение к базе данных
database = databases.Database(DATABASE_URL)

metadata = sqlalchemy.MetaData()

# Определяем структуру таблицы users
users = sqlalchemy.Table(
    "users",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer, primary_key=True, autoincrement=True),
    sqlalchemy.Column("username", sqlalchemy.String, unique=True, nullable=False),
    sqlalchemy.Column("password", sqlalchemy.String, nullable=False),
    sqlalchemy.Column("role", sqlalchemy.String, nullable=False, server_default="user")  # Добавляем роль пользователя
)

# Создаем таблицы в базе данных
engine = sqlalchemy.create_engine(DATABASE_URL)
metadata.create_all(engine)

# Функция для получения соединения с базой данных
async def get_db():
    await database.connect()
    try:
        yield database
    finally:
        await database.disconnect()

# Функция для создания таблицы пользователей (вызвана автоматически через SQLAlchemy)
async def create_user_table():
    query = """
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        username VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(100) NOT NULL,
        role VARCHAR(50) NOT NULL DEFAULT 'user'
    )
    """
    await database.execute(query)

# Вызов функции для создания таблицы пользователей
async def run_create_user_table():
    await create_user_table()

if __name__ == "__main__":
    try:
        # Проверяем, есть ли уже запущенный цикл событий
        loop = asyncio.get_running_loop()
    except RuntimeError:  # Если цикла нет, создаем и запускаем его
        loop = None

    if loop and loop.is_running():
        # Если цикл уже запущен, используем `create_task`
        task = asyncio.create_task(run_create_user_table())
    else:
        # Если нет запущенного цикла, используем `asyncio.run()`
        asyncio.run(run_create_user_table())
