import databases
import sqlalchemy
import asyncio

# Define the database URL
#DATABASE_URL = "postgresql://ershov:pipe@host.docker.internal/my_test_db"
#DATABASE_URL = "postgresql://ershov:pipe@localhost/my_test_db"
DATABASE_URL = "postgresql://db_admin:Lp4yAP0BOKrk@46.254.16.222/eq_rental"


# Create the database connection
database = databases.Database(DATABASE_URL)
metadata = sqlalchemy.MetaData()

# Define the users table schema using SQLAlchemy
web_users = sqlalchemy.Table(
    "web_users",
    metadata,
    sqlalchemy.Column("id", sqlalchemy.Integer, primary_key=True, autoincrement=True),
    sqlalchemy.Column("username", sqlalchemy.String, unique=True, nullable=False),
    sqlalchemy.Column("password", sqlalchemy.String, nullable=False),
    sqlalchemy.Column("role", sqlalchemy.String, nullable=False, server_default="user")  # Add role with default value
)

# Create the engine and use SQLAlchemy to create the table(s)
engine = sqlalchemy.create_engine(DATABASE_URL)
metadata.create_all(engine)

# Function to handle asynchronous database connection
async def get_db():
    await database.connect()
    try:
        yield database
    finally:
        await database.disconnect()

# Main function to manage database connection and table creation
async def main():
    # No need to manually create the table with raw SQL if using SQLAlchemy's metadata.create_all()
    await database.connect()  # Connect to the database
    print("Connected to the database!")
    await database.disconnect()  # Disconnect from the database
    print("Disconnected from the database!")

# Running the asynchronous main function
if __name__ == "__main__":
    asyncio.run(main())
