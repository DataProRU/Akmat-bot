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
    String,
    ForeignKey,
    TIMESTAMP,
Date
)
from sqlalchemy import BigInteger
from sqlalchemy.orm import relationship
from typing import List, Optional, Dict, Union
from datetime import datetime
from utils.tinkoff.browser_utils import PageType

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


class TokenizedUrlRequest(BaseModel):
    token: str  # Токен из ссылки


class Sources(Base):
    __tablename__ = "sources"
    id = Column(Integer, primary_key=True)
    title = Column(Text)


class PaymentTypes(Base):
    __tablename__ = "payment_types"
    id = Column(Integer, primary_key=True)
    title = Column(Text)


class CategoryExpenses(Base):
    __tablename__ = "category_expenses"
    id = Column(Integer, primary_key=True)
    title = Column(Text)


class Commisions(Base):
    __tablename__ = "comissions"
    id = Column(Integer, primary_key=True)
    title = Column(Text)

class Ranks(Base):
    __tablename__ = "ranks"
    id = Column(Integer, primary_key=True)
    rank = Column(Text)
    salary = Column(Numeric)
    percent = Column(Numeric)

class Investors(Base):
    __tablename__ = "investors"
    id = Column(Integer, primary_key=True)
    title = Column(Text)
    tg = Column(Text)
    percent = Column(Numeric)

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
    change_salary = Column(Boolean, default=False)
    card_number = Column(Text)


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
    flight_date = Column(DateTime)
    manager_id = Column(Integer)
    confirmed = Column(Boolean)
    source_id = Column(Integer)
    source_data = Column(Text)
    created_at = Column(DateTime)


class Techniques(Base):
    __tablename__ = "techniques"
    id = Column(Integer, primary_key=True)
    title = Column(Text)
    type_technique_id = Column(Integer)
    investor_id = Column(Integer)
    visible = Column(Boolean)


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
    is_approved = Column(Boolean)


class TypeTechniques(Base):
    __tablename__ = "type_techniques"
    id = Column(Integer, primary_key=True)
    title = Column(Text)

class TypeExpenses(Base):
    __tablename__ = "type_expenses"
    id = Column(Integer, primary_key=True)
    title = Column(Text)
    visible_investor = Column(Boolean)
    visible_employee = Column(Boolean)
    category_exp_id = Column(Integer)

class TypeOperations(Base):
    __tablename__="type_operations"
    id = Column(Integer, primary_key=True)
    title= Column(Text)
    visible_type_technique = Column(Boolean)
    visible_canisters = Column(Boolean)
    visible_amount = Column(Boolean)
    visible_cost_fuel = Column(Boolean)
    visible_technique = Column(Boolean)
    visible_description = Column(Boolean)

class LoginResponse(BaseModel):
    status: str
    next_page_type: Optional[PageType] = None
    current_page_type: Optional[PageType] = None

    class Config:
        use_enum_values = True

class Keyword(BaseModel):
    description: str
    category_name: str

class SaveKeywordsRequest(BaseModel):
    keywords: List[Keyword]

#class CategoryExpenses(Base):
#    __tablename__ = "category_expenses"

#    id = Column(Integer, primary_key=True)
#    title = Column(Text)

class CategoryKeyword(Base):
    __tablename__ = "tinkoff_category_expenses_keywords"

    id = Column(Integer, primary_key=True)
    keyword = Column(Text)
    category_id = Column(Integer, ForeignKey("category_expenses.id"))

# Модель для таблицы расходов
class Expense(Base):
    __tablename__ = "tinkoff_expenses"

    id = Column(Integer, primary_key=True)
    timestamp = Column(Integer)
    card_number = Column(Text)
    amount = Column(Integer)
    description = Column(Text)

class TemporaryCode(Base):
    __tablename__ = 'tinkoff_temporary_code'

    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(4), nullable=False)

class LastError(Base):
    __tablename__ = "tinkoff_last_error"

    id = Column(Integer, primary_key=True, index=True)
    error_text = Column(String, nullable=False)
    error_time = Column(TIMESTAMP, default=datetime.utcnow)
    is_received = Column(Boolean, default=False)


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

class TgTmpUsers(Base):
    __tablename__ = "tg_tmp_users"
    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    chat_id = Column(BigInteger, nullable=False)
    # Связь с таблицей Users
    user = relationship("Users", backref="tmp_users")

class SwingShift(Base):
    __tablename__ = "swing_shift"
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(Text)

class SwingReason(Base):
    __tablename__ = "swing_reason"
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(Text)

class AirBalonWeather(Base):
    __tablename__ = "air_balon_weather"
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(Text)

class FlightNums(Base):
    __tablename__ = "flights_nums"
    id = Column(Integer, primary_key=True, autoincrement=True)
    date = Column(Date)
    flight_number = Column(Integer)
