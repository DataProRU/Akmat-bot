from sqlite3 import connect, Connection

def get_db():
    conn = connect('users.db', check_same_thread=False)
    try:
        yield conn
    finally:
        conn.close()
