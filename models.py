from pydantic import BaseModel
from sqlalchemy.ext.declarative import declarative_base
import sqlalchemy
Base = declarative_base()

class UserInDB(BaseModel):
    username: str
    hashed_password: str
    role: str


class User(BaseModel):
    username: str
    password: str
    role: str


class UserCreate(User):
    username: str
    password: str
    role: str

class UpdateUserRole(BaseModel):
    role: str


class FlightTechniques(Base):
    __tablename__ = 'flight_techniques'

    id = sqlalchemy.Column(sqlalchemy.Integer, primary_key=True)
    flight_id = sqlalchemy.Column(sqlalchemy.Integer)
    technique_id = sqlalchemy.Column(sqlalchemy.Integer)
    discount = sqlalchemy.Column(sqlalchemy.Integer)
    prepayment = sqlalchemy.Column(sqlalchemy.Boolean)
    price = sqlalchemy.Column(sqlalchemy.Numeric)
    payment_type_id = sqlalchemy.Column(sqlalchemy.Integer)
    source_id = sqlalchemy.Column(sqlalchemy.Integer)
    transfer = sqlalchemy.Column(sqlalchemy.Numeric)
    note = sqlalchemy.Column(sqlalchemy.Text)
    hotel_id = sqlalchemy.Column(sqlalchemy.Integer)
    created_at = sqlalchemy.Column(sqlalchemy.DATETIME)
