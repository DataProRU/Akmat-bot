from pydantic import BaseModel
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import (
    create_engine,
    Column,
    Integer,
    Numeric,
    Boolean,
    Text,
    DateTime,
    SmallInteger,
)
from sqlalchemy import BigInteger

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


class Sources(Base):
    __tablename__ = "sources"
    id = Column(Integer, primary_key=True)
    title = Column(Text)


class PaymentTypes(Base):
    __tablename__ = "payment_types"
    id = Column(Integer, primary_key=True)
    title = Column(Text)


class Users(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, autoincrement=True)
    tg = Column(Text, nullable=False)
    full_name = Column(Text, nullable=False)
    is_manager = Column(Boolean, default=False)
    is_instructor = Column(Boolean, default=False)
    is_assistant = Column(Boolean, default=False)
    send_button = Column(Boolean, default=False)
    deposit_income = Column(Boolean, default=False)
    enter_operation = Column(Boolean, default=False)
    view_salary = Column(Boolean, default=False)
    contribute_expense = Column(Boolean, default=False)
    is_director = Column(Boolean, default=False)
    chat_id = Column(BigInteger, nullable=True)
    comission = Column(Boolean, default=False)
    penalty = Column(Boolean, default=False)
    is_investor = Column(Boolean, default=False)
    change_salary= Column(Boolean, default=False)


class Routes(Base):
    __tablename__ = "routes"
    id = Column(Integer, primary_key=True)
    title = Column(Text)


class Flights(Base):
    __tablename__ = "flights"
    id = Column(Integer, primary_key=True)
    flight_number = Column(SmallInteger)
    instructor_id = Column(Integer)
    route_id = Column(Integer)
    flight_date= Column(DateTime)
    manager_id = Column(Integer)
    confirmed = Column(Boolean)
    source_id = Column(Integer)
    source_data = Column(Text)
    created_at = Column(DateTime)


class Techniques(Base):
    __tablename__ = "techniques"
    id = Column(Integer, primary_key=True)
    title = Column(Text)


class FlightTechniques(Base):
    __tablename__ = "flight_techniques"
    id = Column(Integer, primary_key=True)
    flight_id = Column(Integer)
    technique_id = Column(Integer)
    discount = Column(Numeric)
    prepayment = Column(Boolean)
    price = Column(Numeric)
    payment_type_id = Column(Integer)
    source_id = Column(Integer)
    transfer = Column(Numeric)
    note = Column(Text)
    created_at = Column(DateTime)
    is_approved  = Column(Boolean)


class FlightTechniqueUpdate(BaseModel):
    flight_id: int
    technique_id: int
    discount: float
    prepayment: bool
    price: float
    payment_type_id: int
    source_id: int
    transfer: float
    note: str
