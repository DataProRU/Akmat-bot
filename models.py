from pydantic import BaseModel
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine, Column, Integer, Numeric, Boolean, Text, DateTime, SmallInteger
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


class Sources(Base):
    __tablename__ = 'sources'
    id = Column(Integer, primary_key=True)
    title = Column(Text)

class PaymentTypes(Base):
    __tablename__ = 'payment_types'
    id = Column(Integer, primary_key=True)
    title = Column(Text)

class Users(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    full_name = Column(Text)

class Routes(Base):
    __tablename__ = 'routes'
    id = Column(Integer, primary_key=True)
    title = Column(Text)

class Flights(Base):
    __tablename__ = 'flights'
    id = Column(Integer, primary_key=True)
    flight_number = Column(SmallInteger)
    instructor_id = Column(Integer)

class Techniques(Base):
    __tablename__ = 'techniques'
    id = Column(Integer, primary_key=True)
    title = Column(Text)

class FlightTechniques(Base):
    __tablename__ = 'flight_techniques'
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
