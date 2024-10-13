--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 15.5 (Debian 15.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cash_received; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.cash_received (
    date_received timestamp with time zone NOT NULL,
    cash numeric NOT NULL
);


ALTER TABLE public.cash_received OWNER TO db_admin;

--
-- Name: TABLE cash_received; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.cash_received IS 'Получение наличики от менеджера';


--
-- Name: COLUMN cash_received.date_received; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.cash_received.date_received IS 'Дата когда забрали наличку у менеджера';


--
-- Name: COLUMN cash_received.cash; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.cash_received.cash IS 'Сумма налички';


--
-- Name: category_expenses; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.category_expenses (
    id integer NOT NULL,
    title text,
    "position" integer,
    deleted_at timestamp without time zone
);


ALTER TABLE public.category_expenses OWNER TO db_admin;

--
-- Name: TABLE category_expenses; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.category_expenses IS 'Категории расходов';


--
-- Name: COLUMN category_expenses.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.category_expenses.title IS 'Название';


--
-- Name: COLUMN category_expenses."position"; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.category_expenses."position" IS 'Порядок расположения';


--
-- Name: COLUMN category_expenses.deleted_at; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.category_expenses.deleted_at IS 'Дата удаления';


--
-- Name: category_expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.category_expenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_expenses_id_seq OWNER TO db_admin;

--
-- Name: category_expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.category_expenses_id_seq OWNED BY public.category_expenses.id;


--
-- Name: comissions; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.comissions (
    id integer NOT NULL,
    title text,
    deleted_at timestamp without time zone
);


ALTER TABLE public.comissions OWNER TO db_admin;

--
-- Name: TABLE comissions; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.comissions IS 'Типы комиссий';


--
-- Name: COLUMN comissions.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.comissions.id IS 'Идентификатор';


--
-- Name: COLUMN comissions.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.comissions.title IS 'Тип комиссии';


--
-- Name: comissions_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.comissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comissions_id_seq OWNER TO db_admin;

--
-- Name: comissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.comissions_id_seq OWNED BY public.comissions.id;


--
-- Name: day_employees; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.day_employees (
    id integer NOT NULL,
    date_employee date NOT NULL,
    director_id integer NOT NULL,
    manager_id integer NOT NULL,
    ceated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.day_employees OWNER TO db_admin;

--
-- Name: TABLE day_employees; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.day_employees IS 'Кто работает по дням (менеджер и директор)';


--
-- Name: COLUMN day_employees.date_employee; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.day_employees.date_employee IS 'Дата работы';


--
-- Name: COLUMN day_employees.director_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.day_employees.director_id IS 'Идентификатор директора: users';


--
-- Name: COLUMN day_employees.manager_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.day_employees.manager_id IS 'Идентификатор менеджера: users';


--
-- Name: COLUMN day_employees.ceated_at; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.day_employees.ceated_at IS 'Дата и время создания записи';


--
-- Name: day_employees_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.day_employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.day_employees_id_seq OWNER TO db_admin;

--
-- Name: day_employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.day_employees_id_seq OWNED BY public.day_employees.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.expenses (
    id integer NOT NULL,
    date_expense date NOT NULL,
    type_expense_id integer NOT NULL,
    investor_id integer,
    employee_id integer,
    amount numeric NOT NULL,
    description text NOT NULL,
    source_id smallint NOT NULL,
    archive boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.expenses OWNER TO db_admin;

--
-- Name: TABLE expenses; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.expenses IS 'Расходы';


--
-- Name: COLUMN expenses.date_expense; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.expenses.date_expense IS 'Дата расхода';


--
-- Name: COLUMN expenses.type_expense_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.expenses.type_expense_id IS 'Тип расхода: type_expenses';


--
-- Name: COLUMN expenses.investor_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.expenses.investor_id IS 'Инвестор: investors';


--
-- Name: COLUMN expenses.employee_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.expenses.employee_id IS 'Сотрудник: users';


--
-- Name: COLUMN expenses.amount; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.expenses.amount IS 'Сумма расхода';


--
-- Name: COLUMN expenses.description; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.expenses.description IS 'Описание';


--
-- Name: COLUMN expenses.source_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.expenses.source_id IS 'Источник записи: 1 - бот, 2 - таблица';


--
-- Name: COLUMN expenses.archive; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.expenses.archive IS 'Признак перевода в архив';


--
-- Name: COLUMN expenses.created_at; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.expenses.created_at IS 'Дата и время создания записи';


--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.expenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expenses_id_seq OWNER TO db_admin;

--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
-- Name: flight_techniques; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.flight_techniques (
    id integer NOT NULL,
    flight_id integer NOT NULL,
    technique_id integer NOT NULL,
    discount numeric NOT NULL,
    prepayment boolean DEFAULT false NOT NULL,
    price numeric NOT NULL,
    payment_type_id integer NOT NULL,
    source_id integer NOT NULL,
    transfer numeric NOT NULL,
    note text NOT NULL,
    hotel_id integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.flight_techniques OWNER TO db_admin;

--
-- Name: TABLE flight_techniques; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.flight_techniques IS 'Техника из доходов';


--
-- Name: COLUMN flight_techniques.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.id IS 'Идентификатор';


--
-- Name: COLUMN flight_techniques.flight_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.flight_id IS 'Идентификатор рейса';


--
-- Name: COLUMN flight_techniques.technique_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.technique_id IS 'Идентификатор техники';


--
-- Name: COLUMN flight_techniques.discount; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.discount IS 'Скидка, руб.';


--
-- Name: COLUMN flight_techniques.prepayment; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.prepayment IS 'Признак предоплаты';


--
-- Name: COLUMN flight_techniques.price; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.price IS 'Стоимость';


--
-- Name: COLUMN flight_techniques.payment_type_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.payment_type_id IS 'Идентификатор типа оплаты';


--
-- Name: COLUMN flight_techniques.source_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.source_id IS 'Идентификатор источника';


--
-- Name: COLUMN flight_techniques.transfer; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.transfer IS 'Размер трансфера, руб.';


--
-- Name: COLUMN flight_techniques.note; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.note IS 'Примечание';


--
-- Name: COLUMN flight_techniques.hotel_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.hotel_id IS 'Идентификатор отеля';


--
-- Name: COLUMN flight_techniques.created_at; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flight_techniques.created_at IS 'Дата и время создания записи';


--
-- Name: flight_techniques_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.flight_techniques_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flight_techniques_id_seq OWNER TO db_admin;

--
-- Name: flight_techniques_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.flight_techniques_id_seq OWNED BY public.flight_techniques.id;


--
-- Name: flights; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.flights (
    id integer NOT NULL,
    flight_date date NOT NULL,
    flight_number smallint NOT NULL,
    route_id integer NOT NULL,
    instructor_id integer NOT NULL,
    manager_id integer NOT NULL,
    confirmed boolean DEFAULT false NOT NULL,
    source_id smallint NOT NULL,
    source_data text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.flights OWNER TO db_admin;

--
-- Name: TABLE flights; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.flights IS 'Доходы';


--
-- Name: COLUMN flights.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flights.id IS 'Идентификатор';


--
-- Name: COLUMN flights.flight_date; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flights.flight_date IS 'Дата рейса';


--
-- Name: COLUMN flights.flight_number; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flights.flight_number IS 'Номер рейса';


--
-- Name: COLUMN flights.route_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flights.route_id IS 'Идентификатор маршрута';


--
-- Name: COLUMN flights.instructor_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flights.instructor_id IS 'Идентификатор инструктора';


--
-- Name: COLUMN flights.manager_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flights.manager_id IS 'Идентификатор менеджера';


--
-- Name: COLUMN flights.confirmed; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flights.confirmed IS 'Запись подтверждена';


--
-- Name: COLUMN flights.source_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flights.source_id IS 'Источник записи: 1 - бот, 2 - таблица';


--
-- Name: COLUMN flights.source_data; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flights.source_data IS 'Исходные данные';


--
-- Name: COLUMN flights.created_at; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.flights.created_at IS 'Дата и время создания записи';


--
-- Name: flights_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.flights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flights_id_seq OWNER TO db_admin;

--
-- Name: flights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.flights_id_seq OWNED BY public.flights.id;


--
-- Name: hotels; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.hotels (
    id integer NOT NULL,
    title text NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.hotels OWNER TO db_admin;

--
-- Name: TABLE hotels; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.hotels IS 'Отели';


--
-- Name: COLUMN hotels.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.hotels.id IS 'Идентификатор';


--
-- Name: COLUMN hotels.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.hotels.title IS 'Название отеля';


--
-- Name: hotels_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.hotels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hotels_id_seq OWNER TO db_admin;

--
-- Name: hotels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.hotels_id_seq OWNED BY public.hotels.id;


--
-- Name: investors; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.investors (
    id integer NOT NULL,
    title text,
    tg text,
    percent numeric,
    deleted_at timestamp without time zone
);


ALTER TABLE public.investors OWNER TO db_admin;

--
-- Name: TABLE investors; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.investors IS 'Инвесторы';


--
-- Name: COLUMN investors.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.investors.id IS 'Идентификатор';


--
-- Name: COLUMN investors.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.investors.title IS 'Инвестор';


--
-- Name: COLUMN investors.tg; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.investors.tg IS 'Ник в Телеграм';


--
-- Name: COLUMN investors.percent; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.investors.percent IS 'Размер дохода от инвестроской деятельности';


--
-- Name: investors_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.investors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.investors_id_seq OWNER TO db_admin;

--
-- Name: investors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.investors_id_seq OWNED BY public.investors.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    chat_id bigint NOT NULL,
    message_id bigint NOT NULL,
    user_id integer NOT NULL,
    date_send timestamp with time zone NOT NULL,
    message_type text NOT NULL,
    flight_id integer NOT NULL
);


ALTER TABLE public.messages OWNER TO db_admin;

--
-- Name: TABLE messages; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.messages IS 'Отправленные сообщения';


--
-- Name: COLUMN messages.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.messages.id IS 'Идентификатор';


--
-- Name: COLUMN messages.chat_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.messages.chat_id IS 'Идентификатор чата';


--
-- Name: COLUMN messages.message_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.messages.message_id IS 'Идентификатор сообщения';


--
-- Name: COLUMN messages.user_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.messages.user_id IS 'Идентификатор пользователя';


--
-- Name: COLUMN messages.date_send; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.messages.date_send IS 'Дата отправки сообщения';


--
-- Name: COLUMN messages.message_type; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.messages.message_type IS 'Тип сообщения';


--
-- Name: COLUMN messages.flight_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.messages.flight_id IS 'Идентификатор рейса';


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO db_admin;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: oil_coefs; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.oil_coefs (
    id integer NOT NULL,
    date_coef date NOT NULL,
    type_technique_id integer NOT NULL,
    coef numeric NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.oil_coefs OWNER TO db_admin;

--
-- Name: TABLE oil_coefs; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.oil_coefs IS 'Коэффициент по маслу для снегоходов';


--
-- Name: COLUMN oil_coefs.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.oil_coefs.id IS 'Идентификатор';


--
-- Name: COLUMN oil_coefs.date_coef; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.oil_coefs.date_coef IS 'Дата коэффициента';


--
-- Name: COLUMN oil_coefs.type_technique_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.oil_coefs.type_technique_id IS 'Идентификатор типа техники';


--
-- Name: COLUMN oil_coefs.coef; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.oil_coefs.coef IS 'Сумма добавления стоимости к канистре';


--
-- Name: oil_coefs_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.oil_coefs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oil_coefs_id_seq OWNER TO db_admin;

--
-- Name: oil_coefs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.oil_coefs_id_seq OWNED BY public.oil_coefs.id;


--
-- Name: type_operations; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.type_operations (
    id integer NOT NULL,
    title text NOT NULL,
    visible_type_technique boolean DEFAULT false NOT NULL,
    visible_canisters boolean DEFAULT false NOT NULL,
    visible_amount boolean DEFAULT true NOT NULL,
    visible_cost_fuel boolean DEFAULT false NOT NULL,
    visible_technique boolean DEFAULT false NOT NULL,
    visible_description boolean DEFAULT true NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.type_operations OWNER TO db_admin;

--
-- Name: TABLE type_operations; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.type_operations IS 'Виды операций';


--
-- Name: COLUMN type_operations.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_operations.id IS 'Идентификатор';


--
-- Name: COLUMN type_operations.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_operations.title IS 'Операция';


--
-- Name: COLUMN type_operations.visible_type_technique; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_operations.visible_type_technique IS 'Показывать технику';


--
-- Name: COLUMN type_operations.visible_canisters; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_operations.visible_canisters IS 'Показывать количество канистр';


--
-- Name: COLUMN type_operations.visible_amount; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_operations.visible_amount IS 'Показывать сумму операции';


--
-- Name: COLUMN type_operations.visible_cost_fuel; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_operations.visible_cost_fuel IS 'Показывать стоимость бензина';


--
-- Name: COLUMN type_operations.visible_technique; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_operations.visible_technique IS 'Показывать технику';


--
-- Name: COLUMN type_operations.visible_description; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_operations.visible_description IS 'Показывать примечание';


--
-- Name: operacions_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.operacions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operacions_id_seq OWNER TO db_admin;

--
-- Name: operacions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.operacions_id_seq OWNED BY public.type_operations.id;


--
-- Name: operations; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.operations (
    id integer NOT NULL,
    date_operation date NOT NULL,
    operation_id integer NOT NULL,
    type_technique_id integer,
    canisters integer,
    amount numeric,
    cost_fuel numeric,
    technique_id numeric,
    description text,
    archive boolean DEFAULT false NOT NULL,
    source_id smallint NOT NULL,
    fuel_operation_id integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.operations OWNER TO db_admin;

--
-- Name: TABLE operations; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.operations IS 'Операции';


--
-- Name: COLUMN operations.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.id IS 'Идентификатор';


--
-- Name: COLUMN operations.date_operation; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.date_operation IS 'Дата операции';


--
-- Name: COLUMN operations.operation_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.operation_id IS 'Идентификатор типа операции';


--
-- Name: COLUMN operations.type_technique_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.type_technique_id IS 'Идентификатор типа техники';


--
-- Name: COLUMN operations.canisters; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.canisters IS 'Количество канистр';


--
-- Name: COLUMN operations.amount; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.amount IS 'Сумма';


--
-- Name: COLUMN operations.cost_fuel; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.cost_fuel IS 'Стоимость бензина';


--
-- Name: COLUMN operations.technique_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.technique_id IS 'Идентификатор техники';


--
-- Name: COLUMN operations.description; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.description IS 'Примечание';


--
-- Name: COLUMN operations.archive; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.archive IS 'Признак перевода в архив';


--
-- Name: COLUMN operations.source_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.source_id IS 'Источник записи: 1 - бот, 2 - таблица';


--
-- Name: COLUMN operations.fuel_operation_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.operations.fuel_operation_id IS 'Идентификатор записи покупки бензина (при операции Заправка бензина)';


--
-- Name: operations_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.operations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operations_id_seq OWNER TO db_admin;

--
-- Name: operations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.operations_id_seq OWNED BY public.operations.id;


--
-- Name: payment_types; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.payment_types (
    id integer NOT NULL,
    title text NOT NULL,
    emoji character varying DEFAULT ''::character varying NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.payment_types OWNER TO db_admin;

--
-- Name: TABLE payment_types; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.payment_types IS 'Тип оплаты';


--
-- Name: COLUMN payment_types.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.payment_types.id IS 'Идентификатор';


--
-- Name: COLUMN payment_types.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.payment_types.title IS 'Тип оплаты';


--
-- Name: COLUMN payment_types.emoji; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.payment_types.emoji IS 'Символ';


--
-- Name: payment_types_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.payment_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_types_id_seq OWNER TO db_admin;

--
-- Name: payment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.payment_types_id_seq OWNED BY public.payment_types.id;


--
-- Name: penalties; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.penalties (
    id integer NOT NULL,
    date_penalty date NOT NULL,
    user_id integer NOT NULL,
    amount numeric NOT NULL,
    description text,
    source_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.penalties OWNER TO db_admin;

--
-- Name: TABLE penalties; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.penalties IS 'Штрафы сотрудникам';


--
-- Name: COLUMN penalties.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.penalties.id IS 'Идентификатор';


--
-- Name: COLUMN penalties.date_penalty; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.penalties.date_penalty IS 'Дата штрафа';


--
-- Name: COLUMN penalties.user_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.penalties.user_id IS 'Идентификатор пользователя';


--
-- Name: COLUMN penalties.amount; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.penalties.amount IS 'Сумма штрафа';


--
-- Name: COLUMN penalties.description; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.penalties.description IS 'Примечание';


--
-- Name: COLUMN penalties.source_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.penalties.source_id IS 'Источник записи: 1 - бот, 2 - таблица';


--
-- Name: penalties_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.penalties_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.penalties_id_seq OWNER TO db_admin;

--
-- Name: penalties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.penalties_id_seq OWNED BY public.penalties.id;


--
-- Name: ranks; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.ranks (
    id integer NOT NULL,
    rank text NOT NULL,
    salary numeric,
    percent numeric,
    deleted_at timestamp without time zone
);


ALTER TABLE public.ranks OWNER TO db_admin;

--
-- Name: TABLE ranks; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.ranks IS 'Должности';


--
-- Name: COLUMN ranks.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.ranks.id IS 'Идентификатор';


--
-- Name: COLUMN ranks.rank; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.ranks.rank IS 'Должность';


--
-- Name: COLUMN ranks.salary; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.ranks.salary IS 'Размер оклада';


--
-- Name: COLUMN ranks.percent; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.ranks.percent IS 'Процент от дохода';


--
-- Name: ranks_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.ranks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ranks_id_seq OWNER TO db_admin;

--
-- Name: ranks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.ranks_id_seq OWNED BY public.ranks.id;


--
-- Name: route_costs; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.route_costs (
    id integer NOT NULL,
    date_cost date NOT NULL,
    type_technique_id integer NOT NULL,
    route_id integer NOT NULL,
    cost numeric NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.route_costs OWNER TO db_admin;

--
-- Name: TABLE route_costs; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.route_costs IS 'Стоимость маршрутов';


--
-- Name: COLUMN route_costs.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.route_costs.id IS 'Идентификатор';


--
-- Name: COLUMN route_costs.date_cost; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.route_costs.date_cost IS 'Дата установки стоимости';


--
-- Name: COLUMN route_costs.type_technique_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.route_costs.type_technique_id IS 'Идентификатор типа техники';


--
-- Name: COLUMN route_costs.route_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.route_costs.route_id IS 'Идентификатор маршрута';


--
-- Name: COLUMN route_costs.cost; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.route_costs.cost IS 'Стоимость маршрута на данном виде техники';


--
-- Name: route_costs_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.route_costs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.route_costs_id_seq OWNER TO db_admin;

--
-- Name: route_costs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.route_costs_id_seq OWNED BY public.route_costs.id;


--
-- Name: routes; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.routes (
    id integer NOT NULL,
    title text NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.routes OWNER TO db_admin;

--
-- Name: TABLE routes; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.routes IS 'Маршруты';


--
-- Name: COLUMN routes.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.routes.id IS 'Идентификатор';


--
-- Name: COLUMN routes.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.routes.title IS 'Название маршрута';


--
-- Name: routes_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.routes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.routes_id_seq OWNER TO db_admin;

--
-- Name: routes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.routes_id_seq OWNED BY public.routes.id;


--
-- Name: salary_days; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.salary_days (
    date_salary date NOT NULL,
    user_id integer NOT NULL,
    salary numeric NOT NULL,
    percent numeric NOT NULL,
    penalty numeric NOT NULL
);


ALTER TABLE public.salary_days OWNER TO db_admin;

--
-- Name: TABLE salary_days; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.salary_days IS 'Зарплата сотрудников по дням';


--
-- Name: COLUMN salary_days.date_salary; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.salary_days.date_salary IS 'Дата зарплаты';


--
-- Name: COLUMN salary_days.user_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.salary_days.user_id IS 'Идентификатор пользователя';


--
-- Name: COLUMN salary_days.salary; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.salary_days.salary IS 'Оклад';


--
-- Name: COLUMN salary_days.percent; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.salary_days.percent IS 'Процент от дохода';


--
-- Name: COLUMN salary_days.penalty; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.salary_days.penalty IS 'Штраф';


--
-- Name: sources; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.sources (
    id integer NOT NULL,
    title text NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.sources OWNER TO db_admin;

--
-- Name: TABLE sources; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.sources IS 'Источник поступления заявки';


--
-- Name: COLUMN sources.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.sources.id IS 'Идентификатор';


--
-- Name: COLUMN sources.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.sources.title IS 'Источник клиента';


--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.sources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sources_id_seq OWNER TO db_admin;

--
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.sources_id_seq OWNED BY public.sources.id;


--
-- Name: techniques; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.techniques (
    id integer NOT NULL,
    title text NOT NULL,
    type_technique_id integer NOT NULL,
    investor_id integer,
    archive boolean DEFAULT false NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    "position" integer,
    deleted_at timestamp without time zone
);


ALTER TABLE public.techniques OWNER TO db_admin;

--
-- Name: TABLE techniques; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.techniques IS 'Используемая техника';


--
-- Name: COLUMN techniques.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.techniques.id IS 'Идентификатор';


--
-- Name: COLUMN techniques.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.techniques.title IS 'Название техники';


--
-- Name: COLUMN techniques.type_technique_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.techniques.type_technique_id IS 'Идентификатор типа техники';


--
-- Name: COLUMN techniques.investor_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.techniques.investor_id IS 'Идентификатор инвестора';


--
-- Name: COLUMN techniques.archive; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.techniques.archive IS 'Признак перевода в архив';


--
-- Name: COLUMN techniques.visible; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.techniques.visible IS 'Видимость техники на форме';


--
-- Name: COLUMN techniques."position"; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.techniques."position" IS 'Позиция техники в списке';


--
-- Name: techniques_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.techniques_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.techniques_id_seq OWNER TO db_admin;

--
-- Name: techniques_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.techniques_id_seq OWNED BY public.techniques.id;


--
-- Name: type_expenses; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.type_expenses (
    id integer NOT NULL,
    title text DEFAULT ''::text NOT NULL,
    visible_investor boolean DEFAULT false NOT NULL,
    visible_employee boolean DEFAULT false NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    category_exp_id integer DEFAULT 0 NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.type_expenses OWNER TO db_admin;

--
-- Name: TABLE type_expenses; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.type_expenses IS 'Типы расходов';


--
-- Name: COLUMN type_expenses.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_expenses.title IS 'Название';


--
-- Name: COLUMN type_expenses.visible_investor; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_expenses.visible_investor IS 'Показывать инвестора';


--
-- Name: COLUMN type_expenses.visible_employee; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_expenses.visible_employee IS 'Показывать сотрудника';


--
-- Name: COLUMN type_expenses."position"; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_expenses."position" IS 'Расположение';


--
-- Name: COLUMN type_expenses.category_exp_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_expenses.category_exp_id IS 'Категория рсходов: category_expenses';


--
-- Name: type_expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.type_expenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_expenses_id_seq OWNER TO db_admin;

--
-- Name: type_expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.type_expenses_id_seq OWNED BY public.type_expenses.id;


--
-- Name: type_techniques; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.type_techniques (
    id integer NOT NULL,
    title text NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.type_techniques OWNER TO db_admin;

--
-- Name: TABLE type_techniques; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.type_techniques IS 'Используемые типы техники';


--
-- Name: COLUMN type_techniques.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_techniques.id IS 'Иденетификатор';


--
-- Name: COLUMN type_techniques.title; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.type_techniques.title IS 'Наименование типа техники';


--
-- Name: type_technique_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.type_technique_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_technique_id_seq OWNER TO db_admin;

--
-- Name: type_technique_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.type_technique_id_seq OWNED BY public.type_techniques.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    tg text,
    full_name text NOT NULL,
    is_manager boolean DEFAULT false NOT NULL,
    is_instructor boolean DEFAULT false NOT NULL,
    is_assistant boolean DEFAULT false NOT NULL,
    send_button boolean DEFAULT false NOT NULL,
    deposit_income boolean DEFAULT false NOT NULL,
    enter_operation boolean DEFAULT false NOT NULL,
    view_salary boolean DEFAULT false NOT NULL,
    contribute_expense boolean DEFAULT false NOT NULL,
    is_director boolean DEFAULT false NOT NULL,
    chat_id bigint,
    comission boolean DEFAULT false NOT NULL,
    penalty boolean DEFAULT false NOT NULL,
    is_investor boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO db_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON TABLE public.users IS 'Сотрудники';


--
-- Name: COLUMN users.id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.id IS 'Идентификатор';


--
-- Name: COLUMN users.tg; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.tg IS 'Ник в телеграм';


--
-- Name: COLUMN users.full_name; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.full_name IS 'Имя';


--
-- Name: COLUMN users.is_manager; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.is_manager IS 'Является ли менеджером';


--
-- Name: COLUMN users.is_instructor; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.is_instructor IS 'Является ли инстркутор';


--
-- Name: COLUMN users.is_assistant; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.is_assistant IS 'Является ли ассистентом';


--
-- Name: COLUMN users.send_button; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.send_button IS 'Отправить кнопки';


--
-- Name: COLUMN users.deposit_income; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.deposit_income IS 'Внести доход';


--
-- Name: COLUMN users.enter_operation; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.enter_operation IS 'Внести операции';


--
-- Name: COLUMN users.view_salary; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.view_salary IS 'Посмотреть зарплату';


--
-- Name: COLUMN users.contribute_expense; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.contribute_expense IS 'Внести расход';


--
-- Name: COLUMN users.is_director; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.is_director IS 'Является ли директором';


--
-- Name: COLUMN users.chat_id; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.chat_id IS 'Идентификатор чата сотрудника';


--
-- Name: COLUMN users.comission; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.comission IS 'Внести комиссию';


--
-- Name: COLUMN users.penalty; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.penalty IS 'Внести штраф';


--
-- Name: COLUMN users.is_investor; Type: COMMENT; Schema: public; Owner: db_admin
--

COMMENT ON COLUMN public.users.is_investor IS 'Является ли инвестором';


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO db_admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: web_users; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.web_users (
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    role character varying DEFAULT 'user'::character varying NOT NULL
);


ALTER TABLE public.web_users OWNER TO db_admin;

--
-- Name: web_users_id_seq; Type: SEQUENCE; Schema: public; Owner: db_admin
--

CREATE SEQUENCE public.web_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_users_id_seq OWNER TO db_admin;

--
-- Name: web_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db_admin
--

ALTER SEQUENCE public.web_users_id_seq OWNED BY public.web_users.id;


--
-- Name: category_expenses id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.category_expenses ALTER COLUMN id SET DEFAULT nextval('public.category_expenses_id_seq'::regclass);


--
-- Name: comissions id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.comissions ALTER COLUMN id SET DEFAULT nextval('public.comissions_id_seq'::regclass);


--
-- Name: day_employees id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.day_employees ALTER COLUMN id SET DEFAULT nextval('public.day_employees_id_seq'::regclass);


--
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- Name: flight_techniques id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.flight_techniques ALTER COLUMN id SET DEFAULT nextval('public.flight_techniques_id_seq'::regclass);


--
-- Name: flights id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.flights ALTER COLUMN id SET DEFAULT nextval('public.flights_id_seq'::regclass);


--
-- Name: hotels id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.hotels ALTER COLUMN id SET DEFAULT nextval('public.hotels_id_seq'::regclass);


--
-- Name: investors id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.investors ALTER COLUMN id SET DEFAULT nextval('public.investors_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: oil_coefs id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.oil_coefs ALTER COLUMN id SET DEFAULT nextval('public.oil_coefs_id_seq'::regclass);


--
-- Name: operations id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.operations ALTER COLUMN id SET DEFAULT nextval('public.operations_id_seq'::regclass);


--
-- Name: payment_types id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.payment_types ALTER COLUMN id SET DEFAULT nextval('public.payment_types_id_seq'::regclass);


--
-- Name: penalties id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.penalties ALTER COLUMN id SET DEFAULT nextval('public.penalties_id_seq'::regclass);


--
-- Name: ranks id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.ranks ALTER COLUMN id SET DEFAULT nextval('public.ranks_id_seq'::regclass);


--
-- Name: route_costs id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.route_costs ALTER COLUMN id SET DEFAULT nextval('public.route_costs_id_seq'::regclass);


--
-- Name: routes id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.routes ALTER COLUMN id SET DEFAULT nextval('public.routes_id_seq'::regclass);


--
-- Name: sources id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.sources ALTER COLUMN id SET DEFAULT nextval('public.sources_id_seq'::regclass);


--
-- Name: techniques id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.techniques ALTER COLUMN id SET DEFAULT nextval('public.techniques_id_seq'::regclass);


--
-- Name: type_expenses id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.type_expenses ALTER COLUMN id SET DEFAULT nextval('public.type_expenses_id_seq'::regclass);


--
-- Name: type_operations id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.type_operations ALTER COLUMN id SET DEFAULT nextval('public.operacions_id_seq'::regclass);


--
-- Name: type_techniques id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.type_techniques ALTER COLUMN id SET DEFAULT nextval('public.type_technique_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: web_users id; Type: DEFAULT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.web_users ALTER COLUMN id SET DEFAULT nextval('public.web_users_id_seq'::regclass);


--
-- Data for Name: cash_received; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.cash_received (date_received, cash) FROM stdin;
2024-01-21 20:52:39.346562+03	2273400
2024-01-23 18:34:12.136059+03	113000
2024-01-30 19:13:27.121904+03	23000
2024-01-31 21:25:50.25592+03	89000
2024-02-03 10:23:16.406769+03	107000
2024-02-04 11:12:56.491078+03	89000
2024-02-05 18:30:44.15813+03	134500
2024-01-29 18:31:33.916499+03	494700
2024-02-06 18:57:31.369469+03	78000
2024-02-07 19:13:18.924974+03	89000
2024-02-10 19:02:20.515251+03	208000
2024-02-13 19:35:36.628746+03	249500
2024-02-16 20:17:12.542652+03	120000
2024-02-17 22:41:03.129457+03	31000
2024-02-23 08:55:13.182154+03	330000
2024-02-27 19:22:29.496237+03	263600
2024-02-29 19:59:51.729967+03	36000
2024-02-29 19:59:53.729231+03	18000
2024-02-29 19:59:55.45083+03	243600
2024-02-29 19:59:56.743461+03	185600
2024-02-29 19:59:57.507793+03	185600
2024-02-29 19:59:58.967562+03	41600
2024-02-29 20:00:03.837979+03	172000
2024-03-02 06:59:50.908624+03	-832400
2024-03-02 22:01:37.352887+03	51000
2024-03-03 23:48:08.603026+03	28000
2024-03-05 11:36:15.559271+03	54000
2024-03-05 22:50:17.288902+03	88500
2024-03-15 19:45:02.009892+03	354000
2024-03-16 18:30:46.014677+03	4000
2024-03-18 10:46:50.16427+03	28000
2024-03-22 19:10:48.00237+03	78000
2024-03-23 22:33:37.425852+03	0
2024-03-24 20:00:26.364669+03	12000
2024-03-30 22:04:20.621313+03	48000
2024-04-03 18:44:21.141849+03	22000
2024-04-15 09:03:44.161316+03	56000
2024-04-22 21:19:55.908755+03	31000
2024-05-05 08:44:21.525329+03	104500
2024-05-14 19:02:59.840562+03	120500
2024-05-15 19:16:27.999618+03	0
2024-05-24 10:04:49.088478+03	27000
2024-05-29 20:26:29.953854+03	8000
2024-06-19 19:53:05.331947+03	179000
2024-06-24 23:15:28.355377+03	74000
2024-07-20 10:49:23.913039+03	350700
2024-08-22 12:49:12.368018+03	1272200
\.


--
-- Data for Name: category_expenses; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.category_expenses (id, title, "position", deleted_at) FROM stdin;
1	Общие расходы	1	\N
2	Расходы бизнеса	2	\N
3	Техническая часть	3	\N
4	Полиграфия	4	\N
5	Расходы по Рекламе	5	\N
6	ЗП	6	\N
7	Выплаты	7	\N
8	Дополнительно	8	\N
\.


--
-- Data for Name: comissions; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.comissions (id, title, deleted_at) FROM stdin;
3	Кешбек за отзыв	2024-03-23 15:41:27.481068
4	Комиссия агентам	2024-03-23 15:41:27.4863
\.


--
-- Data for Name: day_employees; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.day_employees (id, date_employee, director_id, manager_id, ceated_at) FROM stdin;
50	2024-02-17	3	2	2024-02-17 09:25:32.238658
51	2024-02-18	3	2	2024-02-18 09:05:26.86496
52	2024-02-19	3	0	2024-02-19 12:30:23.492319
53	2024-02-20	3	0	2024-02-20 09:25:36.146115
54	2024-02-21	3	0	2024-02-21 09:20:51.414626
55	2024-02-22	0	2	2024-02-22 09:14:45.336053
56	2024-02-23	3	0	2024-02-23 17:24:32.564281
57	2024-02-24	3	2	2024-02-24 10:35:34.539246
58	2024-02-25	3	2	2024-02-25 09:40:11.116332
59	2024-02-26	3	2	2024-02-26 10:18:12.492486
60	2024-02-27	3	2	2024-02-27 09:51:21.521018
61	2024-02-28	3	2	2024-02-28 09:25:46.301378
62	2024-02-29	3	2	2024-02-29 09:52:40.992113
63	2024-03-01	3	2	2024-03-01 09:20:16.017443
64	2024-03-02	3	2	2024-03-02 09:00:32.38493
65	2024-03-03	3	2	2024-03-03 09:03:06.38747
66	2024-03-05	3	2	2024-03-05 09:00:23.879358
67	2024-03-06	3	2	2024-03-06 09:00:26.17021
68	2024-03-07	3	2	2024-03-07 09:03:13.723505
69	2024-03-08	3	2	2024-03-08 14:48:59.624526
70	2024-03-09	3	0	2024-03-09 09:04:03.74737
71	2024-03-10	3	2	2024-03-10 10:04:59.273165
72	2024-03-15	3	2	2024-03-15 09:42:50.935233
73	2024-03-15	3	2	2024-03-15 09:42:52.044635
74	2024-03-16	3	2	2024-03-16 10:53:53.835551
75	2024-03-17	3	2	2024-03-17 09:49:41.163188
76	2024-03-19	0	2	2024-03-19 12:59:53.457283
77	2024-03-20	0	2	2024-03-20 10:54:39.549801
78	2024-03-20	0	2	2024-03-20 10:54:40.229184
1	2024-01-01	3	2	\N
3	2024-01-02	3	2	\N
6	2024-01-05	3	2	\N
7	2024-01-06	3	2	\N
8	2024-01-07	3	2	\N
9	2024-01-08	3	2	\N
10	2024-01-09	3	2	\N
11	2024-01-10	3	2	\N
13	2024-01-12	3	2	\N
14	2024-01-13	3	2	\N
15	2024-01-14	3	0	\N
16	2024-01-15	3	0	\N
49	2024-02-16	3	2	\N
48	2024-02-15	3	2	\N
47	2024-02-14	3	2	\N
46	2024-02-13	3	2	\N
45	2024-02-12	3	2	\N
44	2024-02-11	3	2	\N
43	2024-02-10	3	2	\N
42	2024-02-09	3	2	\N
41	2024-02-07	3	2	\N
40	2024-02-06	3	2	\N
39	2024-02-05	3	2	\N
38	2024-02-04	3	2	\N
37	2024-02-04	3	2	\N
36	2024-02-03	3	2	\N
35	2024-02-02	3	0	\N
34	2024-02-01	3	0	\N
31	2024-01-29	3	2	\N
30	2024-01-28	3	2	\N
29	2024-01-27	3	2	\N
28	2024-01-26	3	2	\N
27	2024-01-25	3	2	\N
26	2024-01-24	3	2	\N
25	2024-01-23	3	2	\N
24	2024-01-22	3	2	\N
23	2024-01-21	3	2	\N
33	2024-01-31	3	0	\N
32	2024-01-30	3	0	\N
22	2024-01-20	3	2	\N
21	2024-01-19	3	2	\N
20	2024-01-18	3	2	\N
19	2024-01-17	3	2	\N
17	2024-01-16	3	0	\N
12	2024-01-11	3	0	\N
5	2024-01-04	3	2	\N
4	2024-01-03	3	2	\N
79	2024-03-21	0	2	2024-03-21 10:11:01.976798
80	2024-03-22	0	2	2024-03-22 09:53:05.869967
81	2024-03-23	3	2	2024-03-23 09:34:01.519134
82	2024-03-25	0	2	2024-03-25 09:00:48.880818
83	2024-03-27	0	2	2024-03-27 12:35:47.232202
84	2024-03-28	0	2	2024-03-28 09:25:30.390691
85	2024-03-29	0	2	2024-03-29 09:41:18.775217
86	2024-03-30	0	2	2024-03-30 09:09:42.004192
87	2024-03-31	0	2	2024-03-31 09:42:15.671245
88	2024-04-02	0	2	2024-04-02 10:04:19.624037
89	2024-04-03	0	2	2024-04-03 09:45:25.664242
90	2024-04-04	0	2	2024-04-04 09:16:09.26467
91	2024-04-05	0	2	2024-04-05 09:00:19.31745
92	2024-04-07	0	2	2024-04-07 09:03:31.197137
93	2024-04-08	0	2	2024-04-08 09:35:33.785665
94	2024-04-09	0	2	2024-04-09 09:46:46.461561
95	2024-04-10	0	2	2024-04-10 09:27:26.559726
96	2024-04-13	0	2	2024-04-13 10:36:23.755811
97	2024-04-15	0	2	2024-04-15 09:03:50.627939
98	2024-04-16	0	2	2024-04-16 09:50:07.931016
99	2024-04-21	0	2	2024-04-21 11:42:03.088013
100	2024-04-23	0	2	2024-04-23 11:05:45.846952
101	2024-04-26	0	2	2024-04-26 10:13:47.864343
102	2024-04-27	0	2	2024-04-27 09:03:10.755474
103	2024-04-28	0	2	2024-04-28 09:27:44.167309
104	2024-05-01	0	2	2024-05-01 09:02:52.985103
105	2024-05-02	3	2	2024-05-02 09:40:26.437859
106	2024-05-03	3	2	2024-05-03 10:28:08.723037
107	2024-05-05	3	2	2024-05-05 09:40:04.633051
108	2024-05-06	3	2	2024-05-06 09:51:10.115215
109	2024-05-07	0	2	2024-05-07 10:11:54.73887
110	2024-05-11	3	2	2024-05-11 16:16:50.234125
111	2024-05-12	3	2	2024-05-12 09:19:53.417563
112	2024-05-14	3	2	2024-05-14 09:05:09.522449
113	2024-05-15	3	0	2024-05-15 09:07:43.642766
114	2024-05-18	3	0	2024-05-18 09:12:29.336643
115	2024-05-19	3	0	2024-05-19 09:28:30.562619
116	2024-05-21	3	0	2024-05-21 09:08:21.551671
117	2024-05-22	3	0	2024-05-22 09:51:25.003524
118	2024-05-23	3	0	2024-05-23 09:01:08.953587
119	2024-06-05	3	2	2024-06-05 09:32:22.548679
120	2024-06-15	3	2	2024-06-15 16:09:27.853319
121	2024-06-16	0	2	2024-06-16 18:18:09.797272
122	2024-06-17	0	2	2024-06-17 10:07:54.61103
123	2024-07-01	3	2	2024-07-01 16:49:44.499497
124	2024-07-18	3	2	2024-07-18 19:17:31.929772
125	2024-07-24	0	2	2024-07-24 17:59:16.191704
126	2024-07-27	0	2	2024-07-27 15:50:05.619499
127	2024-07-28	3	2	2024-07-28 15:12:27.109289
128	2024-08-04	3	2	2024-08-04 09:00:23.891853
129	2024-08-04	3	2	2024-08-04 09:00:23.909133
130	2024-08-04	3	2	2024-08-04 09:00:23.950218
131	2024-08-04	3	2	2024-08-04 09:00:29.29367
132	2024-08-05	3	2	2024-08-05 10:22:28.994233
133	2024-08-11	3	2	2024-08-11 11:26:04.651688
134	2024-08-12	3	0	2024-08-12 09:34:13.461171
135	2024-08-18	3	2	2024-08-18 18:27:28.719303
136	2024-09-24	3	0	2024-09-24 10:07:00.717816
137	2024-09-25	3	2	2024-09-25 10:22:22.244856
138	2024-09-26	3	2	2024-09-26 09:12:37.259161
139	2024-09-27	0	2	2024-09-27 14:13:40.045543
140	2024-09-28	0	2	2024-09-28 09:08:29.141826
141	2024-09-29	3	2	2024-09-29 10:37:35.3088
142	2024-09-30	3	2	2024-09-30 11:39:26.957922
143	2024-10-02	3	0	2024-10-02 11:26:03.960265
144	2024-10-03	3	2	2024-10-03 09:02:25.142294
145	2024-10-04	3	2	2024-10-04 12:10:11.280048
146	2024-10-05	3	2	2024-10-05 11:08:32.126503
147	2024-10-06	3	2	2024-10-06 09:03:32.411573
148	2024-10-07	0	2	2024-10-07 09:10:26.887364
149	2024-10-08	0	2	2024-10-08 09:19:37.638169
150	2024-10-09	3	0	2024-10-09 09:00:28.953905
151	2024-10-10	3	2	2024-10-10 09:00:54.761721
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.expenses (id, date_expense, type_expense_id, investor_id, employee_id, amount, description, source_id, archive, created_at) FROM stdin;
106	2024-01-04	13	\N	11	15000		2	f	\N
2	2024-01-01	5	\N	\N	1300	Оплата интернета	2	f	\N
3	2024-01-01	1	\N	\N	555	Закуски в дорогу	2	f	\N
4	2024-01-01	2	\N	\N	2941		2	f	\N
6	2024-01-01	2	\N	\N	1296		2	f	\N
7	2024-01-01	19	\N	\N	2200		2	f	\N
11	2024-01-02	5	\N	\N	1000		2	f	\N
13	2024-01-02	1	\N	\N	1800		2	f	\N
17	2024-01-03	8	\N	\N	2300		2	f	\N
18	2024-01-04	3	\N	\N	3000		2	f	\N
21	2024-01-04	7	\N	\N	9000		2	f	\N
23	2024-01-04	2	\N	\N	2000		2	f	\N
24	2024-01-05	1	\N	\N	4000		2	f	\N
26	2024-01-05	2	\N	\N	2000		2	f	\N
27	2024-01-06	2	\N	\N	2000		2	f	\N
28	2024-01-06	1	\N	\N	3000		2	f	\N
29	2024-01-07	12	\N	\N	2000		2	f	\N
30	2024-01-07	1	\N	\N	2400		2	f	\N
33	2024-01-08	2	\N	\N	2500		2	f	\N
34	2024-01-08	1	\N	\N	400		2	f	\N
35	2024-01-09	1	\N	\N	400		2	f	\N
36	2024-01-09	7	\N	\N	4800		2	f	\N
39	2024-01-10	2	\N	\N	1500		2	f	\N
41	2024-01-10	19	\N	\N	7750		2	f	\N
42	2024-01-11	1	\N	\N	1700		2	f	\N
43	2024-01-12	2	\N	\N	800		2	f	\N
44	2024-01-12	1	\N	\N	500		2	f	\N
45	2024-01-13	19	\N	\N	7800		2	f	\N
47	2024-01-13	1	\N	\N	1500		2	f	\N
49	2024-01-14	19	\N	\N	2000		2	f	\N
51	2024-01-14	5	\N	\N	1300		2	f	\N
107	2024-01-31	11	\N	\N	73500		2	f	\N
57	2024-01-17	19	\N	\N	900		2	f	\N
60	2024-01-18	1	\N	\N	1600		2	f	\N
64	2024-01-20	1	\N	\N	1900		2	f	\N
67	2024-01-22	1	\N	\N	2400		2	f	\N
69	2024-01-23	2	\N	\N	3000		2	f	\N
74	2024-01-25	19	\N	\N	4000		2	f	\N
78	2024-01-27	5	\N	\N	5000		2	f	\N
80	2024-01-28	2	\N	\N	5700		2	f	\N
108	2024-02-04	80	0	0	4700		1	f	\N
83	2024-01-30	2	\N	\N	2800		2	f	\N
84	2024-01-30	1	\N	\N	1000		2	f	\N
115	2024-01-31	14	\N	\N	300000		2	f	\N
117	2024-02-01	5	\N	\N	300		2	f	\N
118	2024-02-01	8	\N	\N	14500		2	f	\N
119	2024-02-02	1	\N	\N	1400		2	f	\N
121	2024-02-02	88	\N	\N	5000	крипто про	2	f	\N
122	2024-02-03	1	\N	\N	1050		2	f	\N
123	2024-02-03	19	\N	\N	600		2	f	\N
124	2024-02-04	19	\N	\N	800		2	f	\N
125	2024-02-04	1	\N	\N	1400		2	f	\N
126	2024-02-04	87	\N	\N	300		2	f	\N
127	2024-02-05	1	\N	\N	2000		2	f	\N
128	2024-02-06	2	\N	\N	2800		2	f	\N
129	2024-02-06	1	\N	\N	1600		2	f	\N
130	2024-02-06	19	\N	\N	240		2	f	\N
131	2024-02-07	1	\N	\N	1200		2	f	\N
132	2024-02-07	18	\N	\N	2000		2	f	\N
134	2024-02-09	1	\N	\N	1700		2	f	\N
135	2024-02-09	2	\N	\N	2700		2	f	\N
136	2024-02-09	87	\N	\N	1050		2	f	\N
137	2024-02-10	89	\N	\N	170000	прицеп	2	f	\N
85	2024-01-31	1	\N	\N	600		2	f	\N
97	2024-02-01	1	0	0	639		1	f	\N
98	2024-02-01	85	0	0	18500		1	f	\N
99	2024-02-01	80	0	0	13500		1	f	\N
100	2024-02-01	87	0	0	800		1	f	\N
102	2024-02-02	2	0	0	3100		1	f	\N
140	2024-02-16	99	0	0	1000		1	f	\N
81	2024-01-30	14	3	\N	100000		2	f	\N
16	2024-01-03	80	\N	4	16020		2	f	\N
114	2024-01-31	14	6	\N	141061		2	f	\N
116	2024-01-31	14	3	\N	248485		2	f	\N
101	2024-02-01	14	3	\N	10000		1	f	\N
8	2024-01-01	95	\N	\N	70000	За рекламу сайта	2	f	\N
9	2024-01-02	7	\N	\N	10400	Покупка масла	2	f	\N
10	2024-01-02	3	\N	\N	20000	Таулану 	2	f	\N
14	2024-01-03	1	\N	\N	1700		2	f	\N
15	2024-01-03	90	\N	\N	2000	Визитки 	2	f	\N
22	2024-01-04	80	\N	\N	43500		2	f	\N
31	2024-01-08	85	\N	\N	20000	Таблица	2	f	\N
32	2024-01-08	80	\N	\N	21000		2	f	\N
38	2024-01-10	80	\N	\N	7500		2	f	\N
46	2024-01-13	80	\N	\N	15000		2	f	\N
50	2024-01-14	18	\N	\N	2000	Штрафы	2	f	\N
48	2024-01-14	80	\N	\N	6800		2	f	\N
52	2024-01-14	80	\N	\N	800		2	f	\N
55	2024-01-16	80	\N	\N	45000		2	f	\N
53	2024-01-15	99	\N	\N	25000		2	f	\N
56	2024-01-16	7	\N	\N	6900	Крипто про и Эдо	2	f	\N
54	2024-01-16	9	\N	\N	1500		2	f	\N
58	2024-01-17	85	\N	\N	14000		2	f	\N
61	2024-01-18	83	\N	\N	15000	Налог	2	f	\N
59	2024-01-18	7	\N	\N	3250		2	f	\N
66	2024-01-21	7	\N	\N	7000		2	f	\N
62	2024-01-19	89	\N	\N	40000	Контейнер	2	f	\N
65	2024-01-21	80	\N	\N	40000		2	f	\N
71	2024-01-24	1	\N	\N	480		2	f	\N
70	2024-01-23	1	\N	\N	700		2	f	\N
73	2024-01-25	1	\N	\N	400		2	f	\N
76	2024-01-26	84	\N	\N	1500	Командирвока	2	f	\N
75	2024-01-26	96	\N	\N	25000		2	f	\N
72	2024-01-25	84	\N	\N	6000	Командирвока	2	f	\N
79	2024-01-28	96	\N	\N	15000		2	f	\N
77	2024-01-27	97	\N	\N	2000		2	f	\N
87	2024-01-31	11	\N	2	179436		2	f	\N
86	2024-01-31	11	\N	3	224295		2	f	\N
120	2024-02-02	90	\N	\N	14500		2	f	\N
109	2024-02-05	19	\N	3	100		2	f	\N
133	2024-02-08	1	\N	\N	1800		2	f	\N
138	2024-02-12	1	\N	\N	400		1	f	\N
141	2024-02-16	15	0	0	4000	14 февраля 	1	f	\N
146	2024-02-20	15	0	0	1200	Камила премиум виладж	1	f	2024-02-20 20:45:57.807523+03
145	2024-02-20	99	0	0	1000	Кешбек 19 февраля	1	f	2024-02-20 11:26:55.081052+03
142	2024-02-16	99	0	0	2000	Кешбек 12 февраля 	1	f	\N
149	2024-02-24	99	0	0	1500		1	f	2024-02-24 08:30:21.119426+03
150	2024-02-24	99	0	0	1500		1	f	2024-02-24 14:14:34.964094+03
151	2024-02-25	99	0	0	1500		1	f	2024-02-25 18:27:57.580428+03
162	2024-03-03	136	\N	\N	2000		1	f	2024-03-03 23:48:04.438133+03
163	2024-03-05	136	\N	\N	2000		1	f	2024-03-05 22:50:23.35716+03
164	2024-03-05	136	\N	\N	1000		1	f	2024-03-05 22:50:25.136922+03
165	2024-03-05	136	\N	\N	2000		1	f	2024-03-05 22:50:27.919788+03
166	2024-03-06	99	0	0	2000		1	f	2024-03-06 17:02:24.075512+03
167	2024-03-07	99	0	0	1000		1	f	2024-03-07 14:37:52.563799+03
168	2024-03-07	136	\N	\N	2500		1	f	2024-03-07 18:59:46.650381+03
169	2024-03-08	136	\N	\N	2500		1	f	2024-03-08 18:53:08.679361+03
170	2024-03-16	99	0	0	1500		1	f	2024-03-16 13:14:45.813579+03
171	2024-03-16	136	\N	\N	2000		1	f	2024-03-16 18:30:47.815342+03
172	2024-03-22	97	0	0	27000	Реклама яндекс	1	f	2024-03-22 13:44:40.303223+03
174	2024-03-22	99	0	0	2000		1	f	2024-03-22 19:16:19.440194+03
208	2024-04-17	99	0	0	2000		1	f	2024-04-20 20:05:01.282346+03
209	2024-04-17	99	0	0	2000		1	f	2024-04-20 20:05:01.793754+03
178	2024-02-24	14	4	\N	22000		2	f	2024-03-23 20:22:11.986057+03
180	2024-02-29	14	5	\N	0		2	f	2024-03-23 20:24:13.969821+03
181	2024-02-29	14	2	\N	0		2	f	2024-03-23 20:24:14.553073+03
182	2024-02-29	14	3	\N	0		2	f	2024-03-23 20:24:15.107925+03
183	2024-02-29	14	4	\N	0		2	f	2024-03-23 20:24:16.126988+03
179	2024-02-29	14	6	\N	0		2	f	2024-03-23 20:24:12.938096+03
1	2024-01-01	87	\N	\N	899	Яндекс бизнес подписка	2	f	\N
12	2024-01-02	85	\N	\N	10150	Разработка таблицы	2	f	\N
82	2024-01-30	97	\N	\N	4000		2	f	\N
96	2024-01-31	83	\N	\N	52000	Налог	2	f	\N
95	2024-01-31	16	\N	\N	70000		2	f	\N
94	2024-01-31	98	\N	\N	52700		2	f	\N
88	2024-01-31	11	\N	6	205020		2	f	\N
89	2024-01-31	11	\N	7	136900		2	f	\N
90	2024-01-31	11	\N	9	16200		2	f	\N
91	2024-01-31	11	\N	14	61320		2	f	\N
92	2024-01-31	11	\N	5	30000		2	f	\N
210	2024-05-10	99	0	0	1000		1	f	2024-05-10 18:51:06.831325+03
113	2024-01-31	14	7	\N	300000		2	f	\N
143	2024-02-17	1	\N	\N	600		1	f	2024-02-17 10:00:18.236373+03
147	2024-02-23	1	\N	\N	300		1	f	2024-02-23 08:55:15.89132+03
152	2024-02-28	1	\N	\N	200		1	f	2024-02-28 18:31:10.784908+03
161	2024-02-29	136	\N	\N	64000		1	f	2024-02-29 20:00:09.217397+03
185	2024-02-12	87	\N	\N	1000		2	f	2024-03-29 15:26:53.370875+03
186	2024-02-15	8	\N	\N	26400	постановка на учет	2	f	2024-03-29 15:26:53.450492+03
187	2024-02-17	94	\N	\N	2400		2	f	2024-03-29 15:26:53.539017+03
188	2024-02-24	89	\N	\N	42000	дизайн под ключ контейнера	2	f	2024-03-29 15:26:53.620146+03
189	2024-02-24	85	\N	\N	18000		2	f	2024-03-29 15:26:53.700903+03
190	2024-02-24	139	\N	\N	56000	Доработки сайта	2	f	2024-03-29 15:26:53.784208+03
191	2024-02-29	11	\N	2	105000		2	f	2024-03-29 15:26:53.932397+03
192	2024-02-29	11	\N	3	178000		2	f	2024-03-29 15:26:54.012777+03
193	2024-02-29	11	\N	7	156000		2	f	2024-03-29 15:26:54.093337+03
194	2024-02-29	11	\N	14	80000		2	f	2024-03-29 15:26:54.173842+03
195	2024-02-29	11	\N	5	30000		2	f	2024-03-29 15:26:54.257345+03
196	2024-02-29	11	\N	6	145000		2	f	2024-03-29 15:26:54.343021+03
197	2024-02-29	16	\N	\N	80000		2	f	2024-03-29 15:26:54.425099+03
198	2024-02-29	98	\N	\N	53000		2	f	2024-03-29 15:26:54.511293+03
199	2024-02-29	9	\N	\N	10000	Яндекс бизнес реклама	2	f	2024-03-29 15:26:54.59218+03
200	2024-02-29	5	\N	\N	5000	Why Fly комерческий	2	f	2024-03-29 15:26:54.681982+03
201	2024-02-29	87	\N	\N	5000	Сумма подписки на ваба	2	f	2024-03-29 15:26:54.763445+03
202	2024-02-29	88	\N	\N	6000	WABA 	2	f	2024-03-29 15:26:54.844908+03
203	2024-02-29	5	\N	\N	1000	Мегафон основной	2	f	2024-03-29 15:26:54.926285+03
204	2024-02-29	88	\N	\N	1000	amoCRM 	2	f	2024-03-29 15:26:55.010342+03
205	2024-02-29	95	\N	\N	70000	Сео основного сайта	2	f	2024-03-29 15:26:55.091786+03
206	2024-02-29	88	\N	\N	3000	Тильда и все домены	2	f	2024-03-29 15:26:55.173232+03
207	2024-02-29	88	\N	\N	1000	Топвизор	2	f	2024-03-29 15:26:55.257125+03
211	2024-05-31	99	0	0	2000		1	f	2024-05-31 13:16:08.119906+03
212	2024-07-01	15	0	0	2400	Ислам премиум виладж 3 квадрика на белый 	1	f	2024-07-01 14:57:48.459743+03
213	2024-07-04	15	0	0	800	Камила - 1 квадрик 	1	f	2024-07-04 09:35:32.773548+03
214	2024-07-07	15	0	0	900	Ислам  - премиум виладж	1	f	2024-07-07 11:22:30.273144+03
215	2024-07-10	15	0	0	1000	Исламу комиссия 10.07	1	f	2024-07-10 20:14:25.674265+03
216	2024-07-16	15	0	0	10000		1	f	2024-07-16 21:00:47.686604+03
217	2024-07-22	15	0	0	1000		1	f	2024-07-22 20:09:08.020276+03
218	2024-07-25	15	0	0	1000		1	f	2024-07-25 12:38:50.051126+03
219	2024-07-25	99	0	0	3000		1	f	2024-07-25 15:28:40.945464+03
220	2024-07-26	99	0	0	3000		1	f	2024-07-26 12:10:36.730925+03
221	2024-07-30	15	0	0	1200	Премиум виладж 	1	f	2024-07-30 19:56:50.893269+03
222	2024-08-01	15	0	0	4000		1	f	2024-08-01 20:16:40.665311+03
223	2024-08-03	15	0	0	1200	Премиум виладж 	1	f	2024-08-03 14:55:02.665409+03
224	2024-08-07	15	0	0	1000	Премиум виладж	1	f	2024-08-07 19:00:19.753062+03
225	2024-08-08	15	0	0	1600	Премиум виладж	1	f	2024-08-08 20:44:50.097455+03
226	2024-08-11	15	0	0	3520	Комиссия 5% за тур на квадриках 	1	f	2024-08-11 09:08:36.094786+03
227	2024-08-12	15	0	0	800	Админ белого пика 	1	f	2024-08-12 12:42:44.393406+03
228	2024-08-14	99	0	0	2000		1	f	2024-08-14 10:13:55.147441+03
229	2024-08-15	15	0	0	2000	Премиум виладж	1	f	2024-08-15 18:47:23.257551+03
230	2024-08-15	15	0	0	15400	Аллюр за июль	1	f	2024-08-15 20:49:07.16422+03
231	2024-08-17	99	0	0	1000		1	f	2024-08-17 18:10:36.11778+03
232	2024-08-19	15	0	0	2000	Ислам  	1	f	2024-08-19 19:51:01.551164+03
233	2024-08-25	7	0	0	1390	Хозтовары	1	f	2024-08-25 13:31:56.433562+03
234	2024-08-28	99	0	0	1000		1	f	2024-08-28 22:24:28.621497+03
235	2024-08-28	15	0	0	800	Камила премиум виладж 	1	f	2024-08-28 22:25:34.347853+03
236	2024-08-28	99	0	0	3000		1	f	2024-08-28 22:42:48.126121+03
237	2024-08-28	99	0	0	500		1	f	2024-08-28 22:46:35.6396+03
238	2024-09-02	99	0	0	1500		1	f	2024-09-02 12:54:04.493531+03
239	2024-09-03	99	0	0	1000		1	f	2024-09-03 20:31:51.298039+03
240	2024-09-16	99	0	0	2000		1	f	2024-09-16 17:59:01.240586+03
241	2024-09-18	99	0	0	1000		1	f	2024-09-18 17:36:15.29101+03
242	2024-09-23	18	0	0	3820	На инструменты. Купил самат	1	f	2024-09-23 14:12:19.011678+03
243	2024-10-05	15	0	0	2000	Гранд сноу вездеходы 	1	f	2024-10-05 21:06:53.3111+03
244	2024-10-09	99	0	0	500		1	f	2024-10-09 07:55:14.559747+03
\.


--
-- Data for Name: flight_techniques; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.flight_techniques (id, flight_id, technique_id, discount, prepayment, price, payment_type_id, source_id, transfer, note, hotel_id, created_at) FROM stdin;
3297	1572	39	0	t	4000	1	1	0		\N	\N
3298	1572	39	0	f	5000	1	1	0		\N	\N
3299	1572	1	0	f	5000	1	1	0		\N	\N
3300	1572	2	0	f	5000	1	1	0		\N	\N
3385	1618	3	0	f	5000	2	2	0		\N	\N
3386	1618	39	0	f	5000	2	2	0		\N	\N
3476	1660	39	1000	t	4000	2	1	0		\N	\N
3604	1710	3	0	t	8000	2	1	0		\N	\N
3605	1710	2	0	f	9000	2	1	0		\N	\N
3606	1710	4	0	f	9000	2	1	0		\N	\N
3607	1710	39	0	t	8000	1	1	0		\N	\N
3608	1710	40	0	f	9000	1	1	0		\N	\N
3609	1711	8	1000	t	3000	2	1	0		\N	\N
3610	1711	9	1000	f	4000	2	1	0		\N	\N
3720	1754	39	1000	t	4000	2	1	0		\N	\N
3721	1754	1	1000	f	5000	1	1	0		\N	\N
3722	1755	1	1000	t	4000	1	1	0		\N	\N
3725	1757	13	0	f	7000	1	2	0		\N	\N
3790	1786	10	1000	f	6000	2	1	0		\N	\N
3791	1786	12	1000	f	6000	2	1	0		\N	\N
3872	1821	10	3000	f	7000	1	4	0		\N	\N
3974	1855	10	1000	t	5000	2	1	0		\N	\N
3975	1855	12	1000	t	5000	1	1	0		\N	\N
3977	1857	48	0	t	5000	1	1	0		\N	\N
3978	1857	39	0	t	5000	1	1	0		\N	\N
3979	1858	39	1000	t	7000	1	1	0	Скидка за отзывы	\N	\N
3980	1858	51	1000	t	7000	1	1	0	Скидка за отзывы	\N	\N
3982	1860	39	0	t	5000	1	1	0		\N	\N
4044	1892	39	0	t	5000	2	1	0		\N	2024-02-17 14:17:04.004902+03
4045	1893	39	0	f	9000	1	2	0		\N	2024-02-17 14:18:40.656822+03
4046	1893	40	0	f	9000	1	2	0		\N	2024-02-17 14:18:40.657528+03
4047	1893	48	0	f	9000	1	2	0		\N	2024-02-17 14:18:40.65813+03
4048	1893	51	0	f	9000	1	2	0		\N	2024-02-17 14:18:40.658732+03
4049	1894	51	2600	f	6400	2	1	0	Все 3 с сайта экскурс	\N	2024-02-17 14:20:05.974772+03
4050	1894	48	2600	f	6400	2	1	0		\N	2024-02-17 14:20:05.975477+03
4051	1894	50	2600	f	6400	2	1	0		\N	2024-02-17 14:20:05.97608+03
4156	1938	39	1000	t	7000	2	1	0		\N	2024-02-23 16:26:34.792773+03
4157	1938	48	1000	t	7000	2	1	0		\N	2024-02-23 16:26:34.794971+03
4158	1938	49	1000	t	7000	1	1	0		\N	2024-02-23 16:26:34.795687+03
4159	1939	39	1000	f	4000	2	2	0		\N	2024-02-23 16:28:11.638861+03
4160	1939	51	1000	f	4000	2	2	0		\N	2024-02-23 16:28:11.639519+03
4161	1940	10	0	t	9000	2	1	0		\N	2024-02-23 16:32:09.812889+03
4162	1940	11	0	t	9000	2	1	0		\N	2024-02-23 16:32:09.813487+03
4163	1940	12	0	t	9000	2	1	0		\N	2024-02-23 16:32:09.814041+03
4164	1940	13	5000	f	5000	2	1	0	С инструктором 	\N	2024-02-23 16:32:09.814584+03
4622	2164	12	1000	f	3000	1	2	0		\N	2024-05-10 11:37:15.550664+03
4623	2165	21	500	f	4500	1	2	0		\N	2024-05-10 12:15:02.811467+03
4171	1944	39	1000	f	4000	1	2	0		\N	2024-02-23 16:36:34.845+03
4172	1944	48	1000	f	4000	1	2	0		\N	2024-02-23 16:36:34.845609+03
4178	1946	48	1000	f	4000	2	2	0	Все 3 с Аллюра	\N	2024-02-23 17:23:45.605874+03
4179	1946	50	1000	f	4000	2	2	0		\N	2024-02-23 17:23:45.606549+03
4180	1946	39	1000	f	4000	2	2	0		\N	2024-02-23 17:23:45.607166+03
4268	1987	49	0	f	7000	1	2	0		\N	2024-02-28 17:45:38.98321+03
4355	2023	9	5000	t	4000	1	1	0	Опять 2 предоплаты на 1 технику, буду делить	\N	2024-03-06 10:10:24.395131+03
4356	2023	9	5000	t	4000	1	1	0		\N	2024-03-06 10:10:24.396917+03
4357	2023	10	0	f	10000	2	1	0		\N	2024-03-06 10:10:24.397657+03
4430	2057	51	0	t	5000	1	1	0		\N	2024-03-14 15:00:30.602123+03
4490	2088	11	1600	f	5400	3	3	0	Из горски ,10٪ комиссия	\N	2024-03-25 17:39:42.276104+03
4491	2088	13	1600	f	5400	3	3	0		\N	2024-03-25 17:39:42.277058+03
4173	1945	53	1000	t	8000	2	1	0		\N	2024-02-23 16:54:26.285478+03
4174	1945	53	1000	t	8000	2	1	0		\N	2024-02-23 16:54:26.286165+03
4175	1945	53	1000	t	8000	2	1	0		\N	2024-02-23 16:54:26.286795+03
4176	1945	53	1000	t	8000	2	1	0		\N	2024-02-23 16:54:26.287452+03
4177	1945	53	1000	t	8000	2	1	0	Тут предоплата 2000 просто добавил к оплате переводом 	\N	2024-02-23 16:54:26.28795+03
4542	2122	13	1000	t	8000	2	1	0	С сайта	\N	2024-04-14 13:54:46.295201+03
4608	2153	26	0	t	7000	4	1	0		\N	2024-05-02 10:14:41.471674+03
4680	2196	11	3000	f	7000	4	6	0		\N	2024-06-02 14:53:31.58598+03
4681	2196	12	3000	f	7000	4	6	0		\N	2024-06-02 14:53:31.589004+03
4740	2233	22	0	f	10000	6	1	0		\N	2024-06-15 10:30:43.77397+03
4741	2233	23	0	f	10000	6	1	0		\N	2024-06-15 10:30:43.775172+03
4742	2233	25	0	f	10000	1	1	0		\N	2024-06-15 10:30:43.775802+03
4743	2233	29	0	f	10000	6	1	0		\N	2024-06-15 10:30:43.776424+03
4744	2233	31	0	f	10000	6	1	0		\N	2024-06-15 10:30:43.777062+03
4745	2234	32	0	f	5000	1	1	0		\N	2024-06-15 10:31:51.473555+03
4746	2234	32	0	f	5000	2	1	0		\N	2024-06-15 10:31:51.47438+03
4815	2267	12	1000	f	5000	1	2	0		\N	2024-06-23 17:57:58.387272+03
4932	2333	12	0	f	10000	6	1	0	Оплатили	\N	2024-07-14 13:12:10.422463+03
4933	2333	10	0	t	9000	6	1	0		\N	2024-07-14 13:12:10.423418+03
4934	2333	31	0	t	7000	6	1	0		\N	2024-07-14 13:12:10.424012+03
4935	2333	22	800	f	7200	6	3	0	От Аллюра. 	\N	2024-07-14 13:12:10.424593+03
5041	2378	26	0	f	3000	1	2	0		\N	2024-07-23 14:57:16.646124+03
5123	2408	12	0	f	12000	2	3	0	От ски резорт	\N	2024-07-29 14:20:30.738679+03
5211	2445	21	1000	f	9000	1	3	0	Откат исламу	\N	2024-08-06 12:13:03.609581+03
5301	2486	20	0	f	10000	6	1	0		\N	2024-08-11 17:43:41.593464+03
5302	2486	22	0	f	10000	6	1	0		\N	2024-08-11 17:43:41.594328+03
5303	2486	23	0	f	10000	6	1	0		\N	2024-08-11 17:43:41.594922+03
5304	2486	25	0	f	10000	6	1	0		\N	2024-08-11 17:43:41.595483+03
5305	2486	27	0	f	10000	6	1	0		\N	2024-08-11 17:43:41.596063+03
5306	2486	28	0	f	10000	6	1	0		\N	2024-08-11 17:43:41.596718+03
5307	2486	31	0	f	10000	6	1	0		\N	2024-08-11 17:43:41.59738+03
5308	2486	32	0	f	10000	6	1	0		\N	2024-08-11 17:43:41.5979+03
5309	2486	18	0	f	10000	6	1	0		\N	2024-08-11 17:43:41.598374+03
5388	2522	13	0	t	5000	6	1	0		\N	2024-08-17 17:52:00.084694+03
5389	2522	22	0	f	5000	1	2	0		\N	2024-08-17 17:52:00.086501+03
3301	1573	39	0	t	4000	2	1	0		\N	\N
3302	1573	40	0	f	5000	2	1	0		\N	\N
3391	1621	12	1000	f	4000	2	1	0		\N	\N
3392	1621	13	3000	f	2000	2	1	0		\N	\N
3477	1661	1	1000	t	4000	2	1	0		\N	\N
3478	1661	39	1000	f	5000	2	1	0		\N	\N
3611	1712	8	1000	f	6000	1	2	0		\N	\N
3723	1756	3	2000	t	2000	2	1	0		\N	\N
3724	1756	39	2000	f	3000	2	1	0		\N	\N
3792	1787	9	0	t	9000	1	1	0		\N	\N
3793	1787	10	1000	f	9000	2	1	0		\N	\N
3873	1822	10	0	t	9000	1	1	0		\N	\N
4624	2166	26	600	f	2400	4	6	0	20% стойке	\N	2024-05-10 12:37:39.229393+03
4052	1895	13	1000	t	5000	1	1	0		\N	2024-02-17 15:21:50.744893+03
4169	1943	50	1400	f	3600	1	2	0		\N	2024-02-23 16:35:45.806338+03
4170	1943	51	1000	t	3000	1	1	0		\N	2024-02-23 16:35:45.807039+03
4627	2168	12	1200	f	10800	6	6	0		\N	2024-05-10 13:05:56.026739+03
4628	2168	13	1200	f	10800	6	6	0		\N	2024-05-10 13:05:56.027521+03
4360	2025	9	0	t	9000	1	1	0		\N	2024-03-06 13:21:23.547319+03
4361	2025	10	0	t	9000	1	1	0		\N	2024-03-06 13:21:23.549488+03
4431	2058	10	500	t	8500	2	1	0		\N	2024-03-14 16:19:22.585997+03
4432	2058	11	500	t	8500	2	1	0		\N	2024-03-14 16:19:22.587183+03
4492	2089	9	0	t	9000	2	1	0		\N	2024-03-26 15:59:02.267197+03
4269	1988	53	0	t	9000	2	1	0		\N	2024-02-29 14:44:03.446104+03
4543	2123	35	0	t	6000	4	1	0		\N	2024-04-17 17:11:44.082856+03
4609	2154	23	0	t	7000	4	1	0		\N	2024-05-02 15:13:56.231102+03
4682	2197	12	3000	f	7000	1	2	0		\N	2024-06-02 16:11:48.941777+03
4684	2199	27	0	t	7000	1	1	0		\N	2024-06-02 16:13:30.724165+03
4747	2235	11	0	t	11000	6	1	0		\N	2024-06-15 10:39:40.44292+03
4748	2235	12	0	t	11000	2	1	0		\N	2024-06-15 10:39:40.443988+03
4749	2235	12	0	t	11000	1	1	0		\N	2024-06-15 10:39:40.444709+03
4816	2268	11	0	t	9000	6	1	0		\N	2024-06-24 10:18:47.92934+03
4817	2268	12	0	t	9000	6	1	0		\N	2024-06-24 10:18:47.930708+03
4855	2295	30	0	t	9000	6	1	0		\N	2024-07-04 14:25:32.644347+03
4856	2295	13	0	t	11000	6	1	0		\N	2024-07-04 14:25:32.649096+03
4857	2296	12	0	t	9000	6	1	0		\N	2024-07-04 14:37:38.666959+03
4858	2296	13	0	f	10000	6	1	0		\N	2024-07-04 14:37:38.667642+03
4936	2334	27	0	t	7000	6	1	0		\N	2024-07-14 16:51:35.958229+03
4937	2334	24	0	t	7000	6	1	0		\N	2024-07-14 16:51:35.959263+03
4938	2334	29	0	t	7000	6	1	0		\N	2024-07-14 16:51:35.959973+03
4939	2334	31	0	f	8000	6	1	0		\N	2024-07-14 16:51:35.960653+03
4940	2335	11	0	t	11000	6	1	0		\N	2024-07-14 16:52:16.219221+03
4941	2336	12	1000	f	9000	3	6	0		\N	2024-07-14 16:53:15.338073+03
4942	2337	25	0	f	5000	1	1	0		\N	2024-07-14 17:05:11.68836+03
5042	2379	11	0	t	11000	1	1	0		\N	2024-07-24 10:32:51.638799+03
5124	2409	27	2500	f	2500	2	4	0	От Артура 	\N	2024-07-29 16:51:32.089392+03
5125	2409	32	2500	f	2500	2	4	0		\N	2024-07-29 16:51:32.090648+03
5126	2409	12	3000	f	3000	2	4	0		\N	2024-07-29 16:51:32.091291+03
5212	2446	18	0	f	8000	2	2	0	На дуккинские смотровые	\N	2024-08-06 16:40:03.720509+03
5213	2447	22	0	f	3000	2	2	0		\N	2024-08-06 17:28:39.287907+03
5310	2487	12	0	t	9000	2	1	0		\N	2024-08-12 12:43:14.501152+03
5311	2487	11	0	f	10000	1	2	0		\N	2024-08-12 12:43:14.502261+03
5390	2522	28	0	t	4000	6	1	0		\N	2024-08-17 17:52:00.087441+03
5391	2523	10	0	f	6000	1	2	0		\N	2024-08-17 17:53:13.2024+03
5497	2561	11	0	t	9000	1	1	0		\N	2024-08-22 14:13:29.100618+03
5498	2561	10	0	f	10000	3	6	0		\N	2024-08-22 14:13:29.101621+03
5499	2561	9	0	f	10000	2	2	0		\N	2024-08-22 14:13:29.102308+03
5500	2561	33	1600	f	6400	2	3	0	От Аллюра 	\N	2024-08-22 14:13:29.102946+03
5563	2597	12	0	f	6000	6	2	0		\N	2024-08-26 10:02:56.159728+03
5564	2598	12	0	f	4000	1	2	0		\N	2024-08-26 10:54:33.828554+03
5620	2625	31	0	f	3000	1	2	0		\N	2024-08-29 13:02:09.124431+03
5667	2652	11	2000	f	8000	6	1	0	Ренат всё 	\N	2024-09-01 14:56:00.159344+03
5668	2652	22	1000	t	6000	6	1	0		\N	2024-09-01 14:56:00.160705+03
5669	2652	23	1000	t	6000	6	1	0		\N	2024-09-01 14:56:00.161559+03
5670	2652	30	1000	t	6000	6	1	0		\N	2024-09-01 14:56:00.162225+03
5671	2652	32	1000	t	6000	6	1	0		\N	2024-09-01 14:56:00.162955+03
5672	2652	20	1000	t	6000	6	1	0		\N	2024-09-01 14:56:00.163713+03
5673	2653	26	0	f	5000	1	2	0		\N	2024-09-01 15:01:42.921801+03
5674	2653	28	0	f	5000	1	2	0		\N	2024-09-01 15:01:42.922573+03
5713	2677	18	0	f	3000	1	2	0	Ренат	\N	2024-09-11 17:22:06.877443+03
5714	2677	20	0	f	3000	1	2	0		\N	2024-09-11 17:22:06.878414+03
5715	2677	32	0	f	3000	6	2	0		\N	2024-09-11 17:22:06.879052+03
5760	2692	22	0	t	9000	6	1	0		\N	2024-09-16 13:48:37.646582+03
5761	2692	19	0	t	9000	1	1	0		\N	2024-09-16 13:48:37.647649+03
5762	2692	20	0	t	9000	1	1	0		\N	2024-09-16 13:48:37.648292+03
5763	2692	21	0	t	9000	1	1	0		\N	2024-09-16 13:48:37.64902+03
5764	2692	11	0	t	11000	1	1	0		\N	2024-09-16 13:48:37.649744+03
5765	2692	13	0	t	11000	1	1	0		\N	2024-09-16 13:48:37.650378+03
5766	2693	9	0	f	6000	6	2	0		\N	2024-09-16 13:49:52.566125+03
5799	2708	30	0	f	5000	1	2	0		\N	2024-09-22 12:31:57.92091+03
5819	2720	18	0	f	5000	1	2	0		\N	2024-09-26 16:15:09.944443+03
5820	2720	33	0	f	5000	1	2	0		\N	2024-09-26 16:15:09.945669+03
5823	2722	22	2000	f	6000	6	1	0	Ахмат ст отправил знакомых	\N	2024-09-27 14:15:09.753628+03
5842	2731	9	0	f	4000	1	2	0		\N	2024-09-28 17:47:02.258376+03
5843	2732	32	1000	f	4000	6	2	0		\N	2024-09-28 17:49:01.665703+03
5844	2732	18	0	f	5000	6	2	0		\N	2024-09-28 17:49:01.66656+03
5866	2743	12	0	t	5000	6	1	0	Ренат	\N	2024-10-02 16:26:35.52001+03
5879	2751	33	0	t	4000	1	1	0		\N	2024-10-06 10:13:40.203719+03
5880	2751	19	0	f	5000	1	1	0		\N	2024-10-06 10:13:40.204636+03
5881	2752	21	0	t	7000	6	1	0		\N	2024-10-06 10:18:20.093751+03
5882	2752	25	0	t	7000	6	1	0		\N	2024-10-06 10:18:20.094496+03
5883	2752	22	0	t	7000	1	1	0		\N	2024-10-06 10:18:20.095153+03
5884	2752	12	0	t	9000	6	1	0		\N	2024-10-06 10:18:20.095839+03
5897	2758	23	0	f	3000	1	2	0		\N	2024-10-06 15:48:33.693077+03
5910	2765	30	1000	t	8000	6	3	0	Белый пик. Ренат все	\N	2024-10-07 17:08:54.190394+03
5911	2765	20	0	f	10000	6	1	0		\N	2024-10-07 17:08:54.191668+03
3303	1574	1	0	t	4000	1	1	0		\N	\N
3304	1574	2	0	f	5000	1	1	0		\N	\N
3393	1622	9	1000	f	4000	2	1	0		\N	\N
3394	1622	13	3000	f	2000	2	1	0		\N	\N
3479	1662	8	1000	f	9000	1	1	0		\N	\N
3480	1662	9	1000	t	8000	1	1	0		\N	\N
3481	1662	10	2000	f	8000	1	4	0		\N	\N
3482	1662	11	0	t	9000	1	1	0		\N	\N
3612	1713	3	0	t	8000	1	1	0		\N	\N
3613	1713	4	0	t	8000	1	1	0		\N	\N
3614	1713	5	0	f	9000	1	1	0		\N	\N
3615	1713	39	0	f	9000	1	1	0		\N	\N
3616	1713	40	0	f	9000	1	1	0		\N	\N
3726	1758	13	1600	f	5400	2	3	0	600 это 10% откат	\N	\N
3794	1788	13	1000	f	6000	1	1	0		\N	\N
3874	1823	13	1000	f	6000	2	2	0		\N	\N
3875	1823	12	1000	f	6000	2	2	0		\N	\N
3876	1823	10	1000	f	6000	2	2	0		\N	\N
3981	1859	51	2000	t	2000	2	1	0		\N	\N
4629	2169	19	0	t	7000	6	1	0		\N	2024-05-10 13:23:54.501489+03
4630	2169	23	0	t	7000	1	1	0		\N	2024-05-10 13:23:54.502727+03
4631	2169	30	3200	t	3800	1	1	0		\N	2024-05-10 13:23:54.503373+03
4632	2169	30	4800	f	3200	1	1	0		\N	2024-05-10 13:23:54.503954+03
4683	2198	20	0	f	5000	1	1	0		\N	2024-06-02 16:12:48.938231+03
4750	2236	18	1600	f	6400	4	6	0		\N	2024-06-15 12:30:21.816068+03
4751	2236	19	1600	f	6400	4	6	0		\N	2024-06-15 12:30:21.818514+03
4053	1896	10	1000	f	6000	1	2	0		\N	2024-02-17 16:11:38.512343+03
4054	1896	9	1000	f	6000	1	2	0		\N	2024-02-17 16:11:38.513446+03
4181	1947	51	1000	f	5000	1	5	0		\N	2024-02-23 17:35:18.133336+03
4182	1947	48	1000	f	5000	1	5	0		\N	2024-02-23 17:35:18.134359+03
4270	1989	9	0	f	10000	2	1	0	Все оплатили по счету	\N	2024-02-29 16:19:42.024071+03
4271	1989	10	0	f	10000	2	1	0		\N	2024-02-29 16:19:42.025408+03
4272	1989	11	0	f	10000	2	1	0		\N	2024-02-29 16:19:42.026279+03
4273	1989	13	0	f	10000	2	1	0		\N	2024-02-29 16:19:42.026881+03
4274	1989	53	2000	f	8000	2	1	0	Это откат за 4 вездехода по 2 к	\N	2024-02-29 16:19:42.027537+03
4362	2026	41	0	t	6000	1	1	0		\N	2024-03-06 14:49:40.475687+03
4433	2059	11	0	t	9000	2	1	0		\N	2024-03-15 12:49:19.787663+03
4434	2059	13	2000	f	8000	2	4	0		\N	2024-03-15 12:49:19.79002+03
4493	2090	11	0	t	9000	2	1	0		\N	2024-03-27 12:06:07.279377+03
4544	2124	35	1000	t	8000	1	1	0		\N	2024-04-20 15:26:57.240698+03
4545	2124	35	1000	t	8000	1	1	0		\N	2024-04-20 15:26:57.242549+03
4546	2124	12	1000	t	8000	1	1	0		\N	2024-04-20 15:26:57.243212+03
4610	2155	17	500	f	2500	1	4	0	Откат 500 отдали. Инструктор Амир	\N	2024-05-03 14:01:34.212511+03
4611	2155	28	500	f	2500	1	4	0		\N	2024-05-03 14:01:34.213605+03
4818	2269	30	0	t	9000	1	1	0		\N	2024-06-24 17:21:18.306031+03
4859	2297	12	0	t	11000	6	1	0		\N	2024-07-05 14:05:11.749638+03
4943	2338	11	0	t	3000	6	1	0		\N	2024-07-15 17:26:24.809698+03
4944	2339	18	800	f	7200	6	3	0	Аллюр	\N	2024-07-15 17:32:13.732625+03
4945	2339	29	0	t	7000	6	1	0		\N	2024-07-15 17:32:13.7335+03
5043	2380	18	0	f	3000	1	2	0		\N	2024-07-24 11:23:32.741166+03
5127	2410	10	0	t	5000	1	1	0		\N	2024-07-29 17:32:29.014459+03
5128	2410	11	0	t	5000	1	1	0		\N	2024-07-29 17:32:29.015421+03
5214	2448	20	0	f	3000	2	2	0	Ренат	\N	2024-08-06 17:48:29.919011+03
5312	2488	23	0	f	5000	1	2	0		\N	2024-08-12 12:44:07.566456+03
5313	2488	18	0	f	5000	1	2	0		\N	2024-08-12 12:44:07.567759+03
5392	2524	11	0	t	5000	1	1	0		\N	2024-08-18 11:38:57.549279+03
5501	2562	23	0	f	3000	1	2	0		\N	2024-08-22 14:14:15.970635+03
5502	2562	20	0	f	3000	1	2	0		\N	2024-08-22 14:14:15.971578+03
5503	2563	12	0	f	4000	1	2	0		\N	2024-08-22 14:14:43.636451+03
5565	2599	10	0	f	4000	1	2	0		\N	2024-08-26 11:26:22.154021+03
5621	2626	13	0	t	9000	6	1	0	Ренат	\N	2024-08-29 14:07:52.391367+03
5675	2654	11	3000	f	3000	6	2	0	Поделил, 3к нал 3к qr	\N	2024-09-01 17:44:21.665683+03
5676	2654	11	3000	f	3000	1	2	0		\N	2024-09-01 17:44:21.666815+03
5716	2678	12	0	t	9000	6	1	0		\N	2024-09-12 10:16:29.05732+03
5717	2678	13	0	t	9000	6	1	0		\N	2024-09-12 10:16:29.058537+03
5718	2678	22	0	t	7000	6	1	0		\N	2024-09-12 10:16:29.059225+03
5719	2678	11	2000	f	8000	3	3	0	От Аллюра 	\N	2024-09-12 10:16:29.059885+03
5767	2694	9	800	f	3200	3	6	0		\N	2024-09-16 13:50:54.564578+03
5768	2695	23	1600	f	6400	3	6	0		\N	2024-09-16 14:17:46.689493+03
5769	2695	19	0	t	7000	1	2	0		\N	2024-09-16 14:17:46.69031+03
5770	2696	30	0	f	8000	1	2	0		\N	2024-09-16 14:19:12.659119+03
5800	2709	22	1600	f	6400	6	1	0	 С сайта 	\N	2024-09-22 13:50:06.997083+03
5806	2711	11	0	t	9000	6	1	0		\N	2024-09-22 14:19:32.36186+03
5807	2711	13	0	f	10000	1	2	0		\N	2024-09-22 14:19:32.362603+03
5808	2712	23	0	f	5000	1	2	0		\N	2024-09-22 14:33:29.610324+03
5821	2721	33	2000	f	8000	6	1	0	С сайта	\N	2024-09-26 17:30:59.886858+03
5824	2723	22	1600	f	6400	3	3	0	Аллюр. Ренат	\N	2024-09-27 15:34:41.842855+03
5845	2733	25	0	f	3000	1	2	0		\N	2024-09-28 17:58:33.039535+03
5846	2733	30	0	t	2000	1	2	0		\N	2024-09-28 17:58:33.040419+03
5847	2733	32	0	f	3000	6	2	0		\N	2024-09-28 17:58:33.040965+03
5848	2733	33	0	f	3000	6	2	0		\N	2024-09-28 17:58:33.041571+03
5867	2744	18	0	f	3000	6	2	0		\N	2024-10-02 16:31:21.732326+03
5868	2744	28	0	f	3000	6	2	0		\N	2024-10-02 16:31:21.733412+03
5869	2744	31	0	f	3000	6	2	0		\N	2024-10-02 16:31:21.73411+03
5870	2744	9	0	f	4000	6	2	0		\N	2024-10-02 16:31:21.734749+03
5885	2753	11	500	f	3500	1	2	0	1 отзыв оставили 	\N	2024-10-06 13:10:45.235736+03
5886	2753	23	0	f	3000	6	2	0		\N	2024-10-06 13:10:45.236866+03
5898	2759	23	0	f	3000	6	2	0		\N	2024-10-06 16:47:13.084904+03
5899	2760	23	0	f	3000	6	2	0		\N	2024-10-06 17:37:50.77829+03
5900	2761	13	0	f	6000	1	2	0		\N	2024-10-06 17:38:40.468402+03
5901	2761	12	0	f	6000	6	2	0		\N	2024-10-06 17:38:40.469046+03
5902	2761	10	0	f	6000	6	2	0		\N	2024-10-06 17:38:40.469662+03
5912	2765	22	0	f	10000	6	2	0		\N	2024-10-07 17:08:54.192499+03
5915	2766	9	0	t	5000	1	1	0		\N	2024-10-07 17:10:05.529042+03
5916	2766	12	0	t	5000	1	1	0		\N	2024-10-07 17:10:05.52976+03
3305	1575	13	0	t	4000	1	1	0		\N	\N
3397	1623	13	1000	t	5000	2	1	0		\N	\N
3395	1623	8	3000	f	3000	2	5	0		\N	\N
3396	1623	9	3000	f	4000	2	5	0		\N	\N
3483	1663	12	2000	f	3000	1	2	0		\N	\N
3484	1663	13	2000	f	3000	1	2	0		\N	\N
3485	1664	1	1000	t	4000	2	1	0		\N	\N
3486	1664	39	1000	f	5000	2	1	0		\N	\N
3617	1714	12	1000	t	5000	1	1	0		\N	\N
4633	2170	12	0	f	10000	1	4	0		\N	2024-05-10 15:37:16.760814+03
3795	1789	4	1000	f	8000	2	1	0		\N	\N
3796	1789	4	8000	f	1000	1	1	0		\N	\N
3797	1789	3	0	t	8000	1	1	0		\N	\N
3798	1789	1	0	t	8000	1	1	0		\N	\N
3799	1789	39	0	t	8000	1	1	0		\N	\N
3800	1789	40	0	t	8000	1	1	0		\N	\N
3801	1789	41	0	t	8000	1	1	0		\N	\N
3877	1824	51	1000	f	4000	2	2	0		\N	\N
3878	1824	50	1000	f	4000	2	2	0		\N	\N
3879	1824	39	1000	f	4000	2	2	0		\N	\N
3881	1825	39	1000	t	4000	2	1	0		\N	\N
4634	2170	13	0	f	10000	1	4	0		\N	2024-05-10 15:37:16.762151+03
3880	1825	48	1000	t	4000	1	1	0		0	\N
3989	1862	39	0	f	9000	1	2	0		\N	\N
4055	1897	10	0	f	10000	2	2	0		\N	2024-02-17 17:31:38.988121+03
4056	1898	11	1000	f	4000	1	2	0		\N	2024-02-17 17:32:58.505261+03
4057	1899	39	1000	f	8000	1	2	0		\N	2024-02-17 17:48:01.0051+03
4183	1948	13	2000	f	8000	4	5	0		\N	2024-02-24 10:42:54.047801+03
4363	2027	13	0	t	9000	1	1	0		\N	2024-03-07 12:48:07.088571+03
4364	2027	9	0	t	9000	1	1	0		\N	2024-03-07 12:48:07.090014+03
4435	2060	49	0	t	6000	1	1	0		\N	2024-03-15 12:50:04.500759+03
4436	2060	39	0	t	6000	1	1	0		\N	2024-03-15 12:50:04.502276+03
4494	2091	9	1000	t	5000	2	1	0		\N	2024-03-27 15:17:58.182726+03
4495	2091	10	4000	f	3000	2	1	0	Поехали с инструктором 	\N	2024-03-27 15:17:58.183787+03
4275	1990	53	1000	f	6000	1	2	0		\N	2024-02-29 16:21:09.879456+03
4276	1990	53	1000	f	6000	1	2	0		\N	2024-02-29 16:21:09.880577+03
4277	1990	53	1000	f	6000	1	2	0		\N	2024-02-29 16:21:09.881494+03
4547	2125	10	0	t	9000	2	1	0	Оплатили 12 поэтому разделил на 2 вездехода	\N	2024-04-20 15:34:22.31533+03
4548	2125	10	8000	f	2000	2	1	0		\N	2024-04-20 15:34:22.317063+03
4612	2156	23	0	f	5000	1	2	0		\N	2024-05-03 15:20:45.603336+03
4685	2200	17	1500	f	3500	4	6	0	Скидка - курорту	\N	2024-06-03 16:02:34.464618+03
4686	2200	19	1500	f	3500	4	6	0	Скидка- курорту	\N	2024-06-03 16:02:34.468509+03
4687	2201	24	2400	f	5600	4	6	0	Скидка - курорту	\N	2024-06-03 16:05:01.803067+03
4688	2201	27	2400	f	5600	4	6	0	Скидка - курорту	\N	2024-06-03 16:05:01.81695+03
4752	2237	11	0	f	12000	6	1	0		\N	2024-06-15 14:45:08.653454+03
4753	2237	12	0	f	12000	6	1	0		\N	2024-06-15 14:45:08.654529+03
4754	2237	13	0	f	12000	6	1	0		\N	2024-06-15 14:45:08.655271+03
4819	2270	24	0	f	8000	6	1	0		\N	2024-06-25 11:08:21.215803+03
4820	2270	31	0	f	8000	6	1	0		\N	2024-06-25 11:08:21.217337+03
4860	2298	12	0	f	4000	1	2	0		\N	2024-07-05 16:04:07.943859+03
4861	2299	12	0	t	9000	1	1	0		\N	2024-07-05 16:50:11.544727+03
4862	2299	13	0	t	9000	1	2	0		\N	2024-07-05 16:50:11.545535+03
4946	2340	30	0	t	9000	6	1	0		\N	2024-07-16 09:54:48.122445+03
5044	2381	9	0	t	9000	2	1	0		\N	2024-07-24 13:34:38.912226+03
5045	2381	26	0	t	7000	2	1	0		\N	2024-07-24 13:34:38.913266+03
5129	2411	13	2000	f	8000	3	6	0		\N	2024-07-29 17:56:08.688668+03
5130	2411	9	5000	f	5000	1	4	0		\N	2024-07-29 17:56:08.689976+03
5131	2411	23	1600	f	6400	3	6	0		\N	2024-07-29 17:56:08.690683+03
5132	2411	18	4000	f	4000	1	4	0		\N	2024-07-29 17:56:08.691398+03
5215	2449	22	0	t	7000	1	1	0	Ренат	\N	2024-08-08 10:27:48.897026+03
5216	2449	23	0	t	7000	6	1	0		\N	2024-08-08 10:27:48.898025+03
5217	2449	20	800	f	7200	1	3	0	Откат исламу 	\N	2024-08-08 10:27:48.898748+03
5218	2449	31	0	f	8000	6	3	0	От премиум вилладж 	\N	2024-08-08 10:27:48.899399+03
5314	2489	10	0	t	11000	2	1	0		\N	2024-08-12 15:53:13.107914+03
5318	2491	27	2000	f	6000	2	4	0	От че горы оба	\N	2024-08-12 16:05:50.795549+03
5319	2491	28	2000	f	6000	2	4	0		\N	2024-08-12 16:05:50.796264+03
5320	2491	20	0	t	7000	2	1	0		\N	2024-08-12 16:05:50.796953+03
5321	2491	12	0	t	9000	2	1	0		\N	2024-08-12 16:05:50.797622+03
5393	2525	28	1000	f	2000	1	2	0	За отзывы	\N	2024-08-18 11:39:56.058477+03
5504	2564	30	0	f	3000	1	2	0		\N	2024-08-22 16:46:18.056265+03
5505	2565	11	0	f	4000	1	2	0	Ренат	\N	2024-08-22 17:00:19.484569+03
5566	2600	12	1000	f	9000	1	4	0	Ренат	\N	2024-08-26 15:19:57.915238+03
5567	2600	10	1000	f	9000	1	4	0		\N	2024-08-26 15:19:57.916373+03
5568	2601	22	0	f	8000	6	2	0		\N	2024-08-26 15:23:29.996922+03
5569	2601	23	0	f	8000	6	2	0		\N	2024-08-26 15:23:29.997586+03
5570	2601	20	0	f	8000	6	2	0		\N	2024-08-26 15:23:29.998145+03
5571	2601	30	0	f	8000	6	2	0		\N	2024-08-26 15:23:29.998726+03
5572	2601	31	0	f	8000	1	2	0		\N	2024-08-26 15:23:29.999311+03
5573	2601	13	0	f	10000	1	2	0		\N	2024-08-26 15:23:29.999804+03
5622	2627	20	0	t	7000	1	1	0		\N	2024-08-30 10:16:00.857954+03
5623	2627	33	1600	f	6400	3	6	0		\N	2024-08-30 10:16:00.858918+03
5677	2655	20	0	t	9000	6	1	0		\N	2024-09-02 10:17:44.659529+03
5678	2655	23	0	t	9000	1	1	0		\N	2024-09-02 10:17:44.660632+03
5720	2679	20	0	f	3000	6	2	0		\N	2024-09-12 13:09:18.944201+03
5721	2679	21	0	f	3000	6	2	0		\N	2024-09-12 13:09:18.945444+03
5771	2697	20	1000	f	4000	3	3	0	Аллюр 	\N	2024-09-16 16:51:35.340724+03
5772	2697	25	0	f	5000	1	2	0		\N	2024-09-16 16:51:35.342113+03
5773	2697	30	0	f	5000	1	2	0		\N	2024-09-16 16:51:35.342894+03
5774	2698	21	0	f	8000	6	2	0		\N	2024-09-16 17:34:08.732014+03
5801	2710	33	0	f	10000	6	1	0		\N	2024-09-22 14:18:36.305327+03
5802	2710	28	3600	f	6400	3	6	0		\N	2024-09-22 14:18:36.306565+03
5803	2710	31	0	t	9000	6	1	0		\N	2024-09-22 14:18:36.307132+03
5804	2710	11	0	t	11000	6	1	0		\N	2024-09-22 14:18:36.307732+03
5805	2710	13	0	t	11000	6	1	0		\N	2024-09-22 14:18:36.308295+03
3306	1576	8	1000	f	4000	1	1	0		\N	\N
3398	1624	9	0	t	8000	2	1	0		\N	\N
3487	1665	12	0	f	10000	1	2	0		\N	\N
3488	1665	13	0	f	10000	1	2	0		\N	\N
3491	1667	2	1000	t	4000	1	1	0		\N	\N
3492	1667	39	1000	f	5000	1	1	0		\N	\N
3618	1715	8	0	t	9000	2	1	0		\N	\N
3619	1715	12	3000	f	7000	1	4	0	Откат 1к от 8к	\N	\N
3620	1716	8	1000	t	5000	2	1	0		\N	\N
3621	1716	12	1000	f	6000	2	1	0		\N	\N
3622	1716	13	1000	f	6000	2	1	0		\N	\N
3728	1760	39	2000	t	2000	2	1	0		\N	\N
3802	1790	3	0	t	5000	1	1	0		\N	\N
3883	1826	39	0	t	8000	2	1	0		\N	\N
3884	1826	40	0	t	8000	2	1	0		\N	\N
3885	1826	49	0	t	8000	2	1	0		\N	\N
4635	2171	17	0	f	8000	1	2	0		\N	2024-05-10 16:44:58.057458+03
3990	1863	12	1000	t	5000	1	1	0		\N	\N
3882	1826	48	0	f	9000	1	1	0		0	\N
4058	1900	35	4900	f	100	4	3	0		\N	2024-02-18 09:43:26.364687+03
4059	1900	35	4900	f	100	5	3	0		\N	2024-02-18 09:43:26.368682+03
4060	1901	35	0	f	4000	5	1	0		\N	2024-02-18 09:43:53.233431+03
4184	1949	48	0	f	6000	2	2	0		\N	2024-02-24 11:48:48.984812+03
4185	1949	39	0	f	6000	2	2	0		\N	2024-02-24 11:48:48.986025+03
4365	2028	49	0	t	6000	1	1	0		\N	2024-03-07 13:59:20.684446+03
4366	2028	50	0	t	6000	1	1	0		\N	2024-03-07 13:59:20.685617+03
4437	2061	9	0	t	9000	2	1	0		\N	2024-03-15 13:19:43.368743+03
4438	2061	10	0	t	9000	1	1	0		\N	2024-03-15 13:19:43.370406+03
4439	2061	11	0	f	10000	1	1	0		\N	2024-03-15 13:19:43.371058+03
4440	2061	13	0	t	9000	2	1	0		\N	2024-03-15 13:19:43.371678+03
4496	2092	53	1000	t	3000	1	1	0		\N	2024-03-27 15:52:41.926359+03
4497	2093	51	1000	t	3000	2	1	0		\N	2024-03-27 16:01:53.737959+03
4278	1991	53	2000	t	7000	2	1	0		\N	2024-03-01 12:29:42.477842+03
4279	1991	53	2000	t	7000	2	1	0		\N	2024-03-01 12:29:42.478985+03
4549	2126	35	2000	t	7000	1	1	0		\N	2024-04-21 16:19:13.850931+03
4613	2157	30	0	f	8000	4	5	0	Инструктор Амир 	\N	2024-05-04 14:31:11.74852+03
4636	2171	29	0	f	8000	1	2	0		\N	2024-05-10 16:44:58.060587+03
4637	2171	24	0	f	8000	1	2	0		\N	2024-05-10 16:44:58.061869+03
4638	2171	20	1600	f	6400	4	6	0		\N	2024-05-10 16:44:58.062562+03
4639	2171	22	1600	f	6400	4	6	0		\N	2024-05-10 16:44:58.065322+03
4640	2171	10	4000	f	6000	6	2	0		\N	2024-05-10 16:44:58.068168+03
4689	2202	30	1600	f	6400	3	6	0	Скидка-курорту	\N	2024-06-04 17:23:46.516701+03
4690	2203	24	2700	f	7300	2	3	0	От мун 2 все 3	\N	2024-06-04 17:31:44.40862+03
4691	2203	26	2700	f	7300	2	3	0		\N	2024-06-04 17:31:44.412116+03
4692	2203	22	2700	f	7300	2	1	0		\N	2024-06-04 17:31:44.415659+03
4693	2204	27	600	f	2400	3	6	0	Скидка-курорту	\N	2024-06-04 17:35:06.572064+03
4760	2239	18	0	f	10000	1	1	0		\N	2024-06-15 14:47:56.091794+03
4761	2239	19	0	f	10000	2	1	0		\N	2024-06-15 14:47:56.092742+03
4762	2239	20	0	f	10000	6	1	0		\N	2024-06-15 14:47:56.093471+03
4763	2239	22	0	f	10000	6	1	0		\N	2024-06-15 14:47:56.094133+03
4764	2239	25	0	f	10000	6	1	0		\N	2024-06-15 14:47:56.094979+03
4821	2271	12	0	f	4000	6	2	0		\N	2024-06-25 15:21:13.842334+03
4863	2300	31	0	f	3000	6	2	0		\N	2024-07-06 11:56:07.794817+03
4947	2341	11	0	t	9000	1	1	0		\N	2024-07-16 09:55:09.098974+03
5046	2382	11	0	f	12000	2	2	0	700 из них наличка 	\N	2024-07-24 14:26:28.311394+03
5047	2382	13	2000	f	10000	2	1	0		\N	2024-07-24 14:26:28.312314+03
5133	2412	10	0	t	11000	2	1	0		\N	2024-07-31 10:18:11.34987+03
5134	2412	11	0	t	11000	2	1	0		\N	2024-07-31 10:18:11.351234+03
5135	2412	12	0	t	11000	1	1	0		\N	2024-07-31 10:18:11.351968+03
5219	2450	22	1000	f	4000	3	2	0		\N	2024-08-08 12:51:40.785179+03
5220	2450	27	1000	f	4000	3	2	0		\N	2024-08-08 12:51:40.786614+03
5221	2451	21	0	f	3000	2	2	0		\N	2024-08-08 12:58:18.198126+03
5222	2451	23	0	f	3000	2	2	0		\N	2024-08-08 12:58:18.198835+03
5223	2451	27	0	f	3000	2	2	0		\N	2024-08-08 12:58:18.199427+03
5315	2490	18	0	f	5000	1	2	0		\N	2024-08-12 15:55:35.803479+03
5316	2490	22	0	f	5000	1	2	0		\N	2024-08-12 15:55:35.804622+03
5317	2490	28	0	f	5000	2	2	0		\N	2024-08-12 15:55:35.805374+03
5322	2492	18	0	f	5000	1	2	0		\N	2024-08-12 16:08:59.717777+03
5323	2492	25	0	f	5000	1	2	0		\N	2024-08-12 16:08:59.71842+03
5324	2492	11	1000	f	5000	2	2	0	С инструктором 	\N	2024-08-12 16:08:59.718931+03
5394	2526	30	0	t	9000	6	1	0		\N	2024-08-18 11:49:19.524095+03
5395	2526	32	0	t	9000	6	1	0		\N	2024-08-18 11:49:19.525426+03
5396	2526	20	0	t	9000	6	1	0		\N	2024-08-18 11:49:19.526184+03
5397	2526	23	1000	f	9000	1	3	0	От ислама премиум вилладж	\N	2024-08-18 11:49:19.526975+03
5398	2526	33	1000	f	9000	1	3	0		\N	2024-08-18 11:49:19.527696+03
5399	2527	9	0	t	9000	6	1	0	Ренат	\N	2024-08-18 11:52:52.048065+03
5400	2527	13	2000	f	8000	3	6	0		\N	2024-08-18 11:52:52.048662+03
5401	2527	31	0	t	7000	6	1	0		\N	2024-08-18 11:52:52.049154+03
5402	2527	26	0	f	8000	6	1	0		\N	2024-08-18 11:52:52.049617+03
5403	2528	32	0	f	3000	6	2	0		\N	2024-08-18 12:19:55.100119+03
5506	2566	13	0	t	9000	1	1	0		\N	2024-08-22 17:12:48.055207+03
5507	2566	20	0	t	7000	2	1	0		\N	2024-08-22 17:12:48.05605+03
5508	2566	11	0	t	9000	1	1	0		\N	2024-08-22 17:12:48.05665+03
5509	2566	12	4000	t	5000	1	1	0	Поделил потому что половина нал	\N	2024-08-22 17:12:48.057279+03
5510	2566	12	6000	f	4000	2	1	0		\N	2024-08-22 17:12:48.057889+03
5574	2602	11	0	f	4000	6	2	0		\N	2024-08-26 16:48:39.683469+03
5575	2603	11	0	t	5000	1	1	0		\N	2024-08-26 16:49:16.070645+03
5624	2628	11	0	f	6000	1	2	0		\N	2024-08-30 10:46:06.665534+03
5625	2629	22	0	f	8000	6	2	0	Дуккинские 	\N	2024-08-30 10:47:39.289863+03
5626	2629	23	0	f	8000	6	2	0		\N	2024-08-30 10:47:39.290636+03
5679	2656	30	0	t	4000	1	1	0	Ренат	\N	2024-09-02 12:05:19.841803+03
5680	2657	9	0	t	5000	1	2	0	Ренат 	\N	2024-09-02 12:06:17.164804+03
5681	2657	10	0	f	6000	1	2	0	Ренат 	\N	2024-09-02 12:06:17.166988+03
5722	2680	11	0	t	9000	6	1	0		\N	2024-09-12 14:23:12.813153+03
3307	1577	1	1000	t	2000	1	1	0		\N	\N
3308	1577	39	1000	f	3000	1	1	0		\N	\N
3309	1578	1	0	t	4000	1	1	0		\N	\N
3310	1578	39	0	f	5000	2	2	0		\N	\N
3311	1578	40	0	f	5000	2	2	0		\N	\N
3312	1578	4	0	f	5000	2	2	0		\N	\N
3314	1580	39	0	t	4000	1	1	0		\N	\N
3315	1580	1	0	f	5000	1	1	0		\N	\N
3318	1582	35	1000	t	5000	2	1	0		\N	\N
3319	1582	9	2000	f	7000	2	1	0		\N	\N
3320	1582	8	2000	f	7000	2	1	0		\N	\N
3399	1625	1	0	f	4000	2	2	0		\N	\N
3400	1625	39	0	f	4000	2	2	0		\N	\N
3405	1627	4	1000	f	3000	1	2	0		\N	\N
3406	1627	39	1000	f	3000	1	2	0		\N	\N
3407	1627	40	1000	f	3000	1	2	0		\N	\N
3490	1666	8	1000	f	6000	2	1	0		\N	\N
3493	1668	4	2000	f	3000	1	2	0		\N	\N
3494	1668	39	2000	f	3000	1	2	0		\N	\N
3495	1669	4	2000	f	3000	1	2	0		\N	\N
3496	1669	39	2000	f	3000	1	2	0		\N	\N
3623	1717	13	0	t	9000	2	1	0		\N	\N
3729	1761	1	2000	t	2000	1	1	0		\N	\N
3730	1761	3	2000	f	3000	1	1	0		\N	\N
3803	1791	39	1000	f	5000	1	2	0		\N	\N
3804	1791	1	1000	f	5000	1	2	0		\N	\N
3805	1792	3	0	t	8000	2	1	0		\N	\N
3806	1792	39	0	f	9000	2	1	0		\N	\N
3807	1792	40	0	f	9000	2	1	0		\N	\N
4641	2172	32	2000	f	8000	6	2	0	Все 3 постоянные клиенты	\N	2024-05-10 16:48:47.022304+03
4642	2172	21	2000	f	8000	6	2	0		\N	2024-05-10 16:48:47.023516+03
4643	2172	26	1000	f	9000	6	2	0		\N	2024-05-10 16:48:47.024024+03
4694	2205	12	0	t	11000	6	1	0		\N	2024-06-05 10:23:22.717945+03
4695	2206	11	0	f	12000	6	1	0		\N	2024-06-05 10:38:59.160229+03
4765	2240	11	0	f	6000	1	1	0		\N	2024-06-16 15:19:50.542132+03
4766	2241	13	1000	t	8000	1	3	0	От ски резорт	\N	2024-06-16 15:22:46.667063+03
3991	1864	10	1000	t	3000	2	1	0		\N	\N
3992	1864	11	1000	f	4000	2	1	0		\N	\N
3993	1865	10	1000	t	5000	2	1	0		\N	\N
3994	1866	12	1000	t	5000	1	1	0		\N	\N
4061	1902	9	3000	t	3000	1	1	0		\N	2024-02-18 11:04:47.718543+03
4062	1902	10	0	t	6000	2	1	0		\N	2024-02-18 11:04:47.719749+03
4063	1902	11	0	t	6000	2	1	0		\N	2024-02-18 11:04:47.720366+03
4064	1903	48	0	t	8000	2	1	0		\N	2024-02-18 11:09:01.076163+03
4065	1903	39	0	t	8000	2	1	0		\N	2024-02-18 11:09:01.076984+03
4822	2272	26	0	f	5000	6	1	0	Оплатили предоплату, не доехали до белых	\N	2024-06-25 16:51:44.760459+03
4864	2301	12	1900	f	8100	1	3	0	Премиум вилладж. Комиссия 900 исламу	\N	2024-07-06 11:58:38.23158+03
4865	2302	28	0	f	3000	1	2	0		\N	2024-07-06 12:03:56.947205+03
4948	2342	30	0	f	3000	1	2	0		\N	2024-07-16 12:59:29.922181+03
5048	2383	18	3000	t	6000	1	1	0		\N	2024-07-24 14:38:21.99626+03
5049	2383	28	3000	t	6000	1	1	0		\N	2024-07-24 14:38:21.997082+03
4192	1951	9	1000	t	5000	2	1	0		\N	2024-02-24 12:42:27.879769+03
4193	1951	10	1000	t	5000	2	1	0		\N	2024-02-24 12:42:27.880302+03
4194	1951	11	1000	t	5000	2	1	0		\N	2024-02-24 12:42:27.880792+03
4195	1951	12	1000	t	5000	2	1	0		\N	2024-02-24 12:42:27.881292+03
4280	1992	13	1000	t	3000	2	1	0		\N	2024-03-01 13:14:35.487761+03
4281	1992	9	3000	f	2000	2	1	0	С инструктором поехали	\N	2024-03-01 13:14:35.488775+03
4282	1993	13	0	t	9000	2	1	0		\N	2024-03-01 13:33:13.162732+03
4283	1993	9	0	t	9000	2	1	0		\N	2024-03-01 13:33:13.163586+03
4367	2029	11	0	t	9000	1	1	0		\N	2024-03-07 15:51:09.394528+03
5050	2383	32	3000	t	6000	1	1	0		\N	2024-07-24 14:38:21.997531+03
5051	2383	32	0	f	10000	1	1	0		\N	2024-07-24 14:38:21.997983+03
4443	2063	9	1000	t	5000	2	1	0		\N	2024-03-16 11:55:07.22967+03
4444	2063	13	1000	t	5000	2	1	0		\N	2024-03-16 11:55:07.233602+03
4445	2064	11	0	t	9000	2	3	0	От ски резорт	\N	2024-03-16 12:36:43.413539+03
4498	2094	11	1000	t	5000	2	1	0		\N	2024-03-28 17:20:10.015156+03
5136	2413	9	0	f	6000	2	1	0		\N	2024-07-31 13:30:48.623699+03
5137	2413	13	0	f	6000	2	1	0		\N	2024-07-31 13:30:48.624892+03
4501	2096	11	3000	t	1000	1	1	0	2 предоплаты на 1 технику, приходится делить	\N	2024-03-28 17:25:03.752775+03
4502	2096	11	3000	t	1000	1	1	0		\N	2024-03-28 17:25:03.756159+03
4503	2097	12	0	t	9000	2	1	0		\N	2024-03-28 17:41:06.168854+03
3489	1666	9	1000	f	5000	2	1	0		\N	\N
4196	1951	53	2000	f	3000	2	2	0	Эти 2 квадрика как 1, потому что стоит 5 к тут а мы берём по 6	\N	2024-02-24 12:42:27.881834+03
4197	1951	53	2000	f	3000	2	2	0		\N	2024-02-24 12:42:27.882359+03
4550	2127	12	1000	t	8000	4	1	0		\N	2024-04-21 17:15:06.479001+03
4614	2158	13	0	t	9000	6	1	0		\N	2024-05-06 15:00:02.22788+03
5138	2414	23	1600	f	6400	3	6	0		\N	2024-07-31 14:07:09.315129+03
5139	2414	11	2000	f	8000	3	6	0		\N	2024-07-31 14:07:09.315814+03
5140	2414	12	2000	f	8000	3	6	0		\N	2024-07-31 14:07:09.316346+03
5141	2414	10	0	f	10000	2	1	0		\N	2024-07-31 14:07:09.317052+03
5142	2414	13	0	f	10000	2	1	0		\N	2024-07-31 14:07:09.317781+03
5224	2452	11	0	f	6000	3	2	0		\N	2024-08-08 14:07:17.823238+03
5225	2453	27	0	t	9000	1	1	0		\N	2024-08-08 14:12:48.200826+03
5226	2453	22	0	t	9000	2	1	0		\N	2024-08-08 14:12:48.201668+03
5325	2493	10	0	t	9000	2	1	0	Ренат	\N	2024-08-15 10:23:37.856917+03
5326	2493	13	0	t	9000	6	1	0		\N	2024-08-15 10:23:37.85856+03
5327	2494	20	0	t	9000	6	1	0		\N	2024-08-15 10:32:57.942578+03
5328	2494	23	0	t	9000	6	1	0		\N	2024-08-15 10:32:57.945489+03
5404	2529	32	0	f	3000	1	2	0		\N	2024-08-18 13:50:54.606374+03
5405	2530	9	0	f	10000	1	2	0		\N	2024-08-18 14:14:53.082766+03
5406	2530	13	0	f	10000	1	2	0		\N	2024-08-18 14:14:53.083335+03
5407	2530	11	2000	f	8000	3	6	0		\N	2024-08-18 14:14:53.083856+03
5511	2567	22	1600	f	6400	3	6	0		\N	2024-08-23 10:31:29.304095+03
5576	2604	10	0	f	6000	1	2	0	Ренат	\N	2024-08-27 11:23:55.965334+03
5577	2604	11	0	f	6000	1	2	0		\N	2024-08-27 11:23:55.969252+03
5627	2630	13	0	t	5000	1	1	0		\N	2024-08-30 11:39:25.473568+03
3313	1579	39	1000	t	2000	1	1	0		\N	\N
3316	1581	12	0	t	8000	1	1	0		\N	\N
3317	1581	13	0	f	9000	1	1	0		\N	\N
3321	1583	9	1000	t	3000	1	1	0		\N	\N
3322	1583	10	1000	f	4000	1	1	0		\N	\N
3402	1626	2	1000	f	3000	2	1	0		\N	\N
3403	1626	39	1000	f	3000	2	1	0		\N	\N
3404	1626	40	1000	f	3000	2	1	0		\N	\N
3498	1670	9	1500	f	3500	1	2	0		\N	\N
3499	1671	4	2000	t	2000	1	1	0		\N	\N
3624	1718	39	0	t	8000	1	1	0		\N	\N
3625	1718	3	0	t	8000	1	1	0		\N	\N
3626	1718	4	0	f	9000	1	1	0		\N	\N
3627	1718	40	0	f	9000	1	1	0		\N	\N
3731	1762	13	1000	f	4000	1	2	0		\N	\N
3808	1793	3	2000	t	2000	1	3	0		\N	\N
3809	1793	39	2000	f	3000	1	3	0		\N	\N
3892	1828	12	4000	t	5000	2	1	0		\N	\N
3893	1828	13	4000	t	5000	2	1	0		\N	\N
3995	1867	12	0	t	9000	1	1	0		\N	\N
4066	1904	11	1000	f	6000	2	2	0		\N	2024-02-18 11:28:03.138231+03
4198	1952	9	1000	f	4000	1	2	0		\N	2024-02-24 13:19:11.683788+03
4199	1953	10	1000	f	8000	2	3	1000	От Аллюра, скинуть 1к откат	\N	2024-02-24 13:26:06.6258+03
4200	1953	11	1000	t	8000	1	1	0		\N	2024-02-24 13:26:06.626493+03
4201	1953	13	1000	t	8000	2	1	0		\N	2024-02-24 13:26:06.627059+03
4284	1994	40	0	f	7000	2	2	0		\N	2024-03-01 17:51:27.559191+03
4285	1994	48	0	f	7000	2	2	0		\N	2024-03-01 17:51:27.560213+03
4286	1995	42	0	f	7000	1	1	0		\N	2024-03-01 17:52:07.383857+03
4287	1995	49	0	f	7000	1	1	0		\N	2024-03-01 17:52:07.38464+03
4368	2030	10	0	t	9000	2	1	0		\N	2024-03-08 11:32:42.284981+03
4369	2031	13	1000	t	5000	2	1	0		\N	2024-03-08 11:33:56.231718+03
4446	2065	41	0	t	4000	1	1	0		\N	2024-03-16 16:33:52.24278+03
2719	1344	3	1000	f	5000	1	2	0		\N	\N
2783	1366	8	0	t	4000	1	1	0		\N	\N
2874	1396	8	0	f	5000	1	2	0		\N	\N
3149	1503	39	0	t	5000	1	1	0		\N	\N
3190	1521	1	0	t	5000	1	1	0		\N	\N
3401	1626	1	1000	t	3000	2	1	0		\N	\N
3497	1670	8	1500	f	3500	1	2	0		\N	\N
3894	1828	53	1000	f	6000	2	4	0		\N	\N
3895	1828	53	1000	f	6000	2	4	0		\N	\N
4370	2032	53	0	f	6000	1	4	0		\N	2024-03-08 11:34:19.876381+03
4551	2128	12	0	t	9000	4	1	0		\N	2024-04-22 14:49:08.694363+03
4552	2128	12	8000	f	2000	4	1	0	Цена 12к, поэтому разделил на 2	\N	2024-04-22 14:49:08.695597+03
4615	2159	26	0	t	7000	6	1	0		\N	2024-05-06 15:00:37.018054+03
4644	2173	13	2000	f	8000	4	6	0		\N	2024-05-11 10:22:42.486864+03
4696	2207	22	1600	f	6400	3	6	0	Скидка-курорту	\N	2024-06-05 15:26:45.43216+03
4767	2242	21	0	t	7000	2	1	0		\N	2024-06-17 15:46:18.358213+03
4768	2242	26	800	f	7200	2	4	0	от Маши	\N	2024-06-17 15:46:18.359845+03
4823	2273	20	0	f	3000	1	2	0		\N	2024-06-25 17:27:19.892631+03
4866	2303	28	1600	f	6400	3	6	0		\N	2024-07-07 14:03:28.510558+03
4867	2303	25	1600	f	6400	3	6	0		\N	2024-07-07 14:03:28.511544+03
4868	2303	12	0	f	10000	6	1	0		\N	2024-07-07 14:03:28.512256+03
4869	2303	13	0	f	10000	6	2	0		\N	2024-07-07 14:03:28.512906+03
4949	2343	11	0	f	4000	1	2	0		\N	2024-07-16 13:01:35.660368+03
5052	2384	18	1600	f	6400	3	6	0		\N	2024-07-25 10:21:04.45917+03
5053	2384	20	1600	f	6400	3	6	0		\N	2024-07-25 10:21:04.460541+03
5054	2384	23	1600	f	6400	3	6	0		\N	2024-07-25 10:21:04.461269+03
5055	2384	25	0	f	8000	2	1	0		\N	2024-07-25 10:21:04.46198+03
5056	2384	26	0	f	8000	2	1	0		\N	2024-07-25 10:21:04.462724+03
5057	2384	28	0	f	8000	2	1	0		\N	2024-07-25 10:21:04.463441+03
5058	2384	32	0	f	8000	2	1	0		\N	2024-07-25 10:21:04.464148+03
5143	2415	31	0	f	3000	2	2	0		\N	2024-07-31 17:33:44.946751+03
5148	2417	23	0	f	3000	1	2	0		\N	2024-07-31 17:59:13.880627+03
5149	2417	32	0	f	3000	1	2	0		\N	2024-07-31 17:59:13.881368+03
5150	2417	31	0	f	3000	2	2	0		\N	2024-07-31 17:59:13.882007+03
5151	2417	25	0	f	3000	2	2	0		\N	2024-07-31 17:59:13.88259+03
5152	2418	13	0	t	5000	1	1	0		\N	2024-07-31 17:59:33.674964+03
5227	2454	10	0	t	9000	1	1	0		\N	2024-08-08 14:20:18.366721+03
5228	2454	11	0	t	9000	1	1	0		\N	2024-08-08 14:20:18.367701+03
5229	2454	13	0	t	9000	2	1	0		\N	2024-08-08 14:20:18.368276+03
5230	2454	23	0	t	7000	1	1	0		\N	2024-08-08 14:20:18.368828+03
5329	2495	26	0	f	3000	2	2	0		\N	2024-08-15 13:19:57.230788+03
5330	2495	22	0	f	3000	2	2	0		\N	2024-08-15 13:19:57.232126+03
5331	2495	25	0	f	3000	2	2	0		\N	2024-08-15 13:19:57.232918+03
5408	2531	26	0	t	4000	6	1	0		\N	2024-08-18 14:22:54.41857+03
5409	2531	31	0	f	5000	2	2	0		\N	2024-08-18 14:22:54.419808+03
5410	2531	18	0	f	5000	2	2	0		\N	2024-08-18 14:22:54.420488+03
5411	2531	25	0	f	5000	2	2	0		\N	2024-08-18 14:22:54.421137+03
5412	2532	22	0	f	8000	2	2	0		\N	2024-08-18 14:43:03.112923+03
5413	2532	23	0	f	8000	2	2	0		\N	2024-08-18 14:43:03.113528+03
5414	2532	20	0	f	8000	2	2	0		\N	2024-08-18 14:43:03.114046+03
5512	2568	13	0	f	6000	1	2	0		\N	2024-08-23 11:15:37.00117+03
5513	2569	11	0	f	4000	1	2	0		\N	2024-08-23 12:04:26.249077+03
5578	2605	11	0	f	6000	1	2	0		\N	2024-08-27 12:54:28.369506+03
5579	2606	22	0	f	3000	1	2	0		\N	2024-08-27 12:55:27.205118+03
5580	2606	23	0	f	3000	1	2	0		\N	2024-08-27 12:55:27.205802+03
5628	2630	10	0	f	6000	1	2	0		\N	2024-08-30 11:39:25.475012+03
5629	2631	31	0	f	3000	1	2	0		\N	2024-08-30 12:24:42.527996+03
5682	2658	23	0	f	3000	6	2	0		\N	2024-09-03 14:49:39.51765+03
5683	2658	31	0	f	3000	6	2	0		\N	2024-09-03 14:49:39.518642+03
5723	2680	13	0	t	9000	6	1	0		\N	2024-09-12 14:23:12.814164+03
5724	2680	12	0	t	9000	1	1	0		\N	2024-09-12 14:23:12.814852+03
5725	2680	20	0	t	7000	6	1	0		\N	2024-09-12 14:23:12.815454+03
5726	2680	21	0	t	7000	6	1	0		\N	2024-09-12 14:23:12.816179+03
5727	2680	30	0	t	7000	6	1	0		\N	2024-09-12 14:23:12.816726+03
5775	2699	19	0	t	7000	6	1	0		\N	2024-09-17 10:35:05.396439+03
5776	2699	18	0	f	8000	6	1	0		\N	2024-09-17 10:35:05.399809+03
3323	1584	39	0	t	8000	1	1	0		\N	\N
3324	1585	1	1000	t	2000	2	1	0		\N	\N
3408	1628	1	2000	f	2000	2	2	0		\N	\N
3500	1672	1	2000	f	3000	1	2	0		\N	\N
3501	1672	39	2000	f	3000	1	2	0		\N	\N
3502	1673	1	2000	f	3000	1	2	0		\N	\N
3503	1673	39	2000	f	3000	1	2	0		\N	\N
3628	1719	39	0	t	8000	2	1	0		\N	\N
3629	1719	4	0	t	8000	2	1	0		\N	\N
3630	1719	3	0	t	8000	2	1	0		\N	\N
3631	1719	40	4500	f	4500	2	1	0		\N	\N
4645	2174	10	0	f	6000	1	2	0		\N	2024-05-11 11:47:49.226024+03
4697	2208	26	1000	f	4000	3	6	0	Скидка курорту	\N	2024-06-07 15:40:28.292765+03
3634	1722	3	1000	t	4000	2	1	0		\N	\N
3732	1763	12	1000	t	5000	2	1	0		\N	\N
3733	1763	13	1000	f	6000	2	1	0		\N	\N
3734	1764	39	0	t	5000	2	1	0		\N	\N
3735	1764	4	0	t	5000	2	1	0		\N	\N
3736	1764	40	0	f	6000	2	1	0		\N	\N
3810	1794	3	0	t	8000	1	1	0		\N	\N
4698	2209	26	0	f	3000	1	2	0		\N	2024-06-07 15:41:18.576045+03
4699	2209	27	0	f	3000	1	2	0		\N	2024-06-07 15:41:18.577007+03
4769	2243	11	0	f	10000	1	2	0		\N	2024-06-17 15:47:48.228321+03
4770	2243	13	0	t	9000	2	1	0		\N	2024-06-17 15:47:48.229578+03
4824	2274	26	2000	f	6000	6	1	0		\N	2024-06-26 15:40:58.474829+03
4825	2274	21	2000	f	6000	6	1	0		\N	2024-06-26 15:40:58.476385+03
3996	1868	10	1000	t	5000	2	1	0		\N	\N
3997	1868	12	1000	t	5000	2	1	0		\N	\N
3998	1869	10	2000	t	4000	2	1	0		\N	\N
3999	1869	12	2000	t	4000	2	1	0		\N	\N
4000	1870	39	1000	t	4000	2	1	0		\N	\N
4067	1905	13	0	t	9000	1	1	0		\N	2024-02-18 12:31:01.664422+03
4068	1905	10	0	t	9000	2	1	0		\N	2024-02-18 12:31:01.6656+03
4288	1996	41	0	t	6000	1	1	0		\N	2024-03-02 10:44:39.342453+03
4289	1996	42	0	t	6000	1	1	0		\N	2024-03-02 10:44:39.343607+03
4371	2033	48	0	t	6000	1	1	0		\N	2024-03-08 12:34:01.998831+03
4372	2033	51	0	t	6000	1	1	0		\N	2024-03-08 12:34:02.000777+03
4373	2033	41	0	t	6000	1	1	0		\N	2024-03-08 12:34:02.00174+03
4447	2066	48	0	t	6000	1	1	0		\N	2024-03-17 12:02:06.919462+03
4448	2066	39	0	t	6000	1	1	0		\N	2024-03-17 12:02:06.920759+03
4504	2098	39	0	f	5000	1	2	0		\N	2024-03-29 16:06:45.768926+03
4505	2098	48	0	f	5000	1	4	0		\N	2024-03-29 16:06:45.770388+03
4202	1954	53	1000	t	5000	1	1	0		\N	2024-02-24 14:38:15.458786+03
4512	2101	41	0	f	5000	1	2	0		\N	2024-03-29 16:27:20.794803+03
4553	2129	12	0	t	9000	2	1	0		\N	2024-04-23 16:19:15.194777+03
4554	2130	12	0	f	10000	2	1	0		\N	2024-04-23 16:19:36.964377+03
4616	2160	10	3600	f	6400	4	6	0	20% скидка	\N	2024-05-09 17:35:14.155988+03
4617	2160	10	8000	f	2000	1	6	0	Инструктор Амир. Оплатили нал и на стойке	\N	2024-05-09 17:35:14.188143+03
4618	2161	13	0	f	12000	6	3	0		\N	2024-05-09 17:54:57.136509+03
4826	2275	24	2000	f	6000	6	1	0		\N	2024-06-26 15:42:31.2457+03
4870	2304	27	0	t	9000	6	1	0		\N	2024-07-07 15:35:07.304724+03
4871	2304	28	0	t	9000	6	1	0		\N	2024-07-07 15:35:07.305874+03
4872	2304	31	0	t	9000	6	1	0		\N	2024-07-07 15:35:07.306591+03
4873	2305	18	0	f	3000	1	2	0		\N	2024-07-07 16:26:50.030898+03
4874	2305	26	0	f	3000	1	2	0		\N	2024-07-07 16:26:50.031593+03
4875	2306	25	1000	f	2000	6	4	0		\N	2024-07-07 16:27:17.213479+03
4876	2306	27	1000	f	2000	6	4	0		\N	2024-07-07 16:27:17.214052+03
4877	2307	12	0	t	9000	1	1	0		\N	2024-07-07 16:30:27.614688+03
4878	2307	13	0	t	9000	1	1	0		\N	2024-07-07 16:30:27.615293+03
4950	2344	11	2000	f	8000	6	2	0		\N	2024-07-16 15:07:12.883913+03
4951	2344	13	0	t	9000	1	2	0		\N	2024-07-16 15:07:12.885251+03
5059	2385	11	0	f	4000	2	2	0		\N	2024-07-25 12:55:47.435114+03
5060	2385	12	0	f	4000	2	2	0		\N	2024-07-25 12:55:47.436211+03
5061	2385	13	0	f	4000	2	2	0		\N	2024-07-25 12:55:47.436941+03
5153	2419	25	0	f	3000	1	2	0		\N	2024-08-01 13:46:15.505784+03
5154	2419	26	0	f	3000	1	2	0		\N	2024-08-01 13:46:15.506895+03
5155	2419	16	0	f	3000	1	2	0		\N	2024-08-01 13:46:15.507645+03
5231	2455	23	0	f	8000	1	1	0		\N	2024-08-08 17:25:12.154923+03
5232	2455	21	0	f	8000	2	1	0		\N	2024-08-08 17:25:12.158065+03
5332	2496	13	0	t	9000	6	1	0		\N	2024-08-15 14:22:33.332281+03
5333	2496	10	1000	f	9000	1	3	0	Скидка исламу. От премиум	\N	2024-08-15 14:22:33.333646+03
5334	2496	11	1000	f	9000	1	3	0		\N	2024-08-15 14:22:33.334359+03
5335	2496	53	8000	f	2000	2	2	0	На магином	\N	2024-08-15 14:22:33.335072+03
5336	2497	30	1600	f	6400	3	6	0		\N	2024-08-15 14:24:02.062044+03
5337	2497	20	0	t	7000	6	1	0		\N	2024-08-15 14:24:02.063062+03
5338	2497	23	0	t	7000	6	1	0		\N	2024-08-15 14:24:02.063937+03
5415	2533	20	0	f	3000	2	2	0		\N	2024-08-18 16:34:43.000693+03
5416	2533	23	0	f	3000	2	2	0		\N	2024-08-18 16:34:43.001855+03
5514	2570	12	0	t	9000	2	1	0		\N	2024-08-23 15:06:29.14044+03
5515	2570	30	0	t	7000	6	1	0		\N	2024-08-23 15:06:29.141317+03
5516	2570	20	1600	f	6400	2	3	0	От Аллюра 	\N	2024-08-23 15:06:29.141804+03
5581	2607	10	0	f	6000	1	2	0		\N	2024-08-27 14:00:55.083433+03
5630	2632	20	1600	f	6400	3	6	0	Ренат	\N	2024-08-30 13:59:09.33299+03
5631	2632	22	1600	f	6400	3	6	0		\N	2024-08-30 13:59:09.334012+03
5632	2633	9	2400	f	9600	6	1	0	С сайта, туда комиссия 2400	\N	2024-08-30 14:25:25.219949+03
5633	2633	10	0	t	11000	6	1	0		\N	2024-08-30 14:25:25.221926+03
5684	2659	9	0	f	4000	6	2	0		\N	2024-09-03 17:10:23.286208+03
5728	2681	18	0	f	5000	1	2	0		\N	2024-09-12 17:51:44.556076+03
5729	2681	23	0	f	5000	1	2	0		\N	2024-09-12 17:51:44.557359+03
5777	2699	21	1600	f	6400	3	3	0	Аллюр 	\N	2024-09-17 10:35:05.402865+03
5778	2699	22	1600	f	6400	3	3	0		\N	2024-09-17 10:35:05.407933+03
5779	2699	30	0	f	8000	6	2	0		\N	2024-09-17 10:35:05.411977+03
5809	2713	13	0	f	4000	1	2	0		\N	2024-09-22 16:57:53.578492+03
5825	2724	9	0	f	6000	1	2	0	Ренат	\N	2024-09-27 16:45:45.207399+03
5826	2724	11	0	f	6000	1	2	0		\N	2024-09-27 16:45:45.208536+03
5827	2724	12	0	f	6000	1	2	0		\N	2024-09-27 16:45:45.209282+03
3325	1586	1	1000	f	3000	1	2	0		\N	\N
3326	1586	39	1000	f	3000	1	2	0		\N	\N
3409	1629	1	0	f	5000	2	2	0		\N	\N
3410	1629	39	0	f	5000	2	2	0		\N	\N
3411	1629	2	0	f	5000	2	2	0		\N	\N
3415	1631	13	1000	f	4000	1	2	0		\N	\N
3504	1674	12	0	f	7000	2	3	0	Оба из аллюра, скорее всего перевод 	0	\N
4646	2175	18	2000	f	6000	1	4	0		\N	2024-05-11 12:36:32.866131+03
3635	1723	1	0	f	6000	1	2	0		\N	\N
3636	1724	1	1000	t	4000	1	1	0		\N	\N
3637	1724	4	1000	t	4000	1	1	0		\N	\N
3638	1724	39	1000	f	5000	1	1	0		\N	\N
3639	1725	8	0	f	10000	1	1	0		\N	\N
3640	1725	9	0	t	9000	2	1	0		\N	\N
3641	1725	12	1000	f	9000	1	4	0	Откат дали 1к	\N	\N
3642	1725	13	1000	f	9000	1	4	0	Откат дали 1к	\N	\N
3737	1765	1	1000	f	5000	1	1	0		\N	\N
3738	1765	39	1000	t	4000	1	2	0		\N	\N
3739	1765	3	0	t	5000	1	2	0		\N	\N
3811	1795	13	1000	t	5000	1	1	0		\N	\N
3812	1796	9	1000	t	5000	1	1	0		\N	\N
3813	1796	13	1000	t	5000	1	3	0		\N	\N
3819	1798	12	1000	f	9000	2	4	0		\N	\N
3820	1798	9	1000	f	9000	1	1	0		\N	\N
3821	1798	13	0	t	9000	2	1	0		\N	\N
3822	1798	10	7000	f	3000	2	1	0	Дети с инструктором. 	\N	\N
3899	1829	10	1000	t	3000	1	1	0		\N	\N
3900	1829	12	1000	t	3000	1	1	0		\N	\N
3910	1831	49	0	t	5000	2	1	0		\N	\N
4647	2176	20	0	t	2000	1	1	0		\N	2024-05-11 12:51:17.735624+03
4001	1871	48	0	t	8000	1	1	0		\N	\N
4002	1871	50	0	t	8000	1	1	0		\N	\N
3909	1831	48	0	t	5000	2	1	0		0	\N
4069	1906	12	1000	f	9000	1	4	0	Откат отдали 	\N	2024-02-18 15:22:19.741812+03
4070	1906	13	1000	f	9000	1	4	0	Откат отдали 	\N	2024-02-18 15:22:19.743262+03
4071	1907	9	1000	t	3000	1	1	0		\N	2024-02-18 15:26:27.872211+03
4072	1907	10	1000	t	3000	1	1	0		\N	2024-02-18 15:26:27.872982+03
4073	1907	11	1000	t	3000	1	1	0		\N	2024-02-18 15:26:27.873731+03
4203	1955	39	0	t	4000	1	1	0		\N	2024-02-24 17:24:38.4137+03
4204	1955	48	0	t	4000	1	1	0		\N	2024-02-24 17:24:38.415301+03
4205	1955	51	0	t	4000	1	1	0		\N	2024-02-24 17:24:38.416063+03
4210	1957	48	0	t	4000	1	1	0		\N	2024-02-24 17:32:28.892539+03
4211	1957	49	0	t	4000	1	1	0		\N	2024-02-24 17:32:28.893176+03
4212	1957	39	0	t	4000	1	1	0		\N	2024-02-24 17:32:28.893701+03
4290	1997	10	1000	t	5000	2	1	0		\N	2024-03-02 13:54:06.219038+03
4291	1997	11	1000	t	5000	2	1	0		\N	2024-03-02 13:54:06.221363+03
4374	2034	9	1000	t	3000	1	1	0		\N	2024-03-08 14:42:37.94394+03
4375	2034	10	1000	t	3000	1	1	0		\N	2024-03-08 14:42:37.945316+03
4376	2034	11	1000	t	3000	1	1	0		\N	2024-03-08 14:42:37.946072+03
4377	2034	13	1000	t	3000	1	1	0		\N	2024-03-08 14:42:37.946786+03
4449	2067	13	2000	f	5000	1	2	0		\N	2024-03-17 15:58:19.276439+03
4450	2067	11	2000	f	5000	1	2	0		\N	2024-03-17 15:58:19.277849+03
3505	1674	8	0	f	9000	2	3	0		0	\N
4506	2099	48	0	f	7000	1	2	0		\N	2024-03-29 16:21:32.982638+03
4507	2099	40	3500	t	2500	1	1	0		\N	2024-03-29 16:21:32.9839+03
4508	2099	40	3500	t	2500	1	1	0		\N	2024-03-29 16:21:32.984694+03
4509	2099	50	3500	t	2500	1	1	0		\N	2024-03-29 16:21:32.98545+03
4510	2099	50	3500	t	2500	1	1	0		\N	2024-03-29 16:21:32.986202+03
4511	2100	51	0	f	6000	1	2	0		\N	2024-03-29 16:25:24.130679+03
4513	2102	49	0	f	7000	1	2	0		\N	2024-03-29 16:29:31.997251+03
4514	2102	5	0	f	7000	1	2	0		\N	2024-03-29 16:29:31.998028+03
4555	2131	35	1000	t	5000	2	1	0		\N	2024-04-23 17:18:23.450699+03
4619	2162	20	0	t	7000	1	1	0		\N	2024-05-10 10:23:42.499096+03
4620	2163	24	0	t	7000	1	1	0		\N	2024-05-10 11:02:48.120369+03
4621	2163	25	0	t	7000	1	1	0		\N	2024-05-10 11:02:48.121042+03
4648	2176	22	0	t	2000	1	1	0		\N	2024-05-11 12:51:17.736701+03
4649	2176	27	0	t	2000	1	1	0		\N	2024-05-11 12:51:17.73771+03
4650	2176	11	2000	t	1000	1	1	0		\N	2024-05-11 12:51:17.738691+03
4651	2176	11	2000	t	1000	1	1	0	Инструктор Амир 	\N	2024-05-11 12:51:17.739715+03
4700	2210	12	1000	f	11000	2	1	0	Скидка - откат	\N	2024-06-07 15:42:53.726403+03
4701	2211	12	0	t	11000	1	1	0		\N	2024-06-07 15:44:42.608681+03
4702	2211	11	0	f	12000	1	1	0		\N	2024-06-07 15:44:42.609381+03
4773	2245	19	0	t	7000	1	1	0		\N	2024-06-17 17:20:20.608994+03
4774	2245	23	3000	t	4000	6	1	0		\N	2024-06-17 17:20:20.609837+03
4827	2276	20	1600	f	6400	2	6	0		\N	2024-06-27 13:17:39.120954+03
4879	2308	11	0	t	5000	1	2	0	Предоплата это перевод просто 	\N	2024-07-07 16:48:21.578723+03
4880	2308	18	0	t	4000	6	1	0		\N	2024-07-07 16:48:21.579814+03
4952	2345	21	0	f	3000	1	2	0		\N	2024-07-16 16:53:43.530664+03
4953	2346	25	0	f	3000	6	2	0		\N	2024-07-16 16:55:19.558255+03
4954	2347	28	1000	f	7000	2	3	0	Ски резорт	\N	2024-07-16 17:04:09.325885+03
4955	2348	11	0	t	5000	6	1	0		\N	2024-07-16 17:04:58.310214+03
5062	2386	32	0	t	7000	2	1	0		\N	2024-07-25 17:39:27.824592+03
5063	2386	20	0	f	8000	1	2	0		\N	2024-07-25 17:39:27.826058+03
5064	2386	23	1600	f	6400	3	6	0		\N	2024-07-25 17:39:27.826821+03
5065	2386	28	1600	f	6400	3	6	0		\N	2024-07-25 17:39:27.827555+03
5156	2420	10	0	f	6000	2	2	0		\N	2024-08-01 15:01:55.48837+03
5233	2456	13	0	t	9000	2	1	0	Ренат	\N	2024-08-08 17:30:01.461043+03
5234	2456	9	0	t	9000	1	1	0		\N	2024-08-08 17:30:01.463776+03
5235	2456	10	0	t	9000	1	1	0		\N	2024-08-08 17:30:01.465607+03
5236	2456	23	0	t	7000	2	1	0		\N	2024-08-08 17:30:01.466649+03
5240	2458	22	0	f	5000	2	2	0		\N	2024-08-08 17:46:27.610266+03
5241	2458	20	0	f	5000	2	2	0		\N	2024-08-08 17:46:27.611024+03
5242	2459	20	0	f	10000	3	3	0	Ренат	\N	2024-08-08 17:51:02.011891+03
5243	2459	10	0	f	12000	2	2	0		\N	2024-08-08 17:51:02.012568+03
5339	2498	26	0	f	3000	6	2	0		\N	2024-08-15 15:35:00.973157+03
5340	2498	20	0	f	3000	6	2	0		\N	2024-08-15 15:35:00.974538+03
3327	1587	12	1000	t	3000	1	1	0		\N	\N
3328	1588	12	1000	t	5000	1	1	0		\N	\N
4652	2177	13	0	t	9000	6	1	0		\N	2024-05-11 13:11:43.444197+03
4703	2212	31	0	t	2000	1	1	0		\N	2024-06-08 13:10:05.191546+03
4775	2246	23	0	t	7000	1	1	0		\N	2024-06-18 16:35:16.786404+03
3412	1630	1	0	t	4000	1	1	0		\N	\N
3413	1630	4	0	f	5000	1	1	0		\N	\N
3414	1630	39	0	f	5000	1	1	0		\N	\N
3506	1675	12	1500	f	3500	2	2	0		\N	\N
3507	1675	13	1500	f	3500	2	2	0		\N	\N
3511	1678	39	1800	f	7200	2	1	0		\N	\N
3512	1678	40	1800	f	7200	2	1	0		\N	\N
3513	1678	1	1800	f	7200	2	1	0		\N	\N
3514	1678	3	1800	f	7200	2	1	0		\N	\N
3643	1726	39	1000	t	4000	1	1	0		\N	\N
3740	1766	10	1000	t	5000	2	1	0		\N	\N
3741	1766	11	1000	f	6000	2	1	0		\N	\N
3742	1766	12	1000	f	6000	2	1	0		\N	\N
3743	1766	13	1000	f	6000	2	1	0		\N	\N
4776	2246	11	0	t	9000	6	1	0		\N	2024-06-18 16:35:16.787661+03
4828	2277	12	0	f	10000	6	1	0		\N	2024-06-27 15:35:14.90936+03
4881	2309	11	0	f	6000	2	2	0	Этот и выше рейс Назар	\N	2024-07-07 16:49:09.617344+03
4956	2349	11	0	t	11000	6	1	0		\N	2024-07-17 14:42:01.449661+03
4957	2349	18	2000	f	8000	3	6	0		\N	2024-07-17 14:42:01.45126+03
3901	1830	39	4000	f	5000	1	4	0	Отдали откат за все 8	\N	\N
3902	1830	40	4000	f	5000	1	4	0		\N	\N
3903	1830	41	4000	f	5000	1	4	0		\N	\N
3904	1830	42	4000	f	5000	1	4	0		\N	\N
3905	1830	51	4000	f	5000	1	4	0		\N	\N
3906	1830	5	4000	f	5000	1	4	0		\N	\N
3907	1830	48	4000	f	5000	1	4	0		\N	\N
3908	1830	49	4000	f	5000	1	4	0		\N	\N
4003	1872	39	2000	t	2000	1	1	0		\N	\N
4004	1872	40	2000	t	2000	1	1	0		\N	\N
4005	1872	51	2000	t	2000	1	1	0		\N	\N
4006	1872	48	2000	t	2000	1	1	0		\N	\N
4958	2349	20	0	f	10000	6	1	0		\N	2024-07-17 14:42:01.452067+03
4008	1873	39	0	t	5000	2	1	0		\N	\N
4074	1908	10	1000	t	3000	1	1	0		\N	2024-02-18 16:03:29.163101+03
4206	1956	39	0	t	6000	1	1	0		\N	2024-02-24 17:31:04.758892+03
4207	1956	50	0	t	6000	1	1	0		\N	2024-02-24 17:31:04.760153+03
4208	1956	51	3500	t	2500	1	1	0		\N	2024-02-24 17:31:04.760838+03
4209	1956	51	3500	t	2500	1	1	0		\N	2024-02-24 17:31:04.761513+03
4219	1960	13	1000	t	5000	2	1	0		\N	2024-02-24 17:39:07.345671+03
4220	1960	10	1000	t	5000	2	1	0		\N	2024-02-24 17:39:07.347476+03
4292	1998	11	0	t	9000	2	1	0		\N	2024-03-02 15:24:08.102418+03
4451	2068	40	0	t	6000	1	1	0		\N	2024-03-17 17:26:06.043727+03
4452	2069	49	3300	f	2700	4	5	0		\N	2024-03-17 17:45:30.234727+03
4453	2069	50	3300	f	2700	4	5	0		\N	2024-03-17 17:45:30.236876+03
3644	1726	3	1000	f	4000	1	1	0		\N	\N
3645	1726	4	1000	f	4000	1	1	0		\N	\N
3646	1726	1	1000	f	4000	1	1	0		\N	\N
4959	2349	19	0	f	10000	6	1	0		\N	2024-07-17 14:42:01.452816+03
4379	2035	53	0	f	5000	1	2	0		\N	2024-03-08 14:56:45.780377+03
4378	2035	53	0	f	6000	1	2	0		\N	2024-03-08 14:56:45.778918+03
4515	2103	9	1000	t	5000	2	1	0		\N	2024-03-30 12:16:16.745868+03
4516	2103	10	1000	t	5000	2	1	0		\N	2024-03-30 12:16:16.747752+03
4556	2132	12	2000	f	8000	2	4	0	От Самата	\N	2024-04-24 16:12:29.6719+03
4557	2132	13	2000	f	8000	2	4	0		\N	2024-04-24 16:12:29.672943+03
4960	2349	21	5000	f	5000	6	1	0		\N	2024-07-17 14:42:01.453539+03
4973	2352	9	0	t	9000	6	1	0	Все назар	\N	2024-07-17 15:05:49.456095+03
4974	2352	10	1000	f	9000	1	4	0	Комиссия Динисламу	\N	2024-07-17 15:05:49.456801+03
4975	2352	18	1600	f	6400	3	6	0		\N	2024-07-17 15:05:49.457339+03
4976	2352	20	1600	f	6400	3	6	0		\N	2024-07-17 15:05:49.457863+03
4977	2352	25	1600	f	6400	3	6	0		\N	2024-07-17 15:05:49.458377+03
4978	2352	26	1600	f	6400	3	6	0		\N	2024-07-17 15:05:49.458869+03
4979	2352	28	1600	f	6400	3	6	0		\N	2024-07-17 15:05:49.45936+03
5066	2387	13	0	f	10000	2	1	0		\N	2024-07-25 17:50:43.931859+03
5067	2387	12	0	f	10000	2	1	0		\N	2024-07-25 17:50:43.933041+03
5068	2387	11	0	f	10000	2	1	0		\N	2024-07-25 17:50:43.933642+03
5069	2387	9	0	f	10000	2	1	0		\N	2024-07-25 17:50:43.9342+03
5070	2387	26	0	f	8000	2	1	0		\N	2024-07-25 17:50:43.9348+03
5157	2421	13	0	t	11000	2	1	0		\N	2024-08-01 17:38:34.172384+03
5158	2421	31	2000	f	8000	2	1	0		\N	2024-08-01 17:38:34.173314+03
5159	2422	26	0	t	7000	1	1	0		\N	2024-08-01 17:44:51.663261+03
5160	2422	27	0	t	7000	1	1	0		\N	2024-08-01 17:44:51.664008+03
5161	2422	18	0	t	7000	1	1	0		\N	2024-08-01 17:44:51.664662+03
5162	2423	23	0	f	5000	1	2	0		\N	2024-08-01 17:46:41.899576+03
5163	2423	31	0	f	5000	1	2	0		\N	2024-08-01 17:46:41.900134+03
5237	2457	31	1000	f	4000	2	2	0		\N	2024-08-08 17:31:51.938777+03
5238	2457	32	1000	f	4000	2	2	0		\N	2024-08-08 17:31:51.93989+03
5239	2457	28	1000	f	4000	2	2	0		\N	2024-08-08 17:31:51.940609+03
5244	2460	20	0	f	3000	2	2	0	Ренат 	\N	2024-08-08 17:52:36.427841+03
5245	2460	31	0	f	3000	2	2	0		\N	2024-08-08 17:52:36.428429+03
5341	2499	26	0	f	3000	1	2	0		\N	2024-08-15 16:38:07.115011+03
5417	2534	20	0	f	8000	1	2	0		\N	2024-08-18 17:16:57.703058+03
5517	2571	10	0	f	6000	1	2	0		\N	2024-08-24 11:16:14.999828+03
5518	2571	33	0	t	4000	6	1	0		\N	2024-08-24 11:16:15.000977+03
5520	2573	23	0	f	5000	1	2	0		\N	2024-08-24 11:58:03.553148+03
5521	2573	33	0	f	5000	1	2	0	Ренат	\N	2024-08-24 11:58:03.554069+03
5582	2608	30	0	f	8000	6	2	0		\N	2024-08-27 14:34:01.669317+03
5583	2609	20	0	f	3000	6	2	0		\N	2024-08-27 15:11:39.281014+03
5584	2609	22	0	f	3000	6	2	0		\N	2024-08-27 15:11:39.281858+03
5634	2634	23	0	f	3000	6	2	0		\N	2024-08-30 16:36:14.301501+03
5635	2634	30	0	f	3000	1	2	0		\N	2024-08-30 16:36:14.302926+03
5636	2634	31	0	f	3000	1	2	0		\N	2024-08-30 16:36:14.303522+03
5685	2660	20	0	f	5000	1	2	0		\N	2024-09-04 09:30:41.648921+03
5730	2682	21	0	f	10000	4	1	0		\N	2024-09-13 11:26:23.804209+03
3329	1589	9	1500	f	7500	2	2	0		\N	\N
3333	1591	8	0	f	9000	2	2	0		\N	\N
3334	1591	12	0	f	9000	2	2	0		\N	\N
3335	1591	13	0	f	9000	1	2	0		\N	\N
3416	1632	9	2500	f	4500	1	4	0		\N	\N
3417	1632	10	2500	f	4500	1	4	0		\N	\N
3418	1632	13	2500	f	4500	1	4	0		\N	\N
3419	1633	8	1500	f	3500	1	4	0	500 агенту	\N	\N
3420	1633	13	1500	f	3500	1	4	0	500 агенту	\N	\N
3421	1633	35	2500	f	1500	1	4	0		\N	\N
3424	1635	4	1000	t	2000	1	1	0		\N	\N
3425	1635	5	1000	t	2000	2	1	0		\N	\N
3508	1676	39	1000	t	4000	2	1	0		\N	\N
3515	1679	12	1000	f	9000	1	2	0		\N	\N
3647	1727	39	0	t	8000	2	1	0		\N	\N
3648	1727	40	0	f	9000	2	1	0		\N	\N
3657	1730	39	0	f	6000	1	1	0		\N	\N
3658	1730	4	0	t	5000	2	1	0		\N	\N
3659	1731	1	0	f	9000	2	1	0		\N	\N
3660	1731	3	0	f	9000	2	1	0		\N	\N
3661	1731	4	0	t	8000	2	1	0		\N	\N
3662	1731	39	2000	f	7000	1	4	0	Откат дали 	\N	\N
3663	1731	40	2000	f	7000	1	4	0	Откат дали 	\N	\N
3744	1767	4	0	t	5000	1	1	0		\N	\N
3823	1799	39	0	t	8000	1	1	0		\N	\N
3824	1799	4	0	t	8000	2	1	0		\N	\N
3825	1799	3	1000	f	8000	2	1	0		\N	\N
3911	1832	39	0	t	8000	1	1	0		\N	\N
3912	1832	40	0	f	9000	2	3	0		\N	\N
3913	1832	51	0	f	9000	2	3	0		\N	\N
4653	2178	12	0	t	9000	6	1	0		\N	2024-05-11 14:24:08.756291+03
4704	2213	26	0	f	3000	1	2	0		\N	2024-06-08 17:31:35.905324+03
4777	2247	13	1000	f	9000	2	3	0	От премиум вилладж. Скидка - откат	\N	2024-06-18 16:38:39.507043+03
4778	2247	26	0	t	7000	2	1	0		\N	2024-06-18 16:38:39.508605+03
4829	2278	12	0	t	11000	1	1	0		\N	2024-06-28 14:52:06.888533+03
4882	2310	18	0	f	3000	1	2	0		\N	2024-07-07 17:38:09.07745+03
4883	2310	22	0	f	3000	1	2	0		\N	2024-07-07 17:38:09.078257+03
4884	2310	27	0	f	3000	6	2	0		\N	2024-07-07 17:38:09.078749+03
4885	2311	11	0	f	6000	6	2	0		\N	2024-07-07 17:46:31.058765+03
4961	2350	21	5000	f	5000	6	1	0		\N	2024-07-17 14:43:49.013715+03
4962	2350	24	0	f	10000	1	1	0		\N	2024-07-17 14:43:49.014962+03
4963	2350	25	0	f	10000	1	1	0		\N	2024-07-17 14:43:49.015716+03
4964	2350	26	0	f	10000	1	1	0		\N	2024-07-17 14:43:49.016408+03
4965	2350	27	0	f	10000	1	1	0		\N	2024-07-17 14:43:49.017148+03
4080	1910	48	0	t	8000	1	1	0		\N	2024-02-18 17:28:54.328625+03
4081	1910	49	0	t	8000	1	1	0		\N	2024-02-18 17:28:54.33052+03
4082	1910	50	0	t	8000	1	1	0		\N	2024-02-18 17:28:54.33151+03
4083	1910	5	0	t	8000	1	1	0		\N	2024-02-18 17:28:54.332028+03
4084	1910	39	0	t	8000	1	1	0		\N	2024-02-18 17:28:54.332496+03
4085	1910	40	0	f	9000	1	1	0		\N	2024-02-18 17:28:54.333671+03
4086	1911	11	0	f	5000	1	4	0		\N	2024-02-18 17:53:07.680176+03
4087	1911	10	2000	f	3000	2	4	0		\N	2024-02-18 17:53:07.680784+03
4213	1958	48	0	f	7000	2	2	0		\N	2024-02-24 17:34:02.195664+03
4214	1958	50	0	f	7000	2	2	0		\N	2024-02-24 17:34:02.196711+03
4215	1958	39	0	f	7000	2	2	0		\N	2024-02-24 17:34:02.197488+03
4216	1959	39	0	t	6000	1	1	0		\N	2024-02-24 17:36:19.486763+03
4217	1959	48	0	t	6000	1	1	0		\N	2024-02-24 17:36:19.487541+03
4218	1959	51	0	t	6000	1	1	0		\N	2024-02-24 17:36:19.488237+03
4221	1961	10	0	t	9000	1	1	0		\N	2024-02-24 17:46:41.513401+03
4293	1999	41	0	t	6000	1	1	0		\N	2024-03-02 17:01:20.74805+03
4294	1999	48	0	t	6000	1	1	0		\N	2024-03-02 17:01:20.74936+03
4295	1999	49	0	t	6000	1	1	0		\N	2024-03-02 17:01:20.749961+03
4296	2000	42	0	f	7000	2	1	0		\N	2024-03-02 17:07:17.569696+03
4297	2000	48	0	f	7000	1	1	0		\N	2024-03-02 17:07:17.57038+03
4298	2000	49	0	f	7000	1	1	0		\N	2024-03-02 17:07:17.570903+03
4380	2036	13	1000	t	3000	2	1	0		\N	2024-03-08 17:02:04.583702+03
4381	2036	11	1000	t	3000	2	1	0		\N	2024-03-08 17:02:04.584616+03
4454	2070	11	0	t	9000	2	1	0		\N	2024-03-18 09:57:11.812908+03
3516	1679	8	1000	f	9000	1	2	0		\N	\N
4088	1912	9	1000	f	5000	4	5	0		\N	2024-02-18 17:53:54.62829+03
4223	1961	53	2300	f	6700	2	1	0	С комиссией 	\N	2024-02-24 17:46:41.514548+03
4222	1961	11	1000	f	9000	2	1	0	Откат отдали 	\N	2024-02-24 17:46:41.51398+03
4517	2104	10	1000	t	5000	2	1	0		\N	2024-03-31 15:11:06.432903+03
4518	2104	11	1000	t	5000	2	1	0		\N	2024-03-31 15:11:06.434188+03
4558	2133	13	1000	t	8000	1	1	0		\N	2024-04-25 13:13:28.89698+03
5071	2388	9	0	f	10000	2	1	0		\N	2024-07-26 10:29:13.841048+03
5072	2388	10	0	f	10000	2	1	0		\N	2024-07-26 10:29:13.842173+03
5073	2389	18	0	f	10000	2	1	0	По счету все кроме вездехода	\N	2024-07-26 10:38:29.018663+03
5074	2389	23	0	f	10000	2	1	0		\N	2024-07-26 10:38:29.01947+03
5075	2389	25	0	f	10000	2	1	0		\N	2024-07-26 10:38:29.020215+03
5076	2389	28	0	f	10000	2	1	0		\N	2024-07-26 10:38:29.020941+03
5077	2389	32	0	f	10000	2	1	0		\N	2024-07-26 10:38:29.021724+03
5078	2389	26	0	f	10000	2	1	0		\N	2024-07-26 10:38:29.022441+03
5079	2389	13	0	t	11000	2	1	0		\N	2024-07-26 10:38:29.023078+03
5164	2424	13	0	t	9000	1	1	0		\N	2024-08-03 10:11:53.090681+03
5165	2425	23	1000	f	9000	1	4	0		\N	2024-08-03 10:19:41.5927+03
5166	2425	25	1000	f	9000	1	4	0		\N	2024-08-03 10:19:41.593378+03
5246	2461	11	0	t	11000	6	1	0	Ренат	\N	2024-08-09 10:08:31.976915+03
5342	2500	9	0	t	5000	6	2	0		\N	2024-08-15 17:45:09.563086+03
5343	2500	13	0	t	5000	6	2	0		\N	2024-08-15 17:45:09.564022+03
5344	2501	10	0	f	4000	6	2	0		\N	2024-08-15 17:58:41.467202+03
5345	2501	11	0	f	4000	6	2	0		\N	2024-08-15 17:58:41.468044+03
5418	2535	31	0	f	3000	1	2	0	Ренат	\N	2024-08-18 17:19:30.280013+03
5519	2572	33	0	f	3000	1	2	0	Ренат все	\N	2024-08-24 11:16:47.318995+03
5585	2610	12	0	f	10000	6	2	0		\N	2024-08-27 15:20:17.592574+03
5586	2610	31	0	f	8000	6	2	0		\N	2024-08-27 15:20:17.595119+03
5637	2635	13	0	t	11000	1	1	0		\N	2024-08-31 10:31:13.765288+03
3336	1592	9	2000	f	3000	1	2	0		\N	\N
4654	2179	23	2000	f	6000	2	4	0		\N	2024-05-11 17:15:27.100572+03
4705	2214	25	0	f	3000	6	2	0		\N	2024-06-09 12:36:27.722934+03
3426	1636	1	0	f	5000	1	2	0		\N	\N
3509	1677	39	1000	t	4000	2	1	0		\N	\N
3510	1677	4	1000	f	5000	2	1	0		\N	\N
3649	1728	8	1500	f	8500	4	1	0		\N	\N
3650	1728	9	1500	f	8500	4	1	0		\N	\N
3651	1728	10	1500	f	8500	4	1	0		\N	\N
3652	1728	11	1500	f	8500	4	1	0		\N	\N
3653	1728	12	1500	f	8500	4	1	0		\N	\N
3654	1728	13	1500	f	8500	4	1	0		\N	\N
3655	1729	12	1000	f	9000	1	4	0	1к отдали откат	\N	\N
3656	1729	10	1000	f	7000	1	2	2000		\N	\N
3664	1732	41	0	f	9000	2	1	0		\N	\N
3745	1768	13	0	t	9000	2	1	0		\N	\N
3746	1769	39	0	t	5000	2	1	0		\N	\N
3747	1769	1	0	f	6000	2	1	0		\N	\N
3748	1769	3	0	f	6000	2	1	0		\N	\N
3749	1769	4	0	f	6000	2	1	0		\N	\N
3826	1800	12	1000	f	6000	2	2	0		\N	\N
3919	1834	13	5000	f	2000	2	1	0	Знакомые	\N	\N
3920	1834	9	5000	f	2000	2	1	0		\N	\N
3922	1836	12	1500	f	5500	1	4	0	Откат отдали	\N	\N
3923	1837	48	0	t	6000	1	1	0		\N	\N
4010	1874	12	2000	t	4000	2	1	0		\N	\N
4011	1874	12	2000	t	4000	2	1	0		\N	\N
4012	1874	12	3000	t	3000	2	1	0		\N	\N
3924	1837	49	2000	t	4000	2	1	0		\N	\N
4089	1913	39	0	t	8000	2	1	0		\N	2024-02-19 16:04:18.429306+03
4090	1913	48	0	t	8000	2	1	0		\N	2024-02-19 16:04:18.431266+03
4097	1917	13	1000	t	5000	1	1	0		\N	2024-02-19 16:10:04.815278+03
4224	1962	9	1000	t	3000	1	1	0		\N	2024-02-25 10:14:01.883715+03
4299	2001	48	1000	t	4000	1	1	0		\N	2024-03-02 17:11:34.10925+03
4300	2001	41	3500	t	1500	1	1	0		\N	2024-03-02 17:11:34.1106+03
4301	2001	41	3500	t	1500	1	1	0		\N	2024-03-02 17:11:34.111409+03
4302	2001	49	3000	f	3000	2	2	0	Знакомые 	\N	2024-03-02 17:11:34.112155+03
4382	2037	48	0	f	7000	1	2	0		\N	2024-03-09 12:19:20.826678+03
4383	2037	49	0	f	7000	1	2	0		\N	2024-03-09 12:19:20.827846+03
4384	2037	50	0	f	7000	1	2	0		\N	2024-03-09 12:19:20.828562+03
4385	2037	51	0	f	7000	1	2	0		\N	2024-03-09 12:19:20.829295+03
4386	2037	40	0	f	7000	1	2	0		\N	2024-03-09 12:19:20.829976+03
4387	2037	42	0	f	7000	1	2	0		\N	2024-03-09 12:19:20.830621+03
4455	2071	13	0	t	9000	2	1	0		\N	2024-03-18 16:36:58.807369+03
4456	2071	11	1000	t	8000	1	1	0		\N	2024-03-18 16:36:58.808494+03
4519	2105	9	0	t	9000	4	1	0		\N	2024-04-01 13:17:22.63936+03
4520	2105	10	0	t	9000	4	1	0		\N	2024-04-01 13:17:22.640876+03
4559	2134	13	2000	t	7000	4	1	0		\N	2024-04-28 10:38:28.389827+03
4706	2214	22	0	f	3000	6	2	0		\N	2024-06-09 12:36:27.724207+03
4779	2248	32	1000	f	7000	2	2	0		\N	2024-06-18 17:57:13.020185+03
4830	2279	23	1600	f	6400	2	6	0		\N	2024-06-29 11:18:28.65982+03
4831	2279	12	0	t	9000	1	1	0		\N	2024-06-29 11:18:28.660847+03
4886	2312	12	0	t	11000	1	1	0		\N	2024-07-08 10:57:48.2017+03
4887	2312	13	0	f	12000	1	1	0		\N	2024-07-08 10:57:48.202742+03
4980	2353	28	0	f	5000	2	2	0		\N	2024-07-19 16:58:53.457012+03
5080	2390	12	0	t	9000	2	1	0		\N	2024-07-26 15:39:55.290979+03
5081	2390	11	0	t	9000	2	1	0		\N	2024-07-26 15:39:55.292393+03
5082	2390	30	1600	f	6400	3	6	0		\N	2024-07-26 15:39:55.292966+03
5167	2426	26	0	t	7000	2	1	0		\N	2024-08-03 14:23:14.43249+03
5168	2426	31	1600	f	6400	3	1	0		\N	2024-08-03 14:23:14.4336+03
5169	2426	22	0	t	7000	2	1	0		\N	2024-08-03 14:23:14.434313+03
5170	2426	23	1600	f	6400	2	4	0	С Аллюра 	\N	2024-08-03 14:23:14.436812+03
5247	2462	23	400	f	7600	6	1	0		\N	2024-08-09 12:54:03.300405+03
5248	2462	20	400	f	7600	6	1	0		\N	2024-08-09 12:54:03.301327+03
5249	2462	22	400	f	7600	6	1	0		\N	2024-08-09 12:54:03.301901+03
5250	2462	26	400	f	7600	6	1	0		\N	2024-08-09 12:54:03.302497+03
5251	2462	27	400	f	7600	6	1	0		\N	2024-08-09 12:54:03.303046+03
5252	2462	28	400	f	7600	6	1	0		\N	2024-08-09 12:54:03.303623+03
5253	2462	32	400	f	7600	6	1	0		\N	2024-08-09 12:54:03.304164+03
5346	2502	22	0	t	9000	1	1	0		\N	2024-08-16 10:16:47.997466+03
5347	2502	25	0	t	9000	1	1	0		\N	2024-08-16 10:16:47.998577+03
5419	2536	22	0	f	5000	1	2	0		\N	2024-08-19 17:28:05.721354+03
5420	2536	25	0	f	5000	1	2	0		\N	2024-08-19 17:28:05.722404+03
5421	2536	31	0	f	5000	1	2	0		\N	2024-08-19 17:28:05.723033+03
5422	2536	20	0	f	5000	1	2	0		\N	2024-08-19 17:28:05.723737+03
5423	2536	28	0	f	5000	1	2	0		\N	2024-08-19 17:28:05.724354+03
5424	2536	33	0	f	5000	1	2	0		\N	2024-08-19 17:28:05.724973+03
5425	2536	32	0	t	4000	2	1	0		\N	2024-08-19 17:28:05.725715+03
5426	2536	26	0	t	4000	2	1	0		\N	2024-08-19 17:28:05.72634+03
5427	2536	34	0	f	5000	1	2	0		\N	2024-08-19 17:28:05.72695+03
5428	2536	12	0	f	6000	1	2	0		\N	2024-08-19 17:28:05.727559+03
5430	2538	11	5000	f	5000	1	2	0		\N	2024-08-19 17:53:30.110585+03
5431	2538	11	5000	f	5000	2	2	0		\N	2024-08-19 17:53:30.111348+03
5432	2538	13	0	t	9000	1	1	0		\N	2024-08-19 17:53:30.112019+03
5433	2538	33	0	t	7000	1	1	0		\N	2024-08-19 17:53:30.112714+03
5434	2538	23	0	t	7000	2	1	0		\N	2024-08-19 17:53:30.113372+03
5435	2538	18	0	t	7000	2	1	0		\N	2024-08-19 17:53:30.114045+03
5436	2539	30	0	t	7000	2	1	0		\N	2024-08-19 17:56:03.004279+03
5522	2574	28	0	f	3000	1	2	0		\N	2024-08-24 12:51:29.132067+03
5587	2611	11	0	f	6000	6	2	0		\N	2024-08-27 17:27:08.5999+03
5588	2611	13	0	f	6000	1	2	0		\N	2024-08-27 17:27:08.60086+03
5638	2635	9	0	t	11000	1	1	0		\N	2024-08-31 10:31:13.766335+03
5686	2661	20	0	f	3000	1	2	0		\N	2024-09-09 11:49:58.656174+03
5731	2682	22	0	f	10000	4	1	0		\N	2024-09-13 11:26:23.80536+03
5732	2682	23	0	f	10000	4	1	0		\N	2024-09-13 11:26:23.809295+03
5733	2682	28	0	f	10000	4	1	0		\N	2024-09-13 11:26:23.812534+03
5734	2682	31	0	f	10000	4	1	0		\N	2024-09-13 11:26:23.81325+03
5735	2682	32	0	f	10000	4	1	0		\N	2024-09-13 11:26:23.814+03
3337	1593	12	1000	f	6000	1	2	0		\N	\N
3338	1593	9	3000	f	4000	1	2	0		\N	\N
4655	2180	12	1000	f	9000	1	4	0		\N	2024-05-13 12:59:25.70564+03
4707	2215	13	0	f	10000	1	2	0		\N	2024-06-09 14:32:27.787425+03
4780	2249	21	0	t	9000	1	1	0		\N	2024-06-19 10:00:03.016541+03
4832	2280	27	1600	f	6400	2	6	0		\N	2024-06-29 15:43:21.74562+03
3517	1680	1	0	t	5000	1	1	0		\N	\N
3518	1680	39	0	f	6000	1	1	0		\N	\N
3665	1733	9	1000	t	5000	1	1	0		\N	\N
3750	1770	39	0	t	5000	1	1	0		\N	\N
3751	1770	1	0	f	6000	1	1	0		\N	\N
3752	1770	3	0	f	6000	1	1	0		\N	\N
3753	1770	5	0	f	6000	1	1	0		\N	\N
3754	1770	40	0	f	6000	1	1	0		\N	\N
3827	1801	39	0	t	5000	2	1	0		\N	\N
3828	1801	3	1000	t	4000	2	1	0		\N	\N
3829	1801	40	1000	t	4000	2	1	0		\N	\N
3921	1835	13	1000	t	5000	1	1	0		\N	\N
4013	1875	12	1000	t	3000	2	1	0		\N	\N
4014	1876	39	0	t	8000	1	1	0		\N	\N
4015	1877	39	0	t	8000	2	1	0		\N	\N
4016	1877	48	0	t	8000	1	1	0		\N	\N
4833	2281	12	1000	f	5000	1	2	0		\N	2024-06-29 15:44:00.764936+03
4888	2313	28	0	f	10000	6	2	0	Назар	\N	2024-07-08 10:59:48.495784+03
4889	2313	31	0	f	10000	6	2	0		\N	2024-07-08 10:59:48.497623+03
4094	1915	39	0	t	8000	1	1	0		\N	2024-02-19 16:07:38.128265+03
4095	1915	48	0	f	9000	1	1	0		\N	2024-02-19 16:07:38.129102+03
4096	1916	50	0	t	8000	2	1	0		\N	2024-02-19 16:08:48.428691+03
4225	1963	11	1000	f	6000	2	1	0		\N	2024-02-25 12:02:44.12875+03
4226	1963	10	1000	f	6000	1	1	0		\N	2024-02-25 12:02:44.129791+03
4227	1963	9	3000	f	4000	2	1	0		\N	2024-02-25 12:02:44.130482+03
4228	1964	10	1000	t	5000	1	1	0		\N	2024-02-25 12:04:38.241401+03
4229	1964	11	1000	t	5000	2	1	0		\N	2024-02-25 12:04:38.242224+03
4303	2002	13	0	t	9000	1	1	0		\N	2024-03-03 13:43:27.594077+03
4388	2038	48	1000	f	5000	2	2	0		\N	2024-03-09 12:20:49.327276+03
4389	2038	50	1000	f	5000	2	2	0		\N	2024-03-09 12:20:49.32868+03
4457	2072	41	0	t	6000	1	1	0		\N	2024-03-18 16:37:48.113778+03
4521	2106	35	1000	t	5000	4	1	0		\N	2024-04-01 16:11:19.486483+03
4560	2135	11	1000	f	9000	4	4	0	От Марии	\N	2024-04-28 14:14:06.331427+03
4981	2354	11	2000	f	10000	2	3	0	Аллюр	\N	2024-07-20 14:34:07.676451+03
5083	2391	28	0	f	3000	1	2	0		\N	2024-07-26 17:03:25.882006+03
5172	2428	11	0	t	9000	1	1	0		\N	2024-08-03 14:30:25.277084+03
5173	2429	10	0	t	11000	1	1	0		\N	2024-08-03 14:32:56.615581+03
5174	2429	13	0	t	11000	2	1	0		\N	2024-08-03 14:32:56.616368+03
5175	2429	25	0	f	10000	2	2	0		\N	2024-08-03 14:32:56.61711+03
5176	2429	21	0	f	10000	2	2	0		\N	2024-08-03 14:32:56.617852+03
5254	2463	18	0	f	3000	2	2	0		\N	2024-08-09 12:54:48.312496+03
5348	2503	9	0	f	10000	6	2	0		\N	2024-08-16 11:01:52.406118+03
5429	2537	12	1200	f	4800	3	6	0		\N	2024-08-19 17:30:58.613654+03
5523	2575	28	0	f	3000	1	2	0		\N	2024-08-24 13:58:55.220928+03
5524	2575	32	0	f	3000	1	2	0		\N	2024-08-24 13:58:55.221833+03
5525	2575	23	600	f	2400	3	6	0		\N	2024-08-24 13:58:55.222376+03
5526	2575	33	0	f	3000	1	2	0		\N	2024-08-24 13:58:55.222923+03
5527	2575	30	0	f	3000	1	2	0		\N	2024-08-24 13:58:55.223482+03
5528	2575	10	0	f	4000	1	2	0		\N	2024-08-24 13:58:55.224043+03
5529	2576	18	0	f	3000	6	2	0		\N	2024-08-24 14:12:25.878783+03
5530	2576	13	0	f	4000	6	2	0		\N	2024-08-24 14:12:25.879305+03
5531	2576	11	0	f	4000	6	2	0		\N	2024-08-24 14:12:25.879904+03
5589	2612	22	0	f	3000	6	2	0		\N	2024-08-27 17:27:58.281394+03
5590	2612	20	0	f	3000	6	2	0		\N	2024-08-27 17:27:58.282426+03
5639	2636	10	0	f	4000	1	2	0	Ренат	\N	2024-08-31 10:59:20.538421+03
5687	2662	22	0	t	7000	6	1	0		\N	2024-09-09 13:35:49.290135+03
5736	2683	18	0	f	10000	4	1	0		\N	2024-09-13 11:27:48.380801+03
5737	2683	19	0	f	10000	4	1	0		\N	2024-09-13 11:27:48.382279+03
5738	2683	20	0	f	10000	4	1	0		\N	2024-09-13 11:27:48.384475+03
5739	2683	25	0	f	10000	4	1	0		\N	2024-09-13 11:27:48.386185+03
5740	2683	30	0	f	10000	4	1	0		\N	2024-09-13 11:27:48.386646+03
5741	2683	33	0	f	10000	4	1	0		\N	2024-09-13 11:27:48.387137+03
5780	2700	13	0	t	9000	1	2	0		\N	2024-09-17 10:37:03.155293+03
5781	2700	11	0	t	9000	1	2	0		\N	2024-09-17 10:37:03.157884+03
5810	2714	13	0	t	9000	6	1	0		\N	2024-09-23 12:23:48.805816+03
5828	2725	33	1600	f	6400	3	3	0	Аллюр 	\N	2024-09-28 12:17:57.848342+03
5829	2726	18	0	f	8000	1	1	0	Ренат 	\N	2024-09-28 12:19:09.381659+03
5830	2727	11	0	f	6000	1	2	0		\N	2024-09-28 13:11:01.250298+03
5831	2727	12	0	f	6000	1	2	0		\N	2024-09-28 13:11:01.251602+03
5849	2734	12	0	t	11000	1	1	0	Ренат	\N	2024-09-29 15:10:09.94453+03
5850	2735	12	0	t	11000	1	1	0	Ренат	\N	2024-09-29 15:10:10.259366+03
5851	2736	25	0	f	3000	1	2	0	Ренат 	\N	2024-09-29 15:14:37.632421+03
5852	2737	22	500	f	2500	1	2	0		\N	2024-09-29 15:18:19.194828+03
5853	2737	25	500	f	2500	1	2	0		\N	2024-09-29 15:18:19.195588+03
5854	2737	28	500	f	2500	1	2	0		\N	2024-09-29 15:18:19.196308+03
5855	2737	30	0	f	3000	1	2	0		\N	2024-09-29 15:18:19.197014+03
5856	2737	31	0	f	3000	1	2	0		\N	2024-09-29 15:18:19.197682+03
5857	2737	32	0	f	3000	1	2	0		\N	2024-09-29 15:18:19.198326+03
5860	2739	25	0	f	3000	1	2	0		\N	2024-09-29 15:26:52.383009+03
5871	2745	12	0	f	10000	1	2	0		\N	2024-10-03 16:17:45.582829+03
5872	2745	13	0	f	10000	6	2	0		\N	2024-10-03 16:17:45.585014+03
5873	2746	30	0	f	3000	6	2	0		\N	2024-10-03 16:19:22.636397+03
5887	2754	19	0	f	3000	1	2	0		\N	2024-10-06 13:13:26.448814+03
5888	2754	20	0	f	3000	1	2	0		\N	2024-10-06 13:13:26.450084+03
5889	2754	23	0	f	3000	1	2	0		\N	2024-10-06 13:13:26.450697+03
5890	2754	33	0	f	3000	1	2	0		\N	2024-10-06 13:13:26.451263+03
5903	2762	9	0	t	9000	1	1	0	Друго	\N	2024-10-07 10:35:16.54658+03
5904	2762	10	2000	f	8000	3	6	0		\N	2024-10-07 10:35:16.547896+03
5905	2762	12	2000	f	8000	6	2	0	Отзывы напишут	\N	2024-10-07 10:35:16.548668+03
5906	2762	13	0	t	9000	6	1	0		\N	2024-10-07 10:35:16.549381+03
5907	2763	18	0	f	5000	6	2	0		\N	2024-10-07 10:54:54.014315+03
3339	1594	39	0	f	8000	1	1	1000		\N	\N
3341	1595	1	1000	f	3000	2	4	0	500 это скидка	\N	\N
3342	1595	2	1000	f	3000	2	4	0	500 это скидка	\N	\N
3344	1597	39	0	f	4000	1	4	0		\N	\N
4656	2181	12	0	t	9000	6	1	0		\N	2024-05-13 15:59:01.482136+03
4657	2181	13	3000	t	6000	6	1	0		\N	2024-05-13 15:59:01.48376+03
4658	2181	13	7000	f	3000	1	1	0	Оплатили часть наличкой, поэтому разделил 	\N	2024-05-13 15:59:01.484818+03
4708	2216	26	0	t	4000	6	1	0		\N	2024-06-09 17:41:55.93485+03
3519	1681	9	0	t	9000	2	1	0		\N	\N
3520	1681	10	0	f	10000	2	1	0		\N	\N
3666	1734	3	2000	t	2000	2	1	0		\N	\N
3667	1734	4	2000	f	3000	2	1	0		\N	\N
3755	1771	10	2000	t	4000	1	1	0		\N	\N
3756	1771	12	2000	f	5000	1	1	0		\N	\N
3757	1771	11	2000	f	5000	2	1	0		\N	\N
3830	1802	4	1000	f	8000	1	2	0		\N	\N
3831	1802	39	1000	f	8000	1	2	0		\N	\N
3832	1802	40	1000	f	8000	1	2	0		\N	\N
3833	1802	41	1000	f	8000	1	2	0		\N	\N
3925	1838	50	2000	f	7000	1	2	0		\N	\N
3926	1838	39	2000	f	7000	1	2	0		\N	\N
4017	1878	12	1000	f	4000	1	2	0		\N	\N
4098	1918	13	1000	t	5000	2	1	0		\N	2024-02-19 17:40:00.815127+03
4099	1919	9	0	f	10000	1	1	0		\N	2024-02-19 17:45:17.068839+03
4100	1919	10	0	f	10000	1	1	0		\N	2024-02-19 17:45:17.069524+03
4101	1919	11	0	f	10000	1	1	0		\N	2024-02-19 17:45:17.070117+03
4102	1919	12	0	f	10000	1	1	0		\N	2024-02-19 17:45:17.070694+03
4103	1919	13	0	f	10000	1	1	0		\N	2024-02-19 17:45:17.071269+03
4104	1919	52	6000	f	4000	1	1	0		\N	2024-02-19 17:45:17.071971+03
4230	1965	9	0	t	9000	2	1	0		\N	2024-02-25 13:02:48.589558+03
4231	1966	11	0	t	9000	1	1	0		\N	2024-02-25 13:48:55.897183+03
4304	2003	13	0	t	9000	1	1	0		\N	2024-03-03 13:43:50.730715+03
4390	2039	9	0	t	9000	1	1	0		\N	2024-03-09 16:10:21.358435+03
4391	2039	10	0	t	9000	1	1	0		\N	2024-03-09 16:10:21.359503+03
4392	2039	11	0	t	9000	1	1	0		\N	2024-03-09 16:10:21.360128+03
4393	2039	13	0	t	9000	1	1	0		\N	2024-03-09 16:10:21.360756+03
4394	2040	10	1000	f	9000	1	2	0		\N	2024-03-09 16:11:04.358369+03
4395	2040	11	1000	f	9000	1	2	0		\N	2024-03-09 16:11:04.359023+03
4396	2041	13	0	t	9000	2	1	0		\N	2024-03-09 16:11:39.940973+03
4458	2073	10	0	t	9000	1	1	0		\N	2024-03-19 10:12:06.186615+03
4459	2073	11	0	t	9000	2	1	0		\N	2024-03-19 10:12:06.18803+03
4460	2073	13	0	t	9000	2	1	0		\N	2024-03-19 10:12:06.188798+03
3340	1594	40	1000	f	7700	2	4	0	1000 скидка это откат	\N	\N
4709	2216	22	0	t	4000	6	1	0		\N	2024-06-09 17:41:55.936487+03
4561	2136	35	0	f	7000	1	4	0		\N	2024-04-28 16:11:12.022725+03
4562	2136	35	0	f	7000	1	4	0		\N	2024-04-28 16:11:12.023767+03
4563	2136	35	0	f	7000	1	4	0		\N	2024-04-28 16:11:12.024378+03
4564	2136	35	0	f	7000	1	4	0		\N	2024-04-28 16:11:12.025193+03
4781	2250	11	0	f	10000	1	2	0		\N	2024-06-19 14:20:40.125671+03
4834	2282	12	1000	f	5000	2	4	0		\N	2024-06-29 17:04:23.470354+03
4890	2314	12	1200	f	10800	2	3	0	От ски ресорт	\N	2024-07-09 15:48:11.950567+03
4891	2314	13	1200	f	10800	2	3	0		\N	2024-07-09 15:48:11.951631+03
4892	2315	12	0	t	9000	6	1	0		\N	2024-07-09 15:52:29.955285+03
4893	2315	31	1600	f	6400	3	6	0		\N	2024-07-09 15:52:29.956025+03
4894	2316	27	1600	f	6400	3	6	0	Назар 	\N	2024-07-09 15:56:48.308365+03
4895	2316	28	1600	f	6400	3	6	0		\N	2024-07-09 15:56:48.308956+03
4896	2316	25	1600	f	6400	3	6	0		\N	2024-07-09 15:56:48.309476+03
4982	2355	29	0	t	9000	6	1	0		\N	2024-07-20 14:35:56.022237+03
4983	2356	19	1600	f	6400	3	6	0		\N	2024-07-20 14:36:35.049185+03
4984	2357	23	1000	f	4000	3	6	0		\N	2024-07-20 14:37:17.419822+03
4985	2358	22	0	f	3000	1	2	0		\N	2024-07-20 14:37:59.877921+03
4986	2359	26	4000	t	3000	6	1	0		\N	2024-07-20 15:04:36.801716+03
4987	2359	9	0	t	9000	6	1	0		\N	2024-07-20 15:04:36.802325+03
4988	2359	10	0	t	9000	6	1	0		\N	2024-07-20 15:04:36.802831+03
5084	2392	13	0	t	11000	2	1	0		\N	2024-07-27 10:33:20.536218+03
5085	2392	12	0	t	11000	2	1	0		\N	2024-07-27 10:33:20.537456+03
5086	2392	10	0	t	11000	2	1	0		\N	2024-07-27 10:33:20.538325+03
5177	2430	20	1550	t	450	3	6	0		\N	2024-08-04 09:57:44.910958+03
5178	2431	10	0	t	9000	1	1	0		\N	2024-08-04 10:11:28.209281+03
5179	2431	13	2000	f	8000	3	6	0		\N	2024-08-04 10:11:28.210059+03
5180	2431	26	0	f	8000	1	2	0		\N	2024-08-04 10:11:28.210783+03
5181	2431	22	0	f	8000	1	2	0		\N	2024-08-04 10:11:28.211479+03
5255	2464	13	0	f	12000	2	2	0		\N	2024-08-09 13:30:47.152529+03
5256	2464	11	0	f	12000	2	2	0		\N	2024-08-09 13:30:47.153556+03
5349	2504	20	0	t	4000	1	1	0	Ренат 	\N	2024-08-16 12:37:46.157426+03
5437	2540	13	2000	f	8000	3	6	0	Ренат	\N	2024-08-20 10:05:19.488797+03
5438	2540	20	0	f	8000	1	2	0		\N	2024-08-20 10:05:19.48998+03
5439	2540	18	0	f	8000	1	2	0		\N	2024-08-20 10:05:19.490552+03
5440	2540	22	0	t	7000	2	1	0		\N	2024-08-20 10:05:19.491176+03
5441	2540	9	0	t	9000	2	1	0		\N	2024-08-20 10:05:19.491749+03
5442	2541	30	0	t	9000	2	1	0		\N	2024-08-20 10:07:03.198333+03
5532	2577	33	0	f	8000	1	2	0		\N	2024-08-24 15:44:05.718075+03
5533	2577	10	2000	f	8000	3	6	0	Ренат	\N	2024-08-24 15:44:05.719162+03
5534	2578	13	0	f	10000	1	2	0		\N	2024-08-24 15:47:22.286095+03
5535	2578	11	0	t	9000	1	1	0		\N	2024-08-24 15:47:22.286891+03
5536	2579	20	0	f	8000	1	1	0		\N	2024-08-24 15:48:00.801309+03
5591	2613	18	0	f	3000	1	2	0	Эльбрус 	\N	2024-08-27 17:37:59.456609+03
5592	2613	32	0	f	3000	1	2	0		\N	2024-08-27 17:37:59.457895+03
5640	2637	20	0	f	3000	1	2	0		\N	2024-08-31 11:57:22.685502+03
5688	2663	22	0	f	3000	1	2	0		\N	2024-09-09 14:30:27.3044+03
5689	2663	33	0	f	3000	1	2	0		\N	2024-09-09 14:30:27.30531+03
5742	2684	9	0	f	12000	4	1	0		\N	2024-09-13 11:34:01.967223+03
5743	2684	11	0	f	12000	4	1	0		\N	2024-09-13 11:34:01.968057+03
5744	2684	12	0	f	12000	4	1	0		\N	2024-09-13 11:34:01.968694+03
5745	2684	13	0	f	12000	4	1	0		\N	2024-09-13 11:34:01.96936+03
5782	2701	19	0	f	10000	1	2	0		\N	2024-09-17 14:12:57.839237+03
3343	1596	5	0	f	5000	4	5	0		\N	\N
3435	1639	12	0	f	4000	2	3	1000		\N	\N
3436	1639	13	0	f	4000	2	3	1000		\N	\N
3437	1639	9	500	f	3500	2	3	1000	500 за отзыв	\N	\N
3438	1639	10	0	f	4000	2	3	1000		\N	\N
3521	1682	8	2000	f	5000	1	2	0		\N	\N
3522	1682	13	1000	t	5000	2	1	0		\N	\N
3524	1682	9	2000	f	5000	2	1	0		\N	\N
3668	1735	39	2000	t	2000	1	1	0		\N	\N
3669	1735	4	2000	f	3000	1	1	0		\N	\N
3758	1772	9	1000	t	5000	1	1	0		\N	\N
3759	1772	12	1000	t	5000	1	1	0		\N	\N
3834	1803	39	2000	f	3000	2	1	0	Оплатили сертификатом	\N	\N
3927	1839	50	1000	t	4000	2	1	0		\N	\N
3928	1839	51	1000	t	4000	2	1	0		\N	\N
4659	2182	13	0	t	11000	6	1	0		\N	2024-05-13 16:28:42.47917+03
4660	2182	11	0	t	11000	6	1	0		\N	2024-05-13 16:28:42.48004+03
4710	2217	25	0	t	9000	6	1	0		\N	2024-06-10 10:49:21.732524+03
4711	2217	31	0	f	10000	6	1	0		\N	2024-06-10 10:49:21.738466+03
4782	2251	12	0	t	11000	6	1	0		\N	2024-06-19 17:25:33.919435+03
4018	1879	12	0	f	10000	1	1	0		\N	\N
4105	1920	39	0	t	8000	2	1	0		\N	2024-02-20 12:50:28.674006+03
4232	1967	39	1000	t	3000	1	1	0		\N	2024-02-25 15:23:24.033348+03
4233	1968	48	0	f	9000	2	2	0		\N	2024-02-25 15:25:20.716488+03
4234	1968	49	0	f	9000	2	2	0		\N	2024-02-25 15:25:20.717278+03
4235	1969	39	0	t	4000	1	1	0		\N	2024-02-25 15:41:40.849408+03
4236	1969	50	0	t	4000	1	1	0		\N	2024-02-25 15:41:40.850158+03
4237	1970	39	0	t	4000	1	1	0		\N	2024-02-25 15:42:17.855599+03
4238	1971	39	0	t	6000	1	1	0		\N	2024-02-25 15:46:07.79944+03
4239	1971	48	0	t	6000	1	1	0		\N	2024-02-25 15:46:07.799871+03
4305	2004	42	0	t	4000	1	1	0		\N	2024-03-03 17:22:41.790135+03
4306	2004	49	0	f	5000	2	2	0		\N	2024-03-03 17:22:41.791267+03
4307	2005	41	1000	t	7000	2	1	0		\N	2024-03-03 17:26:59.817046+03
4308	2005	48	1000	t	7000	2	1	0		\N	2024-03-03 17:26:59.817678+03
4309	2006	49	2000	t	6000	1	1	0		\N	2024-03-03 17:28:02.131941+03
4310	2007	48	2000	f	7000	2	1	0		\N	2024-03-03 17:30:07.448098+03
4311	2007	42	2000	f	7000	2	1	0		\N	2024-03-03 17:30:07.448765+03
4397	2042	50	0	t	4000	1	1	0		\N	2024-03-10 11:21:25.049462+03
4461	2074	13	1000	t	3000	1	1	0		\N	2024-03-19 14:51:50.254567+03
4462	2075	10	0	f	10000	4	5	0		\N	2024-03-19 14:57:32.895671+03
4463	2075	11	0	t	9000	1	1	0		\N	2024-03-19 14:57:32.898592+03
4464	2075	13	0	t	9000	2	1	0		\N	2024-03-19 14:57:32.899368+03
3523	1682	8	2000	f	5000	1	1	0		\N	\N
4019	1879	53	5000	t	1000	1	1	0		\N	\N
4523	2108	13	1000	t	8000	4	1	0		\N	2024-04-01 17:28:34.276501+03
4565	2137	12	0	t	9000	4	1	0	Аминчик	\N	2024-04-29 17:09:14.211226+03
4566	2137	11	0	f	10000	1	2	0	Аминчик	\N	2024-04-29 17:09:14.212368+03
4783	2252	34	0	f	3000	2	2	0		\N	2024-06-19 17:30:11.424114+03
4835	2283	18	0	f	3000	1	2	0		\N	2024-06-29 17:27:34.020729+03
4836	2283	23	0	f	3000	1	2	0		\N	2024-06-29 17:27:34.021892+03
4897	2317	12	0	f	4000	6	2	0	Назар	\N	2024-07-09 17:17:00.632544+03
4898	2317	13	0	f	4000	6	2	0		\N	2024-07-09 17:17:00.633498+03
4899	2318	28	0	f	3000	6	2	0		\N	2024-07-09 17:17:48.873424+03
4900	2319	11	0	t	9000	6	1	0		\N	2024-07-09 17:44:44.167424+03
4989	2360	31	1000	f	4000	6	6	0		\N	2024-07-20 15:12:08.415552+03
5087	2393	32	0	f	3000	2	2	0		\N	2024-07-27 10:59:26.371653+03
5088	2393	28	0	f	3000	2	2	0		\N	2024-07-27 10:59:26.372454+03
5182	2432	25	0	f	5000	1	2	0		\N	2024-08-04 12:12:38.634094+03
5183	2432	32	0	f	5000	1	2	0		\N	2024-08-04 12:12:38.635209+03
5184	2432	20	0	t	4000	2	1	0		\N	2024-08-04 12:12:38.635701+03
5257	2465	25	0	t	4000	1	1	0		\N	2024-08-09 17:18:59.895278+03
5258	2465	31	0	t	4000	1	1	0		\N	2024-08-09 17:18:59.896406+03
5265	2468	31	0	f	5000	1	2	0		\N	2024-08-09 17:56:14.373418+03
5266	2468	10	0	f	6000	1	2	0		\N	2024-08-09 17:56:14.373985+03
5350	2505	28	0	f	3000	1	2	0		\N	2024-08-16 13:48:19.902322+03
5351	2506	10	0	t	9000	6	1	0		\N	2024-08-16 14:10:58.770457+03
5352	2506	13	0	f	10000	1	2	0		\N	2024-08-16 14:10:58.771232+03
5353	2506	23	0	f	8000	6	2	0		\N	2024-08-16 14:10:58.77195+03
5354	2507	9	0	t	11000	6	2	0		\N	2024-08-16 14:23:01.400978+03
5355	2507	11	0	f	12000	6	2	0		\N	2024-08-16 14:23:01.402323+03
5443	2542	16	0	f	3000	2	2	0		\N	2024-08-20 12:53:27.420574+03
5537	2580	28	0	f	5000	1	2	0		\N	2024-08-24 17:24:59.13806+03
5538	2580	31	0	f	5000	1	2	0		\N	2024-08-24 17:24:59.141554+03
5593	2614	9	0	f	4000	1	2	0	Ренат	\N	2024-08-28 12:59:54.120198+03
5594	2614	13	0	f	4000	1	2	0		\N	2024-08-28 12:59:54.121599+03
5595	2614	10	0	f	4000	6	2	0		\N	2024-08-28 12:59:54.122291+03
5641	2638	31	0	f	3000	6	2	0		\N	2024-08-31 14:53:24.36202+03
5690	2664	23	0	f	3000	1	2	0		\N	2024-09-09 16:53:48.061902+03
5746	2685	22	0	t	7000	1	1	0		\N	2024-09-14 10:15:58.767616+03
5747	2685	32	0	t	7000	1	1	0		\N	2024-09-14 10:15:58.770929+03
5748	2685	18	0	t	7000	1	1	0		\N	2024-09-14 10:15:58.773893+03
5749	2685	30	1600	f	6400	3	3	0	О Аллюра 	\N	2024-09-14 10:15:58.775179+03
5750	2685	23	0	f	8000	6	2	0		\N	2024-09-14 10:15:58.775915+03
5751	2685	21	0	f	8000	6	2	0		\N	2024-09-14 10:15:58.776651+03
5783	2701	21	0	f	10000	1	2	0		\N	2024-09-17 14:12:57.840267+03
5784	2701	13	0	t	11000	6	1	0		\N	2024-09-17 14:12:57.840986+03
5811	2715	13	0	t	9000	6	2	0		\N	2024-09-23 14:07:14.583812+03
5812	2715	11	0	t	9000	1	1	0		\N	2024-09-23 14:07:14.585181+03
5832	2728	28	0	f	3000	6	2	0		\N	2024-09-28 15:00:14.872367+03
5833	2728	31	0	f	3000	6	2	0		\N	2024-09-28 15:00:14.873306+03
5834	2728	22	0	f	3000	1	2	0		\N	2024-09-28 15:00:14.873826+03
5835	2728	9	0	f	4000	1	2	0		\N	2024-09-28 15:00:14.874425+03
5858	2738	9	2000	f	4000	6	2	0		\N	2024-09-29 15:22:10.242289+03
5859	2738	11	0	t	5000	1	2	0		\N	2024-09-29 15:22:10.243423+03
5874	2747	9	2000	t	9000	1	1	0	С инструктором 	\N	2024-10-04 12:10:49.983764+03
5875	2747	13	0	f	12000	1	2	0		\N	2024-10-04 12:10:49.985016+03
5891	2755	19	2000	f	8000	1	2	0		\N	2024-10-06 14:27:56.408022+03
3345	1598	1	500	f	4500	1	4	0	500 это откат	\N	\N
3439	1640	12	1000	t	8000	2	1	0		\N	\N
3440	1640	8	1000	f	9000	2	1	0		\N	\N
3441	1640	9	1000	f	9000	2	1	0		\N	\N
3525	1683	13	2800	f	7200	1	4	0	С сайта	\N	\N
3526	1683	9	0	t	9000	1	1	0		\N	\N
3527	1684	39	0	t	8000	1	1	0		\N	\N
3528	1684	40	0	f	9000	1	1	0		\N	\N
3529	1684	4	0	f	9000	1	1	0		\N	\N
3530	1684	3	2000	t	6000	2	1	0		\N	\N
3531	1684	1	2000	f	7000	2	1	0		\N	\N
3532	1685	39	0	t	8000	1	1	0		\N	\N
3533	1685	40	0	f	9000	1	1	0		\N	\N
3534	1685	4	0	f	9000	1	1	0		\N	\N
3535	1685	3	2000	t	6000	2	1	0		\N	\N
3536	1685	1	2000	f	7000	2	1	0		\N	\N
3670	1736	1	1000	t	4000	2	1	0		\N	\N
3671	1737	12	0	t	9000	1	1	0		\N	\N
3672	1737	13	0	t	9000	2	1	0		\N	\N
3760	1773	1	0	t	5000	1	1	0		\N	\N
3761	1773	3	0	t	5000	1	1	0		\N	\N
3762	1773	39	0	t	5000	2	1	0		\N	\N
3763	1773	4	0	t	5000	2	1	0		\N	\N
3835	1804	13	1000	t	5000	1	1	0		\N	\N
3836	1804	9	1000	t	5000	1	1	0		\N	\N
3837	1805	4	0	t	5000	1	1	0		\N	\N
3838	1805	39	0	t	5000	1	1	0		\N	\N
3839	1806	1	1000	f	8000	2	2	0		\N	\N
3840	1806	39	1000	f	8000	2	2	0		\N	\N
4661	2183	23	2000	t	5000	6	1	0		\N	2024-05-14 15:10:57.230134+03
4712	2218	12	1000	f	9000	4	3	0	От Аллюра оба	\N	2024-06-11 15:49:45.850157+03
4713	2218	13	1000	f	9000	4	3	0		\N	2024-06-11 15:49:45.851595+03
4714	2219	25	800	f	7200	4	4	0	От Аллюра оба	\N	2024-06-11 15:51:13.27575+03
4715	2219	31	800	f	7200	4	4	0		\N	2024-06-11 15:51:13.276856+03
3942	1843	12	1000	f	4000	2	2	0		\N	\N
4784	2253	13	0	t	11000	6	1	0		\N	2024-06-20 10:12:55.141265+03
4785	2253	12	6000	f	6000	6	1	0	С инструктором -50%	\N	2024-06-20 10:12:55.142419+03
4837	2284	22	2000	t	7000	1	1	0		\N	2024-06-30 10:29:12.971314+03
4838	2284	11	0	t	11000	6	1	0		\N	2024-06-30 10:29:12.97402+03
4839	2284	12	1000	t	10000	1	1	0		\N	2024-06-30 10:29:12.974681+03
4907	2322	28	0	f	3000	6	2	0	Назар	\N	2024-07-10 10:38:36.682772+03
4990	2361	26	0	f	5000	1	2	0		\N	2024-07-20 16:18:52.172699+03
4020	1880	39	1000	t	4000	2	1	0		\N	\N
4021	1880	48	1000	t	4000	2	1	0		\N	\N
4022	1880	50	1000	f	5000	2	1	0		\N	\N
4023	1880	51	1000	f	5000	2	1	0		\N	\N
4991	2362	27	0	f	3000	2	2	0		\N	2024-07-20 16:19:21.790149+03
5185	2433	28	0	f	3000	2	1	0		\N	2024-08-04 13:11:31.825894+03
5186	2433	31	0	f	3000	2	1	0		\N	2024-08-04 13:11:31.827014+03
3939	1842	48	1000	t	5000	2	1	0		0	\N
4106	1921	39	0	t	8000	1	1	0		\N	2024-02-20 14:48:49.476465+03
4107	1921	48	0	t	8000	2	1	0		\N	2024-02-20 14:48:49.480488+03
4108	1921	51	0	t	8000	2	1	0		\N	2024-02-20 14:48:49.481912+03
4240	1972	9	0	t	9000	1	1	0		\N	2024-02-25 16:39:41.922901+03
5187	2434	31	1000	f	4000	3	6	0		\N	2024-08-04 13:45:20.011942+03
5259	2466	32	0	f	8000	1	2	0		\N	2024-08-09 17:26:57.054894+03
4398	2043	48	0	t	6000	1	1	0		\N	2024-03-10 13:23:15.705165+03
4399	2043	42	0	t	6000	1	1	0		\N	2024-03-10 13:23:15.706751+03
4465	2076	11	0	t	9000	2	1	0		\N	2024-03-20 15:19:25.696345+03
4466	2077	11	0	t	9000	1	1	0		\N	2024-03-20 15:20:23.827687+03
4467	2077	13	0	t	9000	1	1	0		\N	2024-03-20 15:20:23.83052+03
3938	1842	48	1000	t	4000	2	1	0		0	\N
3937	1842	51	1000	t	4000	2	1	0		0	\N
3936	1842	50	1000	t	4000	2	1	0		0	\N
4524	2109	12	1000	t	8000	1	1	0		\N	2024-04-02 12:05:37.249211+03
4525	2110	11	0	t	9000	4	1	0		\N	2024-04-02 12:35:02.681428+03
4567	2138	35	3000	f	4000	1	1	0	Амир 	\N	2024-04-29 17:47:45.615447+03
4568	2138	35	3000	f	4000	1	1	0		\N	2024-04-29 17:47:45.616648+03
4569	2138	35	2500	f	4500	1	1	0		\N	2024-04-29 17:47:45.61716+03
4570	2138	35	2500	f	4500	4	1	0		\N	2024-04-29 17:47:45.61762+03
4571	2138	35	3000	f	4000	4	1	0		\N	2024-04-29 17:47:45.618127+03
4572	2138	35	3000	f	4000	4	1	0		\N	2024-04-29 17:47:45.61859+03
4573	2139	12	1000	f	6000	1	1	0	Амир	\N	2024-04-29 17:51:45.488278+03
4574	2139	13	2000	f	5000	1	1	0		\N	2024-04-29 17:51:45.489055+03
4575	2139	11	2000	f	5000	4	1	0		\N	2024-04-29 17:51:45.489717+03
4576	2139	11	1000	f	6000	4	1	0		\N	2024-04-29 17:51:45.490353+03
5260	2466	10	0	t	9000	2	1	0		\N	2024-08-09 17:26:57.056065+03
5261	2466	28	0	t	7000	2	2	0		\N	2024-08-09 17:26:57.056815+03
5262	2466	20	0	t	7000	2	2	0		\N	2024-08-09 17:26:57.057541+03
5263	2466	23	0	t	7000	1	2	0		\N	2024-08-09 17:26:57.058275+03
5264	2467	13	0	f	6000	1	2	0		\N	2024-08-09 17:48:57.928799+03
5356	2508	30	0	f	8000	6	1	0		\N	2024-08-16 14:40:14.708502+03
5444	2543	20	0	f	5000	1	2	0		\N	2024-08-20 13:27:00.365576+03
5445	2543	25	0	f	5000	1	2	0		\N	2024-08-20 13:27:00.366821+03
5446	2543	28	0	f	5000	1	2	0		\N	2024-08-20 13:27:00.36747+03
5447	2543	31	0	f	5000	1	2	0		\N	2024-08-20 13:27:00.368886+03
5448	2543	33	0	f	5000	1	2	0		\N	2024-08-20 13:27:00.370966+03
5449	2544	18	0	f	3000	6	2	0		\N	2024-08-20 13:42:29.947134+03
5450	2544	22	0	f	3000	1	2	0		\N	2024-08-20 13:42:29.947974+03
5451	2544	26	0	f	3000	1	2	0		\N	2024-08-20 13:42:29.94862+03
5539	2581	30	0	t	4000	6	1	0		\N	2024-08-25 10:13:49.822897+03
5596	2615	20	2000	f	8000	3	6	0		\N	2024-08-28 13:02:16.32096+03
5597	2615	30	1000	f	9000	6	3	0	От премиум вилладж, от Камилла, ей откат	\N	2024-08-28 13:02:16.323818+03
5598	2616	20	0	f	3000	1	2	0		\N	2024-08-28 13:56:26.685438+03
5599	2616	16	1500	f	1500	1	2	0		\N	2024-08-28 13:56:26.685982+03
5642	2639	18	0	f	3000	1	2	0		\N	2024-08-31 14:58:26.86738+03
5643	2639	25	0	f	3000	1	2	0		\N	2024-08-31 14:58:26.868511+03
3346	1599	39	0	f	4000	1	2	0		\N	\N
3442	1641	39	1000	f	5000	1	4	0		\N	\N
3443	1642	4	1000	t	4000	1	1	0		\N	\N
3444	1643	12	1000	t	5000	1	1	0		\N	\N
3445	1643	9	1000	f	6000	1	1	0		\N	\N
3537	1686	12	2000	f	8000	1	4	0		\N	\N
3538	1686	10	2000	f	8000	1	4	0		\N	\N
3539	1686	8	0	f	10000	1	2	0		\N	\N
3540	1687	4	1000	t	4000	1	1	0		\N	\N
3541	1687	5	1000	f	5000	1	1	0		\N	\N
3542	1687	39	1000	f	5000	1	1	0		\N	\N
3543	1687	40	1000	f	5000	1	1	0		\N	\N
3544	1687	2	3500	f	2500	1	1	0	Половина цены. С инструктором 	\N	\N
3545	1688	39	0	f	9000	2	2	0		\N	\N
3546	1688	40	0	f	9000	2	2	0		\N	\N
3547	1688	41	0	f	9000	2	2	0		\N	\N
3673	1738	1	500	f	8500	4	1	0		\N	\N
3674	1738	3	500	f	8500	4	1	0		\N	\N
3675	1738	4	500	f	8500	4	1	0		\N	\N
3676	1738	5	500	f	8500	4	1	0		\N	\N
3677	1738	39	500	f	8500	4	1	0		\N	\N
3678	1738	40	500	f	8500	4	1	0		\N	\N
3679	1738	41	500	f	8500	4	1	0		\N	\N
3764	1774	12	0	t	9000	1	1	0		\N	\N
3765	1774	9	0	f	10000	1	1	0		\N	\N
3766	1774	10	0	f	10000	1	1	0		\N	\N
3841	1807	13	0	t	9000	2	1	0		\N	\N
3842	1808	9	0	f	10000	2	2	0		\N	\N
3843	1808	12	0	f	10000	2	2	0		\N	\N
3844	1808	13	0	f	10000	2	2	0		\N	\N
4662	2184	13	0	t	9000	6	1	0		\N	2024-05-15 16:46:16.153592+03
4786	2254	12	2000	f	10000	2	4	0		\N	2024-06-21 11:18:12.820627+03
4024	1881	13	1500	f	3500	2	2	0		\N	\N
4109	1922	39	0	f	6000	1	2	0		\N	2024-02-20 14:50:35.729059+03
4110	1922	40	0	f	6000	1	2	0		\N	2024-02-20 14:50:35.732495+03
4111	1922	48	0	f	6000	1	2	0		\N	2024-02-20 14:50:35.733449+03
4112	1922	50	0	f	6000	1	2	0		\N	2024-02-20 14:50:35.734188+03
4113	1922	51	0	f	6000	1	2	0		\N	2024-02-20 14:50:35.734889+03
4114	1922	5	0	f	6000	1	2	0		\N	2024-02-20 14:50:35.739354+03
4115	1923	13	1000	t	8000	2	1	0		\N	2024-02-20 14:51:45.324722+03
4116	1924	10	0	f	10000	1	1	0		\N	2024-02-20 15:11:30.633041+03
4117	1924	11	0	f	10000	1	1	0		\N	2024-02-20 15:11:30.633764+03
4118	1924	12	0	f	10000	1	1	0		\N	2024-02-20 15:11:30.634397+03
4119	1924	13	0	f	10000	1	1	0		\N	2024-02-20 15:11:30.635011+03
4120	1925	13	1000	f	6000	1	2	0		\N	2024-02-20 15:13:06.68333+03
4121	1925	10	1000	f	6000	1	2	0		\N	2024-02-20 15:13:06.683964+03
4122	1926	12	1000	t	5000	1	1	0		\N	2024-02-20 15:13:43.486297+03
4787	2254	12	4000	f	8000	2	4	0		\N	2024-06-21 11:18:12.821834+03
4840	2285	30	0	f	5000	6	1	0		\N	2024-06-30 13:52:44.83694+03
4904	2321	11	0	t	9000	1	1	0		\N	2024-07-10 10:37:54.469659+03
4905	2321	12	1000	f	9000	6	3	0	Комиссия исламу	\N	2024-07-10 10:37:54.470689+03
4127	1928	10	0	f	10000	2	2	0		\N	2024-02-20 15:21:08.779433+03
4128	1928	11	0	t	9000	2	1	0		\N	2024-02-20 15:21:08.779983+03
4129	1928	12	0	t	9000	2	1	0		\N	2024-02-20 15:21:08.780585+03
4130	1928	13	1000	t	8000	1	1	0		\N	2024-02-20 15:21:08.781191+03
4243	1973	9	1000	f	9000	2	1	0		\N	2024-02-26 14:43:14.46893+03
4314	2009	13	5000	t	4000	1	1	0	Опять на 1 технику 2 к предоплата поэтому делю	\N	2024-03-04 10:03:05.982097+03
4315	2009	13	5000	t	4000	1	1	0		\N	2024-03-04 10:03:05.983567+03
4400	2044	49	0	t	6000	1	1	0		\N	2024-03-12 13:28:49.606888+03
4401	2044	40	0	t	6000	1	1	0		\N	2024-03-12 13:28:49.608857+03
4468	2078	11	0	t	9000	2	1	0		\N	2024-03-21 13:33:09.110059+03
4469	2078	10	0	t	9000	2	1	0		\N	2024-03-21 13:33:09.112939+03
4242	1973	53	1000	f	9000	1	2	0		\N	2024-02-26 14:43:14.467993+03
4241	1973	53	2000	f	8000	1	2	0		\N	2024-02-26 14:43:14.465882+03
4526	2111	12	2000	f	5000	1	2	0		\N	2024-04-02 15:48:54.812777+03
4527	2111	13	2000	f	5000	4	2	0		\N	2024-04-02 15:48:54.814245+03
4528	2112	9	0	t	9000	1	1	0		\N	2024-04-02 15:50:23.415863+03
4577	2140	35	2000	t	7000	4	1	0		\N	2024-04-30 13:42:04.603408+03
4578	2140	35	2000	t	7000	4	1	0		\N	2024-04-30 13:42:04.606013+03
4579	2140	35	2000	t	7000	4	1	0		\N	2024-04-30 13:42:04.610528+03
4906	2321	13	1000	f	9000	6	1	0		\N	2024-07-10 10:37:54.471419+03
4992	2363	21	1000	f	4000	6	2	0		\N	2024-07-20 17:56:11.699204+03
4993	2363	26	1000	f	4000	6	2	0		\N	2024-07-20 17:56:11.700046+03
4994	2363	32	1000	f	4000	6	2	0		\N	2024-07-20 17:56:11.700618+03
4995	2364	18	0	f	3000	6	2	0		\N	2024-07-20 17:58:03.375582+03
5092	2395	9	0	t	11000	1	1	0		\N	2024-07-27 13:15:45.478059+03
5093	2395	20	2000	t	7000	1	1	0		\N	2024-07-27 13:15:45.479054+03
5094	2395	23	0	t	9000	2	1	0		\N	2024-07-27 13:15:45.47967+03
5188	2435	23	0	t	9000	1	1	0	Ренат 	\N	2024-08-04 14:07:43.269419+03
5189	2435	31	0	t	9000	1	1	0		\N	2024-08-04 14:07:43.270387+03
5190	2435	22	0	t	9000	1	1	0		\N	2024-08-04 14:07:43.271206+03
5267	2469	12	0	f	6000	6	2	0		\N	2024-08-10 12:09:24.705641+03
5268	2470	12	0	f	4000	2	2	0		\N	2024-08-10 12:12:03.580822+03
5269	2470	20	0	f	3000	1	2	0		\N	2024-08-10 12:12:03.581558+03
5357	2509	20	0	f	5000	1	2	0		\N	2024-08-16 16:25:12.32936+03
5452	2545	31	2000	f	3000	3	6	0		\N	2024-08-20 15:23:00.672966+03
5540	2582	13	0	t	9000	1	1	0		\N	2024-08-25 10:22:07.969829+03
5541	2582	12	0	f	10000	1	1	0		\N	2024-08-25 10:22:07.970867+03
5542	2582	10	2000	f	8000	3	6	0		\N	2024-08-25 10:22:07.971341+03
5600	2617	10	2000	f	8000	6	1	0	От сайта, с откатом	\N	2024-08-28 14:09:40.652055+03
5601	2617	13	0	t	9000	6	1	0		\N	2024-08-28 14:09:40.653021+03
5602	2617	20	1600	f	6400	3	3	0	От Аллюра 	\N	2024-08-28 14:09:40.653643+03
5644	2639	13	0	f	4000	1	2	0		\N	2024-08-31 14:58:26.869114+03
5691	2665	22	2000	f	8000	3	3	0	От Аллюра 	\N	2024-09-10 10:14:56.603745+03
5692	2665	30	0	f	10000	1	2	0		\N	2024-09-10 10:14:56.604755+03
5752	2686	13	0	f	4000	1	2	0	Рена 	\N	2024-09-14 12:12:55.20893+03
5785	2702	20	0	f	5000	6	1	0		\N	2024-09-18 10:17:12.840326+03
3347	1600	39	0	t	8000	1	1	0		\N	\N
3348	1600	1	0	f	9000	1	1	0		\N	\N
3349	1601	40	0	t	8000	2	1	0	Это 1 снегоход поехал за 13500	\N	\N
3350	1601	40	4500	f	4500	2	1	0		\N	\N
3446	1644	39	0	t	8000	1	1	0		\N	\N
3447	1644	40	0	f	9000	1	1	0		\N	\N
3448	1644	1	0	f	9000	1	1	0		\N	\N
3449	1645	1	2000	t	2000	1	1	0		\N	\N
3450	1645	39	2000	f	3000	1	1	0		\N	\N
3451	1645	4	2000	f	3000	1	1	0		\N	\N
3548	1689	8	1000	t	3000	1	1	0		\N	\N
3553	1692	4	1500	f	4500	2	4	0		\N	\N
3554	1692	5	1500	f	4500	2	4	0		\N	\N
3555	1693	39	2000	f	3000	1	2	0		\N	\N
3556	1693	40	2000	f	3000	1	2	0		\N	\N
3557	1693	41	2000	f	3000	1	2	0		\N	\N
3558	1693	4	2000	f	3000	1	2	0		\N	\N
3561	1695	3	0	t	8000	1	1	0		\N	\N
3562	1695	2	0	t	8000	1	1	0		\N	\N
3563	1695	39	0	t	8000	1	1	0		\N	\N
3564	1695	40	0	t	8000	1	1	0		\N	\N
3565	1695	40	0	f	9000	2	1	0		\N	\N
3767	1775	4	0	t	5000	1	1	0		\N	\N
3768	1775	3	0	t	5000	1	1	0		\N	\N
3846	1809	13	2000	f	8000	2	2	0		\N	\N
3949	1844	10	1000	t	3000	2	1	0		\N	\N
4025	1882	39	0	t	8000	1	1	0		\N	\N
4131	1929	10	1000	t	3000	1	1	0		\N	2024-02-20 16:57:55.503238+03
4132	1929	12	1000	t	3000	1	1	0		\N	2024-02-20 16:57:55.504766+03
4133	1930	48	1000	f	5000	1	2	0		\N	2024-02-20 17:30:22.329721+03
4134	1930	50	1000	f	5000	1	2	0		\N	2024-02-20 17:30:22.330501+03
4244	1974	9	1000	t	8000	1	1	0		\N	2024-02-26 14:44:44.434047+03
4245	1974	10	1000	t	8000	1	1	0		\N	2024-02-26 14:44:44.435323+03
4246	1975	48	1000	t	5000	1	1	0		\N	2024-02-26 15:28:45.562644+03
4247	1975	49	0	t	6000	1	1	0		\N	2024-02-26 15:28:45.563244+03
4248	1975	39	1000	f	6000	1	1	0		\N	2024-02-26 15:28:45.563985+03
4249	1976	42	0	t	8000	1	1	0		\N	2024-02-26 15:30:00.193201+03
4250	1977	48	0	f	6000	2	2	0		\N	2024-02-26 15:30:51.84859+03
4251	1977	49	0	f	6000	2	2	0		\N	2024-02-26 15:30:51.849098+03
4252	1977	42	0	f	6000	2	2	0		\N	2024-02-26 15:30:51.849574+03
4316	2010	10	0	t	9000	2	1	0		\N	2024-03-04 13:22:28.799739+03
4317	2010	9	0	f	10000	2	1	0	Сразу все оплатили	\N	2024-03-04 13:22:28.805643+03
4318	2010	13	0	t	9000	1	1	0		\N	2024-03-04 13:22:28.806232+03
4319	2010	11	0	t	9000	1	1	0		\N	2024-03-04 13:22:28.806874+03
4402	2045	13	1000	t	5000	2	1	0		\N	2024-03-12 15:35:44.65297+03
4470	2079	9	1000	t	5000	1	1	0		\N	2024-03-21 13:40:00.090411+03
4471	2080	11	0	f	10000	4	5	0		\N	2024-03-21 13:44:04.115337+03
4472	2080	13	7000	t	2000	1	1	0	У них 3к предоплата на 1 технику, поэтому разделил	\N	2024-03-21 13:44:04.116059+03
4473	2080	13	7000	t	2000	1	1	0		\N	2024-03-21 13:44:04.116637+03
4474	2080	13	7000	t	2000	1	1	0		\N	2024-03-21 13:44:04.117231+03
3680	1739	9	1000	t	4000	2	1	0		\N	\N
4663	2185	11	1000	f	9000	6	1	0	Скидка - откат Маше 	\N	2024-05-18 17:24:41.179134+03
3847	1810	53	2000	f	3000	1	4	0		\N	\N
3848	1810	53	2000	f	2000	1	4	0		\N	\N
3849	1810	53	2000	f	2000	1	4	0		\N	\N
4320	2010	53	0	t	6000	1	1	0		\N	2024-03-04 13:22:28.807503+03
4321	2010	53	0	t	6000	1	1	0		\N	2024-03-04 13:22:28.808134+03
4322	2010	53	3000	f	4000	1	1	0		\N	2024-03-04 13:22:28.808802+03
4475	2080	53	0	f	7000	1	1	0		\N	2024-03-21 13:44:04.117918+03
4476	2080	53	0	f	7000	1	1	0		\N	2024-03-21 13:44:04.118632+03
4529	2113	9	1000	f	9000	4	2	0		\N	2024-04-04 17:39:32.107886+03
4530	2113	12	1000	f	9000	4	2	0		\N	2024-04-04 17:39:32.109484+03
4580	2141	35	1000	f	6000	1	2	0		\N	2024-04-30 13:58:50.696895+03
4581	2141	35	1000	f	6000	1	2	0		\N	2024-04-30 13:58:50.697893+03
4718	2221	22	1600	f	6400	4	6	0		\N	2024-06-11 15:53:15.926936+03
4719	2221	26	1600	f	6400	4	6	0		\N	2024-06-11 15:53:15.928147+03
4720	2222	11	3000	t	8000	6	2	0		\N	2024-06-11 15:56:53.321203+03
4721	2222	12	3000	t	8000	6	1	0		\N	2024-06-11 15:56:53.322325+03
4722	2222	13	3000	t	8000	6	2	0		\N	2024-06-11 15:56:53.323061+03
4788	2255	29	1000	f	4000	2	6	0		\N	2024-06-21 13:04:52.484741+03
4841	2286	24	800	f	7200	1	4	0	Все 3 от ислама, ему скидка-комисия	\N	2024-06-30 16:58:15.646701+03
4842	2286	31	800	f	7200	1	4	0		\N	2024-06-30 16:58:15.647803+03
4843	2286	28	800	f	7200	1	4	0		\N	2024-06-30 16:58:15.648583+03
4911	2324	27	0	t	4000	6	1	0	Назар	\N	2024-07-10 15:18:45.685841+03
4912	2324	25	0	t	4000	1	1	0		\N	2024-07-10 15:18:45.686497+03
4913	2324	11	0	t	5000	1	1	0		\N	2024-07-10 15:18:45.687103+03
5003	2366	18	0	t	9000	1	1	0		\N	2024-07-21 10:32:38.090954+03
5004	2366	25	0	t	9000	1	1	0		\N	2024-07-21 10:32:38.091526+03
5005	2366	26	0	t	9000	1	1	0		\N	2024-07-21 10:32:38.092057+03
5006	2366	27	0	t	9000	1	1	0		\N	2024-07-21 10:32:38.092556+03
5007	2366	28	0	t	9000	1	1	0		\N	2024-07-21 10:32:38.093054+03
5008	2366	32	0	f	10000	1	1	0		\N	2024-07-21 10:32:38.093586+03
5009	2366	10	0	t	11000	6	1	0		\N	2024-07-21 10:32:38.094071+03
5095	2396	10	0	t	3000	1	1	0		\N	2024-07-27 14:18:34.330982+03
5096	2397	18	0	t	9000	2	1	0		\N	2024-07-27 15:11:34.856849+03
5097	2397	26	0	t	9000	2	1	0		\N	2024-07-27 15:11:34.857627+03
5098	2397	12	0	t	11000	2	1	0		\N	2024-07-27 15:11:34.858339+03
5191	2436	20	0	f	5000	1	2	0		\N	2024-08-04 15:06:21.729186+03
5270	2471	20	0	f	5000	1	2	0	Ренат 	\N	2024-08-10 13:05:42.744883+03
5271	2471	26	0	f	5000	1	2	0		\N	2024-08-10 13:05:42.74598+03
5272	2472	20	0	f	3000	1	2	0		\N	2024-08-10 13:07:05.556228+03
5358	2510	28	0	f	5000	1	2	0		\N	2024-08-16 16:28:23.576483+03
5359	2511	28	1000	f	4000	3	6	0		\N	2024-08-16 17:02:36.377116+03
5360	2512	22	0	f	5000	6	2	0		\N	2024-08-16 17:09:33.96995+03
5453	2546	20	0	f	5000	1	2	0		\N	2024-08-20 15:35:10.129228+03
5454	2546	22	0	f	5000	1	2	0		\N	2024-08-20 15:35:10.130527+03
3351	1602	39	0	f	5000	2	1	0		\N	\N
3352	1602	40	0	t	4000	2	1	0		\N	\N
3353	1603	12	1000	t	9000	1	1	0		\N	\N
3354	1603	13	1000	f	10000	1	1	0		\N	\N
3452	1646	1	0	t	5000	1	1	0		\N	\N
3453	1646	39	0	f	6000	1	1	0		\N	\N
3549	1690	39	0	t	8000	1	1	0		\N	\N
3550	1690	40	0	f	9000	1	1	0		\N	\N
3551	1690	41	1000	f	8000	2	3	0	С Аллюра	\N	\N
3552	1691	4	2000	f	3000	1	2	0		\N	\N
3559	1694	9	1000	f	6000	1	2	0		\N	\N
3560	1694	10	1000	f	6000	1	2	0		\N	\N
3681	1740	1	0	f	9000	1	1	0		\N	\N
3682	1741	3	2600	f	2400	2	1	0	С сайта, с комиссией	\N	\N
3683	1741	4	2600	f	2400	2	1	0	Тоже с сайта	\N	\N
3684	1741	5	2600	f	2400	2	1	0	Тоже с сайта	\N	\N
3685	1741	39	2000	f	3000	2	1	0		\N	\N
3686	1741	40	2000	f	3000	2	1	0		\N	\N
3769	1776	1	1000	f	8000	2	1	0		\N	\N
3770	1776	39	1000	f	8000	2	1	0		\N	\N
3850	1811	9	0	t	9000	2	1	0		\N	\N
3950	1845	50	1000	t	4000	1	1	0		\N	\N
4026	1883	10	0	t	9000	1	1	0		\N	\N
4027	1883	11	0	t	9000	2	1	0		\N	\N
4028	1883	13	0	t	9000	2	1	0		\N	\N
4135	1931	39	0	t	8000	2	1	0		\N	2024-02-21 14:10:18.716487+03
4253	1978	9	1000	t	8000	1	1	0		\N	2024-02-27 11:38:43.873405+03
4254	1978	10	1000	f	9000	2	1	0		\N	2024-02-27 11:38:43.875217+03
4323	2011	48	0	t	6000	1	1	0		\N	2024-03-04 15:01:52.496727+03
4324	2011	41	0	t	6000	1	1	0		\N	2024-03-04 15:01:52.498394+03
4325	2012	50	0	t	4000	2	1	0		\N	2024-03-04 15:03:18.640018+03
4403	2046	50	0	t	4000	1	1	0		\N	2024-03-12 17:01:03.639748+03
4404	2046	48	0	t	4000	1	1	0		\N	2024-03-12 17:01:03.641126+03
4405	2046	39	0	t	4000	1	1	0		\N	2024-03-12 17:01:03.641839+03
4477	2081	9	0	t	9000	2	1	0		\N	2024-03-21 16:12:36.275455+03
4531	2114	35	2500	f	2500	4	4	0		\N	2024-04-05 17:28:52.049894+03
4582	2142	10	3000	f	7000	1	2	0	Амирчи	\N	2024-04-30 14:37:50.875033+03
4664	2186	26	0	f	3000	1	2	0		\N	2024-05-19 13:41:37.11118+03
4665	2186	23	0	f	3000	1	2	0		\N	2024-05-19 13:41:37.112364+03
4666	2187	22	1000	f	9000	2	4	0		\N	2024-05-19 13:51:22.234169+03
4667	2187	10	1200	f	10800	2	4	0	Скидка - откат Маше	\N	2024-05-19 13:51:22.234925+03
4789	2256	13	0	f	6000	6	2	0		\N	2024-06-21 17:21:15.824069+03
4844	2287	27	0	t	4000	1	1	0		\N	2024-06-30 17:37:27.759413+03
4914	2325	12	0	f	6000	1	2	0		\N	2024-07-10 15:40:19.307327+03
5010	2367	22	0	f	3000	6	2	0		\N	2024-07-21 12:03:58.236649+03
5011	2367	9	0	f	4000	1	2	0		\N	2024-07-21 12:03:58.237693+03
5099	2398	11	0	f	4000	2	2	0		\N	2024-07-27 17:50:13.656904+03
5192	2437	25	0	f	3000	1	2	0		\N	2024-08-04 17:05:32.623891+03
5193	2437	26	0	f	3000	1	2	0		\N	2024-08-04 17:05:32.625144+03
5273	2473	13	0	f	4000	1	2	0		\N	2024-08-10 13:55:02.344139+03
5274	2474	27	0	t	9000	1	1	0		\N	2024-08-10 13:58:40.694604+03
5275	2474	13	0	t	11000	2	1	0		\N	2024-08-10 13:58:40.69523+03
5361	2513	31	0	f	3000	6	2	0		\N	2024-08-16 17:32:13.881912+03
5362	2513	26	0	f	3000	6	2	0		\N	2024-08-16 17:32:13.882566+03
5363	2513	33	0	f	3000	6	2	0		\N	2024-08-16 17:32:13.883059+03
5364	2513	25	0	f	3000	1	2	0		\N	2024-08-16 17:32:13.883534+03
5365	2513	31	0	f	3000	6	2	0		\N	2024-08-16 17:32:13.884057+03
5366	2513	9	0	f	4000	6	2	0		\N	2024-08-16 17:32:13.884502+03
5367	2514	25	1000	f	2000	1	2	0		\N	2024-08-16 17:39:29.599277+03
5368	2514	33	1000	f	2000	1	2	0		\N	2024-08-16 17:39:29.600085+03
5455	2547	12	0	f	12000	1	2	0		\N	2024-08-20 15:38:54.19521+03
5456	2547	28	0	f	10000	1	2	0		\N	2024-08-20 15:38:54.1966+03
5457	2548	12	0	f	10000	1	2	0		\N	2024-08-20 16:07:05.598067+03
5458	2548	31	0	f	8000	1	2	0		\N	2024-08-20 16:07:05.598766+03
5459	2548	23	0	f	8000	1	2	0		\N	2024-08-20 16:07:05.5994+03
5460	2548	30	0	t	7000	1	1	0		\N	2024-08-20 16:07:05.60004+03
5461	2548	25	3000	t	4000	2	1	0		\N	2024-08-20 16:07:05.600751+03
5462	2548	25	5000	f	3000	1	1	0		\N	2024-08-20 16:07:05.601265+03
5463	2549	9	0	f	4000	1	2	0	Ренат	\N	2024-08-20 16:31:46.610938+03
5543	2583	30	0	f	5000	6	2	0		\N	2024-08-25 11:25:32.184008+03
5545	2585	23	0	f	3000	1	2	0		\N	2024-08-25 11:35:27.057587+03
5546	2586	18	0	f	3000	6	2	0		\N	2024-08-25 11:42:19.94307+03
5603	2618	30	0	f	8000	1	2	0		\N	2024-08-28 15:09:46.337084+03
5645	2640	20	0	f	5000	6	2	0		\N	2024-08-31 15:00:55.226257+03
5646	2640	23	0	f	5000	6	2	0		\N	2024-08-31 15:00:55.227381+03
5647	2640	9	0	f	6000	6	2	0		\N	2024-08-31 15:00:55.227969+03
5648	2640	11	0	f	6000	1	2	0		\N	2024-08-31 15:00:55.228538+03
5649	2641	21	0	f	8000	6	2	0		\N	2024-08-31 15:04:49.388748+03
5650	2641	33	0	f	8000	6	2	0		\N	2024-08-31 15:04:49.389389+03
5651	2642	9	0	t	11000	1	1	0		\N	2024-08-31 15:14:38.710378+03
5652	2642	10	0	t	11000	6	1	0		\N	2024-08-31 15:14:38.711837+03
5653	2642	11	0	t	11000	6	1	0		\N	2024-08-31 15:14:38.713727+03
5654	2642	28	0	t	9000	6	1	0		\N	2024-08-31 15:14:38.714325+03
5655	2642	23	3600	f	6400	3	4	0	От Аллюра 	\N	2024-08-31 15:14:38.714981+03
5693	2666	12	0	t	9000	6	1	0	Ренат	\N	2024-09-10 12:28:53.799789+03
5694	2666	13	0	t	9000	6	1	0		\N	2024-09-10 12:28:53.800903+03
5695	2666	23	2000	f	6000	6	2	0	От чегоры	\N	2024-09-10 12:28:53.801617+03
5696	2667	18	0	t	4000	6	1	0		\N	2024-09-10 13:03:57.209214+03
5697	2667	23	0	f	5000	6	1	0		\N	2024-09-10 13:03:57.209844+03
5753	2687	13	0	f	6000	6	2	0	Ренат	\N	2024-09-14 14:02:48.787988+03
5754	2687	9	0	f	6000	6	2	0		\N	2024-09-14 14:02:48.789245+03
5786	2702	25	0	f	5000	6	1	0		\N	2024-09-18 10:17:12.841314+03
5813	2716	12	2000	t	9000	6	1	0	Сначала на белый 	\N	2024-09-25 14:35:38.597994+03
5814	2716	12	0	f	12000	6	1	0		\N	2024-09-25 14:35:38.59916+03
5815	2717	11	0	t	9000	1	1	0		\N	2024-09-25 15:01:04.53207+03
5816	2717	13	0	t	9000	6	1	0		\N	2024-09-25 15:01:04.532854+03
5836	2729	11	0	f	10000	1	2	0	Ренат	\N	2024-09-28 15:21:23.380683+03
3355	1604	1	0	f	9000	1	1	0		\N	\N
3454	1647	12	1000	t	3000	1	1	0		\N	\N
3455	1647	13	1000	f	4000	1	1	0		\N	\N
3566	1696	12	1000	t	8000	2	1	0		\N	\N
4668	2188	28	1000	f	4000	1	2	0		\N	2024-05-19 15:30:37.195603+03
4669	2188	11	2000	f	4000	1	2	0		\N	2024-05-19 15:30:37.197256+03
4670	2188	12	2000	f	4000	1	2	0		\N	2024-05-19 15:30:37.197954+03
4724	2224	12	2000	t	9000	6	1	0		\N	2024-06-12 14:40:35.22795+03
4725	2224	13	2000	f	10000	6	1	0		\N	2024-06-12 14:40:35.229111+03
3771	1777	39	0	t	5000	2	1	0		\N	\N
3772	1778	4	2000	f	3000	2	2	0		\N	\N
3773	1778	1	2000	f	3000	2	2	0		\N	\N
3774	1778	3	2000	f	3000	2	2	0		\N	\N
3775	1779	39	1000	t	4000	2	1	0		\N	\N
3776	1779	40	1000	t	4000	2	1	0		\N	\N
3777	1779	1	1000	t	4000	2	1	0		\N	\N
3778	1779	3	1000	t	4000	2	1	0		\N	\N
3851	1812	39	1500	f	4500	1	4	0	500 отдали агенту 	\N	\N
3852	1812	40	1500	f	4500	1	4	0		\N	\N
3853	1812	3	1500	f	4500	1	4	0		\N	\N
3854	1812	1	1500	f	4500	1	4	0		\N	\N
3855	1812	4	1500	f	4500	1	4	0		\N	\N
3856	1813	39	3000	f	2000	1	2	0		\N	\N
3857	1813	4	3000	f	2000	1	2	0		\N	\N
3858	1813	1	3000	f	2000	1	2	0		\N	\N
3951	1846	39	0	t	8000	2	1	0		\N	\N
3952	1846	50	0	f	9000	2	1	0		\N	\N
3953	1846	51	0	f	9000	2	1	0		\N	\N
4029	1884	48	0	t	8000	2	1	0		\N	\N
4030	1884	39	0	t	8000	1	1	0		\N	\N
4031	1885	51	2000	t	2000	1	1	0		\N	\N
4136	1932	9	1000	t	8000	1	1	0		\N	2024-02-21 14:15:27.621817+03
4137	1932	10	1000	t	8000	1	1	0		\N	2024-02-21 14:15:27.622789+03
4138	1932	11	0	t	9000	2	1	0		\N	2024-02-21 14:15:27.623446+03
4139	1932	12	1000	t	8000	2	1	0		\N	2024-02-21 14:15:27.62413+03
4255	1979	9	2000	f	5000	2	4	0	Откат дали	\N	2024-02-27 14:08:58.764708+03
4326	2013	51	0	f	5000	4	5	0		\N	2024-03-04 15:21:50.149808+03
4406	2047	9	0	t	9000	2	1	0		\N	2024-03-13 11:31:02.735887+03
4407	2047	10	0	t	9000	2	1	0		\N	2024-03-13 11:31:02.737+03
4408	2047	11	0	t	9000	2	1	0		\N	2024-03-13 11:31:02.737725+03
4409	2047	13	0	t	9000	2	1	0		\N	2024-03-13 11:31:02.738436+03
4478	2082	13	0	t	9000	2	1	0		\N	2024-03-22 13:16:13.041373+03
4532	2115	12	1000	t	8000	1	1	0		\N	2024-04-08 15:45:14.152163+03
4533	2116	9	0	f	7000	1	2	0		\N	2024-04-08 15:47:17.29497+03
4583	2143	13	0	f	10000	4	2	0		\N	2024-04-30 15:15:05.312147+03
4584	2144	35	2000	f	8000	4	2	0		\N	2024-04-30 15:48:35.286531+03
4585	2145	10	5000	f	5000	4	1	0		\N	2024-04-30 15:59:45.202343+03
4586	2145	10	4000	f	6000	4	1	0		\N	2024-04-30 15:59:45.202994+03
4587	2145	11	5000	f	5000	4	1	0		\N	2024-04-30 15:59:45.203649+03
4588	2145	11	4000	f	6000	4	1	0		\N	2024-04-30 15:59:45.204279+03
4589	2145	13	5000	f	5000	4	1	0		\N	2024-04-30 15:59:45.204845+03
4590	2145	13	4000	f	6000	4	1	0		\N	2024-04-30 15:59:45.205357+03
4591	2146	35	2000	t	7000	4	1	0		\N	2024-04-30 16:01:21.290022+03
4592	2146	35	2000	t	7000	4	1	0		\N	2024-04-30 16:01:21.290699+03
4593	2146	35	2000	f	8000	4	1	0		\N	2024-04-30 16:01:21.291344+03
4726	2225	26	0	f	10000	6	4	0	Стоило 12к отдали откат 2к	\N	2024-06-12 14:42:45.952431+03
4790	2257	12	0	f	4000	1	2	0		\N	2024-06-22 11:50:06.715094+03
4791	2257	13	0	f	4000	1	2	0		\N	2024-06-22 11:50:06.721282+03
4845	2288	18	0	t	9000	6	1	0		\N	2024-07-01 10:54:37.908827+03
4846	2288	26	2000	f	8000	1	1	0	Приехали на белые, отправил на софию по цене белого	\N	2024-07-01 10:54:37.90995+03
4847	2288	31	2000	f	8000	1	1	0		\N	2024-07-01 10:54:37.91062+03
4915	2326	25	1600	f	6400	3	6	0		\N	2024-07-10 17:15:29.99569+03
4916	2326	30	1600	f	6400	3	6	0		\N	2024-07-10 17:15:29.99659+03
4917	2326	13	0	f	10000	1	2	0		\N	2024-07-10 17:15:29.99715+03
5012	2368	9	0	t	9000	6	1	0		\N	2024-07-21 14:26:31.142638+03
5013	2368	10	1000	f	9000	6	1	0	Комиссия исламу	\N	2024-07-21 14:26:31.143747+03
5014	2368	18	0	f	8000	6	1	0		\N	2024-07-21 14:26:31.14443+03
5015	2368	25	0	t	7000	1	1	0		\N	2024-07-21 14:26:31.145083+03
5100	2399	12	0	f	4000	1	2	0		\N	2024-07-28 11:55:37.030998+03
5194	2438	12	0	t	5000	1	1	0		\N	2024-08-05 09:59:28.078071+03
5195	2438	13	0	t	5000	1	1	0		\N	2024-08-05 09:59:28.079033+03
5276	2475	10	2000	f	8000	3	6	0		\N	2024-08-10 14:01:31.942628+03
5277	2475	11	0	f	10000	2	1	0		\N	2024-08-10 14:01:31.943342+03
5278	2475	31	4000	f	4000	2	1	0	С инструктором 	\N	2024-08-10 14:01:31.944323+03
5279	2475	25	0	t	7000	1	1	0		\N	2024-08-10 14:01:31.944892+03
5280	2476	23	0	t	9000	6	1	0		\N	2024-08-10 14:03:52.863224+03
5281	2476	27	0	f	10000	1	1	0		\N	2024-08-10 14:03:52.863869+03
5369	2515	13	2000	f	8000	3	6	0		\N	2024-08-17 10:12:13.429388+03
5370	2515	23	0	t	7000	1	2	0		\N	2024-08-17 10:12:13.430264+03
5371	2515	31	0	t	7000	1	1	0		\N	2024-08-17 10:12:13.430903+03
5372	2515	33	0	t	7000	6	1	0		\N	2024-08-17 10:12:13.431482+03
5373	2515	28	4000	f	4000	1	2	0		\N	2024-08-17 10:12:13.432053+03
5464	2550	22	2000	f	6000	1	4	0		\N	2024-08-20 17:13:04.477986+03
5465	2550	18	2000	f	6000	1	4	0		\N	2024-08-20 17:13:04.478863+03
5466	2550	20	2000	f	6000	1	4	0		\N	2024-08-20 17:13:04.479591+03
5467	2551	32	1000	f	4000	3	6	0		\N	2024-08-20 17:13:43.325871+03
5544	2584	23	0	f	3000	1	2	0		\N	2024-08-25 11:34:49.153435+03
5547	2587	31	0	f	3000	1	2	0		\N	2024-08-25 11:50:26.242819+03
5548	2587	25	0	f	3000	1	2	0		\N	2024-08-25 11:50:26.243634+03
5549	2588	30	0	f	5000	1	2	0		\N	2024-08-25 12:23:49.577894+03
5604	2619	12	0	f	6000	1	2	0		\N	2024-08-28 15:10:33.851189+03
5605	2619	32	0	f	5000	6	2	0		\N	2024-08-28 15:10:33.852488+03
5656	2643	31	0	f	5000	1	2	0	Ренат 	\N	2024-08-31 15:34:55.98292+03
5657	2644	31	0	f	3000	1	2	0		\N	2024-08-31 15:43:22.324727+03
5658	2645	23	0	f	3000	1	2	0		\N	2024-08-31 15:59:39.116418+03
5698	2668	9	0	f	6000	6	2	0		\N	2024-09-10 14:14:33.879621+03
3356	1605	39	1000	f	6000	2	4	0	1000 это откат	\N	\N
3357	1606	39	1000	f	8000	1	2	0		\N	\N
3358	1606	4	1000	f	8000	1	2	0		\N	\N
3359	1607	1	500	f	4500	1	4	0	500 это Динисламу откат	\N	\N
3360	1607	39	500	f	4500	1	4	0		\N	\N
3361	1608	39	0	t	4000	1	1	0		\N	\N
3362	1608	40	0	f	5000	1	1	0		\N	\N
3363	1608	41	0	f	5000	1	2	0		\N	\N
3364	1608	4	0	f	5000	1	2	0		\N	\N
3567	1697	8	1500	f	5500	1	2	0		\N	\N
3568	1697	9	1500	f	5500	1	2	0		\N	\N
3570	1697	13	1500	f	5500	1	2	0		\N	\N
4671	2189	12	0	t	5000	6	1	0		\N	2024-05-22 14:39:21.309961+03
3692	1743	9	0	f	10000	2	2	0		\N	\N
3693	1743	10	1000	f	9000	2	1	0		\N	\N
3694	1743	11	1000	t	8000	1	1	0		\N	\N
3695	1743	12	1000	f	9000	1	1	0		\N	\N
3696	1743	13	1000	f	9000	1	1	0		\N	\N
3779	1780	1	0	t	5000	1	1	0		\N	\N
4727	2226	22	1000	f	2000	6	2	0		\N	2024-06-12 17:45:50.905657+03
3863	1816	3	1500	t	3500	1	1	0		\N	\N
3954	1847	48	0	t	8000	1	1	0		\N	\N
3955	1847	49	0	t	8000	1	1	0		\N	\N
3956	1847	39	0	t	8000	1	1	0		\N	\N
3957	1847	40	0	t	8000	1	1	0		\N	\N
3958	1847	51	0	t	8000	1	1	0		\N	\N
3959	1848	51	2000	f	3000	1	2	0		\N	\N
4728	2227	25	1000	f	2000	1	2	0		\N	2024-06-12 17:46:40.954573+03
4729	2227	32	0	f	3000	6	2	0		\N	2024-06-12 17:46:40.955279+03
4792	2258	12	0	f	10000	1	2	0		\N	2024-06-22 14:24:41.879697+03
4793	2258	21	0	f	8000	1	2	0		\N	2024-06-22 14:24:41.882667+03
4794	2258	13	0	t	9000	1	1	0		\N	2024-06-22 14:24:41.88336+03
4032	1886	48	1000	f	8000	1	2	0		\N	\N
4033	1886	50	1000	f	8000	1	2	0		\N	\N
4034	1887	12	5000	t	4000	1	1	0		\N	\N
4035	1887	12	5000	t	4000	1	1	0		\N	\N
4795	2258	25	0	t	7000	1	1	0		\N	2024-06-22 14:24:41.88403+03
4796	2258	30	0	t	7000	6	1	0		\N	2024-06-22 14:24:41.88476+03
4797	2259	21	0	f	10000	2	1	0		\N	2024-06-22 14:27:52.556413+03
4798	2259	21	5000	f	5000	2	1	0	Взяли 2 квадрика за 30к	\N	2024-06-22 14:27:52.557603+03
4140	1933	48	0	t	8000	1	1	0		\N	2024-02-21 17:57:54.739862+03
4141	1933	49	0	f	9000	1	1	0		\N	2024-02-21 17:57:54.741622+03
4142	1933	39	0	t	8000	2	1	0		\N	2024-02-21 17:57:54.742931+03
4143	1933	40	0	t	8000	2	1	0		\N	2024-02-21 17:57:54.744302+03
4144	1933	50	0	f	9000	2	1	0		\N	2024-02-21 17:57:54.745154+03
4145	1933	51	0	t	8000	2	1	0		\N	2024-02-21 17:57:54.745908+03
4256	1980	9	1000	t	3000	1	1	0		\N	2024-02-27 16:03:21.571552+03
4257	1980	10	1000	t	3000	1	1	0		\N	2024-02-27 16:03:21.572661+03
4258	1980	12	1000	t	3000	1	1	0		\N	2024-02-27 16:03:21.573363+03
4259	1980	13	1000	t	3000	1	1	0		\N	2024-02-27 16:03:21.574054+03
4260	1980	53	2000	f	3000	2	1	0		\N	2024-02-27 16:03:21.574777+03
4799	2259	28	0	f	10000	2	1	0		\N	2024-06-22 14:27:52.558028+03
4800	2259	28	5000	f	5000	2	1	0		\N	2024-06-22 14:27:52.558411+03
4848	2289	13	2000	f	8000	3	6	0		\N	2024-07-01 16:38:32.360844+03
4331	2015	9	0	t	9000	1	3	0		\N	2024-03-05 12:27:52.104521+03
4332	2015	10	0	t	9000	1	3	0		\N	2024-03-05 12:27:52.105339+03
4333	2015	11	0	t	9000	2	1	0		\N	2024-03-05 12:27:52.106076+03
4334	2015	13	0	t	9000	2	1	0		\N	2024-03-05 12:27:52.10666+03
4410	2048	42	0	t	6000	1	1	0		\N	2024-03-13 12:46:05.679301+03
4479	2083	13	0	f	10000	4	5	0		\N	2024-03-23 14:17:34.386588+03
3456	1648	8	1000	t	4000	2	1	0		0	\N
3569	1697	8	1500	f	5500	1	2	0		\N	\N
4534	2117	12	0	t	9000	2	1	0		\N	2024-04-09 14:22:24.899243+03
4594	2147	35	2000	t	7000	4	1	0		\N	2024-04-30 16:31:20.328904+03
4595	2147	35	2000	t	7000	4	1	0		\N	2024-04-30 16:31:20.330122+03
4596	2147	35	2000	t	7000	2	1	0		\N	2024-04-30 16:31:20.330745+03
5016	2369	25	0	t	9000	2	1	0		\N	2024-07-22 14:02:46.830187+03
5017	2369	18	0	t	9000	2	1	0		\N	2024-07-22 14:02:46.831435+03
5018	2369	9	7000	f	5000	1	4	0		\N	2024-07-22 14:02:46.832045+03
5019	2369	10	7000	f	5000	1	4	0		\N	2024-07-22 14:02:46.832646+03
5020	2370	28	0	t	7000	6	1	0		\N	2024-07-22 14:58:52.692693+03
5021	2370	19	1600	f	6400	3	6	0		\N	2024-07-22 14:58:52.693426+03
5022	2370	27	1600	f	6400	3	6	0		\N	2024-07-22 14:58:52.694067+03
5023	2370	32	0	t	7000	1	1	0		\N	2024-07-22 14:58:52.694676+03
5024	2370	26	0	t	7000	1	1	0		\N	2024-07-22 14:58:52.695277+03
5101	2400	18	0	t	7000	2	1	0		\N	2024-07-28 14:03:14.943061+03
5102	2400	9	0	t	9000	2	1	0		\N	2024-07-28 14:03:14.944426+03
5111	2404	28	0	t	9000	2	1	0		\N	2024-07-28 14:59:06.162739+03
5112	2404	28	8000	f	2000	2	1	0	Поехали за 12	\N	2024-07-28 14:59:06.163538+03
5113	2404	32	0	t	9000	2	1	0		\N	2024-07-28 14:59:06.164277+03
5114	2404	32	8000	f	2000	2	1	0	Поехали за 12	\N	2024-07-28 14:59:06.16499+03
5196	2439	31	0	f	10000	2	2	0		\N	2024-08-05 15:14:31.955904+03
5197	2439	23	5000	f	5000	1	4	0	От Самата	\N	2024-08-05 15:14:31.957306+03
5282	2477	19	0	f	3000	1	2	0		\N	2024-08-10 15:24:23.470123+03
5283	2477	20	0	f	3000	1	2	0		\N	2024-08-10 15:24:23.471064+03
5284	2477	28	0	f	3000	2	2	0		\N	2024-08-10 15:24:23.47165+03
5285	2477	32	0	f	3000	2	2	0		\N	2024-08-10 15:24:23.472232+03
5374	2516	23	2000	f	1000	1	2	0		\N	2024-08-17 11:07:38.70331+03
5468	2552	22	0	t	4000	2	1	0		\N	2024-08-21 10:16:40.099062+03
5550	2589	18	0	f	3000	1	2	0		\N	2024-08-25 13:17:02.999508+03
5606	2620	9	0	f	6000	1	2	0		\N	2024-08-28 16:56:36.308264+03
5607	2620	12	0	f	6000	6	2	0		\N	2024-08-28 16:56:36.309653+03
5659	2646	23	0	f	3000	6	2	0		\N	2024-08-31 16:41:28.355593+03
5660	2647	30	0	f	3000	1	2	0		\N	2024-08-31 17:11:39.312406+03
5661	2647	31	0	f	3000	1	2	0		\N	2024-08-31 17:11:39.314012+03
5699	2669	16	0	f	3000	1	2	0		\N	2024-09-10 15:23:25.472919+03
5755	2688	13	0	t	11000	6	1	0		\N	2024-09-14 14:29:30.652412+03
3365	1609	39	1000	f	3000	2	2	0		\N	\N
3366	1609	4	1000	f	3000	2	2	0		\N	\N
3367	1609	1	1000	f	3000	1	2	0		\N	\N
3457	1649	12	1000	t	8000	1	1	0		\N	\N
3461	1651	1	2000	f	3000	2	2	0		\N	\N
3462	1652	39	0	f	9000	1	2	0		\N	\N
3463	1653	1	2000	t	2000	2	1	0		\N	\N
3571	1698	39	1000	f	5000	1	4	0		\N	\N
3572	1698	40	1000	f	5000	1	4	0		\N	\N
3573	1698	41	1000	f	5000	1	4	0		\N	\N
3574	1698	4	1000	f	5000	1	4	0		\N	\N
3575	1698	5	1000	f	5000	1	4	0		\N	\N
3697	1744	1	0	t	8000	2	1	0		\N	\N
3698	1744	4	0	t	8000	1	1	0		\N	\N
3699	1744	3	0	t	8000	1	1	0		\N	\N
3700	1744	39	0	f	9000	1	1	0		\N	\N
3701	1744	40	0	f	9000	1	1	0		\N	\N
3860	1815	39	0	t	8000	1	1	0		\N	\N
3861	1815	4	0	t	8000	1	1	0		\N	\N
3862	1815	1	0	t	8000	1	1	0		\N	\N
3965	1849	12	1500	f	5500	1	4	0	Откат дали	\N	\N
3966	1849	10	1500	f	5500	1	4	0	Откат дали	\N	\N
3967	1850	10	0	t	9000	1	1	0		\N	\N
3968	1850	12	0	f	10000	2	1	0		\N	\N
3969	1851	49	1000	f	4000	1	2	0		\N	\N
4036	1856	3	0	t	8000	2	1	0		0	2024-02-16 20:28:19.699032+03
4146	1934	10	1000	t	5000	2	1	0		\N	2024-02-22 11:16:46.703583+03
4261	1981	48	0	f	9000	2	4	0	Аллюр	\N	2024-02-27 16:59:22.051345+03
4411	2049	9	0	t	9000	1	1	0		\N	2024-03-13 14:27:14.458278+03
4412	2049	11	0	t	9000	1	1	0		\N	2024-03-13 14:27:14.460023+03
4413	2049	10	1000	t	8000	1	1	0		\N	2024-03-13 14:27:14.460621+03
4414	2049	13	1000	t	8000	2	1	0		\N	2024-03-13 14:27:14.461185+03
4480	2084	9	1000	t	8000	2	1	0		\N	2024-03-23 14:19:21.731741+03
4481	2084	11	1000	t	8000	2	1	0		\N	2024-03-23 14:19:21.733197+03
4482	2084	12	1000	t	8000	2	1	0		\N	2024-03-23 14:19:21.733954+03
4483	2084	10	0	t	9000	2	1	0		\N	2024-03-23 14:19:21.734687+03
3780	1781	13	1000	t	4000	1	1	0		\N	\N
4335	2016	53	0	f	6000	1	4	0		\N	2024-03-05 15:57:55.233242+03
4535	2118	12	4000	t	5000	4	1	0		\N	2024-04-09 17:05:11.001842+03
4536	2118	9	4000	t	5000	4	1	0		\N	2024-04-09 17:05:11.003645+03
4597	2148	18	0	f	3000	1	2	0		\N	2024-05-01 12:25:04.782005+03
4598	2148	23	0	f	3000	1	2	0		\N	2024-05-01 12:25:04.783431+03
4672	2190	12	0	t	9000	1	1	0		\N	2024-05-22 14:40:27.424713+03
4730	2228	11	0	t	5000	6	1	0		\N	2024-06-13 13:09:15.152235+03
4731	2228	12	0	t	5000	6	1	0		\N	2024-06-13 13:09:15.153418+03
4732	2228	13	0	t	5000	6	1	0		\N	2024-06-13 13:09:15.154249+03
4801	2260	11	0	f	12000	1	2	0		\N	2024-06-22 16:26:14.026902+03
4849	2290	12	2000	f	8000	3	6	0		\N	2024-07-02 15:25:45.267104+03
4850	2290	13	0	f	10000	6	1	0		\N	2024-07-02 15:25:45.268347+03
4922	2328	27	2000	f	8000	2	1	0	Назар 	\N	2024-07-11 13:56:11.053658+03
4923	2328	28	2000	f	8000	2	1	0		\N	2024-07-11 13:56:11.054836+03
4924	2328	31	0	t	9000	1	2	0		\N	2024-07-11 13:56:11.055447+03
4925	2328	12	0	t	11000	1	2	0		\N	2024-07-11 13:56:11.055999+03
4926	2329	13	0	t	9000	6	1	0		\N	2024-07-11 14:01:27.976817+03
5025	2371	26	0	t	4000	6	1	0		\N	2024-07-22 15:03:16.876005+03
5103	2401	13	0	t	11000	2	1	0		\N	2024-07-28 14:14:03.097055+03
5104	2401	11	0	t	11000	2	1	0		\N	2024-07-28 14:14:03.097979+03
5105	2401	20	0	f	10000	2	1	0		\N	2024-07-28 14:14:03.098561+03
5106	2402	20	1600	f	6400	3	6	0		\N	2024-07-28 14:20:17.208432+03
5198	2440	10	0	t	9000	2	1	0		\N	2024-08-05 15:19:05.181071+03
5199	2440	11	0	t	9000	2	1	0		\N	2024-08-05 15:19:05.182216+03
5200	2440	12	0	t	9000	2	1	0		\N	2024-08-05 15:19:05.182857+03
5286	2478	18	0	f	5000	1	2	0		\N	2024-08-10 16:03:48.522146+03
5287	2479	28	0	f	5000	1	2	0		\N	2024-08-10 16:13:33.598342+03
5375	2517	23	0	f	10000	1	2	0		\N	2024-08-17 12:19:56.254238+03
5376	2517	30	0	f	10000	1	2	0		\N	2024-08-17 12:19:56.255055+03
5377	2517	26	0	f	10000	1	2	0		\N	2024-08-17 12:19:56.255613+03
5469	2553	12	0	t	9000	1	1	0		\N	2024-08-21 15:52:09.179121+03
5470	2553	30	0	f	8000	1	1	0		\N	2024-08-21 15:52:09.180354+03
5471	2553	23	0	f	8000	1	1	0		\N	2024-08-21 15:52:09.181125+03
5472	2553	26	0	t	7000	1	1	0		\N	2024-08-21 15:52:09.181826+03
5473	2553	20	0	t	7000	2	1	0		\N	2024-08-21 15:52:09.182455+03
5474	2553	32	0	t	7000	2	1	0		\N	2024-08-21 15:52:09.183109+03
5551	2590	18	1500	f	1500	6	2	0		\N	2024-08-25 13:25:42.830189+03
5552	2590	11	0	f	4000	6	2	0		\N	2024-08-25 13:25:42.831617+03
5608	2621	31	1000	f	4000	3	6	0		\N	2024-08-29 10:37:33.855675+03
5662	2648	10	0	f	4000	1	2	0		\N	2024-09-01 10:52:58.065372+03
5700	2670	23	0	f	3000	6	2	0		\N	2024-09-10 17:32:48.74517+03
5701	2671	20	0	f	5000	1	2	0		\N	2024-09-10 17:33:16.482682+03
5702	2671	23	0	f	5000	1	2	0		\N	2024-09-10 17:33:16.483569+03
5703	2672	20	200	f	4800	6	3	0	С Аллюра 	\N	2024-09-10 17:44:50.080706+03
5704	2672	23	200	f	4800	6	3	0		\N	2024-09-10 17:44:50.081388+03
5756	2689	9	0	f	4000	6	2	0		\N	2024-09-14 14:29:57.735316+03
5817	2718	22	0	f	3000	1	2	0		\N	2024-09-25 16:30:45.978788+03
5837	2729	12	0	f	10000	6	2	0		\N	2024-09-28 15:21:23.382016+03
5838	2729	25	0	f	8000	6	2	0		\N	2024-09-28 15:21:23.382688+03
5839	2729	30	0	f	8000	6	2	0		\N	2024-09-28 15:21:23.383293+03
5840	2729	33	0	f	8000	6	2	0		\N	2024-09-28 15:21:23.383883+03
5861	2740	9	0	t	9000	6	1	0	Ренат	\N	2024-09-30 11:40:16.878169+03
5862	2740	22	0	f	8000	1	2	0		\N	2024-09-30 11:40:16.879447+03
5876	2748	9	0	f	6000	1	2	0		\N	2024-10-05 11:17:38.368198+03
5892	2755	12	0	t	11000	6	1	0		\N	2024-10-06 14:27:56.409208+03
5893	2755	20	0	t	9000	6	1	0		\N	2024-10-06 14:27:56.409968+03
5894	2755	21	0	t	9000	6	1	0		\N	2024-10-06 14:27:56.410666+03
5908	2764	22	0	f	3000	1	2	0		\N	2024-10-07 13:06:21.747818+03
5909	2764	20	0	f	3000	1	2	0		\N	2024-10-07 13:06:21.748724+03
5913	2766	11	0	f	6000	1	1	0		\N	2024-10-07 17:10:05.527273+03
5914	2766	13	0	f	6000	1	1	0		\N	2024-10-07 17:10:05.528326+03
3368	1610	12	2000	f	9000	1	2	0		\N	\N
4673	2191	20	1000	t	1000	1	1	0	Оставили отзывы 	\N	2024-05-24 17:48:24.482394+03
3458	1650	1	1000	t	4000	2	1	0		\N	\N
3459	1650	39	1000	f	5000	2	1	0		\N	\N
3460	1650	4	1000	f	5000	2	1	0		\N	\N
4674	2191	20	1000	t	1000	1	1	0		\N	2024-05-24 17:48:24.483688+03
4733	2229	11	0	f	10000	6	1	0		\N	2024-06-13 13:14:07.978708+03
4734	2229	13	0	f	10000	6	1	0		\N	2024-06-13 13:14:07.981472+03
4802	2261	13	500	f	3500	6	2	0		\N	2024-06-22 17:46:35.042568+03
3702	1745	1	2000	f	3000	1	1	0		\N	\N
3703	1745	39	2000	f	3000	1	1	0		\N	\N
3704	1746	12	1000	t	5000	2	1	0		\N	\N
3705	1746	13	1000	f	6000	2	1	0		\N	\N
3781	1782	3	2000	f	3000	1	2	0		\N	\N
3782	1782	39	2000	f	3000	1	2	0		\N	\N
3783	1782	4	2000	f	3000	1	2	0		\N	\N
3864	1817	12	0	t	9000	1	1	0		\N	\N
3970	1852	39	1000	f	4000	1	2	0		\N	\N
4037	1888	13	1000	t	8000	2	1	0		\N	2024-02-17 10:50:29.621166+03
4038	1888	10	0	f	10000	2	1	0	Оплатил заранее все 10	\N	2024-02-17 10:50:29.629352+03
4039	1888	12	0	t	9000	2	1	0		\N	2024-02-17 10:50:29.630472+03
4147	1935	12	0	t	9000	2	1	0		\N	2024-02-22 11:29:02.1739+03
4148	1935	10	0	t	9000	2	1	0		\N	2024-02-22 11:29:02.174817+03
4149	1935	11	0	t	9000	2	1	0		\N	2024-02-22 11:29:02.175587+03
4262	1982	42	0	t	5000	1	1	0		\N	2024-02-28 13:45:10.167955+03
4263	1983	9	0	t	9000	2	1	0		\N	2024-02-28 13:45:59.479552+03
4264	1984	48	0	t	6000	1	1	0		\N	2024-02-28 14:05:30.744343+03
4336	2017	10	0	t	9000	1	1	0		\N	2024-03-05 16:49:31.553155+03
4803	2261	24	0	f	3000	1	2	0		\N	2024-06-22 17:46:35.043898+03
4804	2261	17	2000	f	1000	6	2	0		\N	2024-06-22 17:46:35.044638+03
4805	2262	13	500	f	3500	6	2	0		\N	2024-06-22 17:46:44.433265+03
4806	2262	24	0	f	3000	1	2	0		\N	2024-06-22 17:46:44.433795+03
4807	2262	17	2000	f	1000	6	2	0		\N	2024-06-22 17:46:44.434479+03
4345	2020	51	0	t	4000	2	1	0		\N	2024-03-05 17:34:13.217601+03
4346	2021	48	3750	f	5250	1	1	0		\N	2024-03-05 17:42:39.248485+03
4347	2021	48	3750	f	5250	1	1	0		\N	2024-03-05 17:42:39.249167+03
4348	2021	51	2000	f	7000	1	1	0		\N	2024-03-05 17:42:39.249775+03
4349	2021	50	2000	f	7000	1	1	0		\N	2024-03-05 17:42:39.250385+03
4350	2021	41	2000	f	7000	1	1	0		\N	2024-03-05 17:42:39.25096+03
4351	2021	42	2000	f	7000	1	1	0		\N	2024-03-05 17:42:39.251551+03
4415	2050	11	1000	t	5000	2	1	0		\N	2024-03-13 17:59:20.334481+03
4416	2050	11	2000	f	5000	1	4	0		\N	2024-03-13 17:59:20.335832+03
4484	2085	35	0	t	4000	1	1	0		\N	2024-03-24 12:56:07.245421+03
4485	2085	35	0	t	4000	1	1	0		\N	2024-03-24 12:56:07.246742+03
4486	2085	35	0	t	4000	1	1	0		\N	2024-03-24 12:56:07.249968+03
4537	2119	12	0	t	9000	1	1	0		\N	2024-04-10 15:22:36.440939+03
4599	2149	32	0	t	4000	4	1	0	Амирчик	\N	2024-05-01 12:54:36.996278+03
4600	2150	15	0	f	8000	4	5	0		\N	2024-05-01 13:34:55.039392+03
4851	2291	23	1600	f	6400	3	6	0		\N	2024-07-02 15:30:14.536809+03
4927	2330	12	0	t	11000	1	1	0		\N	2024-07-12 10:33:32.792731+03
4928	2330	21	0	t	9000	6	1	0		\N	2024-07-12 10:33:32.793815+03
5026	2372	25	0	t	9000	1	1	0		\N	2024-07-22 17:22:26.62856+03
5027	2373	9	1000	f	3000	1	2	0		\N	2024-07-22 17:25:54.96853+03
5028	2373	26	1000	f	2000	1	2	0		\N	2024-07-22 17:25:54.969301+03
5029	2374	9	0	f	6000	1	2	0		\N	2024-07-22 17:33:24.106538+03
5030	2374	11	0	f	6000	1	2	0		\N	2024-07-22 17:33:24.107125+03
5115	2405	9	0	f	10000	2	1	0		\N	2024-07-28 17:36:53.027981+03
5116	2405	10	0	f	10000	2	1	0		\N	2024-07-28 17:36:53.029109+03
5117	2405	11	0	f	10000	2	1	0		\N	2024-07-28 17:36:53.029752+03
5118	2405	12	0	f	10000	2	1	0		\N	2024-07-28 17:36:53.030351+03
5119	2405	13	0	f	10000	2	1	0		\N	2024-07-28 17:36:53.030955+03
5120	2405	53	8000	f	2000	2	1	0		\N	2024-07-28 17:36:53.031513+03
5201	2441	21	0	f	3000	2	2	0		\N	2024-08-05 17:56:34.962592+03
5202	2441	25	0	f	3000	2	2	0		\N	2024-08-05 17:56:34.963895+03
5203	2441	28	0	f	3000	1	2	0		\N	2024-08-05 17:56:34.964627+03
5204	2441	32	0	f	3000	1	2	0		\N	2024-08-05 17:56:34.965292+03
5205	2441	13	0	f	4000	1	2	0		\N	2024-08-05 17:56:34.965972+03
5288	2480	22	600	f	2400	3	6	0		\N	2024-08-10 16:14:59.040036+03
5289	2480	32	600	f	2400	3	6	0		\N	2024-08-10 16:14:59.04091+03
5290	2481	12	0	f	4000	2	2	0		\N	2024-08-10 16:16:57.273573+03
5378	2518	25	0	f	3000	2	2	0		\N	2024-08-17 13:24:29.711305+03
5475	2554	13	0	t	11000	2	1	0		\N	2024-08-21 15:56:30.40811+03
5476	2554	11	0	t	11000	2	1	0		\N	2024-08-21 15:56:30.409324+03
5477	2554	10	3400	f	8600	2	1	0	Делю на нал и перевод	\N	2024-08-21 15:56:30.410118+03
5478	2554	10	8600	f	3400	2	1	0		\N	2024-08-21 15:56:30.410907+03
5479	2555	23	0	f	8000	1	1	0	Ренат	\N	2024-08-21 15:58:26.767263+03
5480	2555	31	0	f	8000	1	1	0		\N	2024-08-21 15:58:26.767904+03
5481	2555	20	1600	f	6400	3	6	0		\N	2024-08-21 15:58:26.768508+03
5482	2555	30	1600	f	6400	3	6	0		\N	2024-08-21 15:58:26.769043+03
5483	2555	32	1600	f	6400	3	6	0		\N	2024-08-21 15:58:26.769552+03
5489	2557	12	0	t	9000	2	1	0		\N	2024-08-21 16:02:38.872929+03
5490	2557	13	0	t	9000	6	1	0		\N	2024-08-21 16:02:38.87358+03
5491	2557	22	1600	f	6400	3	6	0		\N	2024-08-21 16:02:38.874221+03
5492	2557	33	1600	f	6400	3	6	0		\N	2024-08-21 16:02:38.874813+03
5493	2557	28	1600	f	6400	3	6	0		\N	2024-08-21 16:02:38.875457+03
5494	2558	11	0	f	4000	1	2	0		\N	2024-08-21 16:32:48.695665+03
5553	2591	20	1500	f	1500	6	2	0		\N	2024-08-25 13:26:34.381652+03
5554	2592	20	0	t	9000	6	1	0		\N	2024-08-25 14:08:12.130351+03
5555	2592	33	0	t	9000	1	1	0		\N	2024-08-25 14:08:12.131165+03
5556	2593	20	4000	f	4000	1	2	0	С курорта	\N	2024-08-25 14:09:59.482949+03
5609	2622	18	2000	f	8000	3	6	0		\N	2024-08-29 10:40:23.872196+03
5610	2622	22	2000	f	8000	3	6	0		\N	2024-08-29 10:40:23.873418+03
5611	2622	23	2000	f	8000	3	6	0		\N	2024-08-29 10:40:23.874042+03
5612	2622	30	0	t	9000	2	1	0		\N	2024-08-29 10:40:23.874699+03
5613	2622	12	0	t	11000	1	1	0		\N	2024-08-29 10:40:23.875401+03
5663	2649	31	0	f	5000	1	2	0		\N	2024-09-01 13:36:01.216322+03
3370	1611	39	1600	f	2400	1	4	0	С сайта  	\N	\N
3464	1654	39	1000	t	4000	2	1	0		\N	\N
3465	1654	1	1000	f	5000	2	1	0		\N	\N
3580	1700	8	2000	f	3000	1	2	0		\N	\N
3581	1700	9	2000	f	3000	1	2	0		\N	\N
3582	1700	10	2000	f	3000	1	2	0		\N	\N
3583	1700	12	2000	f	3000	1	2	0		\N	\N
3706	1747	12	0	t	9000	1	1	0		\N	\N
3707	1747	13	0	f	10000	1	1	0		\N	\N
3708	1747	10	0	f	10000	1	1	0		\N	\N
3709	1747	11	0	f	10000	1	1	0		\N	\N
3710	1748	39	0	t	5000	2	1	0		\N	\N
3784	1783	13	0	f	7000	2	1	0	По сертификату	\N	\N
3865	1818	10	0	t	9000	2	1	0		\N	\N
3866	1819	13	0	f	7000	1	2	0		\N	\N
3971	1853	50	1000	f	4000	1	2	0		\N	\N
4040	1889	50	1000	t	4000	2	1	0		\N	2024-02-17 10:53:45.228997+03
4150	1936	10	1000	t	5000	1	1	0		\N	2024-02-23 10:15:33.924044+03
4151	1936	11	1000	t	5000	1	1	0		\N	2024-02-23 10:15:33.925343+03
4152	1936	12	1000	t	5000	2	1	0		\N	2024-02-23 10:15:33.926027+03
4265	1985	49	0	f	9000	2	4	0	Скорее всего с аллюра	\N	2024-02-28 14:10:55.88371+03
4342	2019	48	0	t	6000	1	1	0		\N	2024-03-05 16:54:28.610923+03
4343	2019	50	0	t	6000	1	1	0		\N	2024-03-05 16:54:28.612202+03
4344	2019	39	0	t	6000	1	1	0		\N	2024-03-05 16:54:28.612927+03
4675	2192	10	0	t	9000	2	1	0		\N	2024-05-25 12:26:02.957552+03
4676	2192	13	0	t	9000	2	1	0		\N	2024-05-25 12:26:02.959578+03
4735	2230	12	0	t	11000	6	1	0		\N	2024-06-13 16:13:25.510192+03
4808	2263	22	0	t	7000	6	1	0		\N	2024-06-23 14:44:19.434915+03
4809	2263	21	0	t	7000	6	1	0		\N	2024-06-23 14:44:19.436527+03
4422	2053	48	0	t	6000	1	1	0		\N	2024-03-14 11:18:20.873687+03
4423	2053	50	0	t	6000	1	1	0		\N	2024-03-14 11:18:20.874414+03
4424	2053	39	0	t	6000	1	1	0		\N	2024-03-14 11:18:20.874977+03
4425	2054	49	0	t	6000	1	1	0		\N	2024-03-14 11:54:44.128574+03
4487	2086	35	1000	t	5000	2	1	0		\N	2024-03-25 14:21:38.500331+03
4488	2086	35	1000	t	5000	2	1	0		\N	2024-03-25 14:21:38.501507+03
4538	2120	12	1000	t	8000	1	1	0		\N	2024-04-13 15:15:37.572765+03
4601	2151	10	3200	f	8800	4	1	0	Амирчик. С сайта, поэтому с комиссией 	\N	2024-05-01 14:43:14.836675+03
4602	2151	12	0	t	11000	4	1	0		\N	2024-05-01 14:43:14.837852+03
4810	2264	25	0	f	5000	6	2	0		\N	2024-06-23 14:45:35.778335+03
4811	2264	13	0	f	6000	6	2	0		\N	2024-06-23 14:45:35.779073+03
4852	2292	30	0	f	8000	3	3	0	От ски резорт. Наверное постоплата	\N	2024-07-02 16:53:41.989551+03
4853	2293	13	0	t	5000	1	2	0		\N	2024-07-02 16:54:10.528258+03
4929	2331	26	0	t	4000	6	1	0		\N	2024-07-14 09:20:34.984858+03
5031	2375	18	0	t	7000	6	1	0		\N	2024-07-23 10:28:27.702061+03
5032	2375	19	0	t	7000	6	1	0		\N	2024-07-23 10:28:27.702947+03
5033	2375	21	0	t	7000	6	1	0		\N	2024-07-23 10:28:27.703497+03
5034	2375	25	0	t	7000	6	1	0		\N	2024-07-23 10:28:27.704026+03
5035	2375	27	0	t	7000	1	1	0		\N	2024-07-23 10:28:27.704655+03
5036	2375	9	0	t	9000	6	1	0		\N	2024-07-23 10:28:27.70518+03
5037	2376	18	0	f	3000	1	2	0		\N	2024-07-23 10:30:44.255354+03
5038	2376	8	0	f	4000	1	2	0		\N	2024-07-23 10:30:44.256+03
5039	2376	10	0	f	4000	6	2	0		\N	2024-07-23 10:30:44.256614+03
5121	2406	26	2000	f	6000	1	2	0		\N	2024-07-28 17:50:39.631175+03
5206	2442	11	0	t	9000	1	1	0	Индивидуальный за 15к	\N	2024-08-06 10:02:25.145209+03
5207	2442	11	5000	f	5000	1	1	0		\N	2024-08-06 10:02:25.146293+03
5208	2443	10	0	t	9000	2	1	0	Ренат	\N	2024-08-06 10:04:40.760726+03
5209	2443	13	0	t	9000	2	1	0		\N	2024-08-06 10:04:40.761485+03
5291	2482	10	0	f	12000	1	2	0		\N	2024-08-11 15:28:06.804609+03
5292	2482	11	0	t	11000	1	1	0		\N	2024-08-11 15:28:06.80588+03
5293	2482	12	0	t	11000	1	1	0		\N	2024-08-11 15:28:06.806654+03
5294	2483	26	0	f	3000	1	2	0		\N	2024-08-11 16:02:33.864865+03
5295	2483	32	0	f	3000	2	2	0		\N	2024-08-11 16:02:33.865524+03
5296	2484	26	0	f	3000	1	2	0		\N	2024-08-11 16:04:52.26621+03
5379	2519	9	0	f	10000	1	2	0		\N	2024-08-17 14:11:51.422351+03
5380	2519	11	0	t	9000	1	2	0		\N	2024-08-17 14:11:51.423182+03
5381	2519	13	0	t	9000	1	2	0		\N	2024-08-17 14:11:51.42387+03
5495	2559	11	0	f	4000	1	2	0		\N	2024-08-21 17:16:27.952532+03
5557	2594	12	0	f	6000	1	2	0	Ренат 	\N	2024-08-25 14:20:23.866494+03
5558	2595	31	0	f	5000	1	2	0		\N	2024-08-25 15:07:40.420314+03
5559	2595	28	0	f	5000	1	2	0		\N	2024-08-25 15:07:40.421232+03
5560	2595	32	0	f	5000	1	2	0		\N	2024-08-25 15:07:40.421843+03
5614	2623	10	0	t	9000	6	1	0	Ренат	\N	2024-08-29 10:42:53.006103+03
5615	2623	28	0	f	8000	1	2	0		\N	2024-08-29 10:42:53.007112+03
5616	2623	32	0	f	8000	1	2	0		\N	2024-08-29 10:42:53.007781+03
5617	2623	13	0	f	10000	1	1	0		\N	2024-08-29 10:42:53.008425+03
5618	2623	9	0	t	9000	1	1	0		\N	2024-08-29 10:42:53.008997+03
5664	2650	10	0	f	4000	1	2	0		\N	2024-09-01 13:36:39.108427+03
5705	2673	31	0	t	4000	1	1	0		\N	2024-09-11 12:29:51.227226+03
5706	2674	33	0	f	10000	6	1	0		\N	2024-09-11 13:27:03.908524+03
5757	2690	11	0	t	9000	6	1	0		\N	2024-09-15 10:15:41.076847+03
5758	2690	13	0	f	10000	1	2	0		\N	2024-09-15 10:15:41.078139+03
5791	2704	31	0	t	7000	6	1	0		\N	2024-09-21 14:44:09.547791+03
5792	2704	23	0	t	7000	6	1	0		\N	2024-09-21 14:44:09.54867+03
5793	2704	11	2000	f	8000	3	3	0	От Аллюра 	\N	2024-09-21 14:44:09.549293+03
5794	2704	13	2000	f	8000	3	3	0	От Аллюра 	\N	2024-09-21 14:44:09.549865+03
5795	2705	28	0	f	5000	6	2	0		\N	2024-09-21 14:48:05.967003+03
5841	2730	18	0	f	3000	1	2	0		\N	2024-09-28 16:04:12.476365+03
5863	2741	11	0	f	4000	1	2	0		\N	2024-09-30 13:32:11.880902+03
5864	2741	12	0	f	4000	6	2	0		\N	2024-09-30 13:32:11.881858+03
5865	2742	33	1600	f	6400	3	3	0	Аллюр. Ренат	\N	2024-09-30 14:05:39.845593+03
5877	2749	22	0	f	3000	1	2	0		\N	2024-10-05 11:19:28.954975+03
5878	2750	9	0	f	12000	1	2	0		\N	2024-10-05 11:33:06.048019+03
5895	2756	13	0	f	4000	6	2	0		\N	2024-10-06 15:21:13.703246+03
5896	2757	31	0	f	3000	1	2	0		\N	2024-10-06 15:23:25.839829+03
3371	1612	12	1000	f	4000	1	2	0		\N	\N
3466	1655	12	2000	f	8000	1	2	0		\N	\N
3467	1655	9	2000	f	8000	1	2	0		\N	\N
3468	1655	10	2000	f	8000	1	2	0		\N	\N
3584	1701	39	0	t	5000	1	1	0		\N	\N
3585	1702	13	0	f	7000	1	2	0		\N	\N
3711	1749	4	1500	f	4500	1	4	0	500 отдали откат	\N	\N
3714	1751	1	1000	t	4000	2	1	0		\N	\N
2789	1368	35	1000	f	6000	1	2	0		\N	\N
2790	1368	35	1000	f	6000	1	2	0		\N	\N
2791	1368	35	1000	f	6000	1	2	0		\N	\N
2792	1368	35	1000	f	6000	1	2	0		\N	\N
2793	1369	7	1000	t	5000	1	1	0		\N	\N
2794	1369	8	1000	f	6000	1	1	0		\N	\N
2795	1369	9	1000	f	6000	1	1	0		\N	\N
2796	1369	10	1000	f	6000	1	1	0		\N	\N
4677	2193	11	0	f	6000	1	1	0		\N	2024-05-25 12:26:57.643976+03
2798	1369	12	1000	f	6000	1	1	0		\N	\N
2799	1369	13	1000	f	6000	1	1	0		\N	\N
2800	1370	39	0	t	3000	1	1	0		\N	\N
2801	1370	40	0	t	3000	1	1	0		\N	\N
2802	1370	3	0	f	4000	1	1	0		\N	\N
2808	1372	13	0	f	5000	1	2	0		\N	\N
2809	1372	12	0	f	5000	1	2	0		\N	\N
2810	1372	8	0	f	5000	1	2	0		\N	\N
2812	1374	7	0	t	6000	1	1	0		\N	\N
2813	1374	10	0	f	7000	1	1	0		\N	\N
2822	1377	8	1000	t	3000	1	1	0		\N	\N
2825	1379	1	0	t	3000	1	1	0		\N	\N
2826	1379	5	500	f	3500	1	1	0		\N	\N
2827	1379	3	500	f	3500	1	1	0		\N	\N
2828	1379	39	500	f	3500	1	1	0		\N	\N
2833	1381	1	500	f	3500	1	2	0		\N	\N
2834	1381	3	500	f	3500	1	2	0		\N	\N
2839	1384	7	0	f	7000	2	2	0		\N	\N
2840	1384	8	0	f	7000	2	2	0		\N	\N
2841	1384	9	0	f	7000	2	2	0		\N	\N
2842	1384	12	0	f	7000	2	2	0		\N	\N
2849	1386	39	0	f	4000	1	1	0		\N	\N
2850	1386	40	0	f	4000	1	1	0		\N	\N
2851	1386	41	0	f	4000	2	1	0		\N	\N
2852	1386	42	0	f	4000	2	1	0		\N	\N
2853	1387	35	1000	f	4000	1	2	0		\N	\N
2854	1387	35	1000	f	4000	1	2	0		\N	\N
2855	1387	13	0	f	7000	1	2	0		\N	\N
2857	1388	8	0	f	5000	1	2	0		\N	\N
2858	1388	10	0	f	5000	1	2	0		\N	\N
2859	1388	12	0	f	5000	1	2	0		\N	\N
2860	1389	9	0	f	7000	1	2	0		\N	\N
2861	1390	3	500	f	3500	1	2	0		\N	\N
2862	1390	41	500	f	3500	1	2	0		\N	\N
2863	1390	39	0	f	4000	1	2	0		\N	\N
2864	1390	40	0	f	4000	1	2	0		\N	\N
2865	1391	1	1000	f	3000	1	2	0		\N	\N
2901	1408	8	0	t	5000	1	1	0		\N	\N
2876	1398	9	0	f	7000	1	0	0		\N	\N
2866	1392	9	2000	f	5000	1	2	0		\N	\N
2867	1392	12	2000	f	5000	1	2	0		\N	\N
2868	1393	8	0	f	5000	1	2	0		\N	\N
3715	1751	39	1000	f	5000	2	1	0		\N	\N
3716	1751	40	1000	t	4000	2	1	0		\N	\N
2871	1395	9	0	t	6000	1	1	0		\N	\N
2872	1395	13	0	f	7000	1	1	0		\N	\N
2873	1396	9	0	f	5000	1	2	0		\N	\N
2875	1397	10	0	f	7000	1	2	0		\N	\N
2877	1398	13	0	f	7000	1	2	0		\N	\N
2878	1398	8	0	f	7000	1	2	0		\N	\N
2879	1399	2	0	t	3000	1	1	0		\N	\N
2880	1399	39	0	f	4000	1	1	0		\N	\N
2881	1399	4	0	f	4000	2	2	0		\N	\N
2882	1400	1	1000	f	3000	1	4	0		\N	\N
2883	1400	3	1000	f	3000	1	4	0		\N	\N
2884	1400	39	1000	f	3000	1	4	0		\N	\N
2885	1401	1	0	f	4000	1	2	0		\N	\N
2886	1401	40	0	f	4000	1	2	0		\N	\N
2887	1401	4	0	f	4000	1	2	0		\N	\N
2902	1408	8	0	f	7000	1	1	0		\N	\N
2917	1414	13	0	t	5000	2	1	0		\N	\N
2890	1403	35	1000	t	5000	2	1	0		\N	\N
2891	1403	35	1000	f	6000	2	1	0		\N	\N
2892	1404	13	0	f	5000	3	3	0		\N	\N
2893	1405	35	1000	f	6000	1	2	0		\N	\N
2894	1405	35	1000	f	6000	1	2	0		\N	\N
2895	1406	1	0	f	4000	2	2	0		\N	\N
2896	1406	3	0	f	4000	2	2	0		\N	\N
2897	1406	39	0	f	4000	1	2	0		\N	\N
2898	1407	1	0	f	4000	1	2	0		\N	\N
2899	1407	39	0	f	4000	1	2	0		\N	\N
2900	1407	3	0	f	4000	1	2	0		\N	\N
2903	1408	10	0	f	7000	1	1	0		\N	\N
2904	1409	13	0	f	7000	1	2	0		\N	\N
2905	1409	7	0	f	7000	1	2	0		\N	\N
2906	1410	8	1500	f	3500	1	2	0		\N	\N
2907	1410	11	1500	f	3500	1	2	0		\N	\N
2908	1410	35	1000	f	3000	1	2	0		\N	\N
2910	1410	35	1000	f	3000	1	2	0		\N	\N
2911	1410	35	1000	f	3000	1	2	0		\N	\N
2912	1411	1	0	t	3000	2	1	0		\N	\N
2913	1411	39	0	f	4000	2	2	0		\N	\N
2914	1411	40	0	f	4000	2	2	0		\N	\N
2915	1412	39	0	f	4000	1	2	0		\N	\N
2916	1413	9	0	f	5000	1	2	0		\N	\N
2918	1415	39	0	t	3000	1	1	0		\N	\N
2919	1416	1	0	f	4000	1	2	0		\N	\N
2920	1416	3	0	f	4000	1	2	0		\N	\N
2921	1417	39	0	f	7000	1	2	0		\N	\N
2922	1418	1	0	f	4000	1	1	0		\N	\N
2923	1418	2	0	f	4000	1	1	0		\N	\N
2924	1419	39	0	f	4000	1	1	0		\N	\N
2925	1419	40	0	f	4000	1	1	0		\N	\N
2926	1420	8	1000	t	9000	1	1	0		\N	\N
2927	1420	10	1000	f	10000	1	1	0		\N	\N
2928	1420	11	1000	t	9000	2	1	0		\N	\N
2929	1421	40	0	f	4000	2	2	0		\N	\N
2856	1388	7	1000	f	7000	1	0	0		\N	\N
2823	1378	35	1000	f	6000	1	0	0		\N	\N
2909	1410	35	1000	f	3000	1	0	0		\N	\N
3373	1613	10	2000	f	5000	2	1	0		\N	\N
3374	1614	8	2000	f	5000	2	4	0		\N	\N
3375	1614	9	2000	f	5000	2	4	0		\N	\N
3376	1614	12	2000	f	5000	2	4	0		\N	\N
3469	1656	12	1000	f	9000	1	2	0		\N	\N
3586	1703	12	1000	t	5000	2	1	0		\N	\N
3587	1704	13	1000	t	5000	1	1	0		\N	\N
3588	1705	39	2000	f	7000	1	2	0		\N	\N
3589	1705	40	2000	f	7000	1	2	0		\N	\N
3590	1705	41	2000	f	7000	1	2	0		\N	\N
3591	1705	1	2000	f	7000	1	2	0		\N	\N
3592	1705	4	2000	f	7000	1	2	0		\N	\N
3593	1706	1	2000	f	7000	1	2	0		\N	\N
3594	1706	2	2000	f	7000	1	2	0		\N	\N
3595	1706	39	2000	f	7000	1	2	0		\N	\N
3596	1706	3	2000	f	7000	1	2	0		\N	\N
3597	1706	4	2000	f	7000	1	2	0		\N	\N
3712	1750	4	1500	f	4500	2	4	0	500 откат дали	\N	\N
3713	1750	39	1500	f	4500	2	4	0	500 откат дали	\N	\N
3785	1784	13	1000	t	3000	1	1	0		\N	\N
3867	1820	39	0	t	8000	2	1	0		\N	\N
3868	1820	51	2000	f	7000	2	4	0	Откат дали + отзывы	\N	\N
3869	1820	50	0	t	8000	2	1	0		\N	\N
3870	1820	40	3000	f	6000	2	4	0	Откат дали + отзывы	\N	\N
2797	1369	11	1000	f	6000	1	1	0		0	\N
3871	1820	48	1000	f	8000	1	4	0	Откат дали + отзывы	0	\N
3972	1854	12	0	t	9000	2	1	0		\N	\N
3973	1854	10	0	f	10000	2	1	0		\N	\N
4041	1890	9	1000	t	5000	2	1	0		\N	2024-02-17 12:41:31.331975+03
4042	1890	10	1000	f	6000	2	1	0		\N	2024-02-17 12:41:31.333792+03
4043	1891	9	1000	t	5000	1	1	0		\N	2024-02-17 12:43:06.221548+03
4153	1937	10	0	t	9000	2	1	0		\N	2024-02-23 13:32:14.927818+03
4154	1937	11	0	f	10000	2	3	0	С Аллюра	\N	2024-02-23 13:32:14.929053+03
4155	1937	12	0	f	10000	2	3	0	С Аллюра	\N	2024-02-23 13:32:14.929751+03
4266	1986	9	1000	t	5000	2	1	0		\N	2024-02-28 17:06:34.393706+03
4267	1986	10	1000	t	5000	2	1	0		\N	2024-02-28 17:06:34.394814+03
4678	2194	24	0	t	9000	6	1	0		\N	2024-05-30 15:49:55.420649+03
4736	2231	30	0	t	7000	1	2	0		\N	2024-06-13 17:32:41.672711+03
4737	2231	25	0	f	8000	1	2	0		\N	2024-06-13 17:32:41.673763+03
4426	2055	10	1000	t	5000	1	1	0		\N	2024-03-14 12:30:58.354911+03
4427	2055	11	1000	t	5000	2	1	0		\N	2024-03-14 12:30:58.356645+03
4428	2055	13	1000	t	5000	2	1	0		\N	2024-03-14 12:30:58.35738+03
4429	2056	13	0	t	9000	2	1	0		\N	2024-03-14 13:25:56.649577+03
4489	2087	13	0	t	9000	2	1	0		\N	2024-03-25 15:02:01.800529+03
3372	1613	9	2000	f	4000	2	1	0		\N	\N
3470	1656	8	1000	f	9000	1	2	0		\N	\N
4539	2121	10	2000	f	8000	1	4	0	1500 из скидки агенту	\N	2024-04-13 15:25:11.912601+03
4540	2121	11	2000	f	8000	1	4	0	1500 откат	\N	2024-04-13 15:25:11.915016+03
4541	2121	12	2000	f	8000	1	4	0	1500 откат 	\N	2024-04-13 15:25:11.915817+03
4603	2152	21	0	f	8000	4	5	0		\N	2024-05-01 16:03:25.726562+03
4604	2152	22	0	t	7000	4	1	0		\N	2024-05-01 16:03:25.728055+03
4605	2152	23	0	t	7000	4	1	0		\N	2024-05-01 16:03:25.729012+03
4606	2152	27	0	t	7000	4	1	0		\N	2024-05-01 16:03:25.729595+03
4607	2152	12	0	f	10000	4	5	0		\N	2024-05-01 16:03:25.730208+03
4738	2232	22	0	f	3000	1	2	0		\N	2024-06-13 17:33:32.46494+03
4739	2232	28	0	f	3000	1	2	0		\N	2024-06-13 17:33:32.465636+03
4812	2265	25	500	f	2500	1	2	0		\N	2024-06-23 16:11:55.477093+03
4813	2265	25	2500	f	500	1	2	0		\N	2024-06-23 16:11:55.47812+03
4814	2266	12	1000	f	5000	6	2	0		\N	2024-06-23 16:13:35.463138+03
4854	2294	32	0	f	5000	1	2	0		\N	2024-07-03 12:34:29.958513+03
4930	2332	11	0	t	5000	1	1	0		\N	2024-07-14 10:02:07.053247+03
4931	2332	13	0	t	5000	1	1	0		\N	2024-07-14 10:02:07.054269+03
5040	2377	27	0	f	5000	1	2	0		\N	2024-07-23 11:54:17.121646+03
5122	2407	12	0	t	11000	1	1	0		\N	2024-07-29 12:44:42.778688+03
5210	2444	22	0	f	3000	1	2	0		\N	2024-08-06 11:05:27.612129+03
5297	2485	12	0	f	12000	1	2	0		\N	2024-08-11 16:57:25.798466+03
5298	2485	11	0	t	11000	1	1	0		\N	2024-08-11 16:57:25.799268+03
5299	2485	10	0	t	11000	1	1	0		\N	2024-08-11 16:57:25.799741+03
5300	2485	20	0	t	9000	6	1	0		\N	2024-08-11 16:57:25.80022+03
5382	2520	33	5000	f	3000	2	2	0	Делю чтобы было поровну 	\N	2024-08-17 17:24:17.313062+03
5383	2521	33	3000	f	5000	2	2	0	Делю чтобы было ровно 	\N	2024-08-17 17:33:43.746068+03
5384	2521	31	0	f	8000	2	2	0		\N	2024-08-17 17:33:43.746728+03
5385	2521	20	0	t	7000	6	1	0		\N	2024-08-17 17:33:43.747367+03
5386	2521	32	4000	f	4000	1	4	0	Знакомые от Ахмата	\N	2024-08-17 17:33:43.747928+03
5387	2521	25	0	t	7000	1	1	0		\N	2024-08-17 17:33:43.748514+03
5496	2560	23	0	f	3000	1	2	0		\N	2024-08-21 17:56:13.694927+03
5561	2596	12	0	t	11000	1	1	0	Ренат 	\N	2024-08-25 15:15:16.745726+03
5562	2596	32	2000	f	8000	1	2	0	С белых на Софию за 8к	\N	2024-08-25 15:15:16.74677+03
5619	2624	25	0	t	2000	6	1	0		\N	2024-08-29 12:47:17.686935+03
5665	2651	9	0	t	9000	6	1	0		\N	2024-09-01 14:34:10.336922+03
5666	2651	33	0	f	8000	6	1	0		\N	2024-09-01 14:34:10.33771+03
5707	2675	23	1600	f	6400	3	6	0		\N	2024-09-11 13:29:16.27342+03
5708	2675	22	0	f	8000	6	2	0		\N	2024-09-11 13:29:16.274289+03
5709	2676	30	0	t	7000	6	1	0		\N	2024-09-11 14:07:36.663937+03
5710	2676	12	0	t	9000	1	1	0		\N	2024-09-11 14:07:36.66464+03
5711	2676	13	2000	f	8000	3	3	0	С Аллюра 	\N	2024-09-11 14:07:36.665216+03
5712	2676	11	2000	f	8000	3	6	0		\N	2024-09-11 14:07:36.668052+03
5759	2691	23	0	f	5000	1	2	0		\N	2024-09-15 15:49:06.377019+03
5796	2706	28	0	f	3000	6	2	0		\N	2024-09-21 17:08:10.71252+03
5797	2707	22	0	f	5000	6	2	0		\N	2024-09-21 17:13:46.983661+03
5798	2707	30	0	f	5000	1	2	0		\N	2024-09-21 17:13:46.984499+03
5818	2719	13	0	t	11000	6	1	0		\N	2024-09-26 10:22:43.970675+03
5822	2722	18	0	t	7000	6	1	0	Ренат 	\N	2024-09-27 14:15:09.750921+03
2803	1371	3	0	t	3000	1	1	0		\N	\N
3377	1615	12	0	f	9000	2	3	0		\N	\N
3378	1615	8	0	f	9000	2	3	0		\N	\N
3379	1615	9	0	f	9000	3	3	0	Оплатили в аллюре 12 к	\N	\N
3471	1657	39	1000	t	4000	1	1	0		\N	\N
3472	1657	4	1000	f	5000	1	1	0		\N	\N
3475	1659	4	2000	t	2000	2	1	0		\N	\N
3598	1707	39	1000	t	4000	2	1	0		\N	\N
3599	1707	40	1000	f	5000	1	1	0		\N	\N
3600	1707	4	0	f	6000	1	1	0		\N	\N
3601	1707	5	0	t	5000	1	1	0		\N	\N
3602	1708	12	1000	f	9000	2	3	0	Должны были взять 9000 но взяли 10000. Откат 1000	\N	\N
3717	1752	12	0	t	9000	1	1	0		\N	\N
3718	1753	10	1000	t	5000	2	1	0		\N	\N
3719	1753	13	1000	f	6000	2	1	0		\N	\N
3786	1785	39	0	t	5000	1	1	0		\N	\N
3787	1785	1	0	t	5000	1	1	0		\N	\N
2804	1371	39	0	f	4000	1	2	0		\N	\N
3788	1785	3	1000	t	4000	2	1	0		\N	\N
3789	1786	9	1000	t	5000	2	1	0		\N	\N
4679	2195	12	3000	f	7000	4	6	0	Откат 30%	\N	2024-06-01 15:27:55.489329+03
2722	1346	12	0	f	9000	1	2	0		\N	\N
2723	1346	13	0	f	9000	1	2	0		\N	\N
2724	1347	9	0	f	6000	3	3	0		\N	\N
2725	1348	8	2000	f	7000	2	2	0		\N	\N
2726	1349	7	2000	f	7000	2	2	0		\N	\N
2727	1349	35	1000	f	6000	2	2	0		\N	\N
2728	1350	9	1000	f	10000	1	2	0		\N	\N
2730	1351	9	1000	f	10000	2	1	0		\N	\N
2731	1352	10	2000	f	7000	1	2	0		\N	\N
2733	1353	35	0	f	7000	1	2	0		\N	\N
2811	1373	11	1000	f	5000	1	5	0		\N	\N
2732	1353	35	0	f	7000	1	0	0		\N	\N
2734	1354	35	1000	f	4000	2	2	0		\N	\N
2735	1354	35	1000	f	4000	2	2	0		\N	\N
2736	1354	35	1000	f	4000	1	2	0		\N	\N
2737	1354	35	1000	f	4000	1	2	0		\N	\N
2738	1355	3	0	f	4000	1	2	0		\N	\N
2739	1355	1	0	f	4000	1	2	0		\N	\N
2740	1355	2	0	f	4000	1	2	0		\N	\N
2741	1355	39	0	f	4000	1	2	0		\N	\N
2742	1355	40	0	f	4000	1	2	0		\N	\N
2743	1356	3	0	f	4000	1	2	0		\N	\N
2744	1356	39	0	f	4000	1	2	0		\N	\N
2745	1356	1	0	f	4000	1	2	0		\N	\N
2746	1356	40	0	f	4000	1	2	0		\N	\N
2747	1357	1	0	f	4000	1	2	0		\N	\N
2748	1357	3	0	f	4000	1	2	0		\N	\N
2749	1357	39	0	f	4000	1	2	0		\N	\N
2750	1357	40	0	f	4000	1	2	0		\N	\N
2751	1358	1	1500	f	2500	1	2	0		\N	\N
2752	1358	3	1500	f	2500	1	2	0		\N	\N
2753	1358	39	1500	f	2500	1	2	0		\N	\N
2754	1358	40	1500	f	2500	1	2	0		\N	\N
2755	1358	41	1500	f	2500	1	2	0		\N	\N
2756	1358	42	1500	f	2500	1	2	0		\N	\N
2757	1359	1	1500	f	2500	1	2	0		\N	\N
2758	1359	3	1500	f	2500	1	2	0		\N	\N
2759	1359	39	1500	f	2500	1	2	0		\N	\N
2760	1359	40	1500	f	2500	1	2	0		\N	\N
2761	1359	41	1500	f	2500	1	2	0		\N	\N
2762	1359	42	1500	f	2500	1	2	0		\N	\N
2729	1351	8	1000	t	10000	2	0	0		\N	\N
2763	1360	1	1500	f	2500	1	2	0		\N	\N
2764	1360	3	1500	f	2500	1	2	0		\N	\N
2765	1360	39	1500	f	2500	1	2	0		\N	\N
2766	1360	40	1500	f	2500	1	2	0		\N	\N
2767	1360	41	1500	f	2500	1	2	0		\N	\N
2768	1360	42	1500	f	2500	1	2	0		\N	\N
2769	1361	1	0	f	4000	1	2	0		\N	\N
2770	1361	3	0	f	4000	1	2	0		\N	\N
2771	1361	39	0	f	4000	1	2	0		\N	\N
2717	1343	6	1000	t	3000	2	0	0		\N	\N
2718	1343	6	1000	f	4000	2	0	0		\N	\N
2720	1345	6	1000	f	4000	1	0	0		\N	\N
2721	1345	6	1000	f	4000	1	0	0		\N	\N
2772	1362	35	1500	f	2500	1	2	0		\N	\N
2773	1362	35	1500	f	2500	1	2	0		\N	\N
2774	1362	35	1500	f	2500	1	2	0		\N	\N
2775	1362	35	1500	f	2500	1	2	0		\N	\N
2776	1362	35	1500	f	2500	1	2	0		\N	\N
2805	1371	40	0	f	4000	1	2	0		\N	\N
2806	1371	41	0	f	4000	1	2	0		\N	\N
2779	1364	7	1000	f	10000	1	1	0		\N	\N
2780	1364	12	1000	f	10000	1	1	0		\N	\N
2781	1365	1	0	t	3000	2	1	0		\N	\N
2782	1365	39	0	f	4000	2	1	0		\N	\N
2784	1366	10	0	f	5000	1	1	0		\N	\N
2785	1366	35	0	f	4000	2	1	0		\N	\N
2786	1367	35	2000	f	8000	2	2	0		\N	\N
2787	1367	35	2000	f	8000	2	2	0		\N	\N
2788	1367	35	6000	f	4000	2	2	0		\N	\N
2807	1371	1	0	f	4000	1	2	0		\N	\N
2814	1375	12	1000	f	4000	1	2	0		\N	\N
2815	1375	13	1000	f	4000	1	2	0		\N	\N
2816	1375	8	1000	f	4000	1	2	0		\N	\N
2817	1376	7	0	f	7000	1	2	0		\N	\N
2818	1376	9	0	f	7000	1	2	0		\N	\N
2819	1376	12	0	f	7000	1	2	0		\N	\N
2820	1376	13	0	f	7000	1	2	0		\N	\N
2821	1376	7	0	f	7000	1	2	0		\N	\N
2824	1378	35	1000	f	6000	1	2	0		\N	\N
2829	1380	39	0	t	3000	2	1	0		\N	\N
2830	1380	40	1000	f	3000	2	2	0		\N	\N
2831	1380	41	1000	f	3000	2	2	0		\N	\N
2832	1380	5	0	f	4000	1	2	0		\N	\N
2835	1382	39	0	f	4000	1	2	0		\N	\N
2836	1382	40	0	f	4000	1	2	0		\N	\N
2837	1383	13	0	f	5000	1	2	0		\N	\N
2838	1383	9	0	t	4000	1	1	0		\N	\N
2843	1385	39	1000	f	3000	1	2	0		\N	\N
2844	1385	40	1000	f	3000	1	2	0		\N	\N
2845	1385	41	0	t	3000	1	1	0		\N	\N
2846	1385	3	0	f	4000	1	1	0		\N	\N
2847	1385	1	0	f	4000	1	2	0		\N	\N
2848	1385	4	0	f	4000	1	2	0		\N	\N
3380	1616	12	1000	f	5000	2	2	1000		\N	\N
2934	1424	12	1000	t	9000	2	1	0		\N	\N
2935	1424	13	1000	f	10000	1	1	0		\N	\N
2936	1425	9	1000	f	6000	2	2	0		\N	\N
2937	1425	12	1000	f	6000	2	2	0		\N	\N
2938	1425	11	1000	f	6000	2	2	0		\N	\N
2939	1426	8	1000	t	9000	2	1	0		\N	\N
2940	1427	1	0	t	3000	1	1	0		\N	\N
2941	1427	3	0	t	3000	1	1	0		\N	\N
2942	1427	39	0	t	3000	1	1	0		\N	\N
2943	1427	2	500	f	3500	1	4	0	Откат 500р	\N	\N
2944	1428	1	1000	f	4000	1	4	0	Откат 1к руб	\N	\N
2945	1428	4	1000	f	4000	1	4	0	Откат 1к руб	\N	\N
2946	1429	1	0	f	4000	1	2	0		\N	\N
2947	1429	39	0	f	4000	1	2	0		\N	\N
2948	1430	35	0	f	4000	2	2	0		\N	\N
2949	1430	35	0	f	4000	2	2	0		\N	\N
2950	1431	9	3000	t	7000	2	1	0		\N	\N
2951	1431	10	1000	f	10000	1	2	0		\N	\N
2954	1431	35	0	f	10000	2	1	0		\N	\N
2955	1431	35	0	f	10000	2	1	0		\N	\N
2956	1431	35	4000	f	6000	1	2	0		\N	\N
2957	1431	35	4000	f	6000	1	2	0		\N	\N
2959	1432	7	1000	f	6000	1	2	0		\N	\N
2960	1432	8	1000	f	6000	1	2	0		\N	\N
2961	1433	1	0	f	4000	2	2	0		\N	\N
2962	1433	3	0	f	4000	2	2	0		\N	\N
2963	1433	39	0	f	4000	2	2	0		\N	\N
2964	1434	1	0	f	4000	1	2	0		\N	\N
2966	1434	4	0	f	4000	1	2	0		\N	\N
2967	1434	39	0	f	4000	1	2	0		\N	\N
2968	1434	40	0	f	4000	1	2	0		\N	\N
2969	1435	39	0	t	3000	2	1	0		\N	\N
2970	1435	40	0	t	3000	2	1	0		\N	\N
2971	1435	1	0	t	3000	2	1	0		\N	\N
2972	1436	1	0	f	5000	2	2	0		\N	\N
2973	1436	3	0	f	5000	2	2	0		\N	\N
2974	1436	39	0	f	5000	1	2	0		\N	\N
2975	1436	4	0	f	5000	1	2	0		\N	\N
2976	1437	1	1000	f	6000	1	2	0		\N	\N
2977	1437	39	1000	f	6000	1	2	0		\N	\N
2978	1438	3	0	f	4000	1	2	0		\N	\N
2979	1438	39	0	f	4000	1	2	0		\N	\N
2980	1439	1	0	f	4000	1	2	0		\N	\N
2981	1439	2	0	f	4000	1	2	0		\N	\N
2982	1439	39	0	f	4000	1	2	0		\N	\N
2983	1440	3	1000	t	5000	2	1	0		\N	\N
2984	1440	39	1000	t	5000	2	1	0		\N	\N
2985	1441	39	1000	f	6000	1	2	0		\N	\N
2986	1441	3	1000	f	6000	1	2	0		\N	\N
2952	1431	35	0	t	8000	2	0	0		\N	\N
2953	1431	35	0	f	8000	2	0	0		\N	\N
2958	1431	35	0	t	8000	2	0	0		\N	\N
2965	1434	3	0	f	4000	1	0	0		\N	\N
2987	1442	1	0	t	3000	1	1	0		\N	\N
2988	1443	4	1000	t	5000	1	1	0		\N	\N
2989	1443	39	1000	t	5000	2	1	0		\N	\N
2990	1443	40	1000	f	6000	2	1	0		\N	\N
2993	1444	9	1000	t	9000	2	2	0		\N	\N
2994	1445	1	0	f	4000	1	2	0		\N	\N
2995	1445	39	0	f	4000	1	2	0		\N	\N
2996	1445	2	0	f	4000	1	2	0		\N	\N
2997	1446	3	1000	f	6000	1	2	0		\N	\N
2998	1446	39	2000	f	5000	1	2	0		\N	\N
2999	1446	40	2000	f	5000	1	2	0		\N	\N
3000	1446	4	2000	f	5000	1	2	0		\N	\N
3001	1446	2	2000	f	5000	1	2	0		\N	\N
3005	1448	35	1000	f	6000	2	2	0		\N	\N
3006	1448	35	1000	f	6000	2	2	0		\N	\N
3007	1448	35	1000	f	6000	2	2	0		\N	\N
3008	1448	35	1000	f	6000	2	2	0		\N	\N
3017	1451	35	2000	t	7000	1	2	0		\N	\N
3018	1451	35	2000	f	8000	1	2	0		\N	\N
3019	1451	35	2000	t	7000	1	2	0		\N	\N
3020	1451	35	2000	f	8000	1	2	0		\N	\N
3021	1451	35	2000	f	8000	1	2	0		\N	\N
3022	1452	35	1000	f	6000	1	2	0		\N	\N
3026	1454	3	0	f	4000	2	2	0		\N	\N
3027	1454	39	0	f	4000	2	2	0		\N	\N
3028	1454	40	0	f	4000	2	2	0		\N	\N
3029	1454	1	0	f	4000	2	2	0		\N	\N
3030	1455	1	0	f	4000	1	2	0		\N	\N
3031	1455	4	0	f	4000	1	2	0		\N	\N
3032	1456	1	1000	t	5000	2	1	0		\N	\N
3033	1456	3	1000	t	5000	2	1	0		\N	\N
3034	1456	39	1000	f	6000	1	1	0		\N	\N
3035	1456	40	1000	f	6000	1	1	0		\N	\N
3036	1457	1	0	f	5000	2	2	0		\N	\N
3037	1457	3	0	f	5000	2	2	0		\N	\N
3038	1457	39	1000	f	4000	2	2	0		\N	\N
3039	1457	40	1000	f	4000	2	2	0		\N	\N
3040	1458	1	1000	t	5000	1	1	0		\N	\N
3041	1458	4	1000	t	5000	1	1	0		\N	\N
3042	1458	3	1000	f	6000	1	1	0		\N	\N
3043	1459	1	1000	f	8000	1	2	0		\N	\N
3044	1459	39	1000	f	8000	1	2	0		\N	\N
3045	1460	4	0	f	4000	1	2	0		\N	\N
3046	1460	39	0	f	4000	1	2	0		\N	\N
3047	1461	1	0	t	3000	2	1	0		\N	\N
3048	1461	3	0	f	4000	2	1	0		\N	\N
3049	1462	8	1000	f	10000	1	1	0		\N	\N
3050	1462	9	1000	t	9000	2	1	0		\N	\N
3052	1462	12	1000	f	10000	2	1	0		\N	\N
3053	1462	13	1000	f	10000	3	1	0	Кенты Артура, ТЫ сказал что потом оплатит	\N	\N
3023	1453	8	1000	t	8000	1	0	0		\N	\N
3024	1453	10	1000	f	9000	1	0	0		\N	\N
3025	1453	9	1000	f	9000	1	0	0		\N	\N
2991	1444	35	2000	f	2000	1	0	0		\N	\N
2992	1444	35	2000	f	2000	1	0	0		\N	\N
3054	1463	1	1000	t	5000	1	1	0		\N	\N
3055	1463	3	1000	t	5000	1	1	0		\N	\N
3056	1464	35	2000	f	8000	1	2	0		\N	\N
3057	1465	39	1000	f	6000	1	2	0		\N	\N
3058	1465	40	1000	f	6000	1	2	0		\N	\N
3059	1465	1	1000	f	6000	1	2	0		\N	\N
3060	1465	4	1000	f	6000	1	2	0		\N	\N
3061	1466	39	0	f	4000	1	2	0		\N	\N
3062	1466	40	0	f	4000	1	2	0		\N	\N
3063	1467	9	1000	f	6000	1	2	0		\N	\N
3064	1467	12	1000	f	6000	1	2	0		\N	\N
3065	1468	13	0	f	5000	1	2	0		\N	\N
3066	1469	13	1000	t	9000	1	1	0		\N	\N
3068	1469	7	1000	t	9000	1	1	0		\N	\N
3069	1469	10	1000	t	9000	1	1	0		\N	\N
3073	1471	39	0	f	9000	1	2	0		\N	\N
3074	1471	40	0	f	9000	1	2	0		\N	\N
3075	1471	41	0	f	9000	1	2	0		\N	\N
3076	1472	3	0	t	3000	1	1	0		\N	\N
3077	1472	39	0	f	4000	1	1	0		\N	\N
3078	1472	40	0	f	4000	1	2	0		\N	\N
3079	1472	4	0	f	4000	1	2	0		\N	\N
3080	1473	13	1000	f	4000	1	2	0		\N	\N
3082	1474	40	0	f	4000	1	2	0		\N	\N
3083	1475	7	0	f	5000	1	2	0		\N	\N
3084	1475	12	0	f	5000	1	2	0		\N	\N
3085	1475	13	0	f	5000	1	2	0		\N	\N
3086	1476	3	0	f	4000	1	2	0		\N	\N
3087	1477	1	0	f	4000	1	2	0		\N	\N
3088	1477	39	0	f	4000	1	2	0		\N	\N
3089	1478	3	1000	f	3000	2	2	0		\N	\N
3090	1478	39	1000	f	3000	2	2	0		\N	\N
3091	1478	4	1000	f	3000	2	2	0		\N	\N
3092	1479	39	0	t	3000	2	1	0		\N	\N
3093	1480	39	0	t	3000	2	1	0		\N	\N
3051	1462	7	1000	f	9000	2	0	0	Предоплата не 1000 р а 850	\N	\N
3067	1469	9	1000	t	9000	1	0	0		\N	\N
3070	1470	11	1000	f	10000	2	0	0		\N	\N
3071	1471	1	1000	f	10000	2	0	0		\N	\N
3072	1471	3	1000	f	10000	2	0	0		\N	\N
3081	1474	39	1000	f	4000	1	0	0		\N	\N
3094	1481	4	0	f	4000	1	2	0		\N	\N
3095	1481	39	0	f	4000	1	2	0		\N	\N
3096	1481	40	0	f	4000	1	2	0		\N	\N
3097	1482	39	1000	f	3000	1	2	0		\N	\N
3098	1482	40	1000	f	3000	1	2	0		\N	\N
3099	1482	41	1000	f	3000	1	2	0		\N	\N
3100	1483	3	0	f	4000	1	2	0		\N	\N
3101	1483	1	0	f	4000	1	2	0		\N	\N
3102	1483	4	0	f	4000	1	2	0		\N	\N
3103	1484	1	0	t	6000	2	1	0		\N	\N
3104	1484	2	0	f	7000	1	1	0		\N	\N
3105	1484	3	0	f	7000	1	1	0		\N	\N
3106	1485	35	0	f	4000	1	2	0		\N	\N
3107	1486	9	1000	f	4000	1	2	0		\N	\N
3108	1487	12	1000	f	6000	1	2	0		\N	\N
3109	1487	13	1000	f	6000	1	2	0		\N	\N
3110	1487	35	0	f	5000	1	2	0		\N	\N
3111	1487	35	0	f	5000	1	2	0		\N	\N
3112	1487	35	0	f	5000	1	2	0		\N	\N
3113	1488	7	0	f	5000	1	2	0		\N	\N
3114	1488	9	0	f	5000	1	2	0		\N	\N
3115	1488	8	0	f	5000	1	2	0		\N	\N
3119	1490	9	1000	f	10000	2	2	0		\N	\N
3120	1491	13	1000	f	10000	1	2	0		\N	\N
3121	1491	12	1000	f	10000	1	2	0		\N	\N
3122	1491	10	1000	f	10000	1	2	0		\N	\N
3123	1492	7	0	f	9000	1	2	0		\N	\N
3124	1493	39	0	f	4000	1	2	0		\N	\N
3125	1493	40	0	f	4000	1	2	0		\N	\N
3118	1490	8	1000	f	10000	2	0	0	Переводом 5к	\N	\N
3126	1494	39	0	t	3000	1	1	0		\N	\N
3127	1494	40	0	t	3000	1	1	0		\N	\N
3128	1494	3	0	f	4000	1	2	0		\N	\N
3129	1494	5	0	f	4000	1	2	0		\N	\N
3130	1495	1	0	f	4000	1	2	0		\N	\N
3131	1496	9	1000	f	4000	1	2	0		\N	\N
3132	1497	4	2000	f	3000	1	2	0		\N	\N
3133	1497	3	2000	f	3000	2	2	0		\N	\N
3134	1497	39	0	t	4000	2	1	0		\N	\N
3135	1497	1	0	t	4000	1	1	0		\N	\N
3136	1498	39	1000	t	5000	2	1	0		\N	\N
3137	1498	39	1000	f	6000	2	1	0		\N	\N
3138	1499	1	1000	f	3000	2	2	0		\N	\N
3139	1499	2	1000	f	3000	2	2	0		\N	\N
3140	1500	12	1000	t	9000	1	1	0		\N	\N
3141	1500	13	1000	f	10000	1	1	0		\N	\N
3142	1501	39	0	f	5000	1	4	0		\N	\N
3143	1501	40	0	f	5000	1	4	0		\N	\N
3144	1502	7	3000	f	8000	2	2	0		\N	\N
3145	1502	9	3000	f	8000	2	2	0		\N	\N
3146	1502	8	1000	f	10000	2	2	0	Заплатили 12 к с майри парка. 2 тыс комиссия	\N	\N
3147	1502	12	1000	t	9000	2	2	0		\N	\N
3148	1502	35	2000	f	8000	2	2	0		\N	\N
3151	1504	1	1000	f	6000	2	2	0		\N	\N
3152	1504	2	1000	f	6000	2	2	0		\N	\N
3154	1505	39	0	f	4000	1	3	1000		\N	\N
3155	1506	4	0	f	4000	1	2	0		\N	\N
3156	1506	3	0	f	4000	1	2	0		\N	\N
3150	1503	39	0	f	5000	1	0	0		\N	\N
3153	1504	4	1000	f	6000	2	0	0		\N	\N
3157	1507	35	2000	t	7000	2	1	0		\N	\N
3159	1509	12	1000	f	10000	2	1	0		\N	\N
3160	1509	13	1000	f	10000	2	1	0		\N	\N
3161	1510	3	0	t	3000	1	1	0		\N	\N
3162	1510	39	0	f	4000	1	1	0		\N	\N
3168	1512	1	1000	f	3000	1	2	0		\N	\N
3169	1512	2	1000	f	3000	1	2	0		\N	\N
3170	1512	4	1000	f	3000	1	2	0		\N	\N
3171	1512	39	1000	f	3000	1	2	0		\N	\N
3172	1512	40	1000	f	3000	1	2	0		\N	\N
3174	1514	39	1000	t	5000	1	2	0		\N	\N
3175	1515	1	1000	t	5000	2	1	0		\N	\N
3176	1515	3	1000	f	6000	2	1	0		\N	\N
3177	1515	39	3000	f	4000	1	2	0		\N	\N
3178	1516	5	1000	t	5000	1	1	0		\N	\N
3179	1516	39	1000	f	6000	1	1	0		\N	\N
3180	1517	1	1000	f	3000	1	2	0		\N	\N
3181	1517	39	1000	f	3000	1	2	0		\N	\N
3182	1517	40	1000	f	3000	1	2	0		\N	\N
3183	1517	41	1000	f	3000	1	2	0		\N	\N
3184	1518	13	1000	f	4000	1	2	0		\N	\N
3185	1519	1	0	t	4000	1	2	0		\N	\N
3186	1519	39	0	f	5000	1	2	0		\N	\N
3187	1519	40	0	f	5000	1	2	0		\N	\N
3188	1520	3	0	t	3000	1	1	0		\N	\N
3189	1520	39	1000	f	3000	1	2	0		\N	\N
3191	1521	4	0	f	5000	1	1	0		\N	\N
3192	1522	13	1000	f	6000	2	2	0		\N	\N
3193	1522	12	1000	f	6000	2	2	0		\N	\N
3194	1522	8	1000	f	6000	1	2	0		\N	\N
3195	1523	2	0	t	4000	1	1	0		\N	\N
3196	1524	9	0	t	8000	1	1	0	Заплатили 10000₽ не понял как заполнить \n	\N	\N
3197	1525	39	0	t	4000	2	1	0		\N	\N
3198	1526	3	1000	t	5000	2	1	0		\N	\N
3199	1526	4	3500	f	3500	2	1	0		\N	\N
3200	1526	1	2000	f	5000	2	2	0		\N	\N
3201	1527	39	0	f	5000	2	2	0		\N	\N
3202	1527	1	0	f	5000	2	2	0		\N	\N
3203	1528	12	0	f	5000	2	2	0		\N	\N
3204	1529	39	1000	f	3000	1	2	0		\N	\N
3205	1529	40	1000	f	3000	1	2	0		\N	\N
3206	1529	41	1000	f	3000	1	2	0		\N	\N
3207	1530	3	0	f	4000	2	5	0		\N	\N
3208	1530	2	0	f	4000	2	5	0		\N	\N
3209	1530	4	0	f	4000	2	5	0		\N	\N
3211	1531	3	0	t	4000	1	1	0		\N	\N
3212	1532	39	1500	f	1500	1	3	1000	Комиссия отелю поэтому скидка	\N	\N
3213	1532	40	1500	f	2500	1	3	0		\N	\N
3215	1533	10	0	f	9000	1	2	0		\N	\N
3216	1533	12	0	f	9000	1	2	0		\N	\N
3217	1533	13	0	f	9000	1	2	0		\N	\N
3218	1534	40	0	t	4000	1	1	0		\N	\N
3219	1534	41	0	f	5000	1	1	0		\N	\N
3220	1534	2	0	f	5000	1	1	0		\N	\N
3221	1534	4	0	f	5000	1	1	0		\N	\N
3222	1535	42	0	f	5000	1	1	0		\N	\N
3223	1536	2	0	f	5000	1	2	0		\N	\N
3224	1536	39	0	f	5000	1	2	0		\N	\N
3225	1536	40	0	t	4000	2	2	0		\N	\N
3226	1537	2	0	f	5000	1	1	0		\N	\N
3227	1538	35	0	f	7000	1	2	0		\N	\N
3228	1538	35	0	f	7000	2	2	0		\N	\N
3229	1539	12	2000	f	5000	1	2	0		\N	\N
3230	1539	13	2000	f	5000	1	2	0		\N	\N
3232	1541	8	1000	t	7000	1	1	0		\N	\N
3233	1542	12	1000	f	4000	1	2	0		\N	\N
3234	1543	13	0	f	9000	1	2	0		\N	\N
3235	1543	8	0	f	9000	1	2	0		\N	\N
3214	1533	8	0	f	9000	1	2	3600		\N	\N
3237	1545	9	0	f	9000	1	2	0		\N	\N
3238	1546	4	0	f	4500	1	1	500		\N	\N
3239	1547	12	1000	t	5000	2	1	0		\N	\N
3240	1548	4	0	f	4000	1	2	0		\N	\N
3241	1548	39	0	f	4000	1	2	0		\N	\N
3242	1548	40	0	f	4000	1	2	0		\N	\N
3243	1548	41	0	f	4000	1	2	0		\N	\N
3244	1549	2	0	t	3000	2	1	0		\N	\N
3245	1550	1	0	t	4000	1	1	0		\N	\N
3246	1550	39	0	f	5000	1	1	0		\N	\N
3247	1550	40	0	f	5000	1	1	0		\N	\N
3248	1551	4	0	t	4000	1	1	0		\N	\N
3249	1552	1	0	f	5000	1	2	0		\N	\N
3250	1552	2	0	f	5000	1	2	0		\N	\N
3251	1552	39	0	f	5000	1	2	0		\N	\N
3252	1552	40	0	f	5000	1	2	0		\N	\N
3253	1552	41	0	f	5000	1	2	0		\N	\N
3254	1553	39	1000	f	6000	1	2	0		\N	\N
3255	1553	4	1000	f	6000	1	2	0		\N	\N
3256	1554	1	0	t	4000	2	1	0		\N	\N
3257	1555	39	0	t	4000	2	1	0		\N	\N
3258	1555	40	0	t	4000	2	1	0		\N	\N
3259	1556	1	500	f	4500	1	2	0		\N	\N
3260	1556	2	500	f	4500	1	2	0		\N	\N
3261	1557	39	500	f	3500	1	3	1000	Откат премиум виладж	\N	\N
3262	1558	1	0	t	3000	2	1	0		\N	\N
3263	1558	2	0	t	3000	2	1	0		\N	\N
3264	1559	4	0	t	3000	2	1	0		\N	\N
3265	1560	39	0	t	4000	2	1	0		\N	\N
3266	1560	40	0	t	4000	1	1	0		\N	\N
3267	1561	3	1000	f	3000	2	2	0		\N	\N
3268	1561	1	1000	f	3000	2	2	0		\N	\N
3269	1561	39	1000	f	3000	1	2	0		\N	\N
3270	1562	8	0	t	4000	1	1	0		\N	\N
3271	1563	39	1000	t	2000	1	1	0		\N	\N
3272	1564	3	1000	f	3000	1	2	0		\N	\N
3273	1564	39	1000	f	3000	1	2	0		\N	\N
3274	1565	1	1000	f	3000	2	2	0		\N	\N
3275	1565	39	1000	f	3000	2	2	0		\N	\N
3276	1566	12	1000	f	6000	1	2	0		\N	\N
3277	1566	13	1000	f	6000	1	2	0		\N	\N
3278	1567	35	0	f	5000	1	2	0		\N	\N
3279	1567	35	0	f	5000	1	2	0		\N	\N
3280	1568	39	0	t	4000	1	1	0		\N	\N
3281	1568	40	0	f	5000	1	1	0		\N	\N
3282	1568	2	0	t	4000	2	1	0		\N	\N
3283	1568	4	0	f	5000	2	1	0		\N	\N
3210	1531	1	0	t	4000	2	1	800		\N	\N
3381	1617	39	0	t	8000	1	1	0		\N	\N
3382	1617	1	0	t	8000	1	1	0		\N	\N
3383	1617	4	0	f	9000	1	1	0		\N	\N
3288	1570	13	0	t	8000	2	1	0		\N	\N
3289	1570	9	0	f	9000	2	1	0		\N	\N
3290	1570	10	0	f	9000	2	1	0		\N	\N
3291	1570	35	0	f	7000	2	1	0		\N	\N
3292	1571	35	0	f	7000	2	1	0		\N	\N
3293	1571	35	0	f	7000	2	1	0		\N	\N
3294	1571	35	0	f	7000	2	1	0		\N	\N
3295	1571	35	0	f	7000	2	1	0		\N	\N
3296	1571	35	0	f	7000	2	1	0		\N	\N
3384	1617	40	0	f	9000	1	2	0		\N	\N
3387	1619	4	3000	t	5000	1	1	0		\N	\N
3388	1619	1	1000	f	8000	2	2	0		\N	\N
3389	1620	39	2000	f	2000	1	2	0		\N	\N
3390	1620	1	2000	f	2000	1	2	0		\N	\N
3473	1658	1	0	t	8000	1	1	0		\N	\N
3474	1658	39	0	t	8000	2	1	0		\N	\N
3603	1709	39	0	t	8000	2	2	0		\N	\N
3231	1540	4	0	t	5000	2	1	0		\N	\N
5917	2767	13	0	t	5000	1	1	0		\N	2024-10-07 17:32:00.234677+03
5918	2768	21	0	f	5000	1	2	0	Ренат	\N	2024-10-08 13:03:00.452247+03
5919	2769	23	0	t	7000	6	1	0		\N	2024-10-08 17:11:05.088731+03
5920	2769	11	0	t	9000	1	1	0		\N	2024-10-08 17:11:05.089731+03
5921	2769	12	0	t	9000	6	1	0		\N	2024-10-08 17:11:05.090933+03
5922	2769	13	0	t	9000	6	1	0		\N	2024-10-08 17:11:05.091383+03
5923	2770	19	0	t	7000	4	1	0		\N	2024-10-08 17:37:17.790713+03
5924	2770	32	0	t	7000	4	1	0		\N	2024-10-08 17:37:17.791454+03
5925	2770	28	0	t	7000	4	1	0		\N	2024-10-08 17:37:17.792056+03
5926	2770	33	0	t	7000	4	1	0		\N	2024-10-08 17:37:17.79261+03
5927	2770	20	0	t	7000	4	1	0		\N	2024-10-08 17:37:17.793121+03
5928	2770	25	0	t	7000	4	1	0		\N	2024-10-08 17:37:17.793663+03
5929	2770	22	0	t	7000	4	1	0		\N	2024-10-08 17:37:17.794314+03
5930	2770	21	0	t	7000	4	1	0		\N	2024-10-08 17:37:17.794968+03
5931	2770	30	0	t	7000	4	1	0		\N	2024-10-08 17:37:17.795633+03
5932	2771	13	0	t	11000	6	1	0		\N	2024-10-09 17:46:25.726293+03
5933	2771	13	10000	f	2000	6	1	0	2 вездехода с подъёмом 	\N	2024-10-09 17:46:25.727147+03
5934	2771	12	0	t	11000	6	1	0		\N	2024-10-09 17:46:25.727711+03
5935	2772	9	2000	f	8000	3	3	0	Аллюр. Ренат	\N	2024-10-09 17:52:49.563869+03
5936	2772	20	0	t	7000	6	1	0		\N	2024-10-09 17:52:49.565071+03
5937	2773	30	0	f	3000	1	2	0		\N	2024-10-09 17:53:51.981652+03
5938	2773	11	0	f	4000	1	2	0		\N	2024-10-09 17:53:51.984956+03
5939	2774	12	0	t	11000	1	1	0		\N	2024-10-09 17:54:54.705739+03
5940	2774	9	0	t	11000	1	1	0		\N	2024-10-09 17:54:54.706334+03
5941	2775	25	0	f	3000	1	2	0	Ренат	\N	2024-10-09 17:56:15.271283+03
5942	2776	33	0	f	3000	6	2	0	Ренат\n\n	\N	2024-10-09 17:56:55.513667+03
5943	2777	12	0	t	11000	6	1	0		\N	2024-10-10 09:59:05.789244+03
5944	2778	20	0	t	7000	6	1	0	Ренат	\N	2024-10-10 12:50:34.16804+03
5945	2778	21	0	t	7000	6	1	0		\N	2024-10-10 12:50:34.169196+03
5946	2778	30	0	t	7000	6	1	0		\N	2024-10-10 12:50:34.169902+03
5947	2778	23	0	t	7000	6	1	0		\N	2024-10-10 12:50:34.172973+03
5948	2778	32	0	f	8000	6	2	0		\N	2024-10-10 12:50:34.174368+03
5949	2779	11	0	t	11000	6	1	0		\N	2024-10-10 13:58:07.435248+03
5950	2779	9	0	t	11000	6	1	0		\N	2024-10-10 13:58:07.436363+03
5951	2779	12	0	t	11000	6	1	0		\N	2024-10-10 13:58:07.437053+03
5952	2779	13	0	t	11000	1	1	0		\N	2024-10-10 13:58:07.43776+03
\.


--
-- Data for Name: flights; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.flights (id, flight_date, flight_number, route_id, instructor_id, manager_id, confirmed, source_id, source_data, created_at) FROM stdin;
1572	2024-01-14	4	4	6	2	t	1	\N	\N
1592	2024-01-17	1	3	7	2	t	1	\N	\N
1624	2024-01-21	4	1	14	2	t	1	\N	\N
1609	2024-01-20	1	3	6	2	t	1	\N	\N
1626	2024-01-21	6	3	6	2	t	1	\N	\N
1627	2024-01-21	7	3	6	2	t	1	\N	\N
1687	2024-01-27	6	4	6	2	t	1	\N	\N
1644	2024-01-22	6	2	6	2	t	1	\N	\N
1645	2024-01-22	7	3	6	2	t	1	\N	\N
1688	2024-01-27	7	2	6	2	t	1	\N	\N
1660	2024-01-24	5	4	6	2	t	1	\N	\N
1677	2024-01-26	4	4	6	2	t	1	\N	\N
1707	2024-01-29	8	4	6	2	t	1	\N	\N
1903	2024-02-18	4	2	6	2	t	1	{"dateIncome":"2024-02-18","typeRoute":2,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-18 11:09:01.075342+03
1708	2024-01-29	9	1	14	2	t	1	\N	\N
1752	2024-02-04	6	1	14	2	t	1	\N	\N
1753	2024-02-04	7	4	7	2	t	1	\N	\N
1728	2024-02-02	3	1	14	2	t	1	\N	\N
1729	2024-02-02	4	1	14	2	t	1	\N	\N
1732	2024-02-02	7	2	7	2	t	1	\N	\N
1821	2024-02-10	5	1	7	2	t	1	\N	\N
1745	2024-02-03	11	3	6	2	t	1	\N	\N
1766	2024-02-05	6	4	7	2	t	1	\N	\N
1746	2024-02-03	12	4	7	2	t	1	\N	\N
1781	2024-02-06	10	4	14	2	t	1	\N	\N
1794	2024-02-08	1	2	9	2	t	1	\N	\N
1835	2024-02-11	6	4	14	2	t	1	\N	\N
1811	2024-02-09	9	1	14	2	t	1	\N	\N
1854	2024-02-13	1	1	14	2	t	1	\N	\N
1872	2024-02-14	9	3	6	2	t	1	{"dateIncome":"2024-02-14","typeRoute":3,"flightNumber":9,"instructor":6,"techniques":[{"typeTechnique":39,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":40,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":51,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":48,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000}]}	\N
1921	2024-02-20	2	2	6	2	t	1	{"dateIncome":"2024-02-20","typeRoute":2,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":51,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-20 14:48:49.472923+03
1873	2024-02-14	10	4	6	2	t	1	{"dateIncome":"2024-02-14","typeRoute":4,"flightNumber":10,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	\N
1887	2024-02-16	7	1	7	2	t	1	{"dateIncome":"2024-02-16","typeRoute":1,"flightNumber":7,"instructor":7,"techniques":[{"typeTechnique":12,"discount":5000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":12,"discount":5000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	\N
1940	2024-02-23	5	1	14	2	t	1	{"dateIncome":"2024-02-23","typeRoute":1,"flightNumber":5,"instructor":14,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":5000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"С инструктором ","price":5000}]}	2024-02-23 16:32:09.812098+03
1902	2024-02-18	3	4	7	2	t	1	{"dateIncome":"2024-02-18","typeRoute":4,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":9,"discount":3000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-18 11:04:47.717405+03
1944	2024-02-23	7	3	6	2	t	1	{"dateIncome":"2024-02-23","typeRoute":3,"flightNumber":7,"instructor":6,"techniques":[{"typeTechnique":39,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":48,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-23 16:36:34.844315+03
1938	2024-02-23	3	2	6	2	t	1	{"dateIncome":"2024-02-23","typeRoute":2,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":39,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":48,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":49,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-02-23 16:26:34.790772+03
1939	2024-02-23	4	3	6	2	t	1	{"dateIncome":"2024-02-23","typeRoute":3,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":39,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":51,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-23 16:28:11.638209+03
1972	2024-02-25	11	1	7	2	t	1	{"dateIncome":"2024-02-25","typeRoute":1,"flightNumber":11,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-25 16:39:41.92156+03
1981	2024-02-27	4	2	6	2	t	1	{"dateIncome":"2024-02-27","typeRoute":2,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"Аллюр","price":9000}]}	2024-02-27 16:59:22.049852+03
1573	2024-01-14	5	4	6	2	t	1	\N	\N
1593	2024-01-17	2	4	7	2	t	1	\N	\N
1625	2024-01-21	5	3	6	2	t	1	\N	\N
1610	2024-01-20	2	2	14	2	t	1	\N	\N
1628	2024-01-21	8	3	6	2	t	1	\N	\N
1689	2024-01-28	1	3	7	2	t	1	\N	\N
1646	2024-01-22	8	4	6	2	t	1	\N	\N
1661	2024-01-24	6	4	6	2	t	1	\N	\N
1678	2024-01-26	5	2	6	2	t	1	\N	\N
1692	2024-01-28	4	4	6	2	t	1	\N	\N
1693	2024-01-28	5	3	6	2	t	1	\N	\N
1695	2024-01-28	7	2	6	2	t	1	\N	\N
1754	2024-02-04	8	4	6	2	t	1	\N	\N
1709	2024-01-30	1	2	6	2	t	1	\N	\N
1755	2024-02-04	9	4	6	2	t	1	\N	\N
1712	2024-01-30	4	4	7	2	t	1	\N	\N
1733	2024-02-02	8	4	14	2	t	1	\N	\N
1822	2024-02-10	6	1	14	2	t	1	\N	\N
1747	2024-02-04	1	1	7	2	t	1	\N	\N
1757	2024-02-04	11	4	14	2	t	1	\N	\N
1748	2024-02-04	2	4	6	2	t	1	\N	\N
1767	2024-02-05	7	4	6	2	t	1	\N	\N
1782	2024-02-06	11	3	6	2	t	1	\N	\N
1838	2024-02-11	9	2	7	2	t	1	\N	\N
1795	2024-02-08	2	4	14	2	t	1	\N	\N
1796	2024-02-08	3	4	7	2	t	1	\N	\N
1922	2024-02-20	3	4	6	2	t	1	{"dateIncome":"2024-02-20","typeRoute":4,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":40,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":50,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":51,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":5,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-20 14:50:35.726056+03
1798	2024-02-08	4	1	7	2	t	1	\N	\N
1812	2024-02-09	10	4	6	2	t	1	\N	\N
1923	2024-02-20	4	1	14	2	t	1	{"dateIncome":"2024-02-20","typeRoute":1,"flightNumber":4,"instructor":14,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-20 14:51:45.321853+03
1813	2024-02-09	11	3	6	2	t	1	\N	\N
1855	2024-02-13	2	4	14	2	t	1	\N	\N
1857	2024-02-13	4	4	7	2	t	1	\N	\N
1858	2024-02-13	5	2	7	2	t	1	\N	\N
1860	2024-02-13	7	4	7	2	t	1	\N	\N
1926	2024-02-20	7	4	14	2	t	1	{"dateIncome":"2024-02-20","typeRoute":4,"flightNumber":7,"instructor":14,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-20 15:13:43.485657+03
1874	2024-02-15	1	4	7	2	t	1	{"dateIncome":"2024-02-15","typeRoute":4,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":12,"discount":2000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":12,"discount":2000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":12,"discount":3000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	\N
1888	2024-02-17	1	1	14	2	t	1	{"dateIncome":"2024-02-17","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Оплатил заранее все 10","price":10000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-17 10:50:29.611861+03
1904	2024-02-18	5	4	14	2	t	1	{"dateIncome":"2024-02-18","typeRoute":4,"flightNumber":5,"instructor":14,"techniques":[{"typeTechnique":11,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-18 11:28:03.136187+03
1928	2024-02-20	8	1	14	2	t	1	{"dateIncome":"2024-02-20","typeRoute":1,"flightNumber":8,"instructor":14,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-20 15:21:08.778703+03
1924	2024-02-20	5	1	7	2	t	1	{"dateIncome":"2024-02-20","typeRoute":1,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-02-20 15:11:30.632231+03
1925	2024-02-20	6	4	7	2	t	1	{"dateIncome":"2024-02-20","typeRoute":4,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-20 15:13:06.682503+03
1943	2024-02-23	6	3	6	2	t	1	{"dateIncome":"2024-02-23","typeRoute":3,"flightNumber":6,"instructor":6,"techniques":[{"typeTechnique":50,"discount":1400,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3600},{"typeTechnique":51,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-02-23 16:35:45.805602+03
1574	2024-01-14	6	4	6	2	t	1	\N	\N
1594	2024-01-17	3	2	6	2	t	1	\N	\N
1629	2024-01-21	9	4	6	2	t	1	\N	\N
1595	2024-01-17	4	3	9	2	t	1	\N	\N
1611	2024-01-20	3	3	6	2	t	1	\N	\N
1749	2024-02-04	3	4	6	2	t	1	\N	\N
1631	2024-01-21	11	3	7	2	t	1	\N	\N
1647	2024-01-22	9	3	7	2	t	1	\N	\N
1751	2024-02-04	5	4	6	2	t	1	\N	\N
1662	2024-01-24	7	1	7	2	t	1	\N	\N
1679	2024-01-26	6	1	7	2	t	1	\N	\N
1690	2024-01-28	2	2	6	2	t	1	\N	\N
1691	2024-01-28	3	3	6	2	t	1	\N	\N
1694	2024-01-28	6	4	7	2	t	1	\N	\N
1756	2024-02-04	10	3	6	2	t	1	\N	\N
1710	2024-01-30	2	2	6	2	t	1	\N	\N
1711	2024-01-30	3	3	7	2	t	1	\N	\N
1734	2024-02-03	1	3	7	2	t	1	\N	\N
1823	2024-02-10	7	4	7	2	t	1	\N	\N
1768	2024-02-05	8	1	7	2	t	1	\N	\N
1929	2024-02-20	9	3	14	2	t	1	{"dateIncome":"2024-02-20","typeRoute":3,"flightNumber":9,"instructor":14,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-02-20 16:57:55.50137+03
1769	2024-02-05	9	4	6	2	t	1	\N	\N
1783	2024-02-07	1	4	14	2	t	1	\N	\N
1816	2024-02-09	13	4	6	2	t	1	\N	\N
1930	2024-02-20	10	4	9	2	t	1	{"dateIncome":"2024-02-20","typeRoute":4,"flightNumber":10,"instructor":9,"techniques":[{"typeTechnique":48,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":50,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-20 17:30:22.328414+03
1839	2024-02-11	12	4	7	2	t	1	\N	\N
1856	2024-02-13	3	2	7	2	t	1	\N	\N
1945	2024-02-23	8	2	14	2	t	1	{"dateIncome":"2024-02-23","typeRoute":2,"flightNumber":8,"instructor":14,"techniques":[{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Тут предоплата 2000 просто добавил к оплате переводом ","price":8000}]}	2024-02-23 16:54:26.284729+03
1875	2024-02-15	2	3	7	2	t	1	{"dateIncome":"2024-02-15","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	\N
1955	2024-02-24	7	3	6	2	t	1	{"dateIncome":"2024-02-24","typeRoute":3,"flightNumber":7,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":51,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-24 17:24:38.412034+03
1876	2024-02-15	3	2	6	2	t	1	{"dateIncome":"2024-02-15","typeRoute":2,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	\N
1877	2024-02-15	4	2	6	2	t	1	{"dateIncome":"2024-02-15","typeRoute":2,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	\N
1889	2024-02-17	2	4	6	2	t	1	{"dateIncome":"2024-02-17","typeRoute":4,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":50,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-17 10:53:45.22761+03
1957	2024-02-24	9	3	6	2	t	1	{"dateIncome":"2024-02-24","typeRoute":3,"flightNumber":9,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":49,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-24 17:32:28.891828+03
1905	2024-02-18	6	1	7	2	t	1	{"dateIncome":"2024-02-18","typeRoute":1,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-18 12:31:01.663101+03
1973	2024-02-26	1	2	7	2	t	1	{"dateIncome":"2024-02-26","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":35,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":35,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":9,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-26 14:43:14.464386+03
1983	2024-02-28	2	1	7	2	t	1	{"dateIncome":"2024-02-28","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-28 13:45:59.478734+03
1982	2024-02-28	1	4	6	2	t	1	{"dateIncome":"2024-02-28","typeRoute":4,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":42,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-28 13:45:10.166495+03
1575	2024-01-14	7	3	14	2	t	1	\N	\N
1596	2024-01-17	5	4	3	2	t	1	\N	\N
1612	2024-01-20	4	3	7	2	t	1	\N	\N
1630	2024-01-21	10	4	6	2	t	1	\N	\N
1648	2024-01-23	1	4	7	2	t	1	\N	\N
1750	2024-02-04	4	4	6	2	t	1	\N	\N
1696	2024-01-28	8	1	14	2	t	1	\N	\N
1663	2024-01-25	1	3	7	2	t	1	\N	\N
1664	2024-01-25	2	4	6	2	t	1	\N	\N
1680	2024-01-26	7	4	6	2	t	1	\N	\N
1713	2024-01-31	1	2	6	2	t	1	\N	\N
1735	2024-02-03	2	3	7	2	t	1	\N	\N
1906	2024-02-18	7	1	14	2	t	1	{"dateIncome":"2024-02-18","typeRoute":1,"flightNumber":7,"instructor":14,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"Откат отдали ","price":9000},{"typeTechnique":13,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"Откат отдали ","price":9000}]}	2024-02-18 15:22:19.740584+03
1758	2024-02-04	12	4	7	2	t	1	\N	\N
1770	2024-02-05	10	4	6	2	t	1	\N	\N
1907	2024-02-18	8	3	7	2	t	1	{"dateIncome":"2024-02-18","typeRoute":3,"flightNumber":8,"instructor":7,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-02-18 15:26:27.871464+03
1771	2024-02-05	11	4	7	2	t	1	\N	\N
1824	2024-02-10	8	3	6	2	t	1	\N	\N
1784	2024-02-07	2	3	14	2	t	1	\N	\N
1825	2024-02-10	9	4	6	2	t	1	\N	\N
1799	2024-02-08	5	2	6	2	t	1	\N	\N
1815	2024-02-09	12	2	6	2	t	1	\N	\N
1843	2024-02-11	13	3	14	2	t	1	\N	\N
1960	2024-02-24	12	4	14	2	t	1	{"dateIncome":"2024-02-24","typeRoute":4,"flightNumber":12,"instructor":14,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-24 17:39:07.343979+03
1931	2024-02-21	1	2	6	2	t	1	{"dateIncome":"2024-02-21","typeRoute":2,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-21 14:10:18.714868+03
1946	2024-02-23	9	3	6	2	t	1	{"dateIncome":"2024-02-23","typeRoute":3,"flightNumber":9,"instructor":6,"techniques":[{"typeTechnique":48,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"Все 3 с Аллюра","price":4000},{"typeTechnique":50,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":39,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-23 17:23:45.605051+03
1859	2024-02-13	6	3	7	2	t	1	\N	\N
1878	2024-02-15	5	3	7	2	t	1	{"dateIncome":"2024-02-15","typeRoute":3,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	\N
1890	2024-02-17	3	4	7	2	t	1	{"dateIncome":"2024-02-17","typeRoute":4,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-17 12:41:31.3307+03
1891	2024-02-17	4	4	7	2	t	1	{"dateIncome":"2024-02-17","typeRoute":4,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-17 12:43:06.220862+03
1956	2024-02-24	8	1	6	2	t	1	{"dateIncome":"2024-02-24","typeRoute":1,"flightNumber":8,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":51,"discount":3500,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2500},{"typeTechnique":51,"discount":3500,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2500}]}	2024-02-24 17:31:04.757621+03
1976	2024-02-26	4	2	6	2	t	1	{"dateIncome":"2024-02-26","typeRoute":2,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":42,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-26 15:30:00.192368+03
1974	2024-02-26	2	1	7	2	t	1	{"dateIncome":"2024-02-26","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-26 14:44:44.432424+03
1984	2024-02-28	3	1	6	2	t	1	{"dateIncome":"2024-02-28","typeRoute":1,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-28 14:05:30.743412+03
1975	2024-02-26	3	1	6	2	t	1	{"dateIncome":"2024-02-26","typeRoute":1,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":48,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":49,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":39,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-26 15:28:45.560796+03
1998	2024-03-02	3	1	14	2	t	1	{"dateIncome":"2024-03-02","typeRoute":1,"flightNumber":3,"instructor":14,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-02 15:24:08.101118+03
1842	2024-02-11	10	4	7	2	t	2	\N	\N
1576	2024-01-14	8	3	7	2	t	1	\N	\N
1597	2024-01-17	6	3	3	2	t	1	\N	\N
1613	2024-01-20	5	4	7	2	t	1	\N	\N
1614	2024-01-20	6	4	14	2	t	1	\N	\N
1632	2024-01-21	12	4	7	2	t	1	\N	\N
1633	2024-01-21	13	3	14	2	t	1	\N	\N
1697	2024-01-28	9	4	7	2	t	1	\N	\N
1635	2024-01-21	14	3	6	2	t	1	\N	\N
1714	2024-01-31	2	4	7	2	t	1	\N	\N
1649	2024-01-23	2	1	14	2	t	1	\N	\N
1651	2024-01-23	4	3	6	2	t	1	\N	\N
1652	2024-01-23	5	2	6	2	t	1	\N	\N
1653	2024-01-23	6	3	6	2	t	1	\N	\N
1959	2024-02-24	11	1	6	2	t	1	{"dateIncome":"2024-02-24","typeRoute":1,"flightNumber":11,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":51,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-24 17:36:19.486017+03
1736	2024-02-03	3	4	7	2	t	1	\N	\N
1665	2024-01-25	3	1	7	2	t	1	\N	\N
1667	2024-01-25	5	4	6	2	t	1	\N	\N
1681	2024-01-27	1	1	7	2	t	1	\N	\N
1772	2024-02-06	1	4	14	2	t	1	\N	\N
1737	2024-02-03	4	1	14	2	t	1	\N	\N
1826	2024-02-10	10	2	6	2	t	1	\N	\N
1785	2024-02-07	3	4	6	2	t	1	\N	\N
1786	2024-02-07	4	4	7	2	t	1	\N	\N
1932	2024-02-21	2	1	14	2	t	1	{"dateIncome":"2024-02-21","typeRoute":1,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-21 14:15:27.620605+03
1800	2024-02-08	6	4	7	2	t	1	\N	\N
1844	2024-02-12	1	3	14	2	t	1	\N	\N
1817	2024-02-10	1	1	14	2	t	1	\N	\N
1879	2024-02-15	6	1	7	2	t	1	{"dateIncome":"2024-02-15","typeRoute":1,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":35,"discount":5000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":1000}]}	\N
1947	2024-02-23	10	4	6	2	t	1	{"dateIncome":"2024-02-23","typeRoute":4,"flightNumber":10,"instructor":6,"techniques":[{"typeTechnique":51,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":48,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-23 17:35:18.131931+03
1892	2024-02-17	5	4	6	2	t	1	{"dateIncome":"2024-02-17","typeRoute":4,"flightNumber":5,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-17 14:17:04.003536+03
1893	2024-02-17	6	2	6	2	t	1	{"dateIncome":"2024-02-17","typeRoute":2,"flightNumber":6,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":40,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":51,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-17 14:18:40.656108+03
1908	2024-02-18	9	3	7	2	t	1	{"dateIncome":"2024-02-18","typeRoute":3,"flightNumber":9,"instructor":7,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-02-18 16:03:29.161286+03
1961	2024-02-24	13	2	7	2	t	1	{"dateIncome":"2024-02-24","typeRoute":2,"flightNumber":13,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Откат отдали ","price":9000},{"typeTechnique":35,"discount":2300,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"С комиссией ","price":7700}]}	2024-02-24 17:46:41.512703+03
1958	2024-02-24	10	1	6	2	t	1	{"dateIncome":"2024-02-24","typeRoute":1,"flightNumber":10,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":50,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":39,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-02-24 17:34:02.194441+03
1977	2024-02-26	5	4	6	2	t	1	{"dateIncome":"2024-02-26","typeRoute":4,"flightNumber":5,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":49,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":42,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-26 15:30:51.845167+03
1991	2024-03-01	1	2	14	2	t	1	{"dateIncome":"2024-03-01","typeRoute":2,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-03-01 12:29:42.47642+03
1985	2024-02-28	4	2	6	2	t	1	{"dateIncome":"2024-02-28","typeRoute":2,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":49,"discount":0,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"Скорее всего с аллюра","price":9000}]}	2024-02-28 14:10:55.882189+03
1636	2024-01-21	15	4	6	2	t	1	\N	\N
1577	2024-01-15	1	3	6	2	t	1	\N	\N
1578	2024-01-15	2	4	6	2	t	1	\N	\N
1580	2024-01-15	4	4	6	2	t	1	\N	\N
1582	2024-01-16	1	1	7	2	t	1	\N	\N
1598	2024-01-17	7	4	3	2	t	1	\N	\N
1615	2024-01-20	7	1	7	2	t	1	\N	\N
1698	2024-01-28	10	4	6	2	t	1	\N	\N
1650	2024-01-23	3	4	6	2	t	1	\N	\N
1666	2024-01-25	4	4	7	2	t	1	\N	\N
1669	2024-01-25	6	3	6	2	f	1	\N	\N
1668	2024-01-25	6	3	6	2	t	1	\N	\N
1682	2024-01-27	2	4	14	2	t	1	\N	\N
1760	2024-02-04	13	3	6	2	t	1	\N	\N
1715	2024-01-31	3	1	14	2	t	1	\N	\N
1716	2024-01-31	4	4	7	2	t	1	\N	\N
1718	2024-01-31	6	2	6	2	t	1	\N	\N
1738	2024-02-03	5	2	7	2	t	1	\N	\N
1773	2024-02-06	2	4	6	2	t	1	\N	\N
1911	2024-02-18	11	3	14	2	t	1	{"dateIncome":"2024-02-18","typeRoute":3,"flightNumber":11,"instructor":14,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-02-18 17:53:07.6794+03
1787	2024-02-07	5	1	14	2	t	1	\N	\N
1845	2024-02-12	2	4	7	2	t	1	\N	\N
1801	2024-02-08	7	4	6	2	t	1	\N	\N
1910	2024-02-18	10	2	6	2	t	1	{"dateIncome":"2024-02-18","typeRoute":2,"flightNumber":10,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":49,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":5,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":40,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-18 17:28:54.327986+03
1818	2024-02-10	2	1	14	2	t	1	\N	\N
1819	2024-02-10	3	4	7	2	t	1	\N	\N
1862	2024-02-13	8	2	7	2	t	1	\N	\N
1880	2024-02-15	7	4	6	2	t	1	{"dateIncome":"2024-02-15","typeRoute":4,"flightNumber":7,"instructor":6,"techniques":[{"typeTechnique":39,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":48,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":50,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":51,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	\N
1933	2024-02-21	3	2	6	2	t	1	{"dateIncome":"2024-02-21","typeRoute":2,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":49,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":40,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":50,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":51,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-21 17:57:54.737936+03
1894	2024-02-17	7	2	6	2	t	1	{"dateIncome":"2024-02-17","typeRoute":2,"flightNumber":7,"instructor":6,"techniques":[{"typeTechnique":51,"discount":2600,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Все 3 с сайта экскурс","price":6400},{"typeTechnique":48,"discount":2600,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":50,"discount":2600,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-02-17 14:20:05.97383+03
1912	2024-02-18	12	4	14	2	t	1	{"dateIncome":"2024-02-18","typeRoute":4,"flightNumber":12,"instructor":14,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-18 17:53:54.627593+03
1978	2024-02-27	1	1	7	2	t	1	{"dateIncome":"2024-02-27","typeRoute":1,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-27 11:38:43.871716+03
1948	2024-02-24	1	1	14	2	t	1	{"dateIncome":"2024-02-24","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-24 10:42:54.040921+03
1962	2024-02-25	1	3	14	2	t	1	{"dateIncome":"2024-02-25","typeRoute":3,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-02-25 10:14:01.882376+03
1986	2024-02-28	5	4	7	2	t	1	{"dateIncome":"2024-02-28","typeRoute":4,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-28 17:06:34.392352+03
1684	2024-01-27	4	2	6	2	f	1	\N	\N
1579	2024-01-15	3	3	6	2	t	1	\N	\N
1581	2024-01-15	5	1	7	2	t	1	\N	\N
1583	2024-01-16	2	3	7	2	t	1	\N	\N
1654	2024-01-23	7	4	6	2	t	1	\N	\N
1599	2024-01-17	8	3	3	2	t	1	\N	\N
1616	2024-01-20	8	4	14	2	t	1	\N	\N
1618	2024-01-20	10	4	9	2	t	1	\N	\N
1670	2024-01-25	7	3	7	2	t	1	\N	\N
1820	2024-02-10	4	2	6	2	t	1	\N	\N
1671	2024-01-25	8	3	6	2	t	1	\N	\N
1717	2024-01-31	5	1	14	2	t	1	\N	\N
1683	2024-01-27	3	1	14	2	t	1	\N	\N
1685	2024-01-27	4	2	6	2	t	1	\N	\N
1761	2024-02-05	1	3	6	2	t	1	\N	\N
1739	2024-02-03	6	4	7	2	t	1	\N	\N
1774	2024-02-06	3	1	7	2	t	1	\N	\N
1788	2024-02-07	6	4	7	2	t	1	\N	\N
1828	2024-02-10	11	1	7	2	t	1	\N	\N
1802	2024-02-08	8	2	7	2	t	1	\N	\N
1846	2024-02-12	3	2	7	2	t	1	\N	\N
1863	2024-02-13	9	4	14	2	t	1	\N	\N
1963	2024-02-25	2	4	14	2	t	1	{"dateIncome":"2024-02-25","typeRoute":4,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":11,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":9,"discount":3000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-25 12:02:44.126424+03
1881	2024-02-16	1	3	7	2	t	1	{"dateIncome":"2024-02-16","typeRoute":3,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":13,"discount":1500,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3500}]}	\N
1964	2024-02-25	3	4	14	2	t	1	{"dateIncome":"2024-02-25","typeRoute":4,"flightNumber":3,"instructor":14,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-25 12:04:38.240566+03
1895	2024-02-17	8	4	7	2	t	1	{"dateIncome":"2024-02-17","typeRoute":4,"flightNumber":8,"instructor":7,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-17 15:21:50.743251+03
1913	2024-02-19	1	2	6	2	t	1	{"dateIncome":"2024-02-19","typeRoute":2,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-19 16:04:18.427784+03
1917	2024-02-19	4	4	7	2	t	1	{"dateIncome":"2024-02-19","typeRoute":4,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-19 16:10:04.814203+03
1987	2024-02-28	6	1	6	2	t	1	{"dateIncome":"2024-02-28","typeRoute":1,"flightNumber":6,"instructor":6,"techniques":[{"typeTechnique":49,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-02-28 17:45:38.982295+03
1934	2024-02-22	1	4	14	2	t	1	{"dateIncome":"2024-02-22","typeRoute":4,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-22 11:16:46.701487+03
1979	2024-02-27	2	4	7	2	t	1	{"dateIncome":"2024-02-27","typeRoute":4,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":9,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"Откат дали","price":5000}]}	2024-02-27 14:08:58.763011+03
1949	2024-02-24	2	4	6	2	t	1	{"dateIncome":"2024-02-24","typeRoute":4,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":39,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-24 11:48:48.983452+03
1989	2024-02-29	2	1	7	2	t	1	{"dateIncome":"2024-02-29","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Все оплатили по счету","price":10000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":53,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Это откат за 4 вездехода по 2 к","price":8000}]}	2024-02-29 16:19:42.021789+03
1992	2024-03-01	2	3	7	2	t	1	{"dateIncome":"2024-03-01","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":9,"discount":3000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"С инструктором поехали","price":2000}]}	2024-03-01 13:14:35.486655+03
1993	2024-03-01	3	1	7	2	t	1	{"dateIncome":"2024-03-01","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-01 13:33:13.161511+03
1996	2024-03-02	1	1	7	2	t	1	{"dateIncome":"2024-03-02","typeRoute":1,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":41,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":42,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-02 10:44:39.338646+03
1686	2024-01-27	5	1	7	2	t	1	\N	\N
1584	2024-01-16	3	2	6	2	t	1	\N	\N
1585	2024-01-16	4	3	9	2	t	1	\N	\N
1655	2024-01-23	8	1	7	2	t	1	\N	\N
1600	2024-01-18	1	2	7	2	t	1	\N	\N
1601	2024-01-18	2	2	7	2	t	1	\N	\N
1617	2024-01-20	9	2	6	2	t	1	\N	\N
1673	2024-01-25	9	3	6	2	f	1	\N	\N
1619	2024-01-20	11	2	6	2	t	1	\N	\N
1620	2024-01-20	12	3	6	2	t	1	\N	\N
1672	2024-01-25	9	3	6	2	t	1	\N	\N
1700	2024-01-29	1	3	7	2	t	1	\N	\N
1762	2024-02-05	2	3	7	2	t	1	\N	\N
1719	2024-02-01	1	2	7	2	t	1	\N	\N
1775	2024-02-06	4	4	6	2	t	1	\N	\N
1722	2024-02-01	2	4	7	2	t	1	\N	\N
1829	2024-02-11	1	3	14	2	t	1	\N	\N
1740	2024-02-03	7	2	7	2	t	1	\N	\N
1741	2024-02-03	8	3	7	2	t	1	\N	\N
1789	2024-02-07	7	2	6	2	t	1	\N	\N
1803	2024-02-09	1	3	6	2	t	1	\N	\N
1831	2024-02-11	3	4	7	2	t	1	\N	\N
1935	2024-02-22	2	1	7	2	t	1	{"dateIncome":"2024-02-22","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-22 11:29:02.172839+03
1847	2024-02-12	4	2	7	2	t	1	\N	\N
1848	2024-02-12	5	3	7	2	t	1	\N	\N
1864	2024-02-14	1	3	7	2	t	1	\N	\N
1990	2024-02-29	3	1	7	2	t	1	{"dateIncome":"2024-02-29","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":35,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":35,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":35,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-29 16:21:09.87812+03
1965	2024-02-25	4	1	7	2	t	1	{"dateIncome":"2024-02-25","typeRoute":1,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-25 13:02:48.588289+03
1865	2024-02-14	2	4	7	2	t	1	\N	\N
1866	2024-02-14	3	4	14	2	t	1	\N	\N
1882	2024-02-16	2	2	6	2	t	1	{"dateIncome":"2024-02-16","typeRoute":2,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	\N
1988	2024-02-29	1	2	14	2	t	1	{"dateIncome":"2024-02-29","typeRoute":2,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":35,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-29 14:44:03.442387+03
1896	2024-02-17	9	4	7	2	t	1	{"dateIncome":"2024-02-17","typeRoute":4,"flightNumber":9,"instructor":7,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":9,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-17 16:11:38.51121+03
1966	2024-02-25	5	1	7	2	t	1	{"dateIncome":"2024-02-25","typeRoute":1,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-25 13:48:55.896101+03
1915	2024-02-19	2	2	6	2	t	1	{"dateIncome":"2024-02-19","typeRoute":2,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-19 16:07:38.127153+03
1916	2024-02-19	3	2	6	2	t	1	{"dateIncome":"2024-02-19","typeRoute":2,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-19 16:08:48.427823+03
1980	2024-02-27	3	3	7	2	t	1	{"dateIncome":"2024-02-27","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":53,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-02-27 16:03:21.569645+03
1995	2024-03-01	5	1	6	2	t	1	{"dateIncome":"2024-03-01","typeRoute":1,"flightNumber":5,"instructor":6,"techniques":[{"typeTechnique":42,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":49,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-03-01 17:52:07.382995+03
1994	2024-03-01	4	1	6	2	t	1	{"dateIncome":"2024-03-01","typeRoute":1,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":40,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-03-01 17:51:27.558065+03
1997	2024-03-02	2	4	14	2	t	1	{"dateIncome":"2024-03-02","typeRoute":4,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-02 13:54:06.214117+03
1586	2024-01-16	5	3	6	2	t	1	\N	\N
1639	2024-01-22	1	3	7	2	t	1	\N	\N
1602	2024-01-18	3	4	7	2	t	1	\N	\N
1603	2024-01-18	4	2	14	2	t	1	\N	\N
1621	2024-01-21	1	3	7	2	t	1	\N	\N
1656	2024-01-24	1	1	14	2	t	1	\N	\N
1674	2024-01-26	1	1	7	2	t	1	\N	\N
1701	2024-01-29	2	4	6	2	t	1	\N	\N
1702	2024-01-29	3	4	14	2	t	1	\N	\N
1763	2024-02-05	3	4	7	2	t	1	\N	\N
1723	2024-02-01	3	4	7	2	t	1	\N	\N
1724	2024-02-01	4	4	7	2	t	1	\N	\N
1936	2024-02-23	1	4	7	2	t	1	{"dateIncome":"2024-02-23","typeRoute":4,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-23 10:15:33.922402+03
1725	2024-02-01	5	1	14	2	t	1	\N	\N
1776	2024-02-06	5	2	6	2	t	1	\N	\N
1830	2024-02-11	2	2	6	2	t	1	\N	\N
1790	2024-02-07	8	4	6	2	t	1	\N	\N
1918	2024-02-19	5	4	14	2	t	1	{"dateIncome":"2024-02-19","typeRoute":4,"flightNumber":5,"instructor":14,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-19 17:40:00.813316+03
1804	2024-02-09	2	4	14	2	t	1	\N	\N
1805	2024-02-09	3	4	6	2	t	1	\N	\N
1806	2024-02-09	4	2	6	2	t	1	\N	\N
1919	2024-02-19	6	2	7	2	t	1	{"dateIncome":"2024-02-19","typeRoute":2,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":52,"discount":6000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-19 17:45:17.067708+03
1849	2024-02-12	6	4	14	2	t	1	\N	\N
1850	2024-02-12	7	1	14	2	t	1	\N	\N
1851	2024-02-12	8	3	7	2	t	1	\N	\N
1867	2024-02-14	4	1	14	2	t	1	\N	\N
1883	2024-02-16	3	1	7	2	t	1	{"dateIncome":"2024-02-16","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	\N
1951	2024-02-24	3	4	7	2	t	1	{"dateIncome":"2024-02-24","typeRoute":4,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":35,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"Эти 2 квадрика как 1, потому что стоит 5 к тут а мы берём по 6","price":3000},{"typeTechnique":35,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-02-24 12:42:27.879119+03
1970	2024-02-25	9	3	6	2	t	1	{"dateIncome":"2024-02-25","typeRoute":3,"flightNumber":9,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-25 15:42:17.854819+03
1897	2024-02-17	10	1	14	2	t	1	{"dateIncome":"2024-02-17","typeRoute":1,"flightNumber":10,"instructor":14,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-02-17 17:31:38.98693+03
1898	2024-02-17	11	3	7	2	t	1	{"dateIncome":"2024-02-17","typeRoute":3,"flightNumber":11,"instructor":7,"techniques":[{"typeTechnique":11,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-17 17:32:58.503579+03
1899	2024-02-17	12	2	6	2	t	1	{"dateIncome":"2024-02-17","typeRoute":2,"flightNumber":12,"instructor":6,"techniques":[{"typeTechnique":39,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-17 17:48:01.003997+03
1967	2024-02-25	6	3	6	2	t	1	{"dateIncome":"2024-02-25","typeRoute":3,"flightNumber":6,"instructor":6,"techniques":[{"typeTechnique":39,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-02-25 15:23:24.032094+03
1968	2024-02-25	7	2	6	2	t	1	{"dateIncome":"2024-02-25","typeRoute":2,"flightNumber":7,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":49,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-02-25 15:25:20.715603+03
1969	2024-02-25	8	3	6	2	t	1	{"dateIncome":"2024-02-25","typeRoute":3,"flightNumber":8,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-25 15:41:40.848622+03
1640	2024-01-22	2	1	14	2	t	1	\N	\N
1587	2024-01-16	6	3	7	2	t	1	\N	\N
1588	2024-01-16	7	4	7	2	t	1	\N	\N
1604	2024-01-19	1	2	3	2	t	1	\N	\N
1622	2024-01-21	2	3	14	2	t	1	\N	\N
1657	2024-01-24	2	4	6	2	t	1	\N	\N
1659	2024-01-24	4	3	6	2	t	1	\N	\N
1675	2024-01-26	2	3	7	2	t	1	\N	\N
1764	2024-02-05	4	4	6	2	t	1	\N	\N
1703	2024-01-29	4	4	7	2	t	1	\N	\N
1704	2024-01-29	5	4	7	2	t	1	\N	\N
1705	2024-01-29	6	2	6	2	t	1	\N	\N
1726	2024-02-02	1	4	7	2	t	1	\N	\N
1743	2024-02-03	9	1	14	2	t	1	\N	\N
1832	2024-02-11	4	2	7	2	t	1	\N	\N
1777	2024-02-06	6	4	6	2	t	1	\N	\N
1778	2024-02-06	7	3	6	2	t	1	\N	\N
1779	2024-02-06	8	4	6	2	t	1	\N	\N
1791	2024-02-07	9	4	6	2	t	1	\N	\N
1884	2024-02-16	4	2	6	2	t	1	{"dateIncome":"2024-02-16","typeRoute":2,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	\N
1792	2024-02-07	10	2	6	2	t	1	\N	\N
1807	2024-02-09	5	1	7	2	t	1	\N	\N
1808	2024-02-09	6	1	7	2	t	1	\N	\N
1885	2024-02-16	5	3	6	2	t	1	{"dateIncome":"2024-02-16","typeRoute":3,"flightNumber":5,"instructor":6,"techniques":[{"typeTechnique":51,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000}]}	\N
1852	2024-02-12	9	3	7	2	t	1	\N	\N
1900	2024-02-18	1	4	6	2	f	1	{"dateIncome":"2024-02-18","typeRoute":4,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":35,"discount":4900,"prepayment":false,"typePayment":4,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":100},{"typeTechnique":35,"discount":4900,"prepayment":false,"typePayment":5,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":100}]}	2024-02-18 09:43:26.362708+03
1901	2024-02-18	2	3	6	2	f	1	{"dateIncome":"2024-02-18","typeRoute":3,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":5,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-18 09:43:53.23264+03
1868	2024-02-14	5	4	14	2	t	1	{"dateIncome":"2024-02-14","typeRoute":4,"flightNumber":5,"instructor":14,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	\N
1869	2024-02-14	6	4	14	2	t	1	{"dateIncome":"2024-02-14","typeRoute":4,"flightNumber":6,"instructor":14,"techniques":[{"typeTechnique":10,"discount":2000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":12,"discount":2000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	\N
1870	2024-02-14	7	4	6	2	t	1	{"dateIncome":"2024-02-14","typeRoute":4,"flightNumber":7,"instructor":6,"techniques":[{"typeTechnique":39,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	\N
1937	2024-02-23	2	1	7	2	t	1	{"dateIncome":"2024-02-23","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"С Аллюра","price":10000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"С Аллюра","price":10000}]}	2024-02-23 13:32:14.926054+03
1953	2024-02-24	5	1	14	2	t	1	{"dateIncome":"2024-02-24","typeRoute":1,"flightNumber":5,"instructor":14,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":1000,"description":"От Аллюра, скинуть 1к откат","price":8000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-24 13:26:06.625013+03
1920	2024-02-20	1	2	6	2	t	1	{"dateIncome":"2024-02-20","typeRoute":2,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-02-20 12:50:28.671543+03
1952	2024-02-24	4	3	7	2	t	1	{"dateIncome":"2024-02-24","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-02-24 13:19:11.681965+03
1971	2024-02-25	10	1	6	2	t	1	{"dateIncome":"2024-02-25","typeRoute":1,"flightNumber":10,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-02-25 15:46:07.798743+03
1344	2024-01-01	2	4	6	2	t	1	\N	\N
1345	2024-01-01	3	4	9	2	t	1	\N	\N
1343	2024-01-01	1	4	5	2	t	1	\N	\N
1346	2024-01-01	4	1	5	2	t	1	\N	\N
1348	2024-01-01	6	1	7	2	t	1	\N	\N
1347	2024-01-01	5	4	7	2	t	1	\N	\N
1350	2024-01-01	8	2	14	2	t	1	\N	\N
1349	2024-01-01	7	1	14	2	t	1	\N	\N
1352	2024-01-01	10	1	14	2	t	1	\N	\N
1353	2024-01-01	11	1	5	2	t	1	\N	\N
1351	2024-01-01	9	2	7	2	t	1	\N	\N
1354	2024-01-01	12	4	14	2	t	1	\N	\N
1355	2024-01-01	13	3	6	2	t	1	\N	\N
1356	2024-01-01	14	3	6	2	t	1	\N	\N
1357	2024-01-01	15	3	6	2	t	1	\N	\N
1358	2024-01-01	16	3	6	2	t	1	\N	\N
1426	2024-01-04	5	2	5	2	t	1	\N	\N
1359	2024-01-01	17	3	6	2	t	1	\N	\N
1360	2024-01-01	18	3	6	2	t	1	\N	\N
1427	2024-01-04	6	3	6	2	t	1	\N	\N
1361	2024-01-01	19	3	9	2	t	1	\N	\N
1362	2024-01-01	20	3	14	2	t	1	\N	\N
1398	2024-01-03	6	4	7	2	t	1	\N	\N
1364	2024-01-02	1	2	7	2	t	1	\N	\N
1399	2024-01-03	7	3	6	2	t	1	\N	\N
1365	2024-01-02	2	3	6	2	t	1	\N	\N
1400	2024-01-03	8	3	9	2	t	1	\N	\N
1366	2024-01-02	3	3	14	2	t	1	\N	\N
1401	2024-01-03	9	3	6	2	t	1	\N	\N
1367	2024-01-02	4	2	5	2	t	1	\N	\N
1368	2024-01-02	5	1	14	2	t	1	\N	\N
1369	2024-01-02	6	4	7	2	t	1	\N	\N
1370	2024-01-02	7	3	6	2	t	1	\N	\N
1371	2024-01-02	8	3	6	2	t	1	\N	\N
1456	2024-01-05	12	1	6	2	t	1	\N	\N
1372	2024-01-02	9	3	14	2	t	1	\N	\N
1403	2024-01-03	10	1	5	2	t	1	\N	\N
1373	2024-01-02	10	4	2	2	t	1	\N	\N
1404	2024-01-03	11	3	7	2	t	1	\N	\N
1374	2024-01-02	11	4	7	2	t	1	\N	\N
1405	2024-01-03	12	1	5	2	t	1	\N	\N
1375	2024-01-02	12	3	14	2	t	1	\N	\N
1376	2024-01-02	13	4	7	2	t	1	\N	\N
1377	2024-01-02	14	3	14	2	t	1	\N	\N
1444	2024-01-05	3	2	14	2	t	1	\N	\N
1378	2024-01-02	15	1	5	2	t	1	\N	\N
1428	2024-01-04	7	4	6	2	t	1	\N	\N
1406	2024-01-03	13	3	6	2	t	1	\N	\N
1379	2024-01-02	16	3	6	2	t	1	\N	\N
1380	2024-01-02	17	3	6	2	t	1	\N	\N
1381	2024-01-02	18	3	9	2	t	1	\N	\N
1382	2024-01-02	19	3	6	2	t	1	\N	\N
1407	2024-01-03	14	3	9	2	t	1	\N	\N
1383	2024-01-02	20	3	14	2	t	1	\N	\N
1429	2024-01-04	8	3	6	2	t	1	\N	\N
1384	2024-01-02	21	4	7	2	t	1	\N	\N
1385	2024-01-02	22	3	6	2	t	1	\N	\N
1386	2024-01-02	23	3	6	2	t	1	\N	\N
1387	2024-01-02	24	4	5	2	t	1	\N	\N
1388	2024-01-02	25	3	7	2	t	1	\N	\N
1389	2024-01-02	26	4	14	2	t	1	\N	\N
1408	2024-01-03	15	4	7	2	t	1	\N	\N
1390	2024-01-02	27	3	6	2	t	1	\N	\N
1391	2024-01-02	28	3	9	2	t	1	\N	\N
1430	2024-01-04	9	3	14	2	t	1	\N	\N
1392	2024-01-03	1	4	7	2	t	1	\N	\N
1393	2024-01-03	2	3	14	2	t	1	\N	\N
1395	2024-01-03	3	4	7	2	t	1	\N	\N
1409	2024-01-03	16	4	7	2	t	1	\N	\N
1396	2024-01-03	4	3	14	2	t	1	\N	\N
1410	2024-01-03	17	3	14	2	t	1	\N	\N
1397	2024-01-03	5	4	5	2	t	1	\N	\N
1411	2024-01-03	18	3	6	2	t	1	\N	\N
1412	2024-01-03	19	3	9	2	t	1	\N	\N
1413	2024-01-03	20	3	5	2	t	1	\N	\N
1414	2024-01-03	21	4	7	2	t	1	\N	\N
1431	2024-01-04	10	2	7	2	t	1	\N	\N
1432	2024-01-04	11	4	14	2	t	1	\N	\N
1415	2024-01-03	22	3	6	2	t	1	\N	\N
1416	2024-01-03	23	3	6	2	t	1	\N	\N
1417	2024-01-03	24	1	6	2	t	1	\N	\N
1464	2024-01-06	2	2	14	2	t	1	\N	\N
1418	2024-01-03	25	3	6	2	t	1	\N	\N
1419	2024-01-03	26	3	6	2	t	1	\N	\N
1445	2024-01-05	4	3	6	2	t	1	\N	\N
1420	2024-01-04	1	2	7	2	t	1	\N	\N
1421	2024-01-04	2	3	6	2	t	1	\N	\N
1446	2024-01-05	5	1	6	2	t	1	\N	\N
1424	2024-01-04	3	2	5	2	t	1	\N	\N
1425	2024-01-04	4	4	7	2	t	1	\N	\N
1433	2024-01-04	12	3	9	2	t	1	\N	\N
1434	2024-01-04	13	3	6	2	t	1	\N	\N
1435	2024-01-04	14	3	6	2	t	1	\N	\N
1436	2024-01-04	15	4	6	2	t	1	\N	\N
1457	2024-01-05	13	4	6	2	t	1	\N	\N
1448	2024-01-05	6	1	2	2	t	1	\N	\N
1437	2024-01-04	16	1	9	2	t	1	\N	\N
1438	2024-01-04	17	3	6	2	t	1	\N	\N
1439	2024-01-04	18	3	9	2	t	1	\N	\N
1440	2024-01-04	19	1	6	2	t	1	\N	\N
1441	2024-01-04	20	1	6	2	t	1	\N	\N
1451	2024-01-05	7	2	7	2	t	1	\N	\N
1442	2024-01-05	1	3	6	2	t	1	\N	\N
1443	2024-01-05	2	1	6	2	t	1	\N	\N
1452	2024-01-05	8	1	2	2	t	1	\N	\N
1453	2024-01-05	9	2	5	2	t	1	\N	\N
1469	2024-01-06	7	2	7	2	t	1	\N	\N
1458	2024-01-05	14	1	6	2	t	1	\N	\N
1454	2024-01-05	10	3	6	2	t	1	\N	\N
1455	2024-01-05	11	3	9	2	t	1	\N	\N
1465	2024-01-06	3	1	6	2	t	1	\N	\N
1459	2024-01-05	15	2	9	2	t	1	\N	\N
1466	2024-01-06	4	3	6	2	t	1	\N	\N
1460	2024-01-05	16	3	6	2	t	1	\N	\N
1461	2024-01-05	17	3	6	2	t	1	\N	\N
1462	2024-01-05	18	2	7	2	t	1	\N	\N
1463	2024-01-06	1	1	6	2	t	1	\N	\N
1472	2024-01-06	10	3	6	2	t	1	\N	\N
1470	2024-01-06	8	2	10	2	t	1	\N	\N
1467	2024-01-06	5	4	10	2	t	1	\N	\N
1468	2024-01-06	6	3	7	2	t	1	\N	\N
1474	2024-01-06	12	3	6	2	t	1	\N	\N
1471	2024-01-06	9	2	6	2	t	1	\N	\N
1473	2024-01-06	11	3	10	2	t	1	\N	\N
1477	2024-01-06	15	3	6	2	t	1	\N	\N
1475	2024-01-06	13	3	14	2	t	1	\N	\N
1478	2024-01-06	16	3	6	2	t	1	\N	\N
1479	2024-01-06	17	3	6	2	t	1	\N	\N
1480	2024-01-06	18	3	6	2	t	1	\N	\N
1476	2024-01-06	14	3	9	2	t	1	\N	\N
1481	2024-01-07	1	3	6	2	t	1	\N	\N
1483	2024-01-07	3	3	6	2	t	1	\N	\N
1484	2024-01-07	4	1	6	2	t	1	\N	\N
1482	2024-01-07	2	3	6	2	t	1	\N	\N
1486	2024-01-07	6	3	14	2	t	1	\N	\N
1485	2024-01-07	5	3	7	2	t	1	\N	\N
1487	2024-01-07	7	4	14	2	t	1	\N	\N
1490	2024-01-07	9	2	14	2	t	1	\N	\N
1488	2024-01-07	8	3	7	2	t	1	\N	\N
1491	2024-01-07	10	2	7	2	t	1	\N	\N
1492	2024-01-07	11	1	2	2	t	1	\N	\N
1493	2024-01-07	12	3	6	2	t	1	\N	\N
1556	2024-01-13	15	4	6	2	t	1	\N	\N
1533	2024-01-12	5	1	7	3	t	1	\N	\N
1534	2024-01-12	6	4	6	3	t	1	\N	\N
1535	2024-01-12	7	4	6	3	t	1	\N	\N
1536	2024-01-12	8	4	6	3	t	1	\N	\N
1494	2024-01-07	13	3	6	2	t	1	\N	\N
1495	2024-01-07	14	3	6	2	t	1	\N	\N
1496	2024-01-07	15	3	9	2	t	1	\N	\N
1497	2024-01-07	16	4	6	2	t	1	\N	\N
1498	2024-01-07	17	1	6	2	t	1	\N	\N
1499	2024-01-07	18	3	9	2	t	1	\N	\N
1500	2024-01-08	1	2	7	2	t	1	\N	\N
1501	2024-01-08	2	4	5	2	t	1	\N	\N
1623	2024-01-21	3	4	7	2	t	1	\N	\N
1502	2024-01-08	3	2	7	2	t	1	\N	\N
1537	2024-01-12	9	4	6	3	t	1	\N	\N
1538	2024-01-12	10	1	14	3	t	1	\N	\N
1503	2024-01-08	4	4	6	2	t	1	\N	\N
1504	2024-01-08	5	1	6	2	t	1	\N	\N
1505	2024-01-08	6	4	6	2	t	1	\N	\N
1557	2024-01-13	16	4	6	2	t	1	\N	\N
1506	2024-01-08	7	3	9	2	t	1	\N	\N
1539	2024-01-12	11	4	7	3	t	1	\N	\N
1507	2024-01-08	8	2	7	2	t	1	\N	\N
1509	2024-01-09	1	2	14	2	t	1	\N	\N
1558	2024-01-13	17	3	6	2	t	1	\N	\N
1540	2024-01-13	1	4	6	3	t	1	\N	\N
1589	2024-01-16	8	1	7	2	t	1	\N	\N
1559	2024-01-13	18	3	6	2	t	1	\N	\N
1510	2024-01-09	2	3	6	2	t	1	\N	\N
1512	2024-01-09	3	3	6	2	t	1	\N	\N
1514	2024-01-09	4	1	6	2	t	1	\N	\N
1515	2024-01-09	5	1	6	2	t	1	\N	\N
1516	2024-01-10	1	1	6	2	t	1	\N	\N
1517	2024-01-10	2	3	6	2	t	1	\N	\N
1541	2024-01-13	1	1	14	2	t	1	\N	\N
1518	2024-01-10	3	3	7	2	t	1	\N	\N
1542	2024-01-13	2	3	14	2	t	1	\N	\N
1591	2024-01-16	9	1	7	2	t	1	\N	\N
1519	2024-01-10	4	4	6	2	t	1	\N	\N
1520	2024-01-10	5	3	6	2	t	1	\N	\N
1521	2024-01-10	6	4	6	2	t	1	\N	\N
1522	2024-01-12	1	4	7	3	t	1	\N	\N
1523	2024-01-12	2	4	6	3	t	1	\N	\N
1543	2024-01-13	3	1	14	2	t	1	\N	\N
1524	2024-01-12	3	1	14	3	t	1	\N	\N
1525	2024-01-12	4	4	9	3	t	1	\N	\N
1545	2024-01-13	4	1	14	2	t	1	\N	\N
1546	2024-01-13	5	4	6	2	t	1	\N	\N
1560	2024-01-13	19	4	6	2	t	1	\N	\N
1526	2024-01-12	1	1	6	2	t	1	\N	\N
1527	2024-01-12	2	4	6	2	t	1	\N	\N
1528	2024-01-12	3	3	7	2	t	1	\N	\N
1529	2024-01-12	4	3	6	2	t	1	\N	\N
1530	2024-01-12	5	3	6	2	t	1	\N	\N
1531	2024-01-12	6	4	6	2	t	1	\N	\N
1532	2024-01-12	7	3	6	2	t	1	\N	\N
1561	2024-01-13	20	3	6	2	t	1	\N	\N
1562	2024-01-13	21	3	14	2	t	1	\N	\N
1547	2024-01-13	6	4	7	2	t	1	\N	\N
1563	2024-01-13	22	3	6	2	t	1	\N	\N
1564	2024-01-13	23	3	6	2	t	1	\N	\N
1565	2024-01-13	24	3	6	2	t	1	\N	\N
1548	2024-01-13	7	3	6	2	t	1	\N	\N
1549	2024-01-13	8	3	9	2	t	1	\N	\N
1550	2024-01-13	9	4	6	2	t	1	\N	\N
1566	2024-01-13	25	4	7	2	t	1	\N	\N
1567	2024-01-13	26	4	7	2	t	1	\N	\N
1551	2024-01-13	10	4	6	2	t	1	\N	\N
1552	2024-01-13	11	4	6	2	t	1	\N	\N
1553	2024-01-13	12	1	7	2	t	1	\N	\N
1568	2024-01-14	1	4	6	2	t	1	\N	\N
1605	2024-01-19	2	1	7	2	t	1	\N	\N
1606	2024-01-19	3	2	7	2	t	1	\N	\N
1554	2024-01-13	13	4	6	2	t	1	\N	\N
1607	2024-01-19	4	4	3	2	t	1	\N	\N
1555	2024-01-13	14	4	6	2	t	1	\N	\N
1608	2024-01-19	5	4	7	2	t	1	\N	\N
1706	2024-01-29	7	2	6	2	t	1	\N	\N
1570	2024-01-14	2	1	7	2	t	1	\N	\N
1571	2024-01-14	3	1	14	2	t	1	\N	\N
1641	2024-01-22	3	4	6	2	t	1	\N	\N
1642	2024-01-22	4	4	6	2	t	1	\N	\N
1643	2024-01-22	5	4	7	2	t	1	\N	\N
1658	2024-01-24	3	2	6	2	t	1	\N	\N
1727	2024-02-02	2	2	7	2	t	1	\N	\N
1676	2024-01-26	3	4	6	2	t	1	\N	\N
1765	2024-02-05	5	4	6	2	t	1	\N	\N
1730	2024-02-02	5	4	7	2	t	1	\N	\N
1731	2024-02-02	6	2	7	2	t	1	\N	\N
1744	2024-02-03	10	2	6	2	t	1	\N	\N
1780	2024-02-06	9	4	6	2	t	1	\N	\N
1793	2024-02-07	11	3	6	2	t	1	\N	\N
1809	2024-02-09	7	1	14	2	t	1	\N	\N
1871	2024-02-14	8	2	6	2	t	1	{"dateIncome":"2024-02-14","typeRoute":2,"flightNumber":8,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	\N
1810	2024-02-09	8	3	14	2	t	1	\N	\N
1834	2024-02-11	5	4	14	2	t	1	\N	\N
1836	2024-02-11	7	4	14	2	t	1	\N	\N
1837	2024-02-11	8	1	7	2	t	1	\N	\N
1853	2024-02-12	10	3	7	2	t	1	\N	\N
1886	2024-02-16	6	2	6	2	t	1	{"dateIncome":"2024-02-16","typeRoute":2,"flightNumber":6,"instructor":3,"techniques":[{"typeTechnique":48,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":50,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	\N
1954	2024-02-24	6	1	7	2	t	1	{"dateIncome":"2024-02-24","typeRoute":1,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-02-24 14:38:15.457737+03
1999	2024-03-02	4	1	7	2	t	1	{"dateIncome":"2024-03-02","typeRoute":1,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":41,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":49,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-02 17:01:20.744677+03
2000	2024-03-02	5	1	7	2	t	1	{"dateIncome":"2024-03-02","typeRoute":1,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":42,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":49,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-03-02 17:07:17.568946+03
2001	2024-03-02	6	4	7	2	t	1	{"dateIncome":"2024-03-02","typeRoute":4,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":48,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":41,"discount":3500,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":1500},{"typeTechnique":41,"discount":3500,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":1500},{"typeTechnique":49,"discount":3000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"Знакомые ","price":3000}]}	2024-03-02 17:11:34.10767+03
2003	2024-03-03	2	1	14	2	t	1	{"dateIncome":"2024-03-03","typeRoute":1,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-03 13:43:50.72947+03
2002	2024-03-03	1	1	14	2	t	1	{"dateIncome":"2024-03-03","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-03 13:43:27.592222+03
2004	2024-03-03	3	3	7	2	t	1	{"dateIncome":"2024-03-03","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":42,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":49,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-03 17:22:41.788496+03
2005	2024-03-03	4	2	7	2	t	1	{"dateIncome":"2024-03-03","typeRoute":2,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":41,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":48,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-03-03 17:26:59.816483+03
2006	2024-03-03	5	2	7	2	t	1	{"dateIncome":"2024-03-03","typeRoute":2,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":49,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-03 17:28:02.130943+03
2007	2024-03-03	6	2	7	2	t	1	{"dateIncome":"2024-03-03","typeRoute":2,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":48,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":42,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-03-03 17:30:07.447299+03
2034	2024-03-08	5	3	7	2	t	1	{"dateIncome":"2024-03-08","typeRoute":3,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-03-08 14:42:37.942465+03
2009	2024-03-04	1	1	14	2	t	1	{"dateIncome":"2024-03-04","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":13,"discount":5000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Опять на 1 технику 2 к предоплата поэтому делю","price":4000},{"typeTechnique":13,"discount":5000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-03-04 10:03:05.980041+03
2028	2024-03-07	1	1	6	2	t	1	{"dateIncome":"2024-03-07","typeRoute":1,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":49,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-07 13:59:20.682789+03
2030	2024-03-08	1	1	14	2	t	1	{"dateIncome":"2024-03-08","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-08 11:32:42.283451+03
2031	2024-03-08	2	4	7	2	t	1	{"dateIncome":"2024-03-08","typeRoute":4,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-08 11:33:56.231018+03
2032	2024-03-08	3	4	7	2	t	1	{"dateIncome":"2024-03-08","typeRoute":4,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-08 11:34:19.875616+03
2033	2024-03-08	4	1	6	2	t	1	{"dateIncome":"2024-03-08","typeRoute":1,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":51,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":41,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-08 12:34:01.996691+03
2035	2024-03-08	6	4	14	2	t	1	{"dateIncome":"2024-03-08","typeRoute":4,"flightNumber":6,"instructor":14,"techniques":[{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-08 14:56:45.777351+03
2036	2024-03-08	7	3	14	2	t	1	{"dateIncome":"2024-03-08","typeRoute":3,"flightNumber":7,"instructor":14,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-03-08 17:02:04.582731+03
2053	2024-03-14	1	1	6	2	t	1	{"dateIncome":"2024-03-14","typeRoute":1,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-14 11:18:20.87301+03
2054	2024-03-14	2	1	6	2	t	1	{"dateIncome":"2024-03-14","typeRoute":1,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":49,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-14 11:54:44.127304+03
2055	2024-03-14	3	4	7	2	t	1	{"dateIncome":"2024-03-14","typeRoute":4,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-14 12:30:58.351854+03
2017	2024-03-05	3	1	7	2	t	1	{"dateIncome":"2024-03-05","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-05 16:49:31.551746+03
2010	2024-03-04	2	1	7	2	t	1	{"dateIncome":"2024-03-04","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Сразу все оплатили","price":10000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":35,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":35,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":35,"discount":3000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-03-04 13:22:28.796851+03
2015	2024-03-05	1	1	14	2	t	1	{"dateIncome":"2024-03-05","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-05 12:27:52.103751+03
2011	2024-03-04	3	1	7	2	t	1	{"dateIncome":"2024-03-04","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":41,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-04 15:01:52.495483+03
2012	2024-03-04	4	3	7	2	t	1	{"dateIncome":"2024-03-04","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-03-04 15:03:18.639156+03
2019	2024-03-05	4	1	7	2	t	1	{"dateIncome":"2024-03-05","typeRoute":1,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-05 16:54:28.609506+03
2013	2024-03-04	5	3	7	2	t	1	{"dateIncome":"2024-03-04","typeRoute":3,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":51,"discount":0,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-04 15:21:50.147405+03
2016	2024-03-05	2	4	14	2	t	1	{"dateIncome":"2024-03-05","typeRoute":4,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-05 15:57:55.231834+03
2020	2024-03-05	5	3	7	2	t	1	{"dateIncome":"2024-03-05","typeRoute":3,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":51,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-03-05 17:34:13.216682+03
2021	2024-03-05	6	2	7	2	t	1	{"dateIncome":"2024-03-05","typeRoute":2,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":48,"discount":3750,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5250},{"typeTechnique":48,"discount":3750,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5250},{"typeTechnique":51,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":50,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":41,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":42,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-03-05 17:42:39.247646+03
2023	2024-03-06	1	1	14	2	t	1	{"dateIncome":"2024-03-06","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":9,"discount":5000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Опять 2 предоплаты на 1 технику, буду делить","price":4000},{"typeTechnique":9,"discount":5000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-03-06 10:10:24.393655+03
2025	2024-03-06	2	1	7	2	t	1	{"dateIncome":"2024-03-06","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-06 13:21:23.545041+03
2026	2024-03-06	3	1	7	2	t	1	{"dateIncome":"2024-03-06","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":41,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-06 14:49:40.474626+03
2027	2024-03-07	1	1	7	2	t	1	{"dateIncome":"2024-03-07","typeRoute":1,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-07 12:48:07.086818+03
2029	2024-03-07	2	1	14	2	t	1	{"dateIncome":"2024-03-07","typeRoute":1,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-07 15:51:09.393386+03
2040	2024-03-09	4	1	7	2	t	1	{"dateIncome":"2024-03-09","typeRoute":1,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-09 16:11:04.357639+03
2041	2024-03-09	5	1	7	2	t	1	{"dateIncome":"2024-03-09","typeRoute":1,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-09 16:11:39.940296+03
2037	2024-03-09	1	1	6	2	t	1	{"dateIncome":"2024-03-09","typeRoute":1,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":49,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":50,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":51,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":40,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":42,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-03-09 12:19:20.825351+03
2038	2024-03-09	2	4	6	2	t	1	{"dateIncome":"2024-03-09","typeRoute":4,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":48,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":50,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-09 12:20:49.323465+03
2049	2024-03-13	3	1	14	2	t	1	{"dateIncome":"2024-03-13","typeRoute":1,"flightNumber":3,"instructor":14,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-03-13 14:27:14.456767+03
2045	2024-03-12	2	4	14	2	t	1	{"dateIncome":"2024-03-12","typeRoute":4,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-12 15:35:44.651295+03
2039	2024-03-09	3	1	7	2	t	1	{"dateIncome":"2024-03-09","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-09 16:10:21.357124+03
2042	2024-03-10	1	3	6	2	t	1	{"dateIncome":"2024-03-10","typeRoute":3,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-03-10 11:21:25.048346+03
2047	2024-03-13	1	1	7	2	t	1	{"dateIncome":"2024-03-13","typeRoute":1,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-13 11:31:02.734598+03
2043	2024-03-10	2	1	6	2	t	1	{"dateIncome":"2024-03-10","typeRoute":1,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":42,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-10 13:23:15.7033+03
2046	2024-03-12	3	3	6	2	t	1	{"dateIncome":"2024-03-12","typeRoute":3,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":50,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-03-12 17:01:03.638449+03
2044	2024-03-12	1	1	6	2	t	1	{"dateIncome":"2024-03-12","typeRoute":1,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":49,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":40,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-12 13:28:49.605141+03
2048	2024-03-13	2	1	6	2	t	1	{"dateIncome":"2024-03-13","typeRoute":1,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":42,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-13 12:46:05.677985+03
2050	2024-03-13	4	4	7	2	t	1	{"dateIncome":"2024-03-13","typeRoute":4,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-13 17:59:20.332466+03
2056	2024-03-14	4	1	14	2	t	1	{"dateIncome":"2024-03-14","typeRoute":1,"flightNumber":4,"instructor":14,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-14 13:25:56.648494+03
2057	2024-03-14	5	4	6	2	t	1	{"dateIncome":"2024-03-14","typeRoute":4,"flightNumber":5,"instructor":6,"techniques":[{"typeTechnique":51,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-14 15:00:30.600132+03
2058	2024-03-14	6	1	7	2	t	1	{"dateIncome":"2024-03-14","typeRoute":1,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":10,"discount":500,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8500},{"typeTechnique":11,"discount":500,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8500}]}	2024-03-14 16:19:22.58478+03
2064	2024-03-16	2	1	14	2	t	1	{"dateIncome":"2024-03-16","typeRoute":1,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"От ски резорт","price":9000}]}	2024-03-16 12:36:43.4127+03
2059	2024-03-15	1	1	14	2	t	1	{"dateIncome":"2024-03-15","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-03-15 12:49:19.784479+03
2060	2024-03-15	2	1	6	2	t	1	{"dateIncome":"2024-03-15","typeRoute":1,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":49,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-15 12:50:04.499134+03
2061	2024-03-15	3	1	14	2	t	1	{"dateIncome":"2024-03-15","typeRoute":1,"flightNumber":3,"instructor":14,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-15 13:19:43.367518+03
2065	2024-03-16	3	3	6	2	t	1	{"dateIncome":"2024-03-16","typeRoute":3,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":41,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-03-16 16:33:52.238644+03
2063	2024-03-16	1	4	14	2	t	1	{"dateIncome":"2024-03-16","typeRoute":4,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-16 11:55:07.225314+03
2069	2024-03-17	4	4	6	2	t	1	{"dateIncome":"2024-03-17","typeRoute":4,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":49,"discount":3300,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":2700},{"typeTechnique":50,"discount":3300,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":2700}]}	2024-03-17 17:45:30.204148+03
2066	2024-03-17	1	1	6	2	t	1	{"dateIncome":"2024-03-17","typeRoute":1,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":39,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-17 12:02:06.91818+03
2067	2024-03-17	2	4	14	2	t	1	{"dateIncome":"2024-03-17","typeRoute":4,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-17 15:58:19.274948+03
2068	2024-03-17	3	1	6	2	t	1	{"dateIncome":"2024-03-17","typeRoute":1,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":40,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-17 17:26:06.042436+03
2070	2024-03-18	1	1	14	2	t	1	{"dateIncome":"2024-03-18","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-18 09:57:11.811223+03
2073	2024-03-19	1	1	14	2	t	1	{"dateIncome":"2024-03-19","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-19 10:12:06.185124+03
2071	2024-03-18	2	1	14	2	t	1	{"dateIncome":"2024-03-18","typeRoute":1,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-03-18 16:36:58.806107+03
2072	2024-03-18	3	1	14	2	t	1	{"dateIncome":"2024-03-18","typeRoute":1,"flightNumber":3,"instructor":14,"techniques":[{"typeTechnique":41,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-18 16:37:48.112333+03
2075	2024-03-19	3	1	14	2	t	1	{"dateIncome":"2024-03-19","typeRoute":1,"flightNumber":3,"instructor":14,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-19 14:57:32.89288+03
2074	2024-03-19	2	3	14	2	t	1	{"dateIncome":"2024-03-19","typeRoute":3,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-03-19 14:51:50.252156+03
2076	2024-03-20	1	1	14	2	t	1	{"dateIncome":"2024-03-20","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-20 15:19:25.692421+03
2077	2024-03-20	2	1	14	2	t	1	{"dateIncome":"2024-03-20","typeRoute":1,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-20 15:20:23.816245+03
2085	2024-03-24	1	4	14	2	t	1	{"dateIncome":"2024-03-24","typeRoute":4,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":35,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":35,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":35,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-03-24 12:56:07.243096+03
2082	2024-03-22	1	1	5	2	t	1	{"dateIncome":"2024-03-22","typeRoute":1,"flightNumber":1,"instructor":5,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-22 13:16:13.040117+03
2078	2024-03-21	1	1	14	2	t	1	{"dateIncome":"2024-03-21","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-21 13:33:09.108091+03
2079	2024-03-21	2	4	14	2	t	1	{"dateIncome":"2024-03-21","typeRoute":4,"flightNumber":2,"instructor":14,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-21 13:40:00.089099+03
2080	2024-03-21	3	1	14	2	t	1	{"dateIncome":"2024-03-21","typeRoute":1,"flightNumber":3,"instructor":14,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":7000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"У них 3к предоплата на 1 технику, поэтому разделил","price":2000},{"typeTechnique":13,"discount":7000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":13,"discount":7000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-03-21 13:44:04.114558+03
2081	2024-03-21	4	1	14	2	t	1	{"dateIncome":"2024-03-21","typeRoute":1,"flightNumber":4,"instructor":14,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-21 16:12:36.273308+03
2083	2024-03-23	1	1	6	2	t	1	{"dateIncome":"2024-03-23","typeRoute":1,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-03-23 14:17:34.384938+03
2084	2024-03-23	2	1	6	2	t	1	{"dateIncome":"2024-03-23","typeRoute":1,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-23 14:19:21.730215+03
2088	2024-03-25	3	4	5	2	t	1	{"dateIncome":"2024-03-25","typeRoute":4,"flightNumber":3,"instructor":5,"techniques":[{"typeTechnique":11,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"Из горски ,10٪ комиссия","price":5400},{"typeTechnique":13,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":5400}]}	2024-03-25 17:39:42.275102+03
2086	2024-03-25	1	1	5	2	t	1	{"dateIncome":"2024-03-25","typeRoute":1,"flightNumber":1,"instructor":5,"techniques":[{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-25 14:21:38.499031+03
2087	2024-03-25	2	1	5	2	t	1	{"dateIncome":"2024-03-25","typeRoute":1,"flightNumber":2,"instructor":5,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-25 15:02:01.795899+03
2089	2024-03-26	1	1	14	2	t	1	{"dateIncome":"2024-03-26","typeRoute":1,"flightNumber":1,"instructor":14,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-26 15:59:02.26402+03
2090	2024-03-27	1	1	4	2	t	1	{"dateIncome":"2024-03-27","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-27 12:06:07.27768+03
2091	2024-03-27	2	4	4	2	t	1	{"dateIncome":"2024-03-27","typeRoute":4,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":4000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Поехали с инструктором ","price":3000}]}	2024-03-27 15:17:58.172444+03
2093	2024-03-27	4	3	4	2	t	1	{"dateIncome":"2024-03-27","typeRoute":3,"flightNumber":4,"instructor":4,"techniques":[{"typeTechnique":51,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-03-27 16:01:53.737089+03
2092	2024-03-27	3	3	4	2	t	1	{"dateIncome":"2024-03-27","typeRoute":3,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":53,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-03-27 15:52:41.924895+03
2117	2024-04-09	1	1	4	2	t	1	{"dateIncome":"2024-04-09","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-04-09 14:22:24.893075+03
2094	2024-03-28	1	4	4	2	t	1	{"dateIncome":"2024-03-28","typeRoute":4,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-28 17:20:10.004981+03
2100	2024-03-09	7	4	6	12	t	1	{"dateIncome":"2024-03-09","typeRoute":4,"flightNumber":7,"instructor":6,"techniques":[{"typeTechnique":51,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-03-29 16:25:24.130016+03
2096	2024-03-28	2	3	4	2	t	1	{"dateIncome":"2024-03-28","typeRoute":3,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":11,"discount":3000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"2 предоплаты на 1 технику, приходится делить","price":1000},{"typeTechnique":11,"discount":3000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":1000}]}	2024-03-28 17:25:03.750104+03
2101	2024-03-09	8	3	6	12	t	1	{"dateIncome":"2024-03-09","typeRoute":3,"flightNumber":8,"instructor":6,"techniques":[{"typeTechnique":41,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-29 16:27:20.793884+03
2097	2024-03-28	3	1	4	2	t	1	{"dateIncome":"2024-03-28","typeRoute":1,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-03-28 17:41:06.16732+03
2102	2024-03-09	9	1	6	12	t	1	{"dateIncome":"2024-03-09","typeRoute":1,"flightNumber":9,"instructor":6,"techniques":[{"typeTechnique":49,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":5,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-03-29 16:29:31.99635+03
2105	2024-04-01	1	1	4	2	t	1	{"dateIncome":"2024-04-01","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-04-01 13:17:22.637137+03
2098	2024-02-23	11	3	6	12	t	1	{"dateIncome":"2024-02-23","typeRoute":3,"flightNumber":11,"instructor":6,"techniques":[{"typeTechnique":39,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-29 16:06:45.767263+03
2103	2024-03-30	1	4	4	2	t	1	{"dateIncome":"2024-03-30","typeRoute":4,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-30 12:16:16.743438+03
2112	2024-04-02	4	1	4	2	t	1	{"dateIncome":"2024-04-02","typeRoute":1,"flightNumber":4,"instructor":4,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-04-02 15:50:23.415147+03
2106	2024-04-01	2	1	4	2	t	1	{"dateIncome":"2024-04-01","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-04-01 16:11:19.481925+03
2099	2024-03-09	6	1	6	12	t	1	{"dateIncome":"2024-03-09","typeRoute":1,"flightNumber":6,"instructor":6,"techniques":[{"typeTechnique":48,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":40,"discount":3500,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2500},{"typeTechnique":40,"discount":3500,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2500},{"typeTechnique":50,"discount":3500,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2500},{"typeTechnique":50,"discount":3500,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2500}]}	2024-03-29 16:21:32.981408+03
2104	2024-03-31	1	4	4	2	t	1	{"dateIncome":"2024-03-31","typeRoute":4,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":10,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-03-31 15:11:06.431633+03
2109	2024-04-02	1	1	5	2	t	1	{"dateIncome":"2024-04-02","typeRoute":1,"flightNumber":1,"instructor":5,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-04-02 12:05:37.247791+03
2108	2024-04-01	3	1	4	2	t	1	{"dateIncome":"2024-04-01","typeRoute":1,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-04-01 17:28:34.272171+03
2110	2024-04-02	2	1	5	2	t	1	{"dateIncome":"2024-04-02","typeRoute":1,"flightNumber":2,"instructor":5,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-04-02 12:35:02.676303+03
2113	2024-04-04	1	1	4	2	t	1	{"dateIncome":"2024-04-04","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":false,"typePayment":4,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":4,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-04-04 17:39:32.104155+03
2111	2024-04-02	3	4	5	2	t	1	{"dateIncome":"2024-04-02","typeRoute":4,"flightNumber":3,"instructor":5,"techniques":[{"typeTechnique":12,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":4,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-04-02 15:48:54.811162+03
2114	2024-04-05	1	4	4	2	t	1	{"dateIncome":"2024-04-05","typeRoute":4,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":35,"discount":2500,"prepayment":false,"typePayment":4,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":2500}]}	2024-04-05 17:28:52.048604+03
2116	2024-04-08	2	4	4	2	t	1	{"dateIncome":"2024-04-08","typeRoute":4,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-04-08 15:47:17.294272+03
2115	2024-04-08	1	1	4	2	t	1	{"dateIncome":"2024-04-08","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-04-08 15:45:14.149278+03
2118	2024-04-09	2	1	4	2	t	1	{"dateIncome":"2024-04-09","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":12,"discount":4000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":9,"discount":4000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-04-09 17:05:10.986274+03
2119	2024-04-10	1	1	4	2	t	1	{"dateIncome":"2024-04-10","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-04-10 15:22:36.439214+03
2120	2024-04-13	1	1	4	2	t	1	{"dateIncome":"2024-04-13","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-04-13 15:15:37.570929+03
2124	2024-04-20	1	2	4	2	t	1	{"dateIncome":"2024-04-20","typeRoute":2,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-04-20 15:26:57.238138+03
2121	2024-04-13	2	1	4	2	t	1	{"dateIncome":"2024-04-13","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":10,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"1500 из скидки агенту","price":8000},{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"1500 откат","price":8000},{"typeTechnique":12,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"1500 откат ","price":8000}]}	2024-04-13 15:25:11.91022+03
2125	2024-04-20	2	2	4	2	t	1	{"dateIncome":"2024-04-20","typeRoute":2,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Оплатили 12 поэтому разделил на 2 вездехода","price":9000},{"typeTechnique":10,"discount":8000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000}]}	2024-04-20 15:34:22.313384+03
2122	2024-04-14	1	1	4	2	t	1	{"dateIncome":"2024-04-14","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"С сайта","price":8000}]}	2024-04-14 13:54:46.293295+03
2123	2024-04-17	1	1	5	2	t	1	{"dateIncome":"2024-04-17","typeRoute":1,"flightNumber":1,"instructor":5,"techniques":[{"typeTechnique":35,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-04-17 17:11:44.081164+03
2128	2024-04-22	1	2	4	2	t	1	{"dateIncome":"2024-04-22","typeRoute":2,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":8000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"Цена 12к, поэтому разделил на 2","price":2000}]}	2024-04-22 14:49:08.692384+03
2126	2024-04-21	1	2	4	2	t	1	{"dateIncome":"2024-04-21","typeRoute":2,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-04-21 16:19:13.849208+03
2127	2024-04-21	2	1	4	2	t	1	{"dateIncome":"2024-04-21","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-04-21 17:15:06.47716+03
2131	2024-04-23	3	1	4	2	t	1	{"dateIncome":"2024-04-23","typeRoute":1,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":35,"discount":1000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-04-23 17:18:23.449266+03
2129	2024-04-23	1	2	4	2	t	1	{"dateIncome":"2024-04-23","typeRoute":2,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-04-23 16:19:15.19205+03
2130	2024-04-23	2	1	4	2	t	1	{"dateIncome":"2024-04-23","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-04-23 16:19:36.963621+03
2134	2024-04-28	1	1	4	2	t	1	{"dateIncome":"2024-04-28","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":13,"discount":2000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-04-28 10:38:28.385299+03
2132	2024-04-24	1	1	4	2	t	1	{"dateIncome":"2024-04-24","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"От Самата","price":8000},{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-04-24 16:12:29.670495+03
2133	2024-04-25	1	1	4	2	t	1	{"dateIncome":"2024-04-25","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-04-25 13:13:28.895273+03
2135	2024-04-28	2	1	4	2	t	1	{"dateIncome":"2024-04-28","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":11,"discount":1000,"prepayment":false,"typePayment":4,"clientSource":4,"hotel":0,"transfer":0,"description":"От Марии","price":9000}]}	2024-04-28 14:14:06.33001+03
2149	2024-05-01	2	4	10	2	t	1	{"dateIncome":"2024-05-01","typeRoute":4,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":32,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"Амирчик","price":4000}]}	2024-05-01 12:54:36.994439+03
2150	2024-05-01	3	1	4	2	t	1	{"dateIncome":"2024-05-01","typeRoute":1,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":15,"discount":0,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-05-01 13:34:55.038561+03
2136	2024-04-28	3	1	4	2	t	1	{"dateIncome":"2024-04-28","typeRoute":1,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":0,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-04-28 16:11:12.020985+03
2139	2024-04-29	3	4	10	2	t	1	{"dateIncome":"2024-04-29","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Амир","price":6000},{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":1000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-04-29 17:51:45.487396+03
2137	2024-04-29	1	1	10	2	t	1	{"dateIncome":"2024-04-29","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"Аминчик","price":9000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Аминчик","price":10000}]}	2024-04-29 17:09:14.209126+03
2142	2024-04-30	3	1	10	2	t	1	{"dateIncome":"2024-04-30","typeRoute":1,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":10,"discount":3000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Амирчи","price":7000}]}	2024-04-30 14:37:50.873838+03
2138	2024-04-29	2	1	10	2	t	1	{"dateIncome":"2024-04-29","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":35,"discount":3000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Амир ","price":4000},{"typeTechnique":35,"discount":3000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":35,"discount":2500,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4500},{"typeTechnique":35,"discount":2500,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4500},{"typeTechnique":35,"discount":3000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":35,"discount":3000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-04-29 17:47:45.613938+03
2140	2024-04-30	1	2	6	2	t	1	{"dateIncome":"2024-04-30","typeRoute":2,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-04-30 13:42:04.600323+03
2146	2024-04-30	7	2	6	2	t	1	{"dateIncome":"2024-04-30","typeRoute":2,"flightNumber":7,"instructor":6,"techniques":[{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":2000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-04-30 16:01:21.28914+03
2141	2024-04-30	2	1	6	2	t	1	{"dateIncome":"2024-04-30","typeRoute":1,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":35,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":35,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-04-30 13:58:50.695074+03
2143	2024-04-30	4	1	4	2	t	1	{"dateIncome":"2024-04-30","typeRoute":1,"flightNumber":4,"instructor":4,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":4,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-04-30 15:15:05.310627+03
2144	2024-04-30	5	2	6	2	t	1	{"dateIncome":"2024-04-30","typeRoute":2,"flightNumber":5,"instructor":6,"techniques":[{"typeTechnique":35,"discount":2000,"prepayment":false,"typePayment":4,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-04-30 15:48:35.28583+03
2145	2024-04-30	6	2	10	2	t	1	{"dateIncome":"2024-04-30","typeRoute":2,"flightNumber":6,"instructor":10,"techniques":[{"typeTechnique":10,"discount":5000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":4000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":11,"discount":5000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":4000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":13,"discount":5000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":13,"discount":4000,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-04-30 15:59:45.201605+03
2147	2024-04-30	8	2	4	2	t	1	{"dateIncome":"2024-04-30","typeRoute":2,"flightNumber":8,"instructor":4,"techniques":[{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":35,"discount":2000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-04-30 16:31:20.327393+03
2148	2024-05-01	1	3	6	2	t	1	{"dateIncome":"2024-05-01","typeRoute":3,"flightNumber":1,"instructor":6,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-05-01 12:25:04.780147+03
2151	2024-05-01	4	2	10	2	t	1	{"dateIncome":"2024-05-01","typeRoute":2,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":10,"discount":3200,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"Амирчик. С сайта, поэтому с комиссией ","price":8800},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-05-01 14:43:14.835213+03
2166	2024-05-10	5	3	6	2	t	1	{"dateIncome":"2024-05-10","typeRoute":3,"flightNumber":5,"instructor":6,"techniques":[{"typeTechnique":26,"discount":600,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"20% стойке","price":2400}]}	2024-05-10 12:37:39.228356+03
2152	2024-05-01	5	1	4	2	t	1	{"dateIncome":"2024-05-01","typeRoute":1,"flightNumber":5,"instructor":4,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-05-01 16:03:25.724329+03
2161	2024-05-09	2	2	4	2	t	1	{"dateIncome":"2024-05-09","typeRoute":2,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-05-09 17:54:57.135338+03
2153	2024-05-02	1	1	10	2	t	1	{"dateIncome":"2024-05-02","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-05-02 10:14:41.469994+03
2154	2024-05-02	2	1	4	2	t	1	{"dateIncome":"2024-05-02","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-05-02 15:13:56.22892+03
2155	2024-05-03	1	3	10	2	t	1	{"dateIncome":"2024-05-03","typeRoute":3,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":17,"discount":500,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"Откат 500 отдали. Инструктор Амир","price":2500},{"typeTechnique":28,"discount":500,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":2500}]}	2024-05-03 14:01:34.210166+03
2156	2024-05-03	2	4	6	2	t	1	{"dateIncome":"2024-05-03","typeRoute":4,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-05-03 15:20:45.601121+03
2164	2024-05-10	3	3	10	2	t	1	{"dateIncome":"2024-05-10","typeRoute":3,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-05-10 11:37:15.549615+03
2162	2024-05-10	1	1	10	2	t	1	{"dateIncome":"2024-05-10","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-05-10 10:23:42.497741+03
2157	2024-05-04	1	1	10	2	t	1	{"dateIncome":"2024-05-04","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":4,"clientSource":5,"hotel":0,"transfer":0,"description":"Инструктор Амир ","price":8000}]}	2024-05-04 14:31:11.746619+03
2158	2024-05-06	1	1	4	2	t	1	{"dateIncome":"2024-05-06","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-05-06 15:00:02.22529+03
2160	2024-05-09	1	1	10	2	t	1	{"dateIncome":"2024-05-09","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":10,"discount":3600,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"20% скидка","price":6400},{"typeTechnique":10,"discount":8000,"prepayment":false,"typePayment":1,"clientSource":6,"hotel":0,"transfer":0,"description":"Инструктор Амир. Оплатили нал и на стойке","price":2000}]}	2024-05-09 17:35:14.132677+03
2163	2024-05-10	2	1	4	2	t	1	{"dateIncome":"2024-05-10","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":24,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-05-10 11:02:48.118929+03
2165	2024-05-10	4	4	6	2	t	1	{"dateIncome":"2024-05-10","typeRoute":4,"flightNumber":4,"instructor":6,"techniques":[{"typeTechnique":21,"discount":500,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4500}]}	2024-05-10 12:15:02.810049+03
2168	2024-05-10	6	2	4	2	t	1	{"dateIncome":"2024-05-10","typeRoute":2,"flightNumber":6,"instructor":4,"techniques":[{"typeTechnique":12,"discount":1200,"prepayment":false,"typePayment":6,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":10800},{"typeTechnique":13,"discount":1200,"prepayment":false,"typePayment":6,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":10800}]}	2024-05-10 13:05:56.025172+03
2169	2024-05-10	7	1	10	2	t	1	{"dateIncome":"2024-05-10","typeRoute":1,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":19,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":30,"discount":3200,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3800},{"typeTechnique":30,"discount":4800,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3200}]}	2024-05-10 13:23:54.49758+03
2170	2024-05-10	8	1	4	2	t	1	{"dateIncome":"2024-05-10","typeRoute":1,"flightNumber":8,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-05-10 15:37:16.759228+03
2197	2024-06-02	2	1	4	2	t	1	{"dateIncome":"2024-06-02","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":12,"discount":3000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-06-02 16:11:48.940346+03
2200	2024-06-03	1	4	4	2	t	1	{"dateIncome":"2024-06-03","typeRoute":4,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":17,"discount":1500,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"Скидка - курорту","price":3500},{"typeTechnique":19,"discount":1500,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"Скидка- курорту","price":3500}]}	2024-06-03 16:02:34.460477+03
2171	2024-05-10	9	1	10	2	t	1	{"dateIncome":"2024-05-10","typeRoute":1,"flightNumber":9,"instructor":10,"techniques":[{"typeTechnique":17,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":29,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":24,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":20,"discount":1600,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":22,"discount":1600,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":10,"discount":4000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-05-10 16:44:58.051235+03
2172	2024-05-10	10	2	6	2	t	1	{"dateIncome":"2024-05-10","typeRoute":2,"flightNumber":10,"instructor":6,"techniques":[{"typeTechnique":32,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"Все 3 постоянные клиенты","price":8000},{"typeTechnique":21,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":26,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-05-10 16:48:47.02139+03
2196	2024-06-02	1	1	4	2	t	1	{"dateIncome":"2024-06-02","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":11,"discount":3000,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":12,"discount":3000,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-06-02 14:53:31.584211+03
2173	2024-05-11	1	1	4	2	t	1	{"dateIncome":"2024-05-11","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-05-11 10:22:42.485377+03
2174	2024-05-11	2	4	6	2	t	1	{"dateIncome":"2024-05-11","typeRoute":4,"flightNumber":2,"instructor":6,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-05-11 11:47:49.22498+03
2201	2024-06-03	2	1	4	2	t	1	{"dateIncome":"2024-06-03","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":24,"discount":2400,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"Скидка - курорту","price":5600},{"typeTechnique":27,"discount":2400,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"Скидка - курорту","price":5600}]}	2024-06-03 16:05:01.801096+03
2175	2024-05-11	3	1	6	2	t	1	{"dateIncome":"2024-05-11","typeRoute":1,"flightNumber":3,"instructor":6,"techniques":[{"typeTechnique":18,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-05-11 12:36:32.863647+03
2198	2024-06-02	3	4	4	2	t	1	{"dateIncome":"2024-06-02","typeRoute":4,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-06-02 16:12:48.937185+03
2199	2024-06-02	4	1	4	2	t	1	{"dateIncome":"2024-06-02","typeRoute":1,"flightNumber":4,"instructor":4,"techniques":[{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-06-02 16:13:30.721161+03
2202	2024-06-04	1	1	4	2	t	1	{"dateIncome":"2024-06-04","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":30,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"Скидка-курорту","price":6400}]}	2024-06-04 17:23:46.515271+03
2206	2024-06-05	2	2	4	2	t	1	{"dateIncome":"2024-06-05","typeRoute":2,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-06-05 10:38:59.159178+03
2205	2024-06-05	1	2	4	2	t	1	{"dateIncome":"2024-06-05","typeRoute":2,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-06-05 10:23:22.712578+03
2203	2024-06-04	2	2	4	2	t	1	{"dateIncome":"2024-06-04","typeRoute":2,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":24,"discount":2700,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"От мун 2 все 3","price":7300},{"typeTechnique":26,"discount":2700,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":7300},{"typeTechnique":22,"discount":2700,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7300}]}	2024-06-04 17:31:44.406097+03
2204	2024-06-04	3	3	4	2	t	1	{"dateIncome":"2024-06-04","typeRoute":3,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":27,"discount":600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"Скидка-курорту","price":2400}]}	2024-06-04 17:35:06.563625+03
2207	2024-06-05	3	1	4	2	t	1	{"dateIncome":"2024-06-05","typeRoute":1,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":22,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"Скидка-курорту","price":6400}]}	2024-06-05 15:26:45.430984+03
2209	2024-06-07	2	3	10	2	t	1	{"dateIncome":"2024-06-07","typeRoute":3,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":27,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-06-07 15:41:18.575024+03
2208	2024-06-07	1	4	10	2	t	1	{"dateIncome":"2024-06-07","typeRoute":4,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":26,"discount":1000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"Скидка курорту","price":4000}]}	2024-06-07 15:40:28.287393+03
2181	2024-05-13	2	1	4	2	t	1	{"dateIncome":"2024-05-13","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":3000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":13,"discount":7000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Оплатили часть наличкой, поэтому разделил ","price":3000}]}	2024-05-13 15:59:01.480796+03
2176	2024-05-11	4	3	10	2	t	1	{"dateIncome":"2024-05-11","typeRoute":3,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":11,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":1000},{"typeTechnique":11,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Инструктор Амир ","price":1000}]}	2024-05-11 12:51:17.734475+03
2177	2024-05-11	5	1	10	2	t	1	{"dateIncome":"2024-05-11","typeRoute":1,"flightNumber":5,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-05-11 13:11:43.442735+03
2178	2024-05-11	6	1	4	2	t	1	{"dateIncome":"2024-05-11","typeRoute":1,"flightNumber":6,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-05-11 14:24:08.753832+03
2182	2024-05-13	3	2	3	2	t	1	{"dateIncome":"2024-05-13","typeRoute":2,"flightNumber":3,"instructor":3,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-05-13 16:28:42.477921+03
2179	2024-05-11	7	1	4	2	t	1	{"dateIncome":"2024-05-11","typeRoute":1,"flightNumber":7,"instructor":4,"techniques":[{"typeTechnique":23,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-05-11 17:15:27.098667+03
2180	2024-05-13	1	1	4	2	t	1	{"dateIncome":"2024-05-13","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-05-13 12:59:25.702275+03
2188	2024-05-19	3	4	18	2	t	1	{"dateIncome":"2024-05-19","typeRoute":4,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":28,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":12,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-05-19 15:30:37.193847+03
2183	2024-05-14	1	1	4	2	t	1	{"dateIncome":"2024-05-14","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":23,"discount":2000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-05-14 15:10:57.2277+03
2186	2024-05-19	1	3	18	2	t	1	{"dateIncome":"2024-05-19","typeRoute":3,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-05-19 13:41:37.109382+03
2184	2024-05-15	1	1	3	2	t	1	{"dateIncome":"2024-05-15","typeRoute":1,"flightNumber":1,"instructor":3,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-05-15 16:46:16.151351+03
2187	2024-05-19	2	2	18	2	t	1	{"dateIncome":"2024-05-19","typeRoute":2,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":22,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":1200,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"Скидка - откат Маше","price":10800}]}	2024-05-19 13:51:22.233323+03
2185	2024-05-18	1	1	18	2	t	1	{"dateIncome":"2024-05-18","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":11,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Скидка - откат Маше ","price":9000}]}	2024-05-18 17:24:41.177285+03
2189	2024-05-22	1	4	3	2	t	1	{"dateIncome":"2024-05-22","typeRoute":4,"flightNumber":1,"instructor":3,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-05-22 14:39:21.30839+03
2191	2024-05-24	1	3	3	2	t	1	{"dateIncome":"2024-05-24","typeRoute":3,"flightNumber":1,"instructor":3,"techniques":[{"typeTechnique":20,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Оставили отзывы ","price":1000},{"typeTechnique":20,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":1000}]}	2024-05-24 17:48:24.480608+03
2190	2024-05-22	2	1	3	2	t	1	{"dateIncome":"2024-05-22","typeRoute":1,"flightNumber":2,"instructor":3,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-05-22 14:40:27.423318+03
2193	2024-05-25	2	4	4	2	t	1	{"dateIncome":"2024-05-25","typeRoute":4,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-05-25 12:26:57.642049+03
2192	2024-05-25	1	1	4	2	t	1	{"dateIncome":"2024-05-25","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-05-25 12:26:02.950148+03
2194	2024-05-30	1	2	4	2	t	1	{"dateIncome":"2024-05-30","typeRoute":2,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":24,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-05-30 15:49:55.418693+03
2195	2024-06-01	1	1	4	2	t	1	{"dateIncome":"2024-06-01","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":3000,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"Откат 30%","price":7000}]}	2024-06-01 15:27:55.48773+03
2210	2024-06-07	3	2	10	2	t	1	{"dateIncome":"2024-06-07","typeRoute":2,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Скидка - откат","price":11000}]}	2024-06-07 15:42:53.724479+03
2211	2024-06-07	4	2	10	2	t	1	{"dateIncome":"2024-06-07","typeRoute":2,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-06-07 15:44:42.607853+03
2212	2024-06-08	1	3	10	2	t	1	{"dateIncome":"2024-06-08","typeRoute":3,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000}]}	2024-06-08 13:10:05.189669+03
2219	2024-06-11	2	1	10	2	t	1	{"dateIncome":"2024-06-11","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":25,"discount":800,"prepayment":false,"typePayment":4,"clientSource":4,"hotel":0,"transfer":0,"description":"От Аллюра оба","price":7200},{"typeTechnique":31,"discount":800,"prepayment":false,"typePayment":4,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":7200}]}	2024-06-11 15:51:13.274096+03
2213	2024-06-08	2	3	10	2	t	1	{"dateIncome":"2024-06-08","typeRoute":3,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-06-08 17:31:35.902674+03
2214	2024-06-09	1	3	10	2	t	1	{"dateIncome":"2024-06-09","typeRoute":3,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-06-09 12:36:27.721266+03
2215	2024-06-09	2	1	10	2	t	1	{"dateIncome":"2024-06-09","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-06-09 14:32:27.786209+03
2216	2024-06-09	3	4	10	2	t	1	{"dateIncome":"2024-06-09","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-06-09 17:41:55.933198+03
2217	2024-06-10	1	2	10	2	t	1	{"dateIncome":"2024-06-10","typeRoute":2,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-06-10 10:49:21.726989+03
2224	2024-06-12	1	2	4	2	t	1	{"dateIncome":"2024-06-12","typeRoute":2,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":2000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-06-12 14:40:35.226648+03
2225	2024-06-12	2	2	10	2	t	1	{"dateIncome":"2024-06-12","typeRoute":2,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":6,"clientSource":4,"hotel":0,"transfer":0,"description":"Стоило 12к отдали откат 2к","price":10000}]}	2024-06-12 14:42:45.951665+03
2218	2024-06-11	1	1	4	2	t	1	{"dateIncome":"2024-06-11","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":4,"clientSource":3,"hotel":0,"transfer":0,"description":"От Аллюра оба","price":9000},{"typeTechnique":13,"discount":1000,"prepayment":false,"typePayment":4,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-06-11 15:49:45.846986+03
2221	2024-06-11	3	1	4	2	t	1	{"dateIncome":"2024-06-11","typeRoute":1,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":22,"discount":1600,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":26,"discount":1600,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-06-11 15:53:15.925648+03
2222	2024-06-11	4	2	10	2	t	1	{"dateIncome":"2024-06-11","typeRoute":2,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":11,"discount":3000,"prepayment":true,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":12,"discount":3000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":13,"discount":3000,"prepayment":true,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-06-11 15:56:53.320274+03
2226	2024-06-12	3	3	4	2	t	1	{"dateIncome":"2024-06-12","typeRoute":3,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":22,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":2000}]}	2024-06-12 17:45:50.904304+03
2229	2024-06-13	2	1	20	2	t	1	{"dateIncome":"2024-06-13","typeRoute":1,"flightNumber":2,"instructor":20,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-06-13 13:14:07.975673+03
2227	2024-06-12	4	3	20	2	t	1	{"dateIncome":"2024-06-12","typeRoute":3,"flightNumber":4,"instructor":20,"techniques":[{"typeTechnique":25,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-06-12 17:46:40.953727+03
2228	2024-06-13	1	4	20	2	t	1	{"dateIncome":"2024-06-13","typeRoute":4,"flightNumber":1,"instructor":20,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-06-13 13:09:15.150924+03
2230	2024-06-13	3	2	2	2	t	1	{"dateIncome":"2024-06-13","typeRoute":2,"flightNumber":3,"instructor":2,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-06-13 16:13:25.507963+03
2231	2024-06-13	4	1	20	2	t	1	{"dateIncome":"2024-06-13","typeRoute":1,"flightNumber":4,"instructor":20,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-06-13 17:32:41.671495+03
2232	2024-06-13	5	3	3	2	t	1	{"dateIncome":"2024-06-13","typeRoute":3,"flightNumber":5,"instructor":3,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-06-13 17:33:32.464197+03
2237	2024-06-15	5	2	4	2	t	1	{"dateIncome":"2024-06-15","typeRoute":2,"flightNumber":5,"instructor":4,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-06-15 14:45:08.650724+03
2236	2024-06-15	4	1	3	2	t	1	{"dateIncome":"2024-06-15","typeRoute":1,"flightNumber":4,"instructor":3,"techniques":[{"typeTechnique":18,"discount":1600,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":19,"discount":1600,"prepayment":false,"typePayment":4,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-06-15 12:30:21.813623+03
2233	2024-06-15	1	2	20	2	t	1	{"dateIncome":"2024-06-15","typeRoute":2,"flightNumber":1,"instructor":20,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":29,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-06-15 10:30:43.77198+03
2234	2024-06-15	2	4	20	2	t	1	{"dateIncome":"2024-06-15","typeRoute":4,"flightNumber":2,"instructor":20,"techniques":[{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-06-15 10:31:51.472639+03
2235	2024-06-15	3	2	4	2	t	1	{"dateIncome":"2024-06-15","typeRoute":2,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-06-15 10:39:40.44155+03
2240	2024-06-16	1	4	20	2	t	1	{"dateIncome":"2024-06-16","typeRoute":4,"flightNumber":1,"instructor":20,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-06-16 15:19:50.54013+03
2241	2024-06-16	2	1	4	2	t	1	{"dateIncome":"2024-06-16","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":3,"hotel":0,"transfer":0,"description":"От ски резорт","price":8000}]}	2024-06-16 15:22:46.666293+03
2239	2024-06-15	6	2	20	2	t	1	{"dateIncome":"2024-06-15","typeRoute":2,"flightNumber":6,"instructor":20,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":19,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-06-15 14:47:56.090663+03
2242	2024-06-17	1	1	4	2	t	1	{"dateIncome":"2024-06-17","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":26,"discount":800,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"от Маши","price":7200}]}	2024-06-17 15:46:18.355525+03
2243	2024-06-17	2	1	20	2	t	1	{"dateIncome":"2024-06-17","typeRoute":1,"flightNumber":2,"instructor":20,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-06-17 15:47:48.226982+03
2247	2024-06-18	2	1	20	2	t	1	{"dateIncome":"2024-06-18","typeRoute":1,"flightNumber":2,"instructor":20,"techniques":[{"typeTechnique":13,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"От премиум вилладж. Скидка - откат","price":9000},{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-06-18 16:38:39.505237+03
2245	2024-06-17	3	1	4	2	t	1	{"dateIncome":"2024-06-17","typeRoute":1,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":19,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":23,"discount":3000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-06-17 17:20:20.608026+03
2246	2024-06-18	1	1	4	2	t	1	{"dateIncome":"2024-06-18","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-06-18 16:35:16.784649+03
2248	2024-06-18	3	1	4	2	t	1	{"dateIncome":"2024-06-18","typeRoute":1,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":32,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-06-18 17:57:13.018674+03
2255	2024-06-21	2	4	2	2	t	1	{"dateIncome":"2024-06-21","typeRoute":4,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":29,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-06-21 13:04:52.483214+03
2249	2024-06-19	1	2	18	2	t	1	{"dateIncome":"2024-06-19","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-06-19 10:00:03.013859+03
2250	2024-06-19	2	1	18	2	t	1	{"dateIncome":"2024-06-19","typeRoute":1,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-06-19 14:20:40.124392+03
2256	2024-06-21	3	4	18	2	t	1	{"dateIncome":"2024-06-21","typeRoute":4,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-06-21 17:21:15.822853+03
2251	2024-06-19	3	2	2	2	t	1	{"dateIncome":"2024-06-19","typeRoute":2,"flightNumber":3,"instructor":2,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-06-19 17:25:33.91819+03
2252	2024-06-19	4	3	20	2	t	1	{"dateIncome":"2024-06-19","typeRoute":3,"flightNumber":4,"instructor":20,"techniques":[{"typeTechnique":34,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-06-19 17:30:11.42302+03
2253	2024-06-20	1	2	20	2	t	1	{"dateIncome":"2024-06-20","typeRoute":2,"flightNumber":1,"instructor":20,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":12,"discount":6000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"С инструктором -50%","price":6000}]}	2024-06-20 10:12:55.139985+03
2258	2024-06-22	2	1	4	2	t	1	{"dateIncome":"2024-06-22","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-06-22 14:24:41.87607+03
2254	2024-06-21	1	2	18	2	t	1	{"dateIncome":"2024-06-21","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":12,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":12,"discount":4000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-06-21 11:18:12.816742+03
2259	2024-06-22	3	2	18	2	t	1	{"dateIncome":"2024-06-22","typeRoute":2,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":21,"discount":5000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Взяли 2 квадрика за 30к","price":5000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":28,"discount":5000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-06-22 14:27:52.555766+03
2257	2024-06-22	1	3	18	2	t	1	{"dateIncome":"2024-06-22","typeRoute":3,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-06-22 11:50:06.710199+03
2261	2024-06-22	5	3	2	2	t	1	{"dateIncome":"2024-06-22","typeRoute":3,"flightNumber":5,"instructor":2,"techniques":[{"typeTechnique":13,"discount":500,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3500},{"typeTechnique":24,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":17,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":1000}]}	2024-06-22 17:46:35.040887+03
2260	2024-06-22	4	2	18	2	t	1	{"dateIncome":"2024-06-22","typeRoute":2,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-06-22 16:26:14.02582+03
2262	2024-06-22	5	3	2	2	f	1	{"dateIncome":"2024-06-22","typeRoute":3,"flightNumber":5,"instructor":2,"techniques":[{"typeTechnique":13,"discount":500,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3500},{"typeTechnique":24,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":17,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":1000}]}	2024-06-22 17:46:44.432621+03
2264	2024-06-23	2	4	2	2	t	1	{"dateIncome":"2024-06-23","typeRoute":4,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-06-23 14:45:35.777535+03
2263	2024-06-23	1	1	2	2	t	1	{"dateIncome":"2024-06-23","typeRoute":1,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-06-23 14:44:19.432502+03
2276	2024-06-27	1	1	4	2	t	1	{"dateIncome":"2024-06-27","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":20,"discount":1600,"prepayment":false,"typePayment":2,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-06-27 13:17:39.119649+03
2265	2024-06-23	1	3	3	2	t	1	{"dateIncome":"2024-06-23","typeRoute":3,"flightNumber":1,"instructor":3,"techniques":[{"typeTechnique":25,"discount":500,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":2500},{"typeTechnique":25,"discount":2500,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":500}]}	2024-06-23 16:11:55.473724+03
2266	2024-06-23	3	4	2	2	t	1	{"dateIncome":"2024-06-23","typeRoute":4,"flightNumber":3,"instructor":2,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-06-23 16:13:35.462308+03
2272	2024-06-25	3	4	4	2	t	1	{"dateIncome":"2024-06-25","typeRoute":4,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Оплатили предоплату, не доехали до белых","price":5000}]}	2024-06-25 16:51:44.758945+03
2267	2024-06-23	4	4	20	2	t	1	{"dateIncome":"2024-06-23","typeRoute":4,"flightNumber":4,"instructor":20,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-06-23 17:57:58.384388+03
2268	2024-06-24	1	1	20	2	t	1	{"dateIncome":"2024-06-24","typeRoute":1,"flightNumber":1,"instructor":20,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-06-24 10:18:47.927757+03
2269	2024-06-24	2	2	2	2	t	1	{"dateIncome":"2024-06-24","typeRoute":2,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-06-24 17:21:18.304924+03
2273	2024-06-25	4	3	20	2	t	1	{"dateIncome":"2024-06-25","typeRoute":3,"flightNumber":4,"instructor":20,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-06-25 17:27:19.891608+03
2270	2024-06-25	1	1	4	2	t	1	{"dateIncome":"2024-06-25","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":24,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-06-25 11:08:21.213856+03
2271	2024-06-25	2	3	20	2	t	1	{"dateIncome":"2024-06-25","typeRoute":3,"flightNumber":2,"instructor":20,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-06-25 15:21:13.840848+03
2277	2024-06-27	2	1	4	2	t	1	{"dateIncome":"2024-06-27","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-06-27 15:35:14.906606+03
2274	2024-06-26	1	1	4	2	t	1	{"dateIncome":"2024-06-26","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":26,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":21,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-06-26 15:40:58.47317+03
2275	2024-06-26	2	1	20	2	t	1	{"dateIncome":"2024-06-26","typeRoute":1,"flightNumber":2,"instructor":20,"techniques":[{"typeTechnique":24,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-06-26 15:42:31.244873+03
2283	2024-06-29	5	3	20	2	t	1	{"dateIncome":"2024-06-29","typeRoute":3,"flightNumber":5,"instructor":20,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-06-29 17:27:34.01938+03
2278	2024-06-28	1	2	4	2	t	1	{"dateIncome":"2024-06-28","typeRoute":2,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-06-28 14:52:06.886516+03
2282	2024-06-29	4	4	20	2	t	1	{"dateIncome":"2024-06-29","typeRoute":4,"flightNumber":4,"instructor":20,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-06-29 17:04:23.469168+03
2279	2024-06-29	1	1	4	2	t	1	{"dateIncome":"2024-06-29","typeRoute":1,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":23,"discount":1600,"prepayment":false,"typePayment":2,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-06-29 11:18:28.658777+03
2280	2024-06-29	2	1	4	2	t	1	{"dateIncome":"2024-06-29","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":27,"discount":1600,"prepayment":false,"typePayment":2,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-06-29 15:43:21.744301+03
2281	2024-06-29	3	4	2	2	t	1	{"dateIncome":"2024-06-29","typeRoute":4,"flightNumber":3,"instructor":2,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-06-29 15:44:00.764167+03
2284	2024-06-30	1	2	20	2	t	1	{"dateIncome":"2024-06-30","typeRoute":2,"flightNumber":1,"instructor":20,"techniques":[{"typeTechnique":22,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":12,"discount":1000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-06-30 10:29:12.968012+03
2285	2024-06-30	2	4	2	2	t	1	{"dateIncome":"2024-06-30","typeRoute":4,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-06-30 13:52:44.834426+03
2291	2024-07-02	2	1	4	2	t	1	{"dateIncome":"2024-07-02","typeRoute":1,"flightNumber":2,"instructor":4,"techniques":[{"typeTechnique":23,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-07-02 15:30:14.535774+03
2286	2024-06-30	3	1	4	2	t	1	{"dateIncome":"2024-06-30","typeRoute":1,"flightNumber":3,"instructor":4,"techniques":[{"typeTechnique":24,"discount":800,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"Все 3 от ислама, ему скидка-комисия","price":7200},{"typeTechnique":31,"discount":800,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":7200},{"typeTechnique":28,"discount":800,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":7200}]}	2024-06-30 16:58:15.645333+03
2287	2024-06-30	4	4	2	2	t	1	{"dateIncome":"2024-06-30","typeRoute":4,"flightNumber":4,"instructor":2,"techniques":[{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-06-30 17:37:27.758496+03
2288	2024-07-01	1	2	4	2	t	1	{"dateIncome":"2024-07-01","typeRoute":2,"flightNumber":1,"instructor":4,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":26,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Приехали на белые, отправил на софию по цене белого","price":8000},{"typeTechnique":31,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-07-01 10:54:37.907554+03
2289	2024-07-01	2	1	2	2	t	1	{"dateIncome":"2024-07-01","typeRoute":1,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-07-01 16:38:32.358844+03
2296	2024-07-04	2	1	20	2	t	1	{"dateIncome":"2024-07-04","typeRoute":1,"flightNumber":2,"instructor":20,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-04 14:37:38.666294+03
2290	2024-07-02	1	1	2	2	t	1	{"dateIncome":"2024-07-02","typeRoute":1,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":12,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-02 15:25:45.264525+03
2292	2024-07-02	3	1	20	2	t	1	{"dateIncome":"2024-07-02","typeRoute":1,"flightNumber":3,"instructor":20,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"От ски резорт. Наверное постоплата","price":8000}]}	2024-07-02 16:53:41.986684+03
2293	2024-07-02	4	4	2	2	t	1	{"dateIncome":"2024-07-02","typeRoute":4,"flightNumber":4,"instructor":2,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-02 16:54:10.527286+03
2299	2024-07-05	3	1	3	2	t	1	{"dateIncome":"2024-07-05","typeRoute":1,"flightNumber":3,"instructor":3,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-05 16:50:11.543919+03
2294	2024-07-03	1	4	20	2	t	1	{"dateIncome":"2024-07-03","typeRoute":4,"flightNumber":1,"instructor":20,"techniques":[{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-03 12:34:29.957106+03
2297	2024-07-05	1	2	2	2	t	1	{"dateIncome":"2024-07-05","typeRoute":2,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-05 14:05:11.748575+03
2295	2024-07-04	1	2	3	2	t	1	{"dateIncome":"2024-07-04","typeRoute":2,"flightNumber":1,"instructor":3,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-04 14:25:32.642212+03
2298	2024-07-05	2	3	2	2	t	1	{"dateIncome":"2024-07-05","typeRoute":3,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-05 16:04:07.942557+03
2301	2024-07-06	2	1	20	2	t	1	{"dateIncome":"2024-07-06","typeRoute":1,"flightNumber":2,"instructor":20,"techniques":[{"typeTechnique":12,"discount":1900,"prepayment":false,"typePayment":1,"clientSource":3,"hotel":0,"transfer":0,"description":"Премиум вилладж. Комиссия 900 исламу","price":8100}]}	2024-07-06 11:58:38.230525+03
2303	2024-07-07	1	1	2	2	t	1	{"dateIncome":"2024-07-07","typeRoute":1,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":28,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":25,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-07 14:03:28.509408+03
2300	2024-07-06	1	3	2	2	t	1	{"dateIncome":"2024-07-06","typeRoute":3,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-06 11:56:07.793347+03
2302	2024-07-06	3	3	18	2	t	1	{"dateIncome":"2024-07-06","typeRoute":3,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-06 12:03:56.94657+03
2304	2024-07-07	2	2	18	2	t	1	{"dateIncome":"2024-07-07","typeRoute":2,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":28,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-07 15:35:07.303408+03
2313	2024-07-08	2	2	10	2	t	1	{"dateIncome":"2024-07-08","typeRoute":2,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"Назар","price":10000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-08 10:59:48.493795+03
2305	2024-07-07	3	3	2	2	t	1	{"dateIncome":"2024-07-07","typeRoute":3,"flightNumber":3,"instructor":2,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-07 16:26:50.030273+03
2306	2024-07-07	4	3	2	2	t	1	{"dateIncome":"2024-07-07","typeRoute":3,"flightNumber":4,"instructor":2,"techniques":[{"typeTechnique":25,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":27,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":2000}]}	2024-07-07 16:27:17.212898+03
2307	2024-07-07	5	1	18	2	t	1	{"dateIncome":"2024-07-07","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-07 16:30:27.613995+03
2310	2024-07-07	8	3	20	2	t	1	{"dateIncome":"2024-07-07","typeRoute":3,"flightNumber":8,"instructor":20,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":27,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-07 17:38:09.076506+03
2311	2024-07-07	9	4	2	2	t	1	{"dateIncome":"2024-07-07","typeRoute":4,"flightNumber":9,"instructor":2,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-07-07 17:46:31.058094+03
2308	2024-07-07	6	4	10	2	t	1	{"dateIncome":"2024-07-07","typeRoute":4,"flightNumber":6,"instructor":10,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Предоплата это перевод просто ","price":5000},{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-07 16:48:21.577527+03
2309	2024-07-07	7	4	10	2	t	1	{"dateIncome":"2024-07-07","typeRoute":4,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"Этот и выше рейс Назар","price":6000}]}	2024-07-07 16:49:09.616392+03
2316	2024-07-09	3	1	10	2	t	1	{"dateIncome":"2024-07-09","typeRoute":1,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":27,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"Назар ","price":6400},{"typeTechnique":28,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":25,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-07-09 15:56:48.307756+03
2312	2024-07-08	1	2	18	2	t	1	{"dateIncome":"2024-07-08","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-07-08 10:57:48.199748+03
2314	2024-07-09	1	2	18	2	t	1	{"dateIncome":"2024-07-09","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":12,"discount":1200,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"От ски ресорт","price":10800},{"typeTechnique":13,"discount":1200,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":10800}]}	2024-07-09 15:48:11.948954+03
2315	2024-07-09	2	1	18	2	t	1	{"dateIncome":"2024-07-09","typeRoute":1,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":31,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-07-09 15:52:29.954467+03
2318	2024-07-09	5	3	2	2	t	1	{"dateIncome":"2024-07-09","typeRoute":3,"flightNumber":5,"instructor":2,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-09 17:17:48.872611+03
2317	2024-07-09	4	3	10	2	t	1	{"dateIncome":"2024-07-09","typeRoute":3,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"Назар","price":4000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-09 17:17:00.631355+03
2319	2024-07-09	6	1	10	2	t	1	{"dateIncome":"2024-07-09","typeRoute":1,"flightNumber":6,"instructor":10,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-09 17:44:44.166648+03
2322	2024-07-10	2	3	10	2	t	1	{"dateIncome":"2024-07-10","typeRoute":3,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"Назар","price":3000}]}	2024-07-10 10:38:36.681961+03
2341	2024-07-16	2	1	20	2	t	1	{"dateIncome":"2024-07-16","typeRoute":1,"flightNumber":2,"instructor":20,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-16 09:55:09.09743+03
2321	2024-07-10	1	1	18	2	t	1	{"dateIncome":"2024-07-10","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":3,"hotel":0,"transfer":0,"description":"Комиссия исламу","price":9000},{"typeTechnique":13,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-10 10:37:54.468502+03
2324	2024-07-10	3	4	10	2	t	1	{"dateIncome":"2024-07-10","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Назар","price":4000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-10 15:18:45.685125+03
2325	2024-07-10	4	4	20	2	t	1	{"dateIncome":"2024-07-10","typeRoute":4,"flightNumber":4,"instructor":20,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-07-10 15:40:19.30396+03
2326	2024-07-10	5	1	18	2	t	1	{"dateIncome":"2024-07-10","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":25,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":30,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-10 17:15:29.994599+03
2328	2024-07-11	1	2	10	2	t	1	{"dateIncome":"2024-07-11","typeRoute":2,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":27,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Назар ","price":8000},{"typeTechnique":28,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-11 13:56:11.052423+03
2329	2024-07-11	2	1	18	2	t	1	{"dateIncome":"2024-07-11","typeRoute":1,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-11 14:01:27.975973+03
2332	2024-07-14	2	4	18	2	t	1	{"dateIncome":"2024-07-14","typeRoute":4,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-14 10:02:07.052191+03
2330	2024-07-12	1	2	18	2	t	1	{"dateIncome":"2024-07-12","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-12 10:33:32.790719+03
2331	2024-07-14	1	4	18	2	t	1	{"dateIncome":"2024-07-14","typeRoute":4,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-14 09:20:34.982658+03
2335	2024-07-14	5	2	18	2	t	1	{"dateIncome":"2024-07-14","typeRoute":2,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-14 16:52:16.218573+03
2333	2024-07-14	3	1	18	2	t	1	{"dateIncome":"2024-07-14","typeRoute":1,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Оплатили","price":10000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":22,"discount":800,"prepayment":false,"typePayment":6,"clientSource":3,"hotel":0,"transfer":0,"description":"От Аллюра. ","price":7200}]}	2024-07-14 13:12:10.421282+03
2337	2024-07-14	7	4	2	2	t	1	{"dateIncome":"2024-07-14","typeRoute":4,"flightNumber":7,"instructor":2,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-14 17:05:11.687701+03
2334	2024-07-14	4	1	3	2	t	1	{"dateIncome":"2024-07-14","typeRoute":1,"flightNumber":4,"instructor":3,"techniques":[{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":24,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":29,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-07-14 16:51:35.95697+03
2336	2024-07-14	6	1	3	2	t	1	{"dateIncome":"2024-07-14","typeRoute":1,"flightNumber":6,"instructor":3,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-14 16:53:15.337337+03
2339	2024-07-15	2	1	3	2	t	1	{"dateIncome":"2024-07-15","typeRoute":1,"flightNumber":2,"instructor":3,"techniques":[{"typeTechnique":18,"discount":800,"prepayment":false,"typePayment":6,"clientSource":3,"hotel":0,"transfer":0,"description":"Аллюр","price":7200},{"typeTechnique":29,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-07-15 17:32:13.731372+03
2338	2024-07-15	1	3	2	2	t	1	{"dateIncome":"2024-07-15","typeRoute":3,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-15 17:26:24.807912+03
2340	2024-07-16	1	2	18	2	t	1	{"dateIncome":"2024-07-16","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-16 09:54:48.119967+03
2342	2024-07-16	3	3	2	2	t	1	{"dateIncome":"2024-07-16","typeRoute":3,"flightNumber":3,"instructor":2,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-16 12:59:29.92095+03
2343	2024-07-16	4	3	18	2	t	1	{"dateIncome":"2024-07-16","typeRoute":3,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-16 13:01:35.659228+03
2344	2024-07-16	5	1	18	2	t	1	{"dateIncome":"2024-07-16","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-16 15:07:12.882666+03
2349	2024-07-17	1	2	20	2	t	1	{"dateIncome":"2024-07-17","typeRoute":2,"flightNumber":1,"instructor":20,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":18,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":19,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":21,"discount":5000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-17 14:42:01.44816+03
2345	2024-07-16	6	3	20	2	t	1	{"dateIncome":"2024-07-16","typeRoute":3,"flightNumber":6,"instructor":20,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-16 16:53:43.527252+03
2350	2024-07-17	2	2	18	2	t	1	{"dateIncome":"2024-07-17","typeRoute":2,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":21,"discount":5000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":24,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":27,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-17 14:43:49.012318+03
2346	2024-07-16	7	3	2	2	t	1	{"dateIncome":"2024-07-16","typeRoute":3,"flightNumber":7,"instructor":2,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-16 16:55:19.555628+03
2347	2024-07-16	8	1	3	2	t	1	{"dateIncome":"2024-07-16","typeRoute":1,"flightNumber":8,"instructor":3,"techniques":[{"typeTechnique":28,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"Ски резорт","price":7000}]}	2024-07-16 17:04:09.323031+03
2348	2024-07-16	9	4	20	2	t	1	{"dateIncome":"2024-07-16","typeRoute":4,"flightNumber":9,"instructor":20,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-16 17:04:58.309487+03
2355	2024-07-20	2	2	18	2	t	1	{"dateIncome":"2024-07-20","typeRoute":2,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":29,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-20 14:35:56.020823+03
2352	2024-07-17	3	1	10	2	t	1	{"dateIncome":"2024-07-17","typeRoute":1,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Все назар","price":9000},{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"Комиссия Динисламу","price":9000},{"typeTechnique":18,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":20,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":25,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":26,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":28,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-07-17 15:05:49.455305+03
2353	2024-07-19	1	4	7	2	t	1	{"dateIncome":"2024-07-19","typeRoute":4,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-19 16:58:53.4553+03
2356	2024-07-20	3	1	7	2	t	1	{"dateIncome":"2024-07-20","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":19,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-07-20 14:36:35.048501+03
2357	2024-07-20	4	4	7	2	t	1	{"dateIncome":"2024-07-20","typeRoute":4,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":23,"discount":1000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-20 14:37:17.419145+03
2358	2024-07-20	5	3	20	2	t	1	{"dateIncome":"2024-07-20","typeRoute":3,"flightNumber":5,"instructor":20,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-20 14:37:59.877193+03
2354	2024-07-20	1	2	18	2	t	1	{"dateIncome":"2024-07-20","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"Аллюр","price":10000}]}	2024-07-20 14:34:07.675011+03
2374	2024-07-22	6	4	7	2	t	1	{"dateIncome":"2024-07-22","typeRoute":4,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-07-22 17:33:24.105962+03
2479	2024-08-10	11	4	2	2	t	1	{"dateIncome":"2024-08-10","typeRoute":4,"flightNumber":11,"instructor":2,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-10 16:13:33.597689+03
2359	2024-07-20	6	1	7	2	t	1	{"dateIncome":"2024-07-20","typeRoute":1,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":26,"discount":4000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-20 15:04:36.801074+03
2360	2024-07-20	7	4	20	2	t	1	{"dateIncome":"2024-07-20","typeRoute":4,"flightNumber":7,"instructor":20,"techniques":[{"typeTechnique":31,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-20 15:12:08.411365+03
2371	2024-07-22	3	4	18	2	t	1	{"dateIncome":"2024-07-22","typeRoute":4,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-22 15:03:16.874905+03
2366	2024-07-21	1	2	18	2	t	1	{"dateIncome":"2024-07-21","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":28,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-21 10:32:38.090312+03
2361	2024-07-20	8	4	18	2	t	1	{"dateIncome":"2024-07-20","typeRoute":4,"flightNumber":8,"instructor":18,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-20 16:18:52.171495+03
2362	2024-07-20	9	3	20	2	t	1	{"dateIncome":"2024-07-20","typeRoute":3,"flightNumber":9,"instructor":20,"techniques":[{"typeTechnique":27,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-20 16:19:21.789338+03
2367	2024-07-21	2	3	7	2	t	1	{"dateIncome":"2024-07-21","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-21 12:03:58.235541+03
2363	2024-07-20	10	4	18	2	t	1	{"dateIncome":"2024-07-20","typeRoute":4,"flightNumber":10,"instructor":18,"techniques":[{"typeTechnique":21,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":26,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":32,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-20 17:56:11.698185+03
2364	2024-07-20	11	3	18	2	t	1	{"dateIncome":"2024-07-20","typeRoute":3,"flightNumber":11,"instructor":18,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-20 17:58:03.375033+03
2369	2024-07-22	1	2	7	2	t	1	{"dateIncome":"2024-07-22","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":9,"discount":7000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":7000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-22 14:02:46.828932+03
2368	2024-07-21	3	1	7	2	t	1	{"dateIncome":"2024-07-21","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Комиссия исламу","price":9000},{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-07-21 14:26:31.141408+03
2370	2024-07-22	2	1	18	2	t	1	{"dateIncome":"2024-07-22","typeRoute":1,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":19,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":27,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":32,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-07-22 14:58:52.691838+03
2401	2024-07-28	3	2	18	2	t	1	{"dateIncome":"2024-07-28","typeRoute":2,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-28 14:14:03.095967+03
2372	2024-07-22	4	2	7	2	t	1	{"dateIncome":"2024-07-22","typeRoute":2,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-22 17:22:26.627354+03
2373	2024-07-22	5	3	18	2	t	1	{"dateIncome":"2024-07-22","typeRoute":3,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":9,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":26,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":2000}]}	2024-07-22 17:25:54.967695+03
2383	2024-07-24	5	2	7	2	t	1	{"dateIncome":"2024-07-24","typeRoute":2,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":18,"discount":3000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":28,"discount":3000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":32,"discount":3000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-24 14:38:21.995258+03
2375	2024-07-23	1	1	18	2	t	1	{"dateIncome":"2024-07-23","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":19,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-23 10:28:27.700755+03
2376	2024-07-23	2	3	7	2	t	1	{"dateIncome":"2024-07-23","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":8,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-23 10:30:44.25454+03
2380	2024-07-24	2	3	2	2	t	1	{"dateIncome":"2024-07-24","typeRoute":3,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-24 11:23:32.739943+03
2377	2024-07-23	3	4	7	2	t	1	{"dateIncome":"2024-07-23","typeRoute":4,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":27,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-23 11:54:17.120504+03
2378	2024-07-23	4	3	7	2	t	1	{"dateIncome":"2024-07-23","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-23 14:57:16.644791+03
2379	2024-07-24	1	2	18	2	t	1	{"dateIncome":"2024-07-24","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-24 10:32:51.637761+03
2381	2024-07-24	3	1	18	2	t	1	{"dateIncome":"2024-07-24","typeRoute":1,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-07-24 13:34:38.911006+03
2385	2024-07-25	2	3	7	2	t	1	{"dateIncome":"2024-07-25","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-25 12:55:47.433957+03
2382	2024-07-24	4	2	7	2	t	1	{"dateIncome":"2024-07-24","typeRoute":2,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"700 из них наличка ","price":12000},{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-24 14:26:28.310398+03
2384	2024-07-25	1	1	18	2	t	1	{"dateIncome":"2024-07-25","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":18,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":20,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":23,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-07-25 10:21:04.457694+03
2386	2024-07-25	3	1	7	2	t	1	{"dateIncome":"2024-07-25","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":32,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":23,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":28,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-07-25 17:39:27.823194+03
2434	2024-08-04	5	4	18	2	t	1	{"dateIncome":"2024-08-04","typeRoute":4,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":31,"discount":1000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-04 13:45:20.011227+03
2480	2024-08-10	12	3	3	2	t	1	{"dateIncome":"2024-08-10","typeRoute":3,"flightNumber":12,"instructor":3,"techniques":[{"typeTechnique":22,"discount":600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":2400},{"typeTechnique":32,"discount":600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":2400}]}	2024-08-10 16:14:59.038627+03
2387	2024-07-25	1	1	18	2	t	1	{"dateIncome":"2024-07-25","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-07-25 17:50:43.930363+03
2393	2024-07-27	2	3	20	2	t	1	{"dateIncome":"2024-07-27","typeRoute":3,"flightNumber":2,"instructor":20,"techniques":[{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-27 10:59:26.370695+03
2390	2024-07-26	3	1	18	2	t	1	{"dateIncome":"2024-07-26","typeRoute":1,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":30,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-07-26 15:39:55.289638+03
2388	2024-07-26	1	1	18	2	t	1	{"dateIncome":"2024-07-26","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-26 10:29:13.839659+03
2389	2024-07-26	2	2	7	2	t	1	{"dateIncome":"2024-07-26","typeRoute":2,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"По счету все кроме вездехода","price":10000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-26 10:38:29.017782+03
2391	2024-07-26	4	3	7	2	t	1	{"dateIncome":"2024-07-26","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-26 17:03:25.88056+03
2392	2024-07-27	1	2	18	2	t	1	{"dateIncome":"2024-07-27","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-27 10:33:20.535021+03
2396	2024-07-27	4	3	7	2	t	1	{"dateIncome":"2024-07-27","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-27 14:18:34.329525+03
2395	2024-07-27	3	2	7	2	t	1	{"dateIncome":"2024-07-27","typeRoute":2,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":20,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-27 13:15:45.476876+03
2399	2024-07-28	1	3	2	2	t	1	{"dateIncome":"2024-07-28","typeRoute":3,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-28 11:55:37.029798+03
2397	2024-07-27	5	2	7	2	t	1	{"dateIncome":"2024-07-27","typeRoute":2,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-27 15:11:34.855979+03
2398	2024-07-27	6	3	18	2	t	1	{"dateIncome":"2024-07-27","typeRoute":3,"flightNumber":6,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-27 17:50:13.655796+03
2400	2024-07-28	2	1	7	2	t	1	{"dateIncome":"2024-07-28","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-07-28 14:03:14.941615+03
2402	2024-07-28	4	1	18	2	t	1	{"dateIncome":"2024-07-28","typeRoute":1,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":20,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-07-28 14:20:17.207712+03
2404	2024-07-28	5	2	20	2	t	1	{"dateIncome":"2024-07-28","typeRoute":2,"flightNumber":5,"instructor":20,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":28,"discount":8000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Поехали за 12","price":2000},{"typeTechnique":32,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":32,"discount":8000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Поехали за 12","price":2000}]}	2024-07-28 14:59:06.161985+03
2405	2024-07-28	6	1	7	2	t	1	{"dateIncome":"2024-07-28","typeRoute":1,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":53,"discount":8000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000}]}	2024-07-28 17:36:53.026731+03
2409	2024-07-29	3	4	7	2	t	1	{"dateIncome":"2024-07-29","typeRoute":4,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":27,"discount":2500,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"От Артура ","price":2500},{"typeTechnique":32,"discount":2500,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":2500},{"typeTechnique":12,"discount":3000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-29 16:51:32.088139+03
2406	2024-07-28	7	1	20	2	t	1	{"dateIncome":"2024-07-28","typeRoute":1,"flightNumber":7,"instructor":20,"techniques":[{"typeTechnique":26,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-07-28 17:50:39.628068+03
2407	2024-07-29	1	2	3	2	t	1	{"dateIncome":"2024-07-29","typeRoute":2,"flightNumber":1,"instructor":3,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-29 12:44:42.77735+03
2408	2024-07-29	2	2	7	2	t	1	{"dateIncome":"2024-07-29","typeRoute":2,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"От ски резорт","price":12000}]}	2024-07-29 14:20:30.73716+03
2410	2024-07-29	4	4	7	2	t	1	{"dateIncome":"2024-07-29","typeRoute":4,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-29 17:32:29.013207+03
2412	2024-07-31	1	2	7	2	t	1	{"dateIncome":"2024-07-31","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-07-31 10:18:11.348459+03
2411	2024-07-29	5	1	18	2	t	1	{"dateIncome":"2024-07-29","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":9,"discount":5000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":23,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":18,"discount":4000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-07-29 17:56:08.687133+03
2413	2024-07-31	2	4	18	2	t	1	{"dateIncome":"2024-07-31","typeRoute":4,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-07-31 13:30:48.618173+03
2414	2024-07-31	3	1	18	2	t	1	{"dateIncome":"2024-07-31","typeRoute":1,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":23,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":12,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-07-31 14:07:09.314521+03
2415	2024-07-31	4	3	7	2	t	1	{"dateIncome":"2024-07-31","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-31 17:33:44.945442+03
2418	2024-07-31	6	4	18	2	t	1	{"dateIncome":"2024-07-31","typeRoute":4,"flightNumber":6,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-07-31 17:59:33.674367+03
2481	2024-08-10	13	3	3	2	t	1	{"dateIncome":"2024-08-10","typeRoute":3,"flightNumber":13,"instructor":3,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-10 16:16:57.272938+03
2650	2024-09-01	3	3	7	2	t	1	{"dateIncome":"2024-09-01","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-09-01 13:36:39.10773+03
2417	2024-07-31	5	3	7	2	t	1	{"dateIncome":"2024-07-31","typeRoute":3,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-07-31 17:59:13.879946+03
2419	2024-08-01	1	3	2	2	t	1	{"dateIncome":"2024-08-01","typeRoute":3,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":16,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-01 13:46:15.504602+03
2429	2024-08-03	5	2	18	2	t	1	{"dateIncome":"2024-08-03","typeRoute":2,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-08-03 14:32:56.614722+03
2420	2024-08-01	2	4	2	2	t	1	{"dateIncome":"2024-08-01","typeRoute":4,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-01 15:01:55.487235+03
2424	2024-08-03	1	1	18	2	t	1	{"dateIncome":"2024-08-03","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-03 10:11:53.089196+03
2421	2024-08-01	3	2	7	2	t	1	{"dateIncome":"2024-08-01","typeRoute":2,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":31,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-01 17:38:34.170668+03
2422	2024-08-01	4	1	18	2	t	1	{"dateIncome":"2024-08-01","typeRoute":1,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-08-01 17:44:51.662359+03
2423	2024-08-01	5	4	18	2	t	1	{"dateIncome":"2024-08-01","typeRoute":4,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-01 17:46:41.897013+03
2425	2024-08-03	2	2	7	2	t	1	{"dateIncome":"2024-08-03","typeRoute":2,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":23,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":25,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-03 10:19:41.592147+03
2426	2024-08-03	3	1	18	2	t	1	{"dateIncome":"2024-08-03","typeRoute":1,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":31,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":23,"discount":1600,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"С Аллюра ","price":6400}]}	2024-08-03 14:23:14.429668+03
2428	2024-08-03	4	1	18	2	t	1	{"dateIncome":"2024-08-03","typeRoute":1,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-03 14:30:25.275869+03
2431	2024-08-04	2	1	7	2	t	1	{"dateIncome":"2024-08-04","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-04 10:11:28.208358+03
2430	2024-08-04	1	3	18	2	t	1	{"dateIncome":"2024-08-04","typeRoute":3,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":20,"discount":1550,"prepayment":true,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":450}]}	2024-08-04 09:57:44.909736+03
2432	2024-08-04	3	4	3	2	t	1	{"dateIncome":"2024-08-04","typeRoute":4,"flightNumber":3,"instructor":3,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-04 12:12:38.632864+03
2433	2024-08-04	4	3	18	2	t	1	{"dateIncome":"2024-08-04","typeRoute":3,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-04 13:11:31.824593+03
2440	2024-08-05	3	1	7	2	t	1	{"dateIncome":"2024-08-05","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-05 15:19:05.179642+03
2435	2024-08-04	6	2	10	2	t	1	{"dateIncome":"2024-08-04","typeRoute":2,"flightNumber":6,"instructor":10,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат ","price":9000},{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-04 14:07:43.26824+03
2436	2024-08-04	7	4	18	2	t	1	{"dateIncome":"2024-08-04","typeRoute":4,"flightNumber":7,"instructor":18,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-04 15:06:21.728061+03
2442	2024-08-06	1	1	18	2	t	1	{"dateIncome":"2024-08-06","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Индивидуальный за 15к","price":9000},{"typeTechnique":11,"discount":5000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-06 10:02:25.144123+03
2437	2024-08-04	8	3	18	2	t	1	{"dateIncome":"2024-08-04","typeRoute":3,"flightNumber":8,"instructor":18,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-04 17:05:32.620839+03
2441	2024-08-05	4	3	7	2	t	1	{"dateIncome":"2024-08-05","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-05 17:56:34.961155+03
2438	2024-08-05	1	4	18	2	t	1	{"dateIncome":"2024-08-05","typeRoute":4,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-05 09:59:28.076794+03
2443	2024-08-06	2	1	10	2	t	1	{"dateIncome":"2024-08-06","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-06 10:04:40.759952+03
2439	2024-08-05	2	2	18	2	t	1	{"dateIncome":"2024-08-05","typeRoute":2,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":23,"discount":5000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"От Самата","price":5000}]}	2024-08-05 15:14:31.954373+03
2446	2024-08-06	5	1	7	2	t	1	{"dateIncome":"2024-08-06","typeRoute":1,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"На дуккинские смотровые","price":8000}]}	2024-08-06 16:40:03.717169+03
2444	2024-08-06	3	3	7	2	t	1	{"dateIncome":"2024-08-06","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-06 11:05:27.610775+03
2445	2024-08-06	4	2	7	2	t	1	{"dateIncome":"2024-08-06","typeRoute":2,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":21,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":3,"hotel":0,"transfer":0,"description":"Откат исламу","price":9000}]}	2024-08-06 12:13:03.60781+03
2448	2024-08-06	7	3	10	2	t	1	{"dateIncome":"2024-08-06","typeRoute":3,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":3000}]}	2024-08-06 17:48:29.917766+03
2447	2024-08-06	6	3	18	2	t	1	{"dateIncome":"2024-08-06","typeRoute":3,"flightNumber":6,"instructor":18,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-06 17:28:39.287169+03
2449	2024-08-08	1	1	10	2	t	1	{"dateIncome":"2024-08-08","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":7000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":20,"discount":800,"prepayment":false,"typePayment":1,"clientSource":3,"hotel":0,"transfer":0,"description":"Откат исламу ","price":7200},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":3,"hotel":0,"transfer":0,"description":"От премиум вилладж ","price":8000}]}	2024-08-08 10:27:48.895748+03
2450	2024-08-08	2	4	2	2	t	1	{"dateIncome":"2024-08-08","typeRoute":4,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":22,"discount":1000,"prepayment":false,"typePayment":3,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":27,"discount":1000,"prepayment":false,"typePayment":3,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-08 12:51:40.783536+03
2451	2024-08-08	3	3	18	2	t	1	{"dateIncome":"2024-08-08","typeRoute":3,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":27,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-08 12:58:18.197382+03
2452	2024-08-08	4	4	2	2	t	1	{"dateIncome":"2024-08-08","typeRoute":4,"flightNumber":4,"instructor":2,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":3,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-08 14:07:17.821929+03
2455	2024-08-08	7	1	2	2	t	1	{"dateIncome":"2024-08-08","typeRoute":1,"flightNumber":7,"instructor":2,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-08 17:25:12.153746+03
2453	2024-08-08	5	2	18	2	t	1	{"dateIncome":"2024-08-08","typeRoute":2,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-08 14:12:48.199948+03
2454	2024-08-08	6	1	10	2	t	1	{"dateIncome":"2024-08-08","typeRoute":1,"flightNumber":6,"instructor":10,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-08-08 14:20:18.365497+03
2456	2024-08-08	8	1	10	2	t	1	{"dateIncome":"2024-08-08","typeRoute":1,"flightNumber":8,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":9000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-08-08 17:30:01.455618+03
2457	2024-08-08	9	4	3	2	t	1	{"dateIncome":"2024-08-08","typeRoute":4,"flightNumber":9,"instructor":3,"techniques":[{"typeTechnique":31,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":32,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":28,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-08 17:31:51.937198+03
2461	2024-08-09	1	2	10	2	t	1	{"dateIncome":"2024-08-09","typeRoute":2,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":11000}]}	2024-08-09 10:08:31.975569+03
2458	2024-08-08	10	4	18	2	t	1	{"dateIncome":"2024-08-08","typeRoute":4,"flightNumber":10,"instructor":18,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-08 17:46:27.609488+03
2459	2024-08-08	11	2	10	2	t	1	{"dateIncome":"2024-08-08","typeRoute":2,"flightNumber":11,"instructor":10,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"Ренат","price":10000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-08-08 17:51:02.011009+03
2460	2024-08-08	12	3	10	2	t	1	{"dateIncome":"2024-08-08","typeRoute":3,"flightNumber":12,"instructor":10,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат ","price":3000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-08 17:52:36.427156+03
2477	2024-08-10	9	3	3	2	t	1	{"dateIncome":"2024-08-10","typeRoute":3,"flightNumber":9,"instructor":3,"techniques":[{"typeTechnique":19,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-10 15:24:23.468919+03
2482	2024-08-11	1	2	18	2	t	1	{"dateIncome":"2024-08-11","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":12000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-08-11 15:28:06.803152+03
2484	2024-08-11	3	3	7	2	t	1	{"dateIncome":"2024-08-11","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-11 16:04:52.265546+03
2483	2024-08-11	2	3	7	2	t	1	{"dateIncome":"2024-08-11","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-11 16:02:33.864036+03
2589	2024-08-25	9	3	2	2	t	1	{"dateIncome":"2024-08-25","typeRoute":3,"flightNumber":9,"instructor":2,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-25 13:17:02.997403+03
2466	2024-08-09	6	1	7	2	t	1	{"dateIncome":"2024-08-09","typeRoute":1,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":28,"discount":0,"prepayment":true,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-08-09 17:26:57.053607+03
2462	2024-08-09	2	1	18	2	t	1	{"dateIncome":"2024-08-09","typeRoute":1,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":23,"discount":400,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7600},{"typeTechnique":20,"discount":400,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7600},{"typeTechnique":22,"discount":400,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7600},{"typeTechnique":26,"discount":400,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7600},{"typeTechnique":27,"discount":400,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7600},{"typeTechnique":28,"discount":400,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7600},{"typeTechnique":32,"discount":400,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7600}]}	2024-08-09 12:54:03.298903+03
2463	2024-08-09	3	3	7	2	t	1	{"dateIncome":"2024-08-09","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-09 12:54:48.311201+03
2464	2024-08-09	4	2	10	2	t	1	{"dateIncome":"2024-08-09","typeRoute":2,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":12000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-08-09 13:30:47.151171+03
2469	2024-08-10	1	4	10	2	t	1	{"dateIncome":"2024-08-10","typeRoute":4,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-10 12:09:24.704006+03
2470	2024-08-10	2	3	10	2	t	1	{"dateIncome":"2024-08-10","typeRoute":3,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-10 12:12:03.580054+03
2465	2024-08-09	5	4	18	2	t	1	{"dateIncome":"2024-08-09","typeRoute":4,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-09 17:18:59.894073+03
2467	2024-08-09	7	4	10	2	t	1	{"dateIncome":"2024-08-09","typeRoute":4,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-09 17:48:57.925782+03
2468	2024-08-09	8	4	10	2	t	1	{"dateIncome":"2024-08-09","typeRoute":4,"flightNumber":8,"instructor":10,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-09 17:56:14.372725+03
2472	2024-08-10	4	3	2	2	t	1	{"dateIncome":"2024-08-10","typeRoute":3,"flightNumber":4,"instructor":2,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-10 13:07:05.554419+03
2474	2024-08-10	6	2	18	2	t	1	{"dateIncome":"2024-08-10","typeRoute":2,"flightNumber":6,"instructor":18,"techniques":[{"typeTechnique":27,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-08-10 13:58:40.693886+03
2476	2024-08-10	8	2	18	2	t	1	{"dateIncome":"2024-08-10","typeRoute":2,"flightNumber":8,"instructor":18,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":27,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-08-10 14:03:52.862547+03
2471	2024-08-10	3	4	10	2	t	1	{"dateIncome":"2024-08-10","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат ","price":5000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-10 13:05:42.74376+03
2475	2024-08-10	7	1	7	2	t	1	{"dateIncome":"2024-08-10","typeRoute":1,"flightNumber":7,"instructor":7,"techniques":[{"typeTechnique":10,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":31,"discount":4000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"С инструктором ","price":4000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-08-10 14:01:31.941672+03
2473	2024-08-10	5	3	2	2	t	1	{"dateIncome":"2024-08-10","typeRoute":3,"flightNumber":5,"instructor":2,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-10 13:55:02.342888+03
2590	2024-08-25	10	3	7	2	t	1	{"dateIncome":"2024-08-25","typeRoute":3,"flightNumber":10,"instructor":7,"techniques":[{"typeTechnique":18,"discount":1500,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":1500},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-25 13:25:42.828612+03
2478	2024-08-10	10	4	7	2	t	1	{"dateIncome":"2024-08-10","typeRoute":4,"flightNumber":10,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-10 16:03:48.520954+03
2492	2024-08-12	6	4	18	2	t	1	{"dateIncome":"2024-08-12","typeRoute":4,"flightNumber":6,"instructor":18,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":1000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"С инструктором ","price":5000}]}	2024-08-12 16:08:59.717048+03
2485	2024-08-11	4	2	18	2	t	1	{"dateIncome":"2024-08-11","typeRoute":2,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":12000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-11 16:57:25.797149+03
2487	2024-08-12	1	1	7	2	t	1	{"dateIncome":"2024-08-12","typeRoute":1,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-08-12 12:43:14.49995+03
2486	2024-08-11	5	2	7	2	t	1	{"dateIncome":"2024-08-11","typeRoute":2,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":27,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-08-11 17:43:41.592337+03
2488	2024-08-12	2	4	18	2	t	1	{"dateIncome":"2024-08-12","typeRoute":4,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-12 12:44:07.565009+03
2493	2024-08-15	1	1	10	2	t	1	{"dateIncome":"2024-08-15","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-15 10:23:37.855902+03
2491	2024-08-12	5	1	18	2	t	1	{"dateIncome":"2024-08-12","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":27,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"От че горы оба","price":6000},{"typeTechnique":28,"discount":2000,"prepayment":false,"typePayment":2,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-12 16:05:50.794812+03
2489	2024-08-12	3	2	18	2	t	1	{"dateIncome":"2024-08-12","typeRoute":2,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-08-12 15:53:13.106767+03
2490	2024-08-12	4	4	3	2	t	1	{"dateIncome":"2024-08-12","typeRoute":4,"flightNumber":4,"instructor":3,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-12 15:55:35.802156+03
2495	2024-08-15	3	3	2	2	t	1	{"dateIncome":"2024-08-15","typeRoute":3,"flightNumber":3,"instructor":2,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-15 13:19:57.229298+03
2494	2024-08-15	2	2	18	2	t	1	{"dateIncome":"2024-08-15","typeRoute":2,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-15 10:32:57.939174+03
2591	2024-08-25	11	3	10	2	t	1	{"dateIncome":"2024-08-25","typeRoute":3,"flightNumber":11,"instructor":10,"techniques":[{"typeTechnique":20,"discount":1500,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":1500}]}	2024-08-25 13:26:34.380189+03
2596	2024-08-25	16	2	10	2	t	1	{"dateIncome":"2024-08-25","typeRoute":2,"flightNumber":16,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат ","price":11000},{"typeTechnique":32,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"С белых на Софию за 8к","price":8000}]}	2024-08-25 15:15:16.744417+03
2501	2024-08-15	9	3	2	2	t	1	{"dateIncome":"2024-08-15","typeRoute":3,"flightNumber":9,"instructor":2,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-15 17:58:41.466319+03
2496	2024-08-15	4	1	10	2	t	1	{"dateIncome":"2024-08-15","typeRoute":1,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":3,"hotel":0,"transfer":0,"description":"Скидка исламу. От премиум","price":9000},{"typeTechnique":11,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":53,"discount":8000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"На магином","price":2000}]}	2024-08-15 14:22:33.330844+03
2497	2024-08-15	5	1	18	2	t	1	{"dateIncome":"2024-08-15","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":30,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-08-15 14:24:02.061131+03
2498	2024-08-15	6	3	2	2	t	1	{"dateIncome":"2024-08-15","typeRoute":3,"flightNumber":6,"instructor":2,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-15 15:35:00.971531+03
2499	2024-08-15	7	3	2	2	t	1	{"dateIncome":"2024-08-15","typeRoute":3,"flightNumber":7,"instructor":2,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-15 16:38:07.113902+03
2502	2024-08-16	1	2	7	2	t	1	{"dateIncome":"2024-08-16","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-16 10:16:47.996277+03
2500	2024-08-15	8	4	18	2	t	1	{"dateIncome":"2024-08-15","typeRoute":4,"flightNumber":8,"instructor":18,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-15 17:45:09.562036+03
2506	2024-08-16	5	1	10	2	t	1	{"dateIncome":"2024-08-16","typeRoute":1,"flightNumber":5,"instructor":10,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-16 14:10:58.769658+03
2503	2024-08-16	2	1	18	2	t	1	{"dateIncome":"2024-08-16","typeRoute":1,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-08-16 11:01:52.404708+03
2504	2024-08-16	3	4	10	2	t	1	{"dateIncome":"2024-08-16","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат ","price":4000}]}	2024-08-16 12:37:46.155522+03
2509	2024-08-16	8	4	7	2	t	1	{"dateIncome":"2024-08-16","typeRoute":4,"flightNumber":8,"instructor":7,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-16 16:25:12.328163+03
2505	2024-08-16	4	3	7	2	t	1	{"dateIncome":"2024-08-16","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-16 13:48:19.90084+03
2507	2024-08-16	6	2	18	2	t	1	{"dateIncome":"2024-08-16","typeRoute":2,"flightNumber":6,"instructor":18,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-08-16 14:23:01.397482+03
2508	2024-08-16	7	1	10	2	t	1	{"dateIncome":"2024-08-16","typeRoute":1,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-16 14:40:14.703755+03
2510	2024-08-16	9	4	7	2	t	1	{"dateIncome":"2024-08-16","typeRoute":4,"flightNumber":9,"instructor":7,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-16 16:28:23.575625+03
2512	2024-08-16	11	4	7	2	t	1	{"dateIncome":"2024-08-16","typeRoute":4,"flightNumber":11,"instructor":7,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-16 17:09:33.969013+03
2511	2024-08-16	10	4	7	2	t	1	{"dateIncome":"2024-08-16","typeRoute":4,"flightNumber":10,"instructor":7,"techniques":[{"typeTechnique":28,"discount":1000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-16 17:02:36.376258+03
2593	2024-08-25	13	1	18	2	t	1	{"dateIncome":"2024-08-25","typeRoute":1,"flightNumber":13,"instructor":18,"techniques":[{"typeTechnique":20,"discount":4000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"С курорта","price":4000}]}	2024-08-25 14:09:59.482276+03
2592	2024-08-25	12	2	18	2	t	1	{"dateIncome":"2024-08-25","typeRoute":2,"flightNumber":12,"instructor":18,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":33,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-25 14:08:12.129556+03
2517	2024-08-17	3	2	18	2	t	1	{"dateIncome":"2024-08-17","typeRoute":2,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-08-17 12:19:56.253225+03
2513	2024-08-16	12	3	18	2	t	1	{"dateIncome":"2024-08-16","typeRoute":3,"flightNumber":12,"instructor":18,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-16 17:32:13.877978+03
2514	2024-08-16	13	3	18	2	t	1	{"dateIncome":"2024-08-16","typeRoute":3,"flightNumber":13,"instructor":18,"techniques":[{"typeTechnique":25,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":33,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":2000}]}	2024-08-16 17:39:29.598375+03
2515	2024-08-17	1	1	7	2	t	1	{"dateIncome":"2024-08-17","typeRoute":1,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":33,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":28,"discount":4000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-17 10:12:13.428308+03
2516	2024-08-17	2	3	18	2	t	1	{"dateIncome":"2024-08-17","typeRoute":3,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":23,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":1000}]}	2024-08-17 11:07:38.701746+03
2518	2024-08-17	4	3	10	2	t	1	{"dateIncome":"2024-08-17","typeRoute":3,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-17 13:24:29.710106+03
2520	2024-08-17	6	1	7	2	t	1	{"dateIncome":"2024-08-17","typeRoute":1,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":33,"discount":5000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"Делю чтобы было поровну ","price":3000}]}	2024-08-17 17:24:17.312014+03
2519	2024-08-17	5	1	7	2	t	1	{"dateIncome":"2024-08-17","typeRoute":1,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-17 14:11:51.421441+03
2523	2024-08-17	9	4	10	2	t	1	{"dateIncome":"2024-08-17","typeRoute":4,"flightNumber":9,"instructor":10,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-17 17:53:13.201695+03
2521	2024-08-17	7	1	10	2	t	1	{"dateIncome":"2024-08-17","typeRoute":1,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":33,"discount":3000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"Делю чтобы было ровно ","price":5000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":32,"discount":4000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"Знакомые от Ахмата","price":4000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-08-17 17:33:43.745272+03
2582	2024-08-25	2	1	18	2	t	1	{"dateIncome":"2024-08-25","typeRoute":1,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":10,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-25 10:22:07.968656+03
2522	2024-08-17	8	4	10	2	t	1	{"dateIncome":"2024-08-17","typeRoute":4,"flightNumber":8,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":28,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-17 17:52:00.08273+03
2525	2024-08-18	2	3	7	2	t	1	{"dateIncome":"2024-08-18","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":28,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"За отзывы","price":2000}]}	2024-08-18 11:39:56.057224+03
2524	2024-08-18	1	4	7	2	t	1	{"dateIncome":"2024-08-18","typeRoute":4,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-18 11:38:57.547929+03
2594	2024-08-25	14	4	10	2	t	1	{"dateIncome":"2024-08-25","typeRoute":4,"flightNumber":14,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат ","price":6000}]}	2024-08-25 14:20:23.864934+03
2526	2024-08-18	3	2	18	2	t	1	{"dateIncome":"2024-08-18","typeRoute":2,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":32,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":23,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":3,"hotel":0,"transfer":0,"description":"От ислама премиум вилладж","price":9000},{"typeTechnique":33,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-18 11:49:19.522516+03
2527	2024-08-18	4	1	10	2	t	1	{"dateIncome":"2024-08-18","typeRoute":1,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":9000},{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-18 11:52:52.04744+03
2528	2024-08-18	5	3	7	2	t	1	{"dateIncome":"2024-08-18","typeRoute":3,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-18 12:19:55.097334+03
2532	2024-08-18	9	1	18	2	t	1	{"dateIncome":"2024-08-18","typeRoute":1,"flightNumber":9,"instructor":18,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-18 14:43:03.112139+03
2529	2024-08-18	6	3	7	2	t	1	{"dateIncome":"2024-08-18","typeRoute":3,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-18 13:50:54.605107+03
2537	2024-08-19	2	4	7	2	t	1	{"dateIncome":"2024-08-19","typeRoute":4,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":12,"discount":1200,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":4800}]}	2024-08-19 17:30:58.611702+03
2530	2024-08-18	7	1	7	2	t	1	{"dateIncome":"2024-08-18","typeRoute":1,"flightNumber":7,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-18 14:14:53.082181+03
2531	2024-08-18	8	4	10	2	t	1	{"dateIncome":"2024-08-18","typeRoute":4,"flightNumber":8,"instructor":10,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-18 14:22:54.417316+03
2533	2024-08-18	10	3	18	2	t	1	{"dateIncome":"2024-08-18","typeRoute":3,"flightNumber":10,"instructor":18,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-18 16:34:42.999612+03
2539	2024-08-19	4	1	2	2	t	1	{"dateIncome":"2024-08-19","typeRoute":1,"flightNumber":4,"instructor":2,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-08-19 17:56:03.003447+03
2534	2024-08-18	11	1	18	2	t	1	{"dateIncome":"2024-08-18","typeRoute":1,"flightNumber":11,"instructor":18,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-18 17:16:57.701832+03
2535	2024-08-18	12	3	10	2	t	1	{"dateIncome":"2024-08-18","typeRoute":3,"flightNumber":12,"instructor":10,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":3000}]}	2024-08-18 17:19:30.278809+03
2536	2024-08-19	1	4	7	2	t	1	{"dateIncome":"2024-08-19","typeRoute":4,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":32,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":34,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-19 17:28:05.720019+03
2584	2024-08-25	4	3	7	2	t	1	{"dateIncome":"2024-08-25","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-25 11:34:49.150413+03
2587	2024-08-25	7	3	7	2	t	1	{"dateIncome":"2024-08-25","typeRoute":3,"flightNumber":7,"instructor":7,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-25 11:50:26.24182+03
2588	2024-08-25	8	4	10	2	t	1	{"dateIncome":"2024-08-25","typeRoute":4,"flightNumber":8,"instructor":10,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-25 12:23:49.577125+03
2538	2024-08-19	3	1	7	2	t	1	{"dateIncome":"2024-08-19","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":11,"discount":5000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":11,"discount":5000,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":33,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-08-19 17:53:30.109752+03
2546	2024-08-20	7	4	10	2	t	1	{"dateIncome":"2024-08-20","typeRoute":4,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-20 15:35:10.124455+03
2540	2024-08-20	1	1	10	2	t	1	{"dateIncome":"2024-08-20","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"Ренат","price":8000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-20 10:05:19.487477+03
2541	2024-08-20	2	2	7	2	t	1	{"dateIncome":"2024-08-20","typeRoute":2,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-20 10:07:03.197514+03
2544	2024-08-20	5	3	10	2	t	1	{"dateIncome":"2024-08-20","typeRoute":3,"flightNumber":5,"instructor":10,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-20 13:42:29.946344+03
2542	2024-08-20	3	3	3	2	t	1	{"dateIncome":"2024-08-20","typeRoute":3,"flightNumber":3,"instructor":3,"techniques":[{"typeTechnique":16,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-20 12:53:27.416029+03
2543	2024-08-20	4	4	7	2	t	1	{"dateIncome":"2024-08-20","typeRoute":4,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-20 13:27:00.364037+03
2547	2024-08-20	8	2	7	2	t	1	{"dateIncome":"2024-08-20","typeRoute":2,"flightNumber":8,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":12000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-08-20 15:38:54.193814+03
2545	2024-08-20	6	4	10	2	t	1	{"dateIncome":"2024-08-20","typeRoute":4,"flightNumber":6,"instructor":10,"techniques":[{"typeTechnique":31,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-20 15:23:00.671803+03
2548	2024-08-20	9	1	18	2	t	1	{"dateIncome":"2024-08-20","typeRoute":1,"flightNumber":9,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":25,"discount":3000,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":25,"discount":5000,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-20 16:07:05.597239+03
2551	2024-08-20	12	4	2	2	t	1	{"dateIncome":"2024-08-20","typeRoute":4,"flightNumber":12,"instructor":2,"techniques":[{"typeTechnique":32,"discount":1000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-20 17:13:43.325196+03
2549	2024-08-20	10	3	10	2	t	1	{"dateIncome":"2024-08-20","typeRoute":3,"flightNumber":10,"instructor":10,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":4000}]}	2024-08-20 16:31:46.610193+03
2550	2024-08-20	11	1	10	2	t	1	{"dateIncome":"2024-08-20","typeRoute":1,"flightNumber":11,"instructor":10,"techniques":[{"typeTechnique":22,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":18,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":20,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-20 17:13:04.476958+03
2552	2024-08-21	1	4	10	2	t	1	{"dateIncome":"2024-08-21","typeRoute":4,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-21 10:16:40.097649+03
2558	2024-08-21	6	3	7	2	t	1	{"dateIncome":"2024-08-21","typeRoute":3,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-21 16:32:48.69488+03
2553	2024-08-21	2	1	7	2	t	1	{"dateIncome":"2024-08-21","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":26,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":32,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-08-21 15:52:09.177346+03
2554	2024-08-21	3	2	18	2	t	1	{"dateIncome":"2024-08-21","typeRoute":2,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":10,"discount":3400,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"Делю на нал и перевод","price":8600},{"typeTechnique":10,"discount":8600,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":3400}]}	2024-08-21 15:56:30.406693+03
2555	2024-08-21	4	1	10	2	t	1	{"dateIncome":"2024-08-21","typeRoute":1,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":8000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":20,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":30,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":32,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-08-21 15:58:26.766571+03
2557	2024-08-21	5	1	18	2	t	1	{"dateIncome":"2024-08-21","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":22,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":33,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":28,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-08-21 16:02:38.87216+03
2559	2024-08-21	7	3	7	2	t	1	{"dateIncome":"2024-08-21","typeRoute":3,"flightNumber":7,"instructor":7,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-21 17:16:27.951461+03
2560	2024-08-21	8	3	7	2	t	1	{"dateIncome":"2024-08-21","typeRoute":3,"flightNumber":8,"instructor":7,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-21 17:56:13.694008+03
2562	2024-08-22	2	3	7	2	t	1	{"dateIncome":"2024-08-22","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-22 14:14:15.969552+03
2561	2024-08-22	1	1	10	2	t	1	{"dateIncome":"2024-08-22","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":2,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":33,"discount":1600,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"От Аллюра ","price":6400}]}	2024-08-22 14:13:29.099364+03
2563	2024-08-22	3	3	18	2	t	1	{"dateIncome":"2024-08-22","typeRoute":3,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-22 14:14:43.635687+03
2565	2024-08-22	5	3	10	2	t	1	{"dateIncome":"2024-08-22","typeRoute":3,"flightNumber":5,"instructor":10,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":4000}]}	2024-08-22 17:00:19.483669+03
2564	2024-08-22	4	3	18	2	t	1	{"dateIncome":"2024-08-22","typeRoute":3,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-22 16:46:18.054752+03
2585	2024-08-25	5	3	7	2	t	1	{"dateIncome":"2024-08-25","typeRoute":3,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-25 11:35:27.056812+03
2586	2024-08-25	6	3	7	2	t	1	{"dateIncome":"2024-08-25","typeRoute":3,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-25 11:42:19.942341+03
2630	2024-08-30	4	4	10	2	t	1	{"dateIncome":"2024-08-30","typeRoute":4,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-30 11:39:25.47199+03
2566	2024-08-22	6	1	7	2	t	1	{"dateIncome":"2024-08-22","typeRoute":1,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":4000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Поделил потому что половина нал","price":5000},{"typeTechnique":12,"discount":6000,"prepayment":false,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-22 17:12:48.051992+03
2567	2024-08-23	1	1	18	2	t	1	{"dateIncome":"2024-08-23","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":22,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-08-23 10:31:29.302828+03
2571	2024-08-24	1	4	10	2	t	1	{"dateIncome":"2024-08-24","typeRoute":4,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":33,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-24 11:16:14.998696+03
2568	2024-08-23	2	4	7	2	t	1	{"dateIncome":"2024-08-23","typeRoute":4,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-23 11:15:36.996518+03
2572	2024-08-24	2	3	10	2	t	1	{"dateIncome":"2024-08-24","typeRoute":3,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат все","price":3000}]}	2024-08-24 11:16:47.317626+03
2569	2024-08-23	3	3	7	2	t	1	{"dateIncome":"2024-08-23","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-23 12:04:26.248207+03
2570	2024-08-23	4	1	7	2	t	1	{"dateIncome":"2024-08-23","typeRoute":1,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":20,"discount":1600,"prepayment":false,"typePayment":2,"clientSource":3,"hotel":0,"transfer":0,"description":"От Аллюра ","price":6400}]}	2024-08-23 15:06:29.139159+03
2575	2024-08-24	5	3	10	2	t	1	{"dateIncome":"2024-08-24","typeRoute":3,"flightNumber":5,"instructor":10,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":23,"discount":600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":2400},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-24 13:58:55.219904+03
2573	2024-08-24	3	4	10	2	t	1	{"dateIncome":"2024-08-24","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":5000}]}	2024-08-24 11:58:03.552256+03
2576	2024-08-24	6	3	7	2	t	1	{"dateIncome":"2024-08-24","typeRoute":3,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-24 14:12:25.877942+03
2574	2024-08-24	4	3	2	2	t	1	{"dateIncome":"2024-08-24","typeRoute":3,"flightNumber":4,"instructor":2,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-24 12:51:29.130783+03
2579	2024-08-24	9	1	18	2	t	1	{"dateIncome":"2024-08-24","typeRoute":1,"flightNumber":9,"instructor":18,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-24 15:48:00.800536+03
2577	2024-08-24	7	1	10	2	t	1	{"dateIncome":"2024-08-24","typeRoute":1,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":10,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"Ренат","price":8000}]}	2024-08-24 15:44:05.716826+03
2578	2024-08-24	8	1	7	2	t	1	{"dateIncome":"2024-08-24","typeRoute":1,"flightNumber":8,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-24 15:47:22.285266+03
2580	2024-08-24	10	4	2	2	t	1	{"dateIncome":"2024-08-24","typeRoute":4,"flightNumber":10,"instructor":2,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-24 17:24:59.136938+03
2581	2024-08-25	1	4	10	2	t	1	{"dateIncome":"2024-08-25","typeRoute":4,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-25 10:13:49.82171+03
2583	2024-08-25	3	4	10	2	t	1	{"dateIncome":"2024-08-25","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-25 11:25:32.182477+03
2595	2024-08-25	15	4	7	2	t	1	{"dateIncome":"2024-08-25","typeRoute":4,"flightNumber":15,"instructor":7,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-25 15:07:40.419395+03
2597	2024-08-26	1	4	7	2	t	1	{"dateIncome":"2024-08-26","typeRoute":4,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-26 10:02:56.157147+03
2605	2024-08-27	2	4	10	2	t	1	{"dateIncome":"2024-08-27","typeRoute":4,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-27 12:54:28.36849+03
2598	2024-08-26	2	3	7	2	t	1	{"dateIncome":"2024-08-26","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-26 10:54:33.827733+03
2599	2024-08-26	3	3	18	2	t	1	{"dateIncome":"2024-08-26","typeRoute":3,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-26 11:26:22.152633+03
2606	2024-08-27	3	3	18	2	t	1	{"dateIncome":"2024-08-27","typeRoute":3,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-27 12:55:27.204428+03
2602	2024-08-26	6	3	2	2	t	1	{"dateIncome":"2024-08-26","typeRoute":3,"flightNumber":6,"instructor":2,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-26 16:48:39.682076+03
2600	2024-08-26	4	1	10	2	t	1	{"dateIncome":"2024-08-26","typeRoute":1,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":12,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"Ренат","price":9000},{"typeTechnique":10,"discount":1000,"prepayment":false,"typePayment":1,"clientSource":4,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-26 15:19:57.913793+03
2601	2024-08-26	5	1	18	2	t	1	{"dateIncome":"2024-08-26","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-08-26 15:23:29.996111+03
2603	2024-08-26	7	4	2	2	t	1	{"dateIncome":"2024-08-26","typeRoute":4,"flightNumber":7,"instructor":2,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-26 16:49:16.070115+03
2604	2024-08-27	1	4	10	2	t	1	{"dateIncome":"2024-08-27","typeRoute":4,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":6000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-27 11:23:55.96311+03
2610	2024-08-27	7	1	10	2	t	1	{"dateIncome":"2024-08-27","typeRoute":1,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-27 15:20:17.591056+03
2607	2024-08-27	4	4	10	2	t	1	{"dateIncome":"2024-08-27","typeRoute":4,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-27 14:00:55.082131+03
2609	2024-08-27	6	3	3	2	t	1	{"dateIncome":"2024-08-27","typeRoute":3,"flightNumber":6,"instructor":3,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-27 15:11:39.280135+03
2608	2024-08-27	5	1	18	2	t	1	{"dateIncome":"2024-08-27","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-27 14:34:01.668135+03
2612	2024-08-27	9	3	3	2	t	1	{"dateIncome":"2024-08-27","typeRoute":3,"flightNumber":9,"instructor":3,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-27 17:27:58.280434+03
2631	2024-08-30	5	3	2	2	t	1	{"dateIncome":"2024-08-30","typeRoute":3,"flightNumber":5,"instructor":2,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-30 12:24:42.525232+03
2611	2024-08-27	8	4	2	2	t	1	{"dateIncome":"2024-08-27","typeRoute":4,"flightNumber":8,"instructor":2,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-27 17:27:08.59881+03
2613	2024-08-27	10	3	3	2	t	1	{"dateIncome":"2024-08-27","typeRoute":3,"flightNumber":10,"instructor":3,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Эльбрус ","price":3000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-27 17:37:59.455113+03
2618	2024-08-28	5	1	18	2	t	1	{"dateIncome":"2024-08-28","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-28 15:09:46.335944+03
2614	2024-08-28	1	3	10	2	t	1	{"dateIncome":"2024-08-28","typeRoute":3,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":4000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-28 12:59:54.117041+03
2615	2024-08-28	2	2	18	2	t	1	{"dateIncome":"2024-08-28","typeRoute":2,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":20,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":30,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":3,"hotel":0,"transfer":0,"description":"От премиум вилладж, от Камилла, ей откат","price":9000}]}	2024-08-28 13:02:16.319142+03
2619	2024-08-28	6	4	7	2	t	1	{"dateIncome":"2024-08-28","typeRoute":4,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-08-28 15:10:33.84963+03
2616	2024-08-28	3	3	7	2	t	1	{"dateIncome":"2024-08-28","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":16,"discount":1500,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":1500}]}	2024-08-28 13:56:26.684617+03
2617	2024-08-28	4	1	10	2	t	1	{"dateIncome":"2024-08-28","typeRoute":1,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":10,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"От сайта, с откатом","price":8000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":20,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"От Аллюра ","price":6400}]}	2024-08-28 14:09:40.650927+03
2621	2024-08-29	1	4	18	2	t	1	{"dateIncome":"2024-08-29","typeRoute":4,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":31,"discount":1000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-29 10:37:33.854599+03
2620	2024-08-28	7	4	18	2	t	1	{"dateIncome":"2024-08-28","typeRoute":4,"flightNumber":7,"instructor":18,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-28 16:56:36.306799+03
2623	2024-08-29	3	1	10	2	t	1	{"dateIncome":"2024-08-29","typeRoute":1,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":9000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-08-29 10:42:53.004988+03
2622	2024-08-29	2	2	7	2	t	1	{"dateIncome":"2024-08-29","typeRoute":2,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":18,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":22,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":23,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":2,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-08-29 10:40:23.870814+03
2625	2024-08-29	5	3	18	2	t	1	{"dateIncome":"2024-08-29","typeRoute":3,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-29 13:02:09.123181+03
2624	2024-08-29	4	3	18	2	t	1	{"dateIncome":"2024-08-29","typeRoute":3,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":2000}]}	2024-08-29 12:47:17.685708+03
2626	2024-08-29	6	1	10	2	t	1	{"dateIncome":"2024-08-29","typeRoute":1,"flightNumber":6,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":9000}]}	2024-08-29 14:07:52.390148+03
2627	2024-08-30	1	1	18	2	t	1	{"dateIncome":"2024-08-30","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":33,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-08-30 10:16:00.856692+03
2629	2024-08-30	3	1	7	2	t	1	{"dateIncome":"2024-08-30","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"Дуккинские ","price":8000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-30 10:47:39.289184+03
2628	2024-08-30	2	4	10	2	t	1	{"dateIncome":"2024-08-30","typeRoute":4,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-30 10:46:06.664351+03
2632	2024-08-30	6	1	10	2	t	1	{"dateIncome":"2024-08-30","typeRoute":1,"flightNumber":6,"instructor":10,"techniques":[{"typeTechnique":20,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"Ренат","price":6400},{"typeTechnique":22,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400}]}	2024-08-30 13:59:09.331017+03
2640	2024-08-31	6	4	18	2	t	1	{"dateIncome":"2024-08-31","typeRoute":4,"flightNumber":6,"instructor":18,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-08-31 15:00:55.224991+03
2633	2024-08-30	7	2	18	2	t	1	{"dateIncome":"2024-08-30","typeRoute":2,"flightNumber":7,"instructor":18,"techniques":[{"typeTechnique":9,"discount":2400,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"С сайта, туда комиссия 2400","price":9600},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-08-30 14:25:25.21916+03
2634	2024-08-30	8	3	7	2	t	1	{"dateIncome":"2024-08-30","typeRoute":3,"flightNumber":8,"instructor":7,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-30 16:36:14.298988+03
2635	2024-08-31	1	2	7	2	t	1	{"dateIncome":"2024-08-31","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-08-31 10:31:13.763916+03
2636	2024-08-31	2	3	10	2	t	1	{"dateIncome":"2024-08-31","typeRoute":3,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":4000}]}	2024-08-31 10:59:20.488036+03
2642	2024-08-31	8	2	7	2	t	1	{"dateIncome":"2024-08-31","typeRoute":2,"flightNumber":8,"instructor":7,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":10,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":28,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":23,"discount":3600,"prepayment":false,"typePayment":3,"clientSource":4,"hotel":0,"transfer":0,"description":"От Аллюра ","price":6400}]}	2024-08-31 15:14:38.708654+03
2637	2024-08-31	3	3	18	2	t	1	{"dateIncome":"2024-08-31","typeRoute":3,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-31 11:57:22.684014+03
2638	2024-08-31	4	3	18	2	t	1	{"dateIncome":"2024-08-31","typeRoute":3,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-31 14:53:24.361017+03
2639	2024-08-31	5	3	18	2	t	1	{"dateIncome":"2024-08-31","typeRoute":3,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-08-31 14:58:26.866032+03
2643	2024-08-31	9	4	10	2	t	1	{"dateIncome":"2024-08-31","typeRoute":4,"flightNumber":9,"instructor":10,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат ","price":5000}]}	2024-08-31 15:34:55.972635+03
2641	2024-08-31	7	1	10	2	t	1	{"dateIncome":"2024-08-31","typeRoute":1,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-08-31 15:04:49.388132+03
2644	2024-08-31	10	3	18	2	t	1	{"dateIncome":"2024-08-31","typeRoute":3,"flightNumber":10,"instructor":18,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-31 15:43:22.32201+03
2646	2024-08-31	12	3	10	2	t	1	{"dateIncome":"2024-08-31","typeRoute":3,"flightNumber":12,"instructor":10,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-31 16:41:28.354489+03
2645	2024-08-31	11	3	18	2	t	1	{"dateIncome":"2024-08-31","typeRoute":3,"flightNumber":11,"instructor":18,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-31 15:59:39.115379+03
2647	2024-08-31	13	3	18	2	t	1	{"dateIncome":"2024-08-31","typeRoute":3,"flightNumber":13,"instructor":18,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-08-31 17:11:39.309435+03
2648	2024-09-01	1	3	18	2	t	1	{"dateIncome":"2024-09-01","typeRoute":3,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-09-01 10:52:58.063933+03
2649	2024-09-01	2	4	18	2	t	1	{"dateIncome":"2024-09-01","typeRoute":4,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-01 13:36:01.213931+03
2662	2024-09-09	2	1	3	2	t	1	{"dateIncome":"2024-09-09","typeRoute":1,"flightNumber":2,"instructor":3,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-09-09 13:35:49.288941+03
2651	2024-09-01	4	1	18	2	t	1	{"dateIncome":"2024-09-01","typeRoute":1,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-09-01 14:34:10.335837+03
2655	2024-09-02	1	2	7	2	t	1	{"dateIncome":"2024-09-02","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-09-02 10:17:44.658213+03
2652	2024-09-01	5	1	10	2	t	1	{"dateIncome":"2024-09-01","typeRoute":1,"flightNumber":5,"instructor":10,"techniques":[{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат всё ","price":8000},{"typeTechnique":22,"discount":1000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":23,"discount":1000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":30,"discount":1000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":32,"discount":1000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":20,"discount":1000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-09-01 14:56:00.157812+03
2653	2024-09-01	6	4	7	2	t	1	{"dateIncome":"2024-09-01","typeRoute":4,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":26,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-01 15:01:42.920858+03
2659	2024-09-03	2	3	2	2	t	1	{"dateIncome":"2024-09-03","typeRoute":3,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-09-03 17:10:23.281072+03
2654	2024-09-01	7	4	7	2	t	1	{"dateIncome":"2024-09-01","typeRoute":4,"flightNumber":7,"instructor":7,"techniques":[{"typeTechnique":11,"discount":3000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"Поделил, 3к нал 3к qr","price":3000},{"typeTechnique":11,"discount":3000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-01 17:44:21.664297+03
2656	2024-09-02	2	4	10	2	t	1	{"dateIncome":"2024-09-02","typeRoute":4,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":4000}]}	2024-09-02 12:05:19.839118+03
2657	2024-09-02	3	4	10	2	t	1	{"dateIncome":"2024-09-02","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат ","price":5000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат ","price":6000}]}	2024-09-02 12:06:17.162785+03
2658	2024-09-03	1	3	2	2	t	1	{"dateIncome":"2024-09-03","typeRoute":3,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-03 14:49:39.516451+03
2660	2024-09-04	1	4	7	2	t	1	{"dateIncome":"2024-09-04","typeRoute":4,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-04 09:30:41.646498+03
2664	2024-09-09	4	3	7	2	t	1	{"dateIncome":"2024-09-09","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-09 16:53:48.060694+03
2661	2024-09-09	1	3	2	2	t	1	{"dateIncome":"2024-09-09","typeRoute":3,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-09 11:49:58.653145+03
2663	2024-09-09	3	3	2	2	t	1	{"dateIncome":"2024-09-09","typeRoute":3,"flightNumber":3,"instructor":2,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-09 14:30:27.303404+03
2665	2024-09-10	1	2	7	2	t	1	{"dateIncome":"2024-09-10","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":22,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"От Аллюра ","price":8000},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-09-10 10:14:56.602637+03
2666	2024-09-10	2	1	10	2	t	1	{"dateIncome":"2024-09-10","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":23,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"От чегоры","price":6000}]}	2024-09-10 12:28:53.798592+03
2667	2024-09-10	3	4	10	2	t	1	{"dateIncome":"2024-09-10","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-10 13:03:57.20848+03
2668	2024-09-10	4	4	2	2	t	1	{"dateIncome":"2024-09-10","typeRoute":4,"flightNumber":4,"instructor":2,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-09-10 14:14:33.878654+03
2669	2024-09-10	5	3	3	2	t	1	{"dateIncome":"2024-09-10","typeRoute":3,"flightNumber":5,"instructor":3,"techniques":[{"typeTechnique":16,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-10 15:23:25.471817+03
2676	2024-09-11	4	1	7	2	t	1	{"dateIncome":"2024-09-11","typeRoute":1,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"С Аллюра ","price":8000},{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-09-11 14:07:36.663109+03
2670	2024-09-10	6	3	10	2	t	1	{"dateIncome":"2024-09-10","typeRoute":3,"flightNumber":6,"instructor":10,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-10 17:32:48.743926+03
2671	2024-09-10	7	4	10	2	t	1	{"dateIncome":"2024-09-10","typeRoute":4,"flightNumber":7,"instructor":10,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-10 17:33:16.481776+03
2672	2024-09-10	8	4	10	2	t	1	{"dateIncome":"2024-09-10","typeRoute":4,"flightNumber":8,"instructor":10,"techniques":[{"typeTechnique":20,"discount":200,"prepayment":false,"typePayment":6,"clientSource":3,"hotel":0,"transfer":0,"description":"С Аллюра ","price":4800},{"typeTechnique":23,"discount":200,"prepayment":false,"typePayment":6,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":4800}]}	2024-09-10 17:44:50.080093+03
2673	2024-09-11	1	4	2	2	t	1	{"dateIncome":"2024-09-11","typeRoute":4,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-09-11 12:29:51.226181+03
2677	2024-09-11	5	3	10	2	t	1	{"dateIncome":"2024-09-11","typeRoute":3,"flightNumber":5,"instructor":10,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":3000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-11 17:22:06.876357+03
2674	2024-09-11	2	2	7	2	t	1	{"dateIncome":"2024-09-11","typeRoute":2,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-09-11 13:27:03.907775+03
2675	2024-09-11	3	1	10	2	t	1	{"dateIncome":"2024-09-11","typeRoute":1,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":23,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-09-11 13:29:16.272201+03
2680	2024-09-12	3	1	7	2	t	1	{"dateIncome":"2024-09-12","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-09-12 14:23:12.812098+03
2679	2024-09-12	2	3	7	2	t	1	{"dateIncome":"2024-09-12","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-12 13:09:18.942848+03
2678	2024-09-12	1	1	10	2	t	1	{"dateIncome":"2024-09-12","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"От Аллюра ","price":8000}]}	2024-09-12 10:16:29.056088+03
2681	2024-09-12	4	4	10	2	t	1	{"dateIncome":"2024-09-12","typeRoute":4,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-12 17:51:44.554674+03
2714	2024-09-23	1	1	10	2	t	1	{"dateIncome":"2024-09-23","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-09-23 12:23:48.804513+03
2710	2024-09-22	3	2	7	2	t	1	{"dateIncome":"2024-09-22","typeRoute":2,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":28,"discount":3600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-09-22 14:18:36.303979+03
2718	2024-09-25	3	3	10	2	t	1	{"dateIncome":"2024-09-25","typeRoute":3,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-25 16:30:45.977238+03
2682	2024-09-13	1	2	7	2	t	1	{"dateIncome":"2024-09-13","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-09-13 11:26:23.80287+03
2684	2024-09-13	3	2	10	2	t	1	{"dateIncome":"2024-09-13","typeRoute":2,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-09-13 11:34:01.965669+03
2683	2024-09-13	2	2	10	2	t	1	{"dateIncome":"2024-09-13","typeRoute":2,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":19,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-09-13 11:27:48.380036+03
2693	2024-09-16	2	4	2	2	t	1	{"dateIncome":"2024-09-16","typeRoute":4,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-09-16 13:49:52.56032+03
2685	2024-09-14	1	1	18	2	t	1	{"dateIncome":"2024-09-14","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":32,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":30,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"О Аллюра ","price":6400},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-09-14 10:15:58.76469+03
2686	2024-09-14	2	3	10	2	t	1	{"dateIncome":"2024-09-14","typeRoute":3,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Рена ","price":4000}]}	2024-09-14 12:12:55.207514+03
2687	2024-09-14	3	4	10	2	t	1	{"dateIncome":"2024-09-14","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":6000},{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-09-14 14:02:48.78675+03
2688	2024-09-14	4	2	18	2	t	1	{"dateIncome":"2024-09-14","typeRoute":2,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-09-14 14:29:30.651403+03
2689	2024-09-14	5	3	10	2	t	1	{"dateIncome":"2024-09-14","typeRoute":3,"flightNumber":5,"instructor":10,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-09-14 14:29:57.734232+03
2715	2024-09-23	2	1	10	2	t	1	{"dateIncome":"2024-09-23","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-09-23 14:07:14.582322+03
2690	2024-09-15	1	1	18	2	t	1	{"dateIncome":"2024-09-15","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-09-15 10:15:41.075652+03
2691	2024-09-15	2	4	18	2	t	1	{"dateIncome":"2024-09-15","typeRoute":4,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-15 15:49:06.375671+03
2694	2024-09-16	3	3	2	2	t	1	{"dateIncome":"2024-09-16","typeRoute":3,"flightNumber":3,"instructor":2,"techniques":[{"typeTechnique":9,"discount":800,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":3200}]}	2024-09-16 13:50:54.562986+03
2711	2024-09-22	4	1	10	2	t	1	{"dateIncome":"2024-09-22","typeRoute":1,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-09-22 14:19:32.361219+03
2716	2024-09-25	1	2	25	2	t	1	{"dateIncome":"2024-09-25","typeRoute":2,"flightNumber":1,"instructor":25,"techniques":[{"typeTechnique":12,"discount":2000,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Сначала на белый ","price":9000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-09-25 14:35:38.596725+03
2712	2024-09-22	5	4	18	2	t	1	{"dateIncome":"2024-09-22","typeRoute":4,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-22 14:33:29.609566+03
2717	2024-09-25	2	1	7	2	t	1	{"dateIncome":"2024-09-25","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-09-25 15:01:04.531191+03
2719	2024-09-26	1	2	7	2	t	1	{"dateIncome":"2024-09-26","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-09-26 10:22:43.968173+03
2720	2024-09-26	2	4	7	2	t	1	{"dateIncome":"2024-09-26","typeRoute":4,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-26 16:15:09.942558+03
2721	2024-09-26	3	2	10	2	t	1	{"dateIncome":"2024-09-26","typeRoute":2,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":33,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"С сайта","price":8000}]}	2024-09-26 17:30:59.885715+03
2692	2024-09-16	1	2	7	2	t	1	{"dateIncome":"2024-09-16","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":19,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-09-16 13:48:37.64301+03
2695	2024-09-16	4	1	18	2	t	1	{"dateIncome":"2024-09-16","typeRoute":1,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":23,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":19,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-09-16 14:17:46.688582+03
2696	2024-09-16	5	1	18	2	t	1	{"dateIncome":"2024-09-16","typeRoute":1,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-09-16 14:19:12.658421+03
2699	2024-09-17	1	1	7	2	t	1	{"dateIncome":"2024-09-17","typeRoute":1,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":19,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":21,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"Аллюр ","price":6400},{"typeTechnique":22,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"","price":6400},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-09-17 10:35:05.394364+03
2697	2024-09-16	6	4	2	2	t	1	{"dateIncome":"2024-09-16","typeRoute":4,"flightNumber":6,"instructor":2,"techniques":[{"typeTechnique":20,"discount":1000,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"Аллюр ","price":4000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-16 16:51:35.339249+03
2700	2024-09-17	2	1	7	2	t	1	{"dateIncome":"2024-09-17","typeRoute":1,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-09-17 10:37:03.150434+03
2698	2024-09-16	7	1	7	2	t	1	{"dateIncome":"2024-09-16","typeRoute":1,"flightNumber":7,"instructor":7,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-09-16 17:34:08.731297+03
2702	2024-09-18	1	4	7	2	t	1	{"dateIncome":"2024-09-18","typeRoute":4,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-18 10:17:12.839259+03
2701	2024-09-17	3	2	7	2	t	1	{"dateIncome":"2024-09-17","typeRoute":2,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":19,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-09-17 14:12:57.838044+03
2704	2024-09-21	1	1	18	2	t	1	{"dateIncome":"2024-09-21","typeRoute":1,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":11,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"От Аллюра ","price":8000},{"typeTechnique":13,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"От Аллюра ","price":8000}]}	2024-09-21 14:44:09.546815+03
2705	2024-09-21	2	4	7	2	t	1	{"dateIncome":"2024-09-21","typeRoute":4,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-21 14:48:05.966464+03
2706	2024-09-21	3	3	7	2	t	1	{"dateIncome":"2024-09-21","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-21 17:08:10.711306+03
2707	2024-09-21	4	4	7	2	t	1	{"dateIncome":"2024-09-21","typeRoute":4,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-21 17:13:46.982917+03
2708	2024-09-22	1	4	18	2	t	1	{"dateIncome":"2024-09-22","typeRoute":4,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-22 12:31:57.919896+03
2709	2024-09-22	2	1	10	2	t	1	{"dateIncome":"2024-09-22","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":22,"discount":1600,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":" С сайта ","price":6400}]}	2024-09-22 13:50:06.995904+03
2713	2024-09-22	6	3	7	2	t	1	{"dateIncome":"2024-09-22","typeRoute":3,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-09-22 16:57:53.577324+03
2722	2024-09-27	1	1	10	2	t	1	{"dateIncome":"2024-09-27","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат ","price":7000},{"typeTechnique":22,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ахмат ст отправил знакомых","price":6000}]}	2024-09-27 14:15:09.747341+03
2723	2024-09-27	2	1	10	2	t	1	{"dateIncome":"2024-09-27","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":22,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"Аллюр. Ренат","price":6400}]}	2024-09-27 15:34:41.841719+03
2728	2024-09-28	4	3	2	2	t	1	{"dateIncome":"2024-09-28","typeRoute":3,"flightNumber":4,"instructor":2,"techniques":[{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-09-28 15:00:14.871015+03
2724	2024-09-27	3	4	10	2	t	1	{"dateIncome":"2024-09-27","typeRoute":4,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":6000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-09-27 16:45:45.206317+03
2730	2024-09-28	6	3	2	2	t	1	{"dateIncome":"2024-09-28","typeRoute":3,"flightNumber":6,"instructor":2,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-28 16:04:12.475007+03
2725	2024-09-28	1	1	2	2	t	1	{"dateIncome":"2024-09-28","typeRoute":1,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":33,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"Аллюр ","price":6400}]}	2024-09-28 12:17:57.846128+03
2726	2024-09-28	2	1	10	2	t	1	{"dateIncome":"2024-09-28","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат ","price":8000}]}	2024-09-28 12:19:09.380921+03
2729	2024-09-28	5	1	10	2	t	1	{"dateIncome":"2024-09-28","typeRoute":1,"flightNumber":5,"instructor":10,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":10000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-09-28 15:21:23.379294+03
2727	2024-09-28	3	4	2	2	t	1	{"dateIncome":"2024-09-28","typeRoute":4,"flightNumber":3,"instructor":2,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-09-28 13:11:01.249477+03
2732	2024-09-28	8	4	2	2	t	1	{"dateIncome":"2024-09-28","typeRoute":4,"flightNumber":8,"instructor":2,"techniques":[{"typeTechnique":32,"discount":1000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-28 17:49:01.664831+03
2735	2024-09-29	1	2	10	2	f	1	{"dateIncome":"2024-09-29","typeRoute":2,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":11000}]}	2024-09-29 15:10:10.258246+03
2731	2024-09-28	7	3	2	2	t	1	{"dateIncome":"2024-09-28","typeRoute":3,"flightNumber":7,"instructor":2,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-09-28 17:47:02.256869+03
2733	2024-09-28	9	3	10	2	t	1	{"dateIncome":"2024-09-28","typeRoute":3,"flightNumber":9,"instructor":10,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":2000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-28 17:58:33.038406+03
2734	2024-09-29	1	2	10	2	t	1	{"dateIncome":"2024-09-29","typeRoute":2,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":11000}]}	2024-09-29 15:10:09.943257+03
2736	2024-09-29	2	3	10	2	t	1	{"dateIncome":"2024-09-29","typeRoute":3,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат ","price":3000}]}	2024-09-29 15:14:37.631686+03
2742	2024-09-30	3	1	10	2	t	1	{"dateIncome":"2024-09-30","typeRoute":1,"flightNumber":3,"instructor":10,"techniques":[{"typeTechnique":33,"discount":1600,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"Аллюр. Ренат","price":6400}]}	2024-09-30 14:05:39.843431+03
2737	2024-09-29	3	3	3	2	t	1	{"dateIncome":"2024-09-29","typeRoute":3,"flightNumber":3,"instructor":3,"techniques":[{"typeTechnique":22,"discount":500,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":2500},{"typeTechnique":25,"discount":500,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":2500},{"typeTechnique":28,"discount":500,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":2500},{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-29 15:18:19.193974+03
2738	2024-09-29	4	4	2	2	t	1	{"dateIncome":"2024-09-29","typeRoute":4,"flightNumber":4,"instructor":2,"techniques":[{"typeTechnique":9,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-09-29 15:22:10.241067+03
2739	2024-09-29	5	3	3	2	t	1	{"dateIncome":"2024-09-29","typeRoute":3,"flightNumber":5,"instructor":3,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-09-29 15:26:52.382338+03
2750	2024-10-05	3	2	18	2	t	1	{"dateIncome":"2024-10-05","typeRoute":2,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-10-05 11:33:06.047368+03
2740	2024-09-30	1	1	10	2	t	1	{"dateIncome":"2024-09-30","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":9000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-09-30 11:40:16.876796+03
2741	2024-09-30	2	3	2	2	t	1	{"dateIncome":"2024-09-30","typeRoute":3,"flightNumber":2,"instructor":2,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-09-30 13:32:11.87967+03
2745	2024-10-03	1	1	7	2	t	1	{"dateIncome":"2024-10-03","typeRoute":1,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-10-03 16:17:45.581212+03
2746	2024-10-03	2	3	7	2	t	1	{"dateIncome":"2024-10-03","typeRoute":3,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-10-03 16:19:22.635837+03
2743	2024-10-02	1	4	10	2	t	1	{"dateIncome":"2024-10-02","typeRoute":4,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":5000}]}	2024-10-02 16:26:35.518935+03
2744	2024-10-02	2	3	3	2	t	1	{"dateIncome":"2024-10-02","typeRoute":3,"flightNumber":2,"instructor":3,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":28,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-10-02 16:31:21.730998+03
2747	2024-10-04	1	2	7	2	t	1	{"dateIncome":"2024-10-04","typeRoute":2,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":9,"discount":2000,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"С инструктором ","price":9000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":12000}]}	2024-10-04 12:10:49.98242+03
2748	2024-10-05	1	4	2	2	t	1	{"dateIncome":"2024-10-05","typeRoute":4,"flightNumber":1,"instructor":2,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-10-05 11:17:38.367079+03
2749	2024-10-05	2	3	3	2	t	1	{"dateIncome":"2024-10-05","typeRoute":3,"flightNumber":2,"instructor":3,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-10-05 11:19:28.953943+03
2752	2024-10-06	2	1	18	2	t	1	{"dateIncome":"2024-10-06","typeRoute":1,"flightNumber":2,"instructor":18,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-10-06 10:18:20.092992+03
2751	2024-10-06	1	4	7	2	t	1	{"dateIncome":"2024-10-06","typeRoute":4,"flightNumber":1,"instructor":7,"techniques":[{"typeTechnique":33,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":4000},{"typeTechnique":19,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-10-06 10:13:40.202683+03
2758	2024-10-06	8	3	18	2	t	1	{"dateIncome":"2024-10-06","typeRoute":3,"flightNumber":8,"instructor":18,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-10-06 15:48:33.692448+03
2753	2024-10-06	3	3	7	2	t	1	{"dateIncome":"2024-10-06","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":11,"discount":500,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"1 отзыв оставили ","price":3500},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-10-06 13:10:45.234589+03
2754	2024-10-06	4	3	7	2	t	1	{"dateIncome":"2024-10-06","typeRoute":3,"flightNumber":4,"instructor":7,"techniques":[{"typeTechnique":19,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-10-06 13:13:26.447388+03
2755	2024-10-06	5	2	18	2	t	1	{"dateIncome":"2024-10-06","typeRoute":2,"flightNumber":5,"instructor":18,"techniques":[{"typeTechnique":19,"discount":2000,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-10-06 14:27:56.406731+03
2759	2024-10-06	9	3	2	2	t	1	{"dateIncome":"2024-10-06","typeRoute":3,"flightNumber":9,"instructor":2,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-10-06 16:47:13.083347+03
2756	2024-10-06	6	3	7	2	t	1	{"dateIncome":"2024-10-06","typeRoute":3,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-10-06 15:21:13.702133+03
2757	2024-10-06	7	3	18	2	t	1	{"dateIncome":"2024-10-06","typeRoute":3,"flightNumber":7,"instructor":18,"techniques":[{"typeTechnique":31,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-10-06 15:23:25.839095+03
2762	2024-10-07	1	1	10	2	t	1	{"dateIncome":"2024-10-07","typeRoute":1,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"Друго","price":9000},{"typeTechnique":10,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":6,"hotel":0,"transfer":0,"description":"","price":8000},{"typeTechnique":12,"discount":2000,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"Отзывы напишут","price":8000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-10-07 10:35:16.545293+03
2764	2024-10-07	3	3	7	2	t	1	{"dateIncome":"2024-10-07","typeRoute":3,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-10-07 13:06:21.746682+03
2760	2024-10-06	10	3	2	2	t	1	{"dateIncome":"2024-10-06","typeRoute":3,"flightNumber":10,"instructor":2,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000}]}	2024-10-06 17:37:50.777616+03
2761	2024-10-06	11	4	18	2	t	1	{"dateIncome":"2024-10-06","typeRoute":4,"flightNumber":11,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":12,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":10,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":6000}]}	2024-10-06 17:38:40.467716+03
2763	2024-10-07	2	4	7	2	t	1	{"dateIncome":"2024-10-07","typeRoute":4,"flightNumber":2,"instructor":7,"techniques":[{"typeTechnique":18,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-10-07 10:54:54.01307+03
2766	2024-10-07	5	4	7	2	t	1	{"dateIncome":"2024-10-07","typeRoute":4,"flightNumber":5,"instructor":7,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":13,"discount":0,"prepayment":false,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":6000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-10-07 17:10:05.525946+03
2765	2024-10-07	4	2	10	2	t	1	{"dateIncome":"2024-10-07","typeRoute":2,"flightNumber":4,"instructor":10,"techniques":[{"typeTechnique":30,"discount":1000,"prepayment":true,"typePayment":6,"clientSource":3,"hotel":0,"transfer":0,"description":"Белый пик. Ренат все","price":8000},{"typeTechnique":20,"discount":0,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":10000},{"typeTechnique":22,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":10000}]}	2024-10-07 17:08:54.18918+03
2767	2024-10-07	6	4	7	2	t	1	{"dateIncome":"2024-10-07","typeRoute":4,"flightNumber":6,"instructor":7,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":5000}]}	2024-10-07 17:32:00.233438+03
2768	2024-10-08	1	4	10	2	t	1	{"dateIncome":"2024-10-08","typeRoute":4,"flightNumber":1,"instructor":10,"techniques":[{"typeTechnique":21,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":5000}]}	2024-10-08 13:03:00.450878+03
2769	2024-10-08	2	1	10	2	t	1	{"dateIncome":"2024-10-08","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":9000}]}	2024-10-08 17:11:05.087163+03
2773	2024-10-09	3	3	3	2	t	1	{"dateIncome":"2024-10-09","typeRoute":3,"flightNumber":3,"instructor":3,"techniques":[{"typeTechnique":30,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":3000},{"typeTechnique":11,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":4000}]}	2024-10-09 17:53:51.978162+03
2770	2024-10-08	3	1	7	2	t	1	{"dateIncome":"2024-10-08","typeRoute":1,"flightNumber":3,"instructor":7,"techniques":[{"typeTechnique":19,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":32,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":28,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":33,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":25,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":22,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":4,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-10-08 17:37:17.789712+03
2774	2024-10-09	4	2	18	2	t	1	{"dateIncome":"2024-10-09","typeRoute":2,"flightNumber":4,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-10-09 17:54:54.705178+03
2778	2024-10-10	2	1	10	2	t	1	{"dateIncome":"2024-10-10","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"Ренат","price":7000},{"typeTechnique":21,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":30,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":23,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000},{"typeTechnique":32,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"","price":8000}]}	2024-10-10 12:50:34.164992+03
2771	2024-10-09	1	2	18	2	t	1	{"dateIncome":"2024-10-09","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":13,"discount":10000,"prepayment":false,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"2 вездехода с подъёмом ","price":2000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-10-09 17:46:25.725248+03
2779	2024-10-10	3	2	18	2	t	1	{"dateIncome":"2024-10-10","typeRoute":2,"flightNumber":3,"instructor":18,"techniques":[{"typeTechnique":11,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":9,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000},{"typeTechnique":13,"discount":0,"prepayment":true,"typePayment":1,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-10-10 13:58:07.434061+03
2772	2024-10-09	2	1	10	2	t	1	{"dateIncome":"2024-10-09","typeRoute":1,"flightNumber":2,"instructor":10,"techniques":[{"typeTechnique":9,"discount":2000,"prepayment":false,"typePayment":3,"clientSource":3,"hotel":0,"transfer":0,"description":"Аллюр. Ренат","price":8000},{"typeTechnique":20,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":7000}]}	2024-10-09 17:52:49.562569+03
2775	2024-10-09	5	3	10	2	t	1	{"dateIncome":"2024-10-09","typeRoute":3,"flightNumber":5,"instructor":10,"techniques":[{"typeTechnique":25,"discount":0,"prepayment":false,"typePayment":1,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат","price":3000}]}	2024-10-09 17:56:15.270096+03
2776	2024-10-09	6	3	10	2	t	1	{"dateIncome":"2024-10-09","typeRoute":3,"flightNumber":6,"instructor":10,"techniques":[{"typeTechnique":33,"discount":0,"prepayment":false,"typePayment":6,"clientSource":2,"hotel":0,"transfer":0,"description":"Ренат\\n\\n","price":3000}]}	2024-10-09 17:56:55.512854+03
2777	2024-10-10	1	2	18	2	t	1	{"dateIncome":"2024-10-10","typeRoute":2,"flightNumber":1,"instructor":18,"techniques":[{"typeTechnique":12,"discount":0,"prepayment":true,"typePayment":6,"clientSource":1,"hotel":0,"transfer":0,"description":"","price":11000}]}	2024-10-10 09:59:05.788+03
\.


--
-- Data for Name: hotels; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.hotels (id, title, deleted_at) FROM stdin;
1	Отель 1	\N
\.


--
-- Data for Name: investors; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.investors (id, title, tg, percent, deleted_at) FROM stdin;
2	Джамал	\N	0.5	2024-05-06 13:58:23.665246
4	Мудалиф	\N	\N	2024-05-06 13:58:23.665697
5	Самат	\N	1	2024-05-06 13:58:23.66612
6	Сергей	\N	0.5	2024-05-06 13:58:23.666592
1	Ахмат	axm9t	1	\N
3	Мизар	mizar_2	0.5	\N
7	Умар	\N	1	\N
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.messages (id, chat_id, message_id, user_id, date_send, message_type, flight_id) FROM stdin;
1910	268398735	4919	13	2024-03-04 08:53:10.183404+03	expense_start	0
1170	1129601494	3237	1	2024-02-04 14:48:41.656702+03	operacion_start	0
1911	268398735	4921	13	2024-03-04 08:53:18.771124+03	expense_start	0
694	1129601494	2065	1	2024-01-17 13:34:42.150445+03	deposit_income_start	0
903	1129601494	2709	1	2024-01-24 18:07:18.204229+03	confirm_cash	0
904	268398735	2711	13	2024-01-24 18:19:04.07768+03	deposit_income_start	0
905	1129601494	2721	1	2024-01-24 21:13:57.637711+03	confirm_cash	0
3035	1129601494	7797	1	2024-06-17 23:35:55.481485+03	confirm_cash	0
975	1129601494	2857	1	2024-01-27 18:30:10.368733+03	confirm_cash	0
703	1129601494	2089	1	2024-01-17 13:39:23.978901+03	deposit_income_start	0
704	1129601494	2095	1	2024-01-17 13:54:29.976394+03	deposit_income_start	0
2773	1129601494	7135	1	2024-05-21 12:03:30.824184+03	expense_start	0
1686	268398735	4394	13	2024-02-23 13:40:54.323883+03	expense_start	0
1536	268398735	4035	13	2024-02-16 19:15:59.894474+03	deposit_income_start	0
1537	268398735	4038	13	2024-02-16 19:16:02.103619+03	operacion_start	0
658	268398735	1972	13	2024-01-15 15:09:31.277943+03	deposit_income_start	0
659	268398735	1978	13	2024-01-15 16:33:19.686024+03	operacion_start	0
712	1129601494	2118	1	2024-01-17 14:05:38.741395+03	confirm_report	0
2322	1129601494	5950	1	2024-03-31 18:30:55.255108+03	confirm_cash	0
1546	596510270	4066	12	2024-02-17 11:21:29.716627+03	expense_start	0
716	1129601494	2126	1	2024-01-17 15:36:21.527941+03	deposit_income_start	0
2923	1129601494	7511	1	2024-06-09 18:35:24.952832+03	confirm_cash	0
718	1129601494	2132	1	2024-01-17 15:39:16.802933+03	deposit_income_start	0
784	1129601494	2271	1	2024-01-20 17:37:52.006804+03	deposit_income_start	0
785	1129601494	2274	1	2024-01-20 17:38:04.476959+03	deposit_income_start	0
1050	596510270	2996	12	2024-01-31 15:13:47.670359+03	expense_start	0
1051	596510270	2998	12	2024-01-31 15:16:13.210875+03	expense_start	0
2798	1129601494	7190	1	2024-05-26 10:19:33.813147+03	expense_start	0
1052	1129601494	3000	1	2024-01-31 15:26:10.823635+03	deposit_income_start	0
1053	268398735	3002	13	2024-01-31 15:38:04.703818+03	expense_start	0
1054	1129601494	3004	1	2024-01-31 15:55:42.450155+03	deposit_income_start	0
2800	663459487	7198	6	2024-05-26 15:34:29.191765+03	expense_start	0
1189	1129601494	3272	1	2024-02-04 18:30:10.383521+03	confirm_cash	0
1057	596510270	3011	12	2024-01-31 18:10:30.240491+03	expense_start	0
733	1129601494	2162	1	2024-01-18 12:51:43.668473+03	deposit_income_start	0
3055	1129601494	7840	1	2024-06-19 19:11:09.548356+03	confirm_cash	0
2810	498590409	7220	3	2024-05-28 18:58:01.52334+03	expense_start	0
2334	1129601494	5973	1	2024-04-01 18:49:19.370168+03	confirm_cash	0
998	1129601494	2896	1	2024-01-28 18:30:10.63873+03	confirm_cash	0
927	1129601494	2772	1	2024-01-25 18:09:06.063965+03	confirm_cash	0
2817	1129601494	7246	1	2024-05-29 19:17:29.60616+03	confirm_cash	0
4256	1129601494	10698	1	2024-09-01 09:00:10.266309+03	employees_start	0
2823	1129601494	7256	1	2024-05-30 18:31:47.646438+03	confirm_cash	0
2826	1129601494	7264	1	2024-05-30 18:57:42.037707+03	confirm_cash	0
809	268398735	2323	13	2024-01-21 13:57:23.137297+03	expense_start	0
2829	1129601494	7274	1	2024-05-30 19:19:46.768956+03	expense_start	0
810	1129601494	2326	1	2024-01-21 14:18:17.400294+03	deposit_income_start	0
1267	268398735	3413	13	2024-02-07 16:58:09.214786+03	operacion_start	0
1268	1129601494	3416	1	2024-02-07 17:00:14.803049+03	operacion_start	0
1269	268398735	3418	13	2024-02-07 17:01:12.942046+03	operacion_start	0
2347	663459487	6000	6	2024-04-02 19:21:13.268091+03	expense_start	0
816	1129601494	2350	1	2024-01-21 14:33:07.802654+03	deposit_income_start	0
2833	1129601494	7284	1	2024-05-31 09:44:10.340125+03	expense_start	0
2350	1129601494	6004	1	2024-04-03 18:30:36.85898+03	confirm_cash	0
758	596510270	2214	12	2024-01-19 20:17:47.902999+03	expense_start	0
759	268398735	2217	13	2024-01-19 20:35:54.254173+03	deposit_income_start	0
760	268398735	2220	13	2024-01-19 20:36:06.47281+03	operacion_start	0
761	268398735	2223	13	2024-01-19 20:36:14.918664+03	expense_start	0
762	268398735	2226	13	2024-01-19 22:25:26.615172+03	deposit_income_start	0
817	268398735	2353	13	2024-01-21 14:33:12.317915+03	deposit_income_start	0
4286	1129601494	10765	1	2024-09-03 09:00:10.371446+03	employees_start	0
4300	702856294	10796	2	2024-09-05 18:30:10.38673+03	confirm_report	0
2362	1129601494	6033	1	2024-04-05 21:02:58.888464+03	confirm_cash	0
824	596510270	2368	12	2024-01-21 15:54:54.667051+03	expense_start	0
1078	1129601494	3056	1	2024-02-01 18:30:10.535661+03	confirm_cash	0
944	1129601494	2811	1	2024-01-26 18:59:45.499267+03	confirm_cash	0
945	1129601494	2812	1	2024-01-26 18:59:55.784028+03	confirm_cash	0
946	1129601494	2813	1	2024-01-26 19:00:06.670804+03	confirm_cash	0
947	1129601494	2814	1	2024-01-26 19:00:17.834262+03	confirm_cash	0
948	1129601494	2815	1	2024-01-26 19:00:28.354272+03	confirm_cash	0
951	1129601494	2820	1	2024-01-27 11:27:57.495074+03	confirm_cash	0
952	1129601494	2821	1	2024-01-27 11:28:07.702788+03	confirm_cash	0
953	1129601494	2822	1	2024-01-27 11:28:17.877895+03	confirm_cash	0
954	1129601494	2823	1	2024-01-27 11:28:28.184522+03	confirm_cash	0
955	1129601494	2824	1	2024-01-27 11:28:38.422348+03	confirm_cash	0
1347	268398735	3581	13	2024-02-10 11:10:59.638713+03	operacion_start	0
1413	1129601494	3701	1	2024-02-11 18:30:10.684112+03	confirm_cash	0
1024	268398735	2948	13	2024-01-30 15:22:30.305755+03	operacion_start	0
1416	596510270	3721	12	2024-02-12 08:22:07.480588+03	comission_start	0
1103	268398735	3105	13	2024-02-02 17:13:29.531841+03	expense_start	0
1104	1129601494	3107	1	2024-02-02 17:13:33.788295+03	deposit_income_start	0
1441	268398735	3787	13	2024-02-12 18:11:02.38865+03	deposit_income_start	0
1442	1129601494	3789	1	2024-02-12 18:30:10.350826+03	confirm_cash	0
1447	268398735	3806	13	2024-02-13 13:34:23.266099+03	deposit_income_start	0
2213	596510270	5658	12	2024-03-23 18:59:37.931915+03	expense_start	0
1603	1129601494	4194	1	2024-02-18 18:50:09.210539+03	confirm_cash	0
1838	268398735	4728	13	2024-02-29 16:40:39.042906+03	operacion_start	0
1687	268398735	4396	13	2024-02-23 13:41:23.205025+03	expense_start	0
1538	268398735	4040	13	2024-02-16 19:18:49.885491+03	deposit_income_start	0
1539	268398735	4042	13	2024-02-16 19:18:51.839154+03	operacion_start	0
1688	596510270	4399	12	2024-02-23 13:45:49.011712+03	expense_start	0
1689	268398735	4402	13	2024-02-23 13:59:02.633237+03	expense_start	0
1839	268398735	4730	13	2024-02-29 16:40:51.006279+03	deposit_income_start	0
1547	596510270	4068	12	2024-02-17 11:21:46.500238+03	expense_start	0
2313	1129601494	5923	1	2024-03-30 21:05:38.605228+03	confirm_cash	0
1843	268398735	4742	13	2024-02-29 20:28:37.674431+03	expense_start	0
2770	1129601494	7127	1	2024-05-20 18:35:58.245369+03	confirm_cash	0
2320	5649904178	5948	4	2024-03-31 18:16:53.222572+03	expense_start	0
4187	1129601494	10542	1	2024-08-28 19:04:45.035973+03	confirm_cash	0
2005	1129601494	5151	1	2024-03-08 18:48:05.416506+03	confirm_cash	0
2006	268398735	5159	13	2024-03-08 21:40:33.873368+03	expense_start	0
2121	268398735	5432	13	2024-03-16 14:11:13.618186+03	expense_start	0
2122	268398735	5434	13	2024-03-16 14:11:31.478247+03	expense_start	0
4361	1129601494	10925	1	2024-09-12 19:21:47.454476+03	confirm_cash	0
4207	1129601494	10596	1	2024-08-29 19:18:29.933634+03	confirm_cash	0
2786	1129601494	7165	1	2024-05-23 19:12:21.307418+03	confirm_cash	0
2013	1044795623	5175	14	2024-03-09 12:48:33.705202+03	expense_start	0
2014	276700108	5179	7	2024-03-09 12:52:36.221584+03	expense_start	0
1929	1129601494	4955	1	2024-03-05 11:28:23.054898+03	operacion_start	0
1930	268398735	4958	13	2024-03-05 11:30:39.142116+03	expense_start	0
1931	1129601494	4961	1	2024-03-05 11:34:54.621851+03	penalty_start	0
1932	1129601494	4964	1	2024-03-05 11:35:58.725104+03	expense_start	0
1933	268398735	4967	13	2024-03-05 11:58:29.304146+03	operacion_start	0
2016	663459487	5186	6	2024-03-09 13:13:39.616299+03	expense_start	0
2017	498590409	5190	3	2024-03-09 13:14:21.685053+03	expense_start	0
1864	268398735	4815	13	2024-03-01 12:49:34.802013+03	operacion_start	0
4257	498590409	10701	3	2024-09-01 10:14:06.651424+03	expense_start	0
2026	1129601494	5207	1	2024-03-09 19:04:34.009579+03	confirm_cash	0
2027	663459487	5213	6	2024-03-09 19:05:14.065078+03	expense_start	0
2240	1129601494	5755	1	2024-03-25 08:31:50.798257+03	expense_start	0
1649	1129601494	4289	1	2024-02-20 22:42:31.976968+03	confirm_cash	0
1875	1129601494	4837	1	2024-03-02 03:18:45.794931+03	confirm_cash	0
1522	268398735	3992	13	2024-02-16 16:22:46.070292+03	expense_start	0
2032	268398735	5224	13	2024-03-10 13:01:26.276067+03	deposit_income_start	0
1655	268398735	4305	13	2024-02-21 14:59:43.368827+03	deposit_income_start	0
1656	268398735	4307	13	2024-02-21 14:59:44.656628+03	operacion_start	0
1657	268398735	4309	13	2024-02-21 14:59:46.748097+03	deposit_income_start	0
1658	268398735	4311	13	2024-02-21 14:59:50.203105+03	deposit_income_start	0
1659	268398735	4314	13	2024-02-21 14:59:53.129736+03	expense_start	0
1660	268398735	4316	13	2024-02-21 14:59:53.980184+03	operacion_start	0
2035	268398735	5231	13	2024-03-10 14:12:30.126926+03	expense_start	0
2139	1129601494	5472	1	2024-03-17 20:16:59.642541+03	confirm_cash	0
2140	663459487	5479	6	2024-03-17 20:39:36.262842+03	expense_start	0
1665	1129601494	4325	1	2024-02-21 19:21:05.477837+03	confirm_cash	0
2038	596510270	5238	12	2024-03-10 18:43:22.405195+03	operacion_start	0
2039	1129601494	5239	1	2024-03-10 19:03:11.503245+03	confirm_cash	0
2041	268398735	5246	13	2024-03-11 11:09:45.961762+03	deposit_income_start	0
2042	268398735	5248	13	2024-03-11 11:10:39.432671+03	deposit_income_start	0
1673	596510270	4352	12	2024-02-22 15:36:30.213764+03	operacion_start	0
2144	268398735	5487	13	2024-03-18 10:48:05.568332+03	deposit_income_start	0
2046	1129601494	5260	1	2024-03-11 21:50:04.994417+03	confirm_cash	0
2145	268398735	5490	13	2024-03-18 11:11:24.903702+03	deposit_income_start	0
1832	268398735	4715	13	2024-02-29 16:01:05.660196+03	deposit_income_start	0
1969	1129601494	5044	1	2024-03-06 22:13:45.078195+03	confirm_cash	0
1834	268398735	4721	13	2024-02-29 16:18:54.327361+03	deposit_income_start	0
2151	1129601494	5499	1	2024-03-18 19:19:19.886069+03	confirm_cash	0
1974	596510270	5072	12	2024-03-07 11:38:49.250259+03	expense_start	0
1975	596510270	5083	12	2024-03-07 11:49:42.342547+03	expense_start	0
2055	1044795623	5277	14	2024-03-13 07:20:09.605963+03	expense_start	0
1978	268398735	5090	13	2024-03-07 13:19:58.751352+03	expense_start	0
1909	596510270	4915	12	2024-03-03 19:32:42.970113+03	expense_start	0
2061	663459487	5289	6	2024-03-13 12:47:59.371365+03	expense_start	0
1985	1129601494	5105	1	2024-03-07 18:54:00.960258+03	confirm_cash	0
2068	1129601494	5304	1	2024-03-13 18:46:16.076868+03	confirm_cash	0
2069	276700108	5310	7	2024-03-13 18:48:48.281009+03	expense_start	0
2090	1129601494	5351	1	2024-03-14 20:27:44.325185+03	confirm_cash	0
2091	663459487	5357	6	2024-03-14 20:28:48.933878+03	expense_start	0
2093	276700108	5362	7	2024-03-15 11:21:26.352975+03	expense_start	0
2094	276700108	5364	7	2024-03-15 11:22:19.0481+03	expense_start	0
2095	276700108	5366	7	2024-03-15 11:22:29.973041+03	expense_start	0
2101	268398735	5379	13	2024-03-15 13:18:51.831574+03	expense_start	0
2103	498590409	5383	3	2024-03-15 13:34:36.269805+03	expense_start	0
2104	663459487	5386	6	2024-03-15 13:36:43.375772+03	expense_start	0
2106	498590409	5392	3	2024-03-15 15:59:55.17569+03	expense_start	0
2110	1129601494	5401	1	2024-03-15 19:44:50.989786+03	confirm_cash	0
2111	268398735	5408	13	2024-03-15 21:08:18.100921+03	expense_start	0
2112	1044795623	5411	14	2024-03-16 07:19:28.072723+03	expense_start	0
2152	1044795623	5503	14	2024-03-18 20:41:42.039368+03	expense_start	0
2153	268398735	5506	13	2024-03-18 21:03:34.965422+03	deposit_income_start	0
2214	268398735	5661	13	2024-03-23 20:50:54.996446+03	expense_start	0
2308	1129601494	5913	1	2024-03-29 18:35:18.667453+03	confirm_cash	0
4350	1129601494	10902	1	2024-09-11 19:23:17.719404+03	confirm_cash	0
3915	1129601494	9941	1	2024-08-16 20:03:53.725894+03	confirm_cash	0
3769	498590409	9602	3	2024-08-08 20:27:27.216384+03	expense_start	0
2418	1129601494	6169	1	2024-04-13 18:50:05.837544+03	confirm_cash	0
2239	1129601494	5751	1	2024-03-24 18:32:41.232809+03	confirm_cash	0
2775	1129601494	7137	1	2024-05-21 18:31:22.503231+03	confirm_cash	0
2162	268398735	5525	13	2024-03-19 15:49:31.622231+03	expense_start	0
4362	1129601494	10927	1	2024-09-13 09:00:10.291449+03	employees_start	0
2165	1129601494	5532	1	2024-03-19 18:30:45.375482+03	confirm_cash	0
2904	1129601494	7468	1	2024-06-07 18:32:43.321863+03	confirm_cash	0
2246	1253613887	5777	17	2024-03-25 17:02:36.332831+03	expense_start	0
4370	702856294	10946	2	2024-09-13 18:30:10.341701+03	confirm_report	0
3044	1129601494	7817	1	2024-06-18 19:42:33.22165+03	confirm_cash	0
2545	1129601494	6535	1	2024-04-29 09:30:20.306836+03	confirm_cash	0
2346	1129601494	5995	1	2024-04-02 19:15:08.812894+03	confirm_cash	0
2172	1129601494	5545	1	2024-03-20 18:30:39.772532+03	confirm_cash	0
2426	1129601494	6188	1	2024-04-14 19:22:52.686675+03	confirm_cash	0
4378	1129601494	10972	1	2024-09-14 09:00:10.205509+03	employees_start	0
2253	1129601494	5791	1	2024-03-25 18:30:43.488053+03	confirm_cash	0
5023	702856294	12722	2	2024-10-09 18:30:10.226945+03	confirm_report	0
4208	1129601494	10599	1	2024-08-30 09:00:10.258921+03	employees_start	0
2357	1129601494	6023	1	2024-04-04 18:30:43.021944+03	confirm_cash	0
2259	1129601494	5807	1	2024-03-26 18:31:19.207046+03	confirm_cash	0
2433	1129601494	6223	1	2024-04-15 18:30:49.269695+03	confirm_cash	0
2553	1129601494	6551	1	2024-04-29 21:18:35.264853+03	confirm_cash	0
2438	1129601494	6234	1	2024-04-16 19:07:40.955008+03	confirm_cash	0
2370	1129601494	6052	1	2024-04-06 23:06:41.082543+03	confirm_cash	0
2193	1129601494	5603	1	2024-03-21 18:30:52.629663+03	confirm_cash	0
2195	1129601494	5611	1	2024-03-22 11:17:24.0128+03	operacion_start	0
2373	1129601494	6056	1	2024-04-07 18:31:00.323142+03	confirm_cash	0
2273	1129601494	5833	1	2024-03-27 18:31:36.024244+03	confirm_cash	0
2941	1129601494	7545	1	2024-06-11 19:05:52.375637+03	confirm_cash	0
2200	1129601494	5622	1	2024-03-22 18:59:00.724413+03	confirm_cash	0
2446	1129601494	6257	1	2024-04-17 18:39:20.394242+03	confirm_cash	0
2382	5649904178	6078	4	2024-04-09 10:19:39.271302+03	expense_start	0
4301	1129601494	10799	1	2024-09-06 09:00:10.307809+03	employees_start	0
4305	1129601494	10807	1	2024-09-08 09:00:10.263805+03	employees_start	0
2212	1129601494	5652	1	2024-03-23 18:30:33.959179+03	confirm_cash	0
2454	596510270	6281	12	2024-04-17 22:23:28.575674+03	edit_salary_start	0
2390	1129601494	6095	1	2024-04-09 18:48:58.296185+03	confirm_cash	0
2289	1129601494	5869	1	2024-03-28 18:31:32.170605+03	confirm_cash	0
2455	268398735	6286	13	2024-04-18 08:22:20.456171+03	edit_salary_start	0
2457	268398735	6290	13	2024-04-18 14:19:32.257635+03	deposit_income_start	0
2458	268398735	6293	13	2024-04-18 14:19:43.138969+03	expense_start	0
2459	268398735	6296	13	2024-04-18 14:19:55.349173+03	expense_start	0
2461	1129601494	6298	1	2024-04-18 18:30:41.876993+03	confirm_cash	0
2463	596510270	6302	12	2024-04-19 09:21:04.709509+03	operacion_start	0
2400	1129601494	6127	1	2024-04-10 18:30:43.410912+03	confirm_cash	0
2466	268398735	6311	13	2024-04-19 16:34:08.270584+03	operacion_start	0
2404	1129601494	6135	1	2024-04-11 21:09:17.12678+03	confirm_cash	0
2468	1129601494	6313	1	2024-04-19 18:30:28.737485+03	confirm_cash	0
2410	1129601494	6152	1	2024-04-12 18:30:34.533904+03	confirm_cash	0
2474	1129601494	6323	1	2024-04-20 18:33:25.016523+03	confirm_cash	0
2581	1129601494	6625	1	2024-04-30 18:43:55.235367+03	confirm_cash	0
2477	1129601494	6337	1	2024-04-21 11:42:11.594528+03	operacion_start	0
2583	268398735	6632	13	2024-05-01 10:21:50.495253+03	deposit_income_start	0
2584	268398735	6635	13	2024-05-01 10:22:01.917608+03	operacion_start	0
2585	268398735	6638	13	2024-05-01 10:22:13.916863+03	edit_salary_start	0
2483	1129601494	6351	1	2024-04-21 18:30:42.860051+03	confirm_cash	0
2484	5649904178	6356	4	2024-04-21 18:31:21.634496+03	expense_start	0
2491	1129601494	6375	1	2024-04-22 18:31:42.469424+03	confirm_cash	0
2494	276700108	6388	7	2024-04-23 12:32:47.070362+03	expense_start	0
2600	1129601494	6675	1	2024-05-01 18:30:57.642444+03	confirm_cash	0
2502	1129601494	6402	1	2024-04-23 18:30:36.778384+03	confirm_cash	0
2508	1129601494	6416	1	2024-04-24 18:34:34.236636+03	confirm_cash	0
2515	1129601494	6436	1	2024-04-25 18:31:29.160729+03	confirm_cash	0
2519	1129601494	6448	1	2024-04-26 18:47:26.752385+03	confirm_cash	0
2617	1129601494	6730	1	2024-05-02 19:02:04.111099+03	confirm_cash	0
2618	5649904178	6738	4	2024-05-02 19:03:34.625949+03	expense_start	0
2528	1129601494	6485	1	2024-04-27 18:36:40.909014+03	confirm_cash	0
2625	1129601494	6750	1	2024-05-03 18:30:38.250916+03	confirm_cash	0
2632	1129601494	6776	1	2024-05-04 18:39:40.363781+03	confirm_cash	0
2635	1129601494	6782	1	2024-05-05 18:41:58.318912+03	confirm_cash	0
2640	268398735	6800	13	2024-05-06 15:57:51.785714+03	deposit_income_start	0
2641	268398735	6803	13	2024-05-06 16:03:10.429619+03	edit_salary_start	0
2644	1129601494	6808	1	2024-05-06 18:33:49.863192+03	confirm_cash	0
2647	1129601494	6817	1	2024-05-07 18:30:36.852622+03	confirm_cash	0
2650	1129601494	6825	1	2024-05-08 19:32:25.678757+03	confirm_cash	0
2657	1129601494	6838	1	2024-05-09 18:37:08.904939+03	confirm_cash	0
4351	1129601494	10905	1	2024-09-12 09:00:10.244158+03	employees_start	0
2767	1129601494	7119	1	2024-05-19 18:32:31.310802+03	confirm_cash	0
3185	5649904178	8149	4	2024-07-01 18:36:07.673782+03	expense_start	0
2912	1129601494	7484	1	2024-06-08 18:30:40.078452+03	confirm_cash	0
2783	1129601494	7157	1	2024-05-22 21:55:46.267524+03	confirm_cash	0
3193	268398735	8173	13	2024-07-02 15:53:58.139045+03	expense_start	0
2928	1129601494	7520	1	2024-06-10 19:23:51.522436+03	confirm_cash	0
2799	1253613887	7195	17	2024-05-26 14:06:35.412294+03	expense_start	0
3624	1129601494	9218	1	2024-08-01 18:34:54.743494+03	confirm_cash	0
2805	1129601494	7207	1	2024-05-27 18:31:10.549943+03	confirm_cash	0
3200	1129601494	8186	1	2024-07-02 18:31:53.42792+03	confirm_cash	0
2808	1129601494	7212	1	2024-05-28 18:30:39.272269+03	confirm_cash	0
4371	429567381	10953	26	2024-09-13 21:58:09.508519+03	expense_start	0
3060	1129601494	7853	1	2024-06-20 19:19:48.966583+03	confirm_cash	0
4372	429567381	10956	26	2024-09-13 21:58:14.448087+03	deposit_income_start	0
4373	429567381	10959	26	2024-09-13 21:58:16.583499+03	operacion_start	0
3789	1129601494	9645	1	2024-08-09 18:37:53.13949+03	confirm_cash	0
2949	1129601494	7562	1	2024-06-12 17:31:18.754156+03	expense_start	0
2824	1129601494	7260	1	2024-05-30 18:50:28.581837+03	confirm_cash	0
2825	1129601494	7262	1	2024-05-30 18:57:01.210556+03	confirm_cash	0
3213	1129601494	8219	1	2024-07-04 19:06:44.91173+03	confirm_cash	0
2834	268398735	7287	13	2024-05-31 09:46:53.732609+03	expense_start	0
4086	1129601494	10319	1	2024-08-25 09:00:10.24801+03	employees_start	0
2836	702856294	7293	2	2024-05-31 18:30:12.442962+03	confirm_report	0
3069	1129601494	7871	1	2024-06-21 21:04:31.673692+03	confirm_cash	0
4295	1129601494	10787	1	2024-09-04 09:00:10.274985+03	employees_start	0
2842	1129601494	7309	1	2024-06-01 20:38:29.220361+03	confirm_cash	0
2959	1129601494	7586	1	2024-06-12 18:52:20.987195+03	confirm_cash	0
3223	1129601494	8241	1	2024-07-05 19:46:20.85212+03	confirm_cash	0
2961	1129601494	7593	1	2024-06-12 18:53:09.375079+03	expense_start	0
2847	5649904178	7331	4	2024-06-02 13:33:04.824712+03	expense_start	0
2963	1129601494	7599	1	2024-06-12 18:53:37.634284+03	expense_start	0
4302	702856294	10800	2	2024-09-06 18:30:10.331256+03	confirm_report	0
2710	1129601494	6972	1	2024-05-11 19:26:00.312372+03	confirm_cash	0
4306	702856294	10808	2	2024-09-08 18:30:10.248045+03	confirm_report	0
2714	1129601494	6985	1	2024-05-12 18:35:30.762269+03	confirm_cash	0
4317	1129601494	10831	1	2024-09-10 09:00:10.309093+03	employees_start	0
3082	1129601494	7897	1	2024-06-22 18:38:43.766321+03	confirm_cash	0
2858	1129601494	7354	1	2024-06-02 21:03:06.1825+03	confirm_cash	0
4335	1129601494	10867	1	2024-09-10 19:49:44.206958+03	confirm_cash	0
3084	498590409	7903	3	2024-06-23 10:35:12.672774+03	expense_start	0
4336	1129601494	10871	1	2024-09-10 19:50:04.993447+03	confirm_cash	0
2723	1129601494	7008	1	2024-05-13 20:40:43.829253+03	confirm_cash	0
4337	276700108	10877	7	2024-09-10 20:19:29.486633+03	expense_start	0
2865	1129601494	7366	1	2024-06-03 18:31:09.13188+03	confirm_cash	0
2980	1129601494	7640	1	2024-06-13 20:14:09.205155+03	confirm_cash	0
2733	596510270	7041	12	2024-05-14 15:55:29.620229+03	deposit_income_start	0
2734	596510270	7044	12	2024-05-14 15:55:46.892713+03	edit_salary_start	0
2736	1129601494	7048	1	2024-05-14 18:35:39.828066+03	confirm_cash	0
2984	702856294	7667	2	2024-06-14 18:30:10.665281+03	confirm_report	0
2874	1129601494	7386	1	2024-06-04 19:17:00.885375+03	confirm_cash	0
2741	1129601494	7061	1	2024-05-15 18:52:27.217745+03	confirm_cash	0
2743	268398735	7066	13	2024-05-16 15:29:22.371163+03	expense_start	0
2744	268398735	7069	13	2024-05-16 15:29:38.740475+03	edit_salary_start	0
2746	1129601494	7073	1	2024-05-16 18:37:20.842419+03	confirm_cash	0
3262	268398735	8336	13	2024-07-08 20:54:53.118572+03	deposit_income_start	0
3265	268398735	8345	13	2024-07-08 20:56:43.677287+03	operacion_start	0
2749	1129601494	7076	1	2024-05-17 18:31:26.811808+03	confirm_cash	0
3098	1129601494	7931	1	2024-06-23 18:31:24.431189+03	confirm_cash	0
2752	268398735	7088	13	2024-05-18 14:41:02.194403+03	edit_salary_start	0
2753	268398735	7091	13	2024-05-18 15:40:50.387883+03	deposit_income_start	0
3099	268398735	7939	13	2024-06-24 08:55:18.840567+03	deposit_income_start	0
3266	268398735	8348	13	2024-07-08 20:56:58.159183+03	expense_start	0
3267	268398735	8351	13	2024-07-08 20:57:06.991855+03	penalty_start	0
2757	1129601494	7097	1	2024-05-18 18:30:43.477768+03	confirm_cash	0
3268	268398735	8354	13	2024-07-08 20:57:13.427337+03	expense_start	0
2759	1129601494	7104	1	2024-05-19 09:28:08.881251+03	expense_start	0
2884	1129601494	7406	1	2024-06-05 18:30:32.036966+03	confirm_cash	0
3106	1129601494	7950	1	2024-06-24 18:30:40.562725+03	confirm_cash	0
2891	702856294	7437	2	2024-06-06 18:30:10.259586+03	confirm_report	0
3005	1129601494	7721	1	2024-06-15 18:04:18.888786+03	expense_start	0
3007	498590409	7727	3	2024-06-15 18:10:30.959349+03	expense_start	0
3117	1129601494	7973	1	2024-06-25 18:34:26.485895+03	confirm_cash	0
3009	1129601494	7729	1	2024-06-15 18:31:40.177016+03	confirm_cash	0
3124	1129601494	7990	1	2024-06-26 18:54:45.864929+03	confirm_cash	0
3022	702856294	7767	2	2024-06-16 18:30:10.242269+03	confirm_report	0
3024	5649904178	7775	4	2024-06-16 18:37:31.321792+03	expense_start	0
3130	1129601494	8004	1	2024-06-27 17:23:18.828884+03	expense_start	0
3131	1129601494	8007	1	2024-06-27 17:23:39.976977+03	expense_start	0
3132	1129601494	8010	1	2024-06-27 17:23:59.9654+03	expense_start	0
3134	1129601494	8012	1	2024-06-27 18:30:49.71078+03	confirm_cash	0
3137	5649904178	8022	4	2024-06-28 11:58:37.191387+03	expense_start	0
3141	1129601494	8030	1	2024-06-28 20:06:43.602849+03	confirm_cash	0
3155	1129601494	8061	1	2024-06-29 18:57:53.631813+03	confirm_cash	0
3184	1129601494	8143	1	2024-07-01 18:35:32.279584+03	confirm_cash	0
4192	1129601494	10565	1	2024-08-29 09:00:10.255671+03	employees_start	0
3626	276700108	9231	7	2024-08-01 20:31:12.714835+03	expense_start	0
3628	702856294	9233	2	2024-08-02 18:30:10.312782+03	confirm_report	0
3194	268398735	8176	13	2024-07-02 15:54:06.02078+03	edit_salary_start	0
3195	268398735	8179	13	2024-07-02 15:54:14.435667+03	penalty_start	0
3482	1129601494	8858	1	2024-07-24 18:34:24.789852+03	confirm_cash	0
3483	1129601494	8866	1	2024-07-24 18:36:40.970443+03	operacion_start	0
3350	1129601494	8536	1	2024-07-15 18:42:26.907296+03	confirm_cash	0
3205	1129601494	8200	1	2024-07-03 20:12:34.281552+03	confirm_cash	0
3169	1129601494	8098	1	2024-06-30 20:04:24.551059+03	confirm_cash	0
4203	498590409	10588	3	2024-08-29 13:05:31.742914+03	expense_start	0
4374	429567381	10962	26	2024-09-13 21:58:17.875219+03	expense_start	0
3174	268398735	8114	13	2024-07-01 12:12:01.756771+03	deposit_income_start	0
3176	498590409	8122	3	2024-07-01 16:09:00.111663+03	expense_start	0
4226	1129601494	10635	1	2024-08-30 20:33:40.362485+03	confirm_cash	0
3492	498590409	8891	3	2024-07-25 15:42:06.717986+03	expense_start	0
3233	1129601494	8267	1	2024-07-06 18:30:43.559756+03	confirm_cash	0
3499	1129601494	8906	1	2024-07-25 19:05:52.980967+03	confirm_cash	0
3644	1129601494	9269	1	2024-08-03 19:05:16.352221+03	confirm_cash	0
4274	1129601494	10736	1	2024-09-01 19:57:23.415344+03	confirm_cash	0
3255	1129601494	8319	1	2024-07-07 19:43:13.581885+03	confirm_cash	0
4298	702856294	10792	2	2024-09-04 18:30:10.400891+03	confirm_report	0
4303	1129601494	10803	1	2024-09-07 09:00:10.30999+03	employees_start	0
3371	1129601494	8579	1	2024-07-16 19:09:16.384924+03	confirm_cash	0
3261	702856294	8331	2	2024-07-08 18:30:10.255228+03	confirm_report	0
3263	268398735	8339	13	2024-07-08 20:55:35.077164+03	expense_start	0
3264	268398735	8342	13	2024-07-08 20:56:06.087659+03	deposit_income_start	0
3269	268398735	8357	13	2024-07-08 20:57:27.81986+03	edit_salary_start	0
3650	268398735	9295	22	2024-08-04 11:22:24.028678+03	edit_salary_start	0
3651	268398735	9297	22	2024-08-04 11:22:26.708278+03	deposit_income_start	0
4307	1129601494	10811	1	2024-09-09 09:00:10.195225+03	employees_start	0
3510	1129601494	8929	1	2024-07-26 18:30:37.663802+03	confirm_cash	0
3654	268398735	9304	22	2024-08-04 12:50:11.233201+03	expense_start	0
3655	268398735	9307	22	2024-08-04 12:56:50.242493+03	expense_start	0
4338	1129601494	10878	1	2024-09-11 09:00:10.241403+03	employees_start	0
3384	1129601494	8612	1	2024-07-17 18:32:25.62302+03	confirm_cash	0
3284	1129601494	8386	1	2024-07-09 19:14:27.675095+03	confirm_cash	0
3285	5834993171	8392	18	2024-07-09 21:30:31.500326+03	expense_start	0
3664	268398735	9326	22	2024-08-04 15:42:31.910894+03	deposit_income_start	0
3665	268398735	9329	22	2024-08-04 15:46:07.291004+03	expense_start	0
3388	702856294	8626	2	2024-07-18 18:30:10.277248+03	confirm_report	0
3389	268398735	8638	13	2024-07-18 19:25:55.30996+03	operacion_start	0
3392	498590409	8645	3	2024-07-19 16:58:02.920384+03	expense_start	0
3395	1129601494	8650	1	2024-07-19 21:25:03.924141+03	confirm_cash	0
3671	1129601494	9343	1	2024-08-04 19:10:24.53433+03	confirm_cash	0
3529	1129601494	8973	1	2024-07-27 18:37:15.573419+03	confirm_cash	0
3302	1129601494	8423	1	2024-07-10 18:31:28.794925+03	confirm_cash	0
3821	1129601494	9712	1	2024-08-10 19:49:22.012854+03	confirm_cash	0
3532	1129601494	8986	1	2024-07-27 19:13:05.192119+03	expense_start	0
3824	1129601494	9728	1	2024-08-11 11:26:12.228489+03	expense_start	0
3535	276700108	8995	7	2024-07-27 20:13:47.17855+03	expense_start	0
3536	498590409	8998	3	2024-07-28 02:04:47.426796+03	expense_start	0
3313	276700108	8454	7	2024-07-11 18:58:17.006664+03	expense_start	0
3314	1129601494	8455	1	2024-07-11 19:11:12.779443+03	confirm_cash	0
3679	498590409	9371	3	2024-08-04 20:51:57.563313+03	expense_start	0
3319	1129601494	8465	1	2024-07-12 19:21:30.846899+03	confirm_cash	0
3322	1129601494	8471	1	2024-07-13 19:25:51.006266+03	confirm_cash	0
3837	498590409	9757	3	2024-08-11 21:16:31.573819+03	expense_start	0
3838	1129601494	9758	1	2024-08-11 21:16:52.397943+03	confirm_cash	0
3554	1129601494	9035	1	2024-07-28 18:25:18.730654+03	operacion_start	0
3556	1129601494	9047	1	2024-07-28 18:29:10.089526+03	expense_start	0
3427	1129601494	8733	1	2024-07-20 19:31:39.496534+03	confirm_cash	0
3561	1129601494	9061	1	2024-07-28 18:35:36.865416+03	confirm_cash	0
3341	1129601494	8510	1	2024-07-14 18:31:54.71706+03	confirm_cash	0
3699	5834993171	9431	18	2024-08-05 11:35:43.323029+03	expense_start	0
3847	276700108	9788	7	2024-08-12 14:06:25.180499+03	expense_start	0
3439	1129601494	8760	1	2024-07-21 18:30:54.473246+03	confirm_cash	0
3709	1129601494	9455	1	2024-08-05 19:05:25.037665+03	confirm_cash	0
3855	702856294	9802	2	2024-08-12 18:30:10.255502+03	confirm_report	0
3575	498590409	9111	3	2024-07-28 21:02:41.210581+03	expense_start	0
3711	498590409	9465	3	2024-08-05 20:33:43.227064+03	expense_start	0
3857	702856294	9806	2	2024-08-13 18:30:10.278308+03	confirm_report	0
3454	1129601494	8793	1	2024-07-22 18:36:59.30297+03	confirm_cash	0
3589	1129601494	9140	1	2024-07-29 18:59:30.101141+03	confirm_cash	0
3591	702856294	9145	2	2024-07-30 18:30:10.335991+03	confirm_report	0
3467	702856294	8826	2	2024-07-23 18:30:10.191377+03	confirm_report	0
3730	1129601494	9504	1	2024-08-06 18:43:52.918567+03	confirm_cash	0
3601	498590409	9173	3	2024-07-31 16:10:56.07469+03	expense_start	0
3734	276700108	9518	7	2024-08-06 20:09:41.810081+03	expense_start	0
3737	702856294	9523	2	2024-08-07 18:30:10.242943+03	confirm_report	0
3611	1129601494	9193	1	2024-07-31 18:49:41.449342+03	confirm_cash	0
3766	1129601494	9590	1	2024-08-08 19:11:35.451784+03	confirm_cash	0
3860	702856294	9815	2	2024-08-14 18:30:10.431601+03	confirm_report	0
4369	429567381	10945	26	2024-09-13 16:45:42.473986+03	expense_start	0
4375	429567381	10965	26	2024-09-13 21:58:18.81658+03	expense_start	0
4085	1129601494	10315	1	2024-08-24 18:54:33.389633+03	confirm_cash	0
4376	429567381	10968	26	2024-09-13 21:58:19.738921+03	penalty_start	0
4377	429567381	10971	26	2024-09-13 21:58:20.350552+03	expense_start	0
4227	1129601494	10639	1	2024-08-31 09:00:10.296577+03	employees_start	0
4255	1129601494	10693	1	2024-08-31 18:31:15.12814+03	confirm_cash	0
4275	1129601494	10739	1	2024-09-02 09:00:10.258474+03	employees_start	0
4285	1129601494	10763	1	2024-09-02 20:42:23.960327+03	confirm_cash	0
4292	1129601494	10777	1	2024-09-03 19:09:27.411694+03	confirm_cash	0
4299	1129601494	10795	1	2024-09-05 09:00:10.260598+03	employees_start	0
3936	498590409	9985	3	2024-08-17 17:58:19.974259+03	expense_start	0
4304	702856294	10804	2	2024-09-07 18:30:10.24277+03	confirm_report	0
3881	1129601494	9858	1	2024-08-15 18:38:50.089283+03	confirm_cash	0
4389	702856294	10993	2	2024-09-14 18:30:10.208291+03	confirm_report	0
3940	1129601494	9995	1	2024-08-17 18:33:26.046978+03	confirm_cash	0
4390	1129601494	10996	1	2024-09-15 09:00:10.230201+03	employees_start	0
4395	702856294	11005	2	2024-09-15 18:30:10.364806+03	confirm_report	0
4112	702856294	10379	2	2024-08-25 13:29:37.562731+03	operacion_start	0
4397	1129601494	11011	1	2024-09-16 09:00:10.262513+03	employees_start	0
4122	276700108	10403	7	2024-08-25 15:10:33.755709+03	expense_start	0
4123	276700108	10405	7	2024-08-25 15:10:34.022182+03	expense_start	0
4127	1129601494	10413	1	2024-08-25 18:43:47.040502+03	confirm_cash	0
4128	1129601494	10417	1	2024-08-26 09:00:10.315878+03	employees_start	0
3968	1129601494	10056	1	2024-08-18 18:31:46.937439+03	confirm_cash	0
3969	1129601494	10063	1	2024-08-19 09:00:10.193726+03	employees_start	0
4414	1129601494	11048	1	2024-09-16 18:56:05.008831+03	confirm_cash	0
4415	1129601494	11052	1	2024-09-17 09:00:10.375361+03	employees_start	0
4422	268398735	11067	22	2024-09-17 14:59:21.179786+03	edit_salary_start	0
3980	1129601494	10084	1	2024-08-19 18:31:55.705156+03	confirm_cash	0
4144	1129601494	10447	1	2024-08-26 18:31:21.304721+03	confirm_cash	0
4145	702856294	10455	2	2024-08-26 18:42:08.774672+03	operacion_start	0
3983	1129601494	10099	1	2024-08-20 09:00:10.275179+03	employees_start	0
4147	1129601494	10459	1	2024-08-27 09:00:10.190767+03	employees_start	0
4425	1129601494	11074	1	2024-09-17 18:42:53.824861+03	confirm_cash	0
4426	1129601494	11076	1	2024-09-18 09:00:10.315953+03	employees_start	0
4430	702856294	11086	2	2024-09-18 18:30:10.34841+03	confirm_report	0
4431	1129601494	11089	1	2024-09-19 09:00:10.226277+03	employees_start	0
4432	429567381	11092	26	2024-09-19 15:05:48.278085+03	expense_start	0
4433	429567381	11095	26	2024-09-19 15:06:07.497086+03	penalty_start	0
4434	429567381	11098	26	2024-09-19 15:06:48.471513+03	deposit_income_start	0
4435	429567381	11101	26	2024-09-19 15:08:43.652012+03	deposit_income_start	0
4436	429567381	11104	26	2024-09-19 15:08:46.188317+03	operacion_start	0
4437	429567381	11107	26	2024-09-19 15:08:54.314849+03	penalty_start	0
4438	429567381	11110	26	2024-09-19 15:09:00.271772+03	expense_start	0
4439	429567381	11113	26	2024-09-19 15:09:20.793799+03	deposit_income_start	0
4440	429567381	11116	26	2024-09-19 17:39:30.123775+03	deposit_income_start	0
4441	429567381	11119	26	2024-09-19 17:39:36.584548+03	penalty_start	0
4442	429567381	11122	26	2024-09-19 17:39:50.301458+03	expense_start	0
4443	429567381	11125	26	2024-09-19 17:40:18.305652+03	expense_start	0
4444	429567381	11128	26	2024-09-19 17:41:31.736856+03	penalty_start	0
4169	1129601494	10503	1	2024-08-27 18:55:08.22511+03	confirm_cash	0
4009	1129601494	10152	1	2024-08-20 18:40:37.724734+03	confirm_cash	0
4171	1129601494	10510	1	2024-08-28 09:00:10.207245+03	employees_start	0
4445	429567381	11153	26	2024-09-19 17:54:03.145544+03	deposit_income_start	0
4012	1129601494	10164	1	2024-08-20 19:43:36.468698+03	edit_salary_start	0
4013	276700108	10167	7	2024-08-20 20:47:04.194014+03	expense_start	0
4446	429567381	11156	26	2024-09-19 17:54:10.245339+03	operacion_start	0
4015	1129601494	10171	1	2024-08-21 09:00:10.212535+03	employees_start	0
4447	429567381	11159	26	2024-09-19 17:54:24.415606+03	expense_start	0
4448	429567381	11162	26	2024-09-19 17:54:33.93233+03	expense_start	0
4035	1129601494	10211	1	2024-08-21 19:33:14.888246+03	confirm_cash	0
4036	1129601494	10214	1	2024-08-22 09:00:10.340777+03	employees_start	0
4050	1129601494	10242	1	2024-08-22 18:45:37.192576+03	confirm_cash	0
4051	1129601494	10245	1	2024-08-23 09:00:10.310607+03	employees_start	0
4061	1129601494	10263	1	2024-08-23 18:32:20.776373+03	confirm_cash	0
4062	1129601494	10268	1	2024-08-24 09:00:10.286081+03	employees_start	0
4449	429567381	11165	26	2024-09-19 17:54:52.916302+03	expense_start	0
4450	429567381	11168	26	2024-09-19 17:55:16.868326+03	expense_start	0
4452	702856294	11172	2	2024-09-19 18:30:10.20762+03	confirm_report	0
5005	1129601494	12679	1	2024-10-08 18:55:20.461941+03	confirm_cash	0
4451	429567381	11171	26	2024-09-19 17:55:37.399278+03	penalty_start	0
4453	702856294	11177	2	2024-09-19 19:30:10.949479+03	confirm_report	0
4454	1129601494	11180	1	2024-09-20 09:00:10.233613+03	employees_start	0
4455	429567381	11183	26	2024-09-20 12:01:48.47619+03	operacion_start	0
4456	429567381	11186	26	2024-09-20 12:01:58.710458+03	operacion_start	0
4457	429567381	11189	26	2024-09-20 12:02:00.092028+03	expense_start	0
4458	429567381	11192	26	2024-09-20 12:02:05.243053+03	deposit_income_start	0
4459	429567381	11195	26	2024-09-20 12:02:22.626748+03	expense_start	0
4460	429567381	11198	26	2024-09-20 12:02:31.415101+03	expense_start	0
4461	429567381	11201	26	2024-09-20 12:02:40.106694+03	penalty_start	0
4462	429567381	11204	26	2024-09-20 13:31:11.275304+03	deposit_income_start	0
4463	429567381	11207	26	2024-09-20 13:31:38.808179+03	expense_start	0
4464	702856294	11208	2	2024-09-20 18:30:10.290379+03	confirm_report	0
4465	1129601494	11211	1	2024-09-21 09:00:10.243951+03	employees_start	0
5006	429567381	12684	26	2024-10-08 20:51:31.504232+03	deposit_income_start	0
5007	429567381	12687	26	2024-10-08 20:51:50.759022+03	operacion_start	0
5008	429567381	12690	26	2024-10-08 20:52:04.618392+03	deposit_income_start	0
5027	429567381	12730	27	2024-10-10 12:00:34.179914+03	deposit_income_start	0
4476	702856294	11232	2	2024-09-21 18:30:10.181782+03	confirm_report	0
4477	429567381	11239	26	2024-09-21 21:58:44.272173+03	deposit_income_start	0
4478	268398735	11242	22	2024-09-22 07:10:15.195626+03	edit_salary_start	0
4479	268398735	11245	22	2024-09-22 08:25:12.395032+03	edit_salary_start	0
4480	1129601494	11246	1	2024-09-22 09:00:10.223714+03	employees_start	0
4496	1129601494	11278	1	2024-09-22 18:33:15.414463+03	confirm_cash	0
4497	702856294	11287	2	2024-09-22 18:36:47.975686+03	operacion_start	0
4498	1129601494	11290	1	2024-09-22 18:37:22.619375+03	edit_salary_start	0
4499	429567381	11293	26	2024-09-22 20:10:24.648746+03	deposit_income_start	0
4500	429567381	11296	26	2024-09-22 20:10:33.204275+03	penalty_start	0
4501	429567381	11299	26	2024-09-22 20:10:38.426604+03	expense_start	0
4502	429567381	11302	26	2024-09-22 20:10:44.410595+03	operacion_start	0
4503	429567381	11305	26	2024-09-22 20:10:49.468318+03	expense_start	0
4504	429567381	11308	26	2024-09-22 20:10:54.817722+03	expense_start	0
4505	429567381	11311	26	2024-09-22 20:11:20.512692+03	deposit_income_start	0
4506	429567381	11314	26	2024-09-22 20:33:37.669447+03	deposit_income_start	0
4507	429567381	11317	26	2024-09-22 20:41:57.814339+03	penalty_start	0
4508	429567381	11320	26	2024-09-22 20:42:03.322143+03	expense_start	0
4509	429567381	11323	26	2024-09-22 20:42:05.361129+03	expense_start	0
4510	429567381	11326	26	2024-09-22 20:42:08.3593+03	deposit_income_start	0
4511	1129601494	11327	1	2024-09-23 09:00:10.253984+03	employees_start	0
4512	268398735	11330	22	2024-09-23 11:58:29.79593+03	edit_salary_start	0
4513	429567381	11333	26	2024-09-23 11:59:26.470234+03	penalty_start	0
4514	1129601494	11336	1	2024-09-23 12:15:10.360239+03	expense_start	0
4515	1129601494	11339	1	2024-09-23 12:16:23.569756+03	expense_start	0
4518	429567381	11346	26	2024-09-23 12:32:21.623697+03	deposit_income_start	0
4519	429567381	11351	26	2024-09-23 12:32:42.432388+03	deposit_income_start	0
4520	268398735	11354	22	2024-09-23 12:59:18.611775+03	edit_salary_start	0
4523	702856294	11361	2	2024-09-23 14:09:29.723968+03	operacion_start	0
4526	1129601494	11369	1	2024-09-23 18:54:06.873208+03	confirm_cash	0
4527	429567381	11372	26	2024-09-23 21:13:25.259075+03	deposit_income_start	0
4528	429567381	11377	26	2024-09-23 21:13:49.507531+03	deposit_income_start	0
4529	429567381	11379	26	2024-09-23 21:13:49.695671+03	expense_start	0
4530	429567381	11381	26	2024-09-23 21:13:49.880183+03	deposit_income_start	0
4531	429567381	11388	26	2024-09-23 21:15:27.708993+03	deposit_income_start	0
4532	429567381	11390	26	2024-09-23 21:15:27.905299+03	deposit_income_start	0
4533	429567381	11392	26	2024-09-23 21:15:28.14876+03	deposit_income_start	0
4534	429567381	11394	26	2024-09-23 21:15:28.42811+03	expense_start	0
4535	429567381	11396	26	2024-09-23 21:15:28.648496+03	penalty_start	0
4536	429567381	11400	26	2024-09-23 21:25:57.600782+03	deposit_income_start	0
4537	429567381	11402	26	2024-09-23 21:25:57.851867+03	deposit_income_start	0
4538	429567381	11405	26	2024-09-23 21:46:17.618649+03	deposit_income_start	0
4539	429567381	11408	26	2024-09-23 21:49:46.059667+03	deposit_income_start	0
4540	429567381	11411	26	2024-09-23 21:50:48.467062+03	operacion_start	0
4541	429567381	11414	26	2024-09-23 21:53:22.387261+03	deposit_income_start	0
4542	429567381	11417	26	2024-09-23 22:04:37.561764+03	deposit_income_start	0
4543	429567381	11421	26	2024-09-23 22:11:13.318032+03	deposit_income_start	0
4544	429567381	11423	26	2024-09-23 22:11:13.615829+03	deposit_income_start	0
4545	429567381	11427	26	2024-09-23 22:15:09.357684+03	deposit_income_start	0
4546	429567381	11429	26	2024-09-23 22:15:09.59484+03	deposit_income_start	0
4547	429567381	11432	26	2024-09-23 22:28:08.495144+03	deposit_income_start	0
4548	429567381	11435	26	2024-09-23 22:28:15.536723+03	operacion_start	0
4549	429567381	11438	26	2024-09-23 22:32:19.329666+03	deposit_income_start	0
4550	429567381	11441	26	2024-09-23 23:13:03.179492+03	operacion_start	0
4551	429567381	11444	26	2024-09-23 23:19:24.740281+03	deposit_income_start	0
4553	268398735	11449	22	2024-09-24 10:34:42.354845+03	edit_salary_start	0
4554	268398735	11452	22	2024-09-24 10:35:51.675428+03	expense_start	0
4555	429567381	11455	26	2024-09-24 17:01:38.891811+03	deposit_income_start	0
4556	429567381	11458	26	2024-09-24 17:03:09.195672+03	deposit_income_start	0
4558	702856294	11462	2	2024-09-24 18:30:10.242915+03	confirm_report	0
4559	429567381	11467	26	2024-09-24 18:38:57.763302+03	deposit_income_start	0
4560	429567381	11470	26	2024-09-24 20:22:41.397943+03	deposit_income_start	0
4561	429567381	11474	26	2024-09-24 20:23:22.311881+03	expense_start	0
4562	429567381	11476	26	2024-09-24 20:23:22.513609+03	expense_start	0
4563	429567381	11479	26	2024-09-24 20:32:16.884151+03	deposit_income_start	0
4564	429567381	11482	26	2024-09-24 20:36:41.23965+03	deposit_income_start	0
4565	429567381	11485	26	2024-09-24 20:37:09.505563+03	expense_start	0
4566	429567381	11488	26	2024-09-24 20:37:59.602545+03	expense_start	0
4567	429567381	11491	26	2024-09-24 22:05:10.946264+03	deposit_income_start	0
4568	429567381	11494	26	2024-09-24 23:57:11.217376+03	deposit_income_start	0
4569	429567381	11497	26	2024-09-25 00:02:16.767899+03	deposit_income_start	0
4570	429567381	11500	26	2024-09-25 00:02:23.710033+03	deposit_income_start	0
4571	429567381	11503	26	2024-09-25 00:16:24.853372+03	deposit_income_start	0
4574	1129601494	11512	1	2024-09-25 10:28:49.873499+03	penalty_start	0
4575	429567381	11515	26	2024-09-25 10:55:37.93922+03	deposit_income_start	0
4576	429567381	11519	26	2024-09-25 11:21:01.793551+03	deposit_income_start	0
4577	429567381	11522	26	2024-09-25 11:21:04.788682+03	operacion_start	0
4578	429567381	11525	26	2024-09-25 11:21:46.006415+03	penalty_start	0
4579	429567381	11528	26	2024-09-25 11:21:47.438894+03	expense_start	0
4580	429567381	11531	26	2024-09-25 11:25:49.202708+03	deposit_income_start	0
4581	429567381	11534	26	2024-09-25 14:03:45.196619+03	deposit_income_start	0
4582	429567381	11537	26	2024-09-25 14:06:28.329597+03	deposit_income_start	0
4583	429567381	11540	26	2024-09-25 14:06:33.914183+03	deposit_income_start	0
4584	429567381	11543	26	2024-09-25 14:08:58.976121+03	deposit_income_start	0
4585	429567381	11546	26	2024-09-25 14:09:04.053792+03	deposit_income_start	0
4590	429567381	11557	26	2024-09-25 15:15:34.245419+03	deposit_income_start	0
4591	429567381	11563	26	2024-09-25 15:26:12.654597+03	deposit_income_start	0
4592	429567381	11565	26	2024-09-25 15:26:12.934047+03	deposit_income_start	0
4593	429567381	11567	26	2024-09-25 15:26:13.16529+03	operacion_start	0
4594	429567381	11569	26	2024-09-25 15:26:13.36499+03	deposit_income_start	0
4595	429567381	11572	26	2024-09-25 15:41:34.095677+03	deposit_income_start	0
4596	429567381	11575	26	2024-09-25 15:43:05.597331+03	deposit_income_start	0
4597	429567381	11578	26	2024-09-25 15:43:55.517759+03	deposit_income_start	0
4598	429567381	11581	26	2024-09-25 15:45:27.8852+03	deposit_income_start	0
4599	429567381	11584	26	2024-09-25 15:57:29.536377+03	deposit_income_start	0
4600	429567381	11587	26	2024-09-25 16:01:23.350284+03	deposit_income_start	0
4601	429567381	11590	26	2024-09-25 16:07:59.602145+03	deposit_income_start	0
4602	429567381	11593	26	2024-09-25 16:08:11.47316+03	edit_salary_start	0
4605	429567381	11603	26	2024-09-25 17:12:59.329309+03	edit_salary_start	0
4606	429567381	11605	26	2024-09-25 17:12:59.750561+03	deposit_income_start	0
4607	429567381	11607	26	2024-09-25 17:13:00.087199+03	deposit_income_start	0
4608	429567381	11609	26	2024-09-25 17:13:00.289569+03	deposit_income_start	0
4609	429567381	11612	26	2024-09-25 17:15:22.621824+03	deposit_income_start	0
4610	429567381	11615	26	2024-09-25 17:15:47.545849+03	deposit_income_start	0
4611	429567381	11618	26	2024-09-25 17:15:49.897454+03	edit_salary_start	0
4612	429567381	11621	26	2024-09-25 17:19:29.532799+03	edit_salary_start	0
4613	429567381	11624	26	2024-09-25 17:24:44.226656+03	edit_salary_start	0
4614	429567381	11627	26	2024-09-25 17:24:45.307468+03	expense_start	0
4615	429567381	11630	26	2024-09-25 17:52:25.191171+03	deposit_income_start	0
4616	429567381	11633	26	2024-09-25 17:54:05.772171+03	edit_salary_start	0
4617	429567381	11636	26	2024-09-25 18:02:13.593737+03	deposit_income_start	0
4618	429567381	11639	26	2024-09-25 18:02:16.578182+03	edit_salary_start	0
4619	429567381	11642	26	2024-09-25 18:04:33.969699+03	deposit_income_start	0
4622	1129601494	11649	1	2024-09-25 18:41:39.801259+03	confirm_cash	0
4620	429567381	11645	26	2024-09-25 18:04:39.80801+03	edit_salary_start	0
4623	429567381	11655	26	2024-09-25 19:39:27.213905+03	deposit_income_start	0
4624	429567381	11658	26	2024-09-25 20:22:49.993791+03	deposit_income_start	0
4625	429567381	11661	26	2024-09-25 20:22:51.592661+03	edit_salary_start	0
4626	429567381	11664	26	2024-09-25 20:34:42.407109+03	edit_salary_start	0
4627	429567381	11667	26	2024-09-25 20:45:05.6096+03	deposit_income_start	0
4628	429567381	11670	26	2024-09-25 20:45:07.125116+03	edit_salary_start	0
4629	429567381	11673	26	2024-09-25 20:49:38.994265+03	expense_start	0
4630	429567381	11676	26	2024-09-25 20:58:05.369494+03	deposit_income_start	0
4631	429567381	11679	26	2024-09-25 20:58:10.083018+03	edit_salary_start	0
4632	429567381	11684	26	2024-09-25 20:58:58.673511+03	edit_salary_start	0
4633	429567381	11687	26	2024-09-25 21:08:49.269362+03	deposit_income_start	0
4634	429567381	11690	26	2024-09-25 21:08:50.883591+03	edit_salary_start	0
4635	429567381	11693	26	2024-09-25 21:12:48.245929+03	deposit_income_start	0
4636	429567381	11696	26	2024-09-25 21:12:49.665347+03	edit_salary_start	0
4637	429567381	11699	26	2024-09-25 21:45:38.277935+03	deposit_income_start	0
4638	429567381	11702	26	2024-09-25 21:45:43.301109+03	edit_salary_start	0
4639	429567381	11705	26	2024-09-25 21:46:20.912412+03	edit_salary_start	0
4640	429567381	11708	26	2024-09-25 21:58:41.881217+03	edit_salary_start	0
4641	429567381	11711	26	2024-09-25 21:58:50.238072+03	deposit_income_start	0
4642	429567381	11714	26	2024-09-26 00:53:15.632918+03	edit_salary_start	0
4643	429567381	11717	26	2024-09-26 01:04:31.49268+03	deposit_income_start	0
4644	429567381	11720	26	2024-09-26 01:04:32.960799+03	edit_salary_start	0
4645	429567381	11723	26	2024-09-26 01:07:37.992992+03	edit_salary_start	0
4648	429567381	11731	26	2024-09-26 10:17:05.400724+03	edit_salary_start	0
4649	429567381	11734	26	2024-09-26 10:18:31.299939+03	operacion_start	0
4650	429567381	11737	26	2024-09-26 10:18:38.260067+03	edit_salary_start	0
4657	1129601494	11748	1	2024-09-26 18:30:35.302351+03	confirm_cash	0
4658	276700108	11754	7	2024-09-26 18:31:36.56712+03	expense_start	0
4659	429567381	11759	26	2024-09-26 22:43:48.73729+03	edit_salary_start	0
4660	429567381	11762	26	2024-09-26 22:59:10.864096+03	edit_salary_start	0
4661	429567381	11765	26	2024-09-26 22:59:18.922932+03	deposit_income_start	0
4662	429567381	11768	26	2024-09-26 23:03:40.406213+03	deposit_income_start	0
4663	429567381	11771	26	2024-09-26 23:03:45.850059+03	edit_salary_start	0
4664	429567381	11774	26	2024-09-26 23:03:50.097781+03	expense_start	0
4665	429567381	11777	26	2024-09-26 23:03:55.4096+03	operacion_start	0
4666	429567381	11780	26	2024-09-26 23:04:00.21961+03	expense_start	0
4667	429567381	11783	26	2024-09-26 23:04:05.201131+03	penalty_start	0
4668	429567381	11786	26	2024-09-26 23:04:13.570284+03	edit_salary_start	0
4669	429567381	11789	26	2024-09-26 23:04:20.800332+03	expense_start	0
4670	429567381	11792	26	2024-09-26 23:04:24.931699+03	penalty_start	0
4671	429567381	11795	26	2024-09-26 23:04:52.327031+03	deposit_income_start	0
4672	429567381	11798	26	2024-09-26 23:04:54.290949+03	edit_salary_start	0
4673	429567381	11801	26	2024-09-26 23:08:12.293619+03	deposit_income_start	0
4674	429567381	11804	26	2024-09-26 23:08:13.5699+03	edit_salary_start	0
4675	429567381	11807	26	2024-09-26 23:56:50.988252+03	deposit_income_start	0
4676	429567381	11810	26	2024-09-26 23:56:55.210186+03	edit_salary_start	0
4677	429567381	11813	26	2024-09-26 23:57:21.639644+03	edit_salary_start	0
4678	429567381	11816	26	2024-09-26 23:58:01.663146+03	deposit_income_start	0
4679	429567381	11819	26	2024-09-26 23:58:06.551242+03	edit_salary_start	0
4680	429567381	11822	26	2024-09-26 23:58:23.084692+03	expense_start	0
4681	429567381	11825	26	2024-09-27 00:33:36.670856+03	deposit_income_start	0
4682	429567381	11828	26	2024-09-27 00:33:38.388688+03	edit_salary_start	0
4683	429567381	11831	26	2024-09-27 00:33:55.641495+03	deposit_income_start	0
4684	429567381	11834	26	2024-09-27 00:33:56.736107+03	edit_salary_start	0
4685	429567381	11837	26	2024-09-27 00:37:34.529397+03	edit_salary_start	0
4686	429567381	11840	26	2024-09-27 00:37:45.533077+03	deposit_income_start	0
4687	429567381	11843	26	2024-09-27 00:39:22.987872+03	edit_salary_start	0
4688	429567381	11848	26	2024-09-27 00:44:30.361263+03	edit_salary_start	0
4689	429567381	11851	26	2024-09-27 00:45:57.733946+03	expense_start	0
4690	429567381	11854	26	2024-09-27 00:45:59.989625+03	edit_salary_start	0
4691	429567381	11857	26	2024-09-27 00:46:14.201318+03	expense_start	0
4692	429567381	11860	26	2024-09-27 00:46:16.386136+03	edit_salary_start	0
4693	429567381	11863	26	2024-09-27 00:47:34.124572+03	deposit_income_start	0
4694	429567381	11866	26	2024-09-27 00:47:36.13688+03	edit_salary_start	0
4695	429567381	11869	26	2024-09-27 00:50:18.221928+03	deposit_income_start	0
4696	429567381	11872	26	2024-09-27 00:50:19.842816+03	edit_salary_start	0
4697	429567381	11875	26	2024-09-27 00:50:28.612968+03	penalty_start	0
4698	429567381	11878	26	2024-09-27 00:50:33.185411+03	expense_start	0
4699	429567381	11881	26	2024-09-27 00:50:43.721543+03	penalty_start	0
4700	429567381	11884	26	2024-09-27 00:50:49.427704+03	operacion_start	0
4701	429567381	11887	26	2024-09-27 00:50:54.223379+03	expense_start	0
4702	429567381	11890	26	2024-09-27 00:50:58.681942+03	expense_start	0
4703	429567381	11893	26	2024-09-27 00:51:03.054126+03	deposit_income_start	0
4704	429567381	11896	26	2024-09-27 00:51:10.416796+03	edit_salary_start	0
4705	429567381	11899	26	2024-09-27 00:56:07.862504+03	edit_salary_start	0
4706	429567381	11902	26	2024-09-27 00:57:29.929282+03	edit_salary_start	0
4707	429567381	11905	26	2024-09-27 01:46:44.971976+03	edit_salary_start	0
4708	429567381	11908	26	2024-09-27 01:58:52.447078+03	edit_salary_start	0
4709	429567381	11911	26	2024-09-27 02:18:50.857376+03	deposit_income_start	0
4710	429567381	11914	26	2024-09-27 02:18:51.960307+03	edit_salary_start	0
4711	429567381	11917	26	2024-09-27 02:19:57.402742+03	edit_salary_start	0
4712	429567381	11920	26	2024-09-27 02:20:32.335295+03	edit_salary_start	0
4713	429567381	11923	26	2024-09-27 02:21:20.43066+03	edit_salary_start	0
4715	429567381	11927	26	2024-09-27 11:38:45.076328+03	edit_salary_start	0
4716	429567381	11930	26	2024-09-27 11:44:15.632311+03	deposit_income_start	0
4717	429567381	11933	26	2024-09-27 11:44:28.889826+03	edit_salary_start	0
4718	429567381	11936	26	2024-09-27 11:48:31.594166+03	edit_salary_start	0
4719	429567381	11939	26	2024-09-27 11:48:37.278191+03	deposit_income_start	0
4720	429567381	11942	26	2024-09-27 11:48:43.801862+03	edit_salary_start	0
4721	429567381	11945	26	2024-09-27 11:54:55.819098+03	edit_salary_start	0
4722	429567381	11948	26	2024-09-27 11:55:05.397819+03	deposit_income_start	0
4723	429567381	11951	26	2024-09-27 11:55:09.687642+03	operacion_start	0
4724	429567381	11954	26	2024-09-27 11:57:22.632704+03	edit_salary_start	0
4725	429567381	11957	26	2024-09-27 11:58:12.757764+03	edit_salary_start	0
4726	429567381	11960	26	2024-09-27 11:58:34.328864+03	edit_salary_start	0
4727	429567381	11967	26	2024-09-27 12:01:00.300146+03	edit_salary_start	0
4728	429567381	11970	26	2024-09-27 12:02:30.321624+03	deposit_income_start	0
4729	429567381	11973	26	2024-09-27 12:02:40.336573+03	operacion_start	0
4730	429567381	11976	26	2024-09-27 12:02:44.530881+03	expense_start	0
4731	429567381	11979	26	2024-09-27 12:02:50.375762+03	expense_start	0
4732	429567381	11989	26	2024-09-27 12:08:50.421492+03	deposit_income_start	0
4733	429567381	11991	26	2024-09-27 12:08:50.628093+03	deposit_income_start	0
4734	429567381	11993	26	2024-09-27 12:08:50.802632+03	deposit_income_start	0
4735	429567381	11995	26	2024-09-27 12:08:51.004796+03	expense_start	0
4736	429567381	11997	26	2024-09-27 12:08:51.183251+03	deposit_income_start	0
4737	429567381	11999	26	2024-09-27 12:08:51.367269+03	operacion_start	0
4738	429567381	12001	26	2024-09-27 12:08:51.549411+03	expense_start	0
4739	429567381	12003	26	2024-09-27 12:08:51.724978+03	deposit_income_start	0
4740	429567381	12006	26	2024-09-27 12:08:57.865844+03	edit_salary_start	0
4741	429567381	12009	26	2024-09-27 12:10:42.256087+03	penalty_start	0
4742	429567381	12012	26	2024-09-27 12:10:46.707104+03	operacion_start	0
4743	429567381	12015	26	2024-09-27 12:10:52.848255+03	deposit_income_start	0
4744	429567381	12018	26	2024-09-27 12:10:56.49997+03	expense_start	0
4745	429567381	12021	26	2024-09-27 12:11:00.435635+03	expense_start	0
4746	429567381	12024	26	2024-09-27 12:11:05.488303+03	penalty_start	0
4747	429567381	12027	26	2024-09-27 12:43:27.037423+03	deposit_income_start	0
4748	429567381	12030	26	2024-09-27 12:44:40.508732+03	edit_salary_start	0
5032	429567381	12741	27	2024-10-10 16:00:58.963968+03	edit_salary_start	0
4752	429567381	12041	26	2024-09-27 14:35:25.768375+03	edit_salary_start	0
4753	429567381	12044	26	2024-09-27 14:37:12.769481+03	edit_salary_start	0
4754	429567381	12047	26	2024-09-27 14:38:24.16206+03	expense_start	0
4755	429567381	12050	26	2024-09-27 14:49:54.080385+03	edit_salary_start	0
4756	429567381	12053	26	2024-09-27 14:50:42.066851+03	edit_salary_start	0
4757	429567381	12056	26	2024-09-27 14:51:30.267641+03	operacion_start	0
4758	429567381	12059	26	2024-09-27 14:51:31.723456+03	edit_salary_start	0
4762	429567381	12067	26	2024-09-27 17:40:26.563828+03	edit_salary_start	0
4763	429567381	12070	26	2024-09-27 18:14:40.237521+03	expense_start	0
4764	429567381	12073	26	2024-09-27 18:15:50.480459+03	operacion_start	0
4765	429567381	12076	26	2024-09-27 18:19:09.40252+03	edit_salary_start	0
4766	429567381	12079	26	2024-09-27 18:19:18.023686+03	deposit_income_start	0
4767	429567381	12082	26	2024-09-27 18:19:29.522144+03	operacion_start	0
4768	429567381	12085	26	2024-09-27 18:19:34.994569+03	expense_start	0
4770	1129601494	12087	1	2024-09-27 18:31:29.783307+03	confirm_cash	0
4771	429567381	12091	26	2024-09-27 18:35:00.676923+03	expense_start	0
4772	429567381	12096	26	2024-09-27 18:35:11.012863+03	edit_salary_start	0
4773	429567381	12099	26	2024-09-27 18:39:45.015181+03	deposit_income_start	0
4774	429567381	12102	26	2024-09-27 18:39:46.663706+03	edit_salary_start	0
4775	429567381	12105	26	2024-09-27 18:40:55.997455+03	deposit_income_start	0
4776	429567381	12108	26	2024-09-27 18:41:05.587244+03	operacion_start	0
4777	429567381	12111	26	2024-09-27 18:41:10.708934+03	edit_salary_start	0
4778	429567381	12114	26	2024-09-27 18:41:38.090966+03	deposit_income_start	0
4779	429567381	12117	26	2024-09-27 18:41:39.47745+03	edit_salary_start	0
4780	429567381	12120	26	2024-09-27 18:41:50.825944+03	edit_salary_start	0
4781	429567381	12123	26	2024-09-27 18:42:48.854569+03	edit_salary_start	0
4782	429567381	12126	26	2024-09-27 18:43:53.026847+03	edit_salary_start	0
4783	429567381	12129	26	2024-09-27 18:44:48.154493+03	edit_salary_start	0
4784	429567381	12132	26	2024-09-27 18:45:54.24685+03	deposit_income_start	0
4785	429567381	12135	26	2024-09-27 18:47:12.653202+03	edit_salary_start	0
4786	429567381	12138	26	2024-09-27 18:50:24.437332+03	edit_salary_start	0
4787	429567381	12141	26	2024-09-27 18:51:50.432655+03	edit_salary_start	0
4788	429567381	12144	26	2024-09-27 18:52:05.840561+03	edit_salary_start	0
4789	429567381	12147	26	2024-09-27 18:53:07.106906+03	deposit_income_start	0
4790	429567381	12150	26	2024-09-27 18:53:08.360147+03	edit_salary_start	0
4791	429567381	12153	26	2024-09-27 18:53:22.766354+03	edit_salary_start	0
4792	429567381	12156	26	2024-09-27 18:53:47.052413+03	edit_salary_start	0
4793	429567381	12159	26	2024-09-27 18:53:53.860179+03	edit_salary_start	0
4794	429567381	12162	26	2024-09-27 18:54:09.339572+03	penalty_start	0
4795	429567381	12165	26	2024-09-27 18:54:14.270665+03	edit_salary_start	0
4796	429567381	12168	26	2024-09-27 18:55:46.909951+03	edit_salary_start	0
4797	429567381	12171	26	2024-09-27 18:56:28.181173+03	edit_salary_start	0
4798	429567381	12174	26	2024-09-27 19:00:23.686529+03	edit_salary_start	0
4799	429567381	12177	26	2024-09-27 19:00:59.659597+03	edit_salary_start	0
4800	429567381	12180	26	2024-09-27 19:01:12.625795+03	edit_salary_start	0
4801	429567381	12183	26	2024-09-27 19:01:27.140661+03	deposit_income_start	0
4802	429567381	12186	26	2024-09-27 19:02:15.7722+03	edit_salary_start	0
4803	429567381	12189	26	2024-09-27 19:02:24.589397+03	deposit_income_start	0
4804	429567381	12192	26	2024-09-27 19:02:53.393907+03	operacion_start	0
4805	429567381	12195	26	2024-09-27 19:03:06.856036+03	edit_salary_start	0
4806	429567381	12198	26	2024-09-27 19:03:32.967089+03	edit_salary_start	0
4807	429567381	12201	26	2024-09-27 19:04:31.788691+03	edit_salary_start	0
4808	429567381	12204	26	2024-09-27 19:04:42.815071+03	edit_salary_start	0
4809	429567381	12207	26	2024-09-27 19:04:48.750737+03	edit_salary_start	0
4810	429567381	12210	26	2024-09-27 19:04:59.855754+03	edit_salary_start	0
4811	429567381	12213	26	2024-09-27 19:07:27.913648+03	edit_salary_start	0
4812	429567381	12216	26	2024-09-27 19:09:06.565998+03	edit_salary_start	0
4813	429567381	12219	26	2024-09-27 19:09:15.368671+03	deposit_income_start	0
4814	429567381	12222	26	2024-09-27 19:09:16.486653+03	operacion_start	0
4815	429567381	12225	26	2024-09-27 19:09:16.972026+03	expense_start	0
4816	429567381	12228	26	2024-09-27 19:09:18.923563+03	edit_salary_start	0
4817	429567381	12231	26	2024-09-27 19:09:35.179898+03	edit_salary_start	0
4818	429567381	12234	26	2024-09-27 19:43:42.676096+03	edit_salary_start	0
4819	429567381	12237	26	2024-09-27 19:43:49.634583+03	expense_start	0
4820	429567381	12240	26	2024-09-27 19:43:50.711909+03	edit_salary_start	0
4821	429567381	12243	26	2024-09-27 19:43:56.699238+03	deposit_income_start	0
4822	429567381	12246	26	2024-09-27 19:44:01.313197+03	edit_salary_start	0
4823	429567381	12249	26	2024-09-27 19:44:27.074851+03	edit_salary_start	0
4824	429567381	12252	26	2024-09-27 19:44:43.460199+03	edit_salary_start	0
4825	429567381	12255	26	2024-09-27 19:50:46.63837+03	expense_start	0
4826	429567381	12258	26	2024-09-27 19:50:48.525307+03	edit_salary_start	0
4827	429567381	12261	26	2024-09-27 19:52:23.247145+03	edit_salary_start	0
4828	429567381	12264	26	2024-09-27 19:53:02.760245+03	deposit_income_start	0
4829	429567381	12267	26	2024-09-27 19:53:09.464922+03	edit_salary_start	0
4830	429567381	12270	26	2024-09-27 19:54:59.259401+03	expense_start	0
4831	429567381	12273	26	2024-09-27 19:55:00.693539+03	edit_salary_start	0
4832	429567381	12276	26	2024-09-27 19:57:04.929014+03	expense_start	0
4833	429567381	12279	26	2024-09-27 19:57:06.412721+03	edit_salary_start	0
4834	429567381	12282	26	2024-09-27 19:59:13.725143+03	edit_salary_start	0
4835	429567381	12285	26	2024-09-27 20:33:16.600402+03	penalty_start	0
4836	429567381	12288	26	2024-09-27 20:35:05.231097+03	edit_salary_start	0
4837	429567381	12291	26	2024-09-27 20:35:41.814167+03	deposit_income_start	0
4838	429567381	12294	26	2024-09-27 20:36:23.022926+03	edit_salary_start	0
4839	429567381	12297	26	2024-09-27 20:36:30.767073+03	deposit_income_start	0
4840	429567381	12300	26	2024-09-27 20:36:32.218829+03	penalty_start	0
4841	429567381	12303	26	2024-09-27 20:36:37.829375+03	edit_salary_start	0
4842	429567381	12306	26	2024-09-27 20:36:50.532233+03	edit_salary_start	0
4843	429567381	12309	26	2024-09-27 20:38:01.285382+03	deposit_income_start	0
4844	429567381	12312	26	2024-09-27 20:38:08.572939+03	edit_salary_start	0
4845	429567381	12315	26	2024-09-27 20:43:11.932776+03	edit_salary_start	0
4846	429567381	12318	26	2024-09-27 20:43:26.941781+03	deposit_income_start	0
4847	429567381	12321	26	2024-09-27 20:43:28.928599+03	edit_salary_start	0
4848	429567381	12324	26	2024-09-27 20:44:01.330903+03	expense_start	0
4849	429567381	12327	26	2024-09-27 20:44:02.597858+03	edit_salary_start	0
4850	429567381	12330	26	2024-09-27 20:44:13.52165+03	penalty_start	0
4851	429567381	12333	26	2024-09-27 20:44:19.335447+03	expense_start	0
4852	429567381	12336	26	2024-09-27 20:44:26.235943+03	expense_start	0
4853	429567381	12339	26	2024-09-27 20:44:31.097258+03	expense_start	0
4854	429567381	12342	26	2024-09-27 20:45:11.359988+03	edit_salary_start	0
4855	429567381	12345	26	2024-09-27 20:45:17.328813+03	expense_start	0
4856	429567381	12348	26	2024-09-27 20:45:22.144025+03	penalty_start	0
4857	429567381	12351	26	2024-09-27 20:45:27.843305+03	penalty_start	0
4858	429567381	12354	26	2024-09-27 20:47:06.991445+03	expense_start	0
4859	429567381	12357	26	2024-09-27 20:47:08.55474+03	edit_salary_start	0
4860	429567381	12360	26	2024-09-27 22:12:09.353838+03	edit_salary_start	0
4881	1129601494	12402	1	2024-09-28 18:47:14.59408+03	confirm_cash	0
4882	429567381	12406	26	2024-09-28 20:36:34.51156+03	edit_salary_start	0
4883	429567381	12409	26	2024-09-28 20:36:46.422553+03	expense_start	0
4884	429567381	12412	26	2024-09-28 20:37:00.703938+03	edit_salary_start	0
4885	429567381	12415	26	2024-09-28 20:38:03.978837+03	edit_salary_start	0
4886	429567381	12418	26	2024-09-28 20:38:21.789109+03	penalty_start	0
4887	429567381	12421	26	2024-09-28 20:39:46.55265+03	edit_salary_start	0
4888	429567381	12424	26	2024-09-28 20:40:12.099236+03	edit_salary_start	0
4889	429567381	12427	26	2024-09-28 20:54:18.958909+03	edit_salary_start	0
4890	429567381	12430	26	2024-09-28 20:57:33.468199+03	edit_salary_start	0
4891	429567381	12433	26	2024-09-28 21:15:55.374765+03	edit_salary_start	0
4892	429567381	12436	26	2024-09-28 21:16:22.668501+03	deposit_income_start	0
4893	429567381	12439	26	2024-09-28 21:16:34.862036+03	edit_salary_start	0
4894	429567381	12442	26	2024-09-28 21:16:58.480927+03	operacion_start	0
4895	429567381	12445	26	2024-09-28 21:17:03.262742+03	penalty_start	0
4896	429567381	12448	26	2024-09-28 21:17:10.385279+03	edit_salary_start	0
4909	1129601494	12472	1	2024-09-29 18:30:45.767508+03	confirm_cash	0
5033	702856294	12742	2	2024-10-10 18:30:10.247289+03	confirm_report	0
4917	429567381	12493	26	2024-09-30 15:33:55.16522+03	deposit_income_start	0
4918	429567381	12496	26	2024-09-30 17:31:43.277573+03	deposit_income_start	0
4919	429567381	12502	26	2024-09-30 18:22:42.787599+03	deposit_income_start	0
4920	429567381	12504	26	2024-09-30 18:22:42.987828+03	deposit_income_start	0
4921	429567381	12506	26	2024-09-30 18:22:43.21796+03	operacion_start	0
4922	429567381	12508	26	2024-09-30 18:22:43.411318+03	edit_salary_start	0
5034	702856294	12745	2	2024-10-10 18:33:36.654768+03	deposit_income_start	0
4924	429567381	12512	26	2024-09-30 19:06:41.562837+03	deposit_income_start	0
4925	1129601494	12513	1	2024-09-30 19:14:38.360706+03	confirm_cash	0
4927	702856294	12517	2	2024-10-01 18:30:10.288687+03	confirm_report	0
4933	702856294	12528	2	2024-10-02 18:30:10.284665+03	confirm_report	0
4940	1129601494	12540	1	2024-10-03 19:01:01.75698+03	confirm_cash	0
4942	429567381	12547	26	2024-10-04 11:01:24.296566+03	edit_salary_start	0
4945	702856294	12555	2	2024-10-04 18:30:10.35736+03	confirm_report	0
4953	702856294	12570	2	2024-10-05 18:30:10.310644+03	confirm_report	0
4979	1129601494	12623	1	2024-10-06 18:52:24.663186+03	confirm_cash	0
4987	268398735	12644	22	2024-10-07 15:29:15.087029+03	deposit_income_start	0
4988	268398735	12647	22	2024-10-07 15:29:17.055494+03	deposit_income_start	0
4996	1129601494	12661	1	2024-10-07 19:12:13.702139+03	confirm_cash	0
\.


--
-- Data for Name: oil_coefs; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.oil_coefs (id, date_coef, type_technique_id, coef, created_at) FROM stdin;
1	2024-01-01	1	500	\N
\.


--
-- Data for Name: operations; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.operations (id, date_operation, operation_id, type_technique_id, canisters, amount, cost_fuel, technique_id, description, archive, source_id, fuel_operation_id, created_at) FROM stdin;
699	2024-02-09	6	0	\N	\N	0	13	Бензонасос нужен новый	f	1	\N	\N
710	2024-02-13	4	0	0	3000	0	13	2 рулевые тяги	f	1	\N	\N
673	2024-02-04	6	0	0	0	0	9	Сначала писал как небольшая поломка. Сломан руль грубо говоря. Бирюзовый 	f	1	\N	\N
702	2024-02-10	4	0	\N	10660	0	8		f	1	\N	\N
711	2024-02-14	7	0	0	0	0	11	Надо срочно поменять масло и посмотреть тяги	f	1	\N	\N
703	2024-02-10	5	2	\N	3000	0	0	За выезд, подкрутил 3 сокола	f	1	\N	\N
704	2024-02-10	5	2	\N	8000	0	0	Починили мост на Умаровском. Сокол 2	f	1	\N	\N
674	2024-02-04	5	2	0	3000	0	0		f	1	\N	\N
683	2024-02-08	6	0	\N	\N	0	3	Пружина сломалась, подвеска	f	1	\N	\N
685	2024-02-08	5	1	\N	3000	0	0	3 снежинка отрегулировал, 1 оживил и прикрутил бак соколу	f	1	\N	\N
712	2024-02-14	6	0	0	0	0	11	Не крутится правое колесо	f	1	\N	\N
661	2024-02-03	4	0	0	2340	0	13	Бензонасос. Из кассы	f	1	\N	\N
686	2024-02-08	6	0	\N	\N	0	4	Порвался ремень 	f	1	\N	\N
705	2024-02-01	5	1	\N	8000	\N	\N	\N	f	2	\N	\N
713	2024-02-16	8	0	0	0	0	13	Починили тягу	f	1	\N	\N
714	2024-02-16	8	0	0	0	0	11	Ручка газа и то что одно колесо не крутилось	f	1	\N	\N
715	2024-02-16	5	2	0	7000	0	0	Починили сокол 7 и сокол 5	f	1	\N	\N
716	2024-02-16	4	0	0	2500	0	13		f	1	\N	\N
717	2024-02-16	4	0	0	2500	0	11		f	1	\N	\N
678	2024-02-05	4	0	0	10660	0	8		f	1	\N	\N
706	2024-02-10	5	1	\N	2000	0	0	Ремонт ручного стартера на белом Ахматовском снежике	f	1	\N	\N
665	2024-02-03	7	0	0	0	0	39	Пластик спереди. Ударился об другой снежик	f	1	\N	\N
666	2024-02-03	7	0	0	0	0	40	Пластик спереди. Ударился об снежик	f	1	\N	\N
679	2024-02-07	5	1	\N	5000	0	0	Снегоход самата	f	1	\N	\N
618	2024-01-24	5	1	\N	4000	\N	\N	\N	f	2	\N	\N
619	2024-01-27	5	2	\N	13000	\N	\N	\N	f	2	\N	\N
620	2024-01-29	5	1	\N	11500	\N	\N	\N	f	2	\N	\N
667	2024-02-03	6	0	0	0	0	9	Бирюзовый. Сломался руль	f	1	\N	\N
680	2024-02-07	6	0	\N	\N	0	1	Сломалась лыжа	f	1	\N	\N
692	2024-02-09	4	0	\N	10000	0	4		f	1	\N	\N
693	2024-02-09	4	0	\N	10000	0	6	Запасной ремень вариатора	f	1	\N	\N
628	2024-01-07	2	2	2	\N	2212.42857142857	\N	\N	f	2	627	\N
633	2024-01-14	2	2	3	\N	3318.45	\N	\N	f	2	631	\N
635	2024-01-15	2	2	2	\N	2212.3	\N	\N	f	2	631	\N
639	2024-01-18	1	\N	33	36500	1106.06060606061	\N	\N	f	2	\N	\N
642	2024-01-21	2	1	3	\N	4818.18181818182	\N	\N	f	2	639	\N
643	2024-01-21	2	2	3	\N	3318.18181818182	\N	\N	f	2	639	\N
647	2024-01-24	2	2	3	\N	3318.18181818182	\N	\N	f	2	639	\N
651	2024-01-26	2	1	4	\N	6424	\N	\N	f	2	648	\N
652	2024-01-26	2	2	3	\N	3318	\N	\N	f	2	648	\N
654	2024-01-27	2	2	4	\N	4424	\N	\N	f	2	648	\N
668	2024-01-31	2	1	3	0	4820.68965517241	0	\N	f	1	657	\N
655	2024-01-28	2	1	11	\N	17675.8620689655	\N	\N	f	2	657	\N
669	2024-02-01	2	2	3	0	3320.68965517241	0	\N	f	1	657	\N
671	2024-02-02	2	2	5	0	5534.48275862069	0	\N	f	1	657	\N
681	2024-02-07	2	1	4	\N	6429.05882352941	0	\N	f	1	672	\N
675	2024-02-04	2	2	3	0	3321.79411764706	0	\N	f	1	672	\N
682	2024-02-08	2	1	6	\N	9643.58823529412	0	\N	f	1	672	\N
690	2024-02-09	1	0	28	30968	1106	0	\N	f	1	\N	\N
700	2024-02-09	2	1	5	\N	8030	0	\N	f	1	690	\N
688	2024-02-09	2	2	1	\N	1106	0	\N	f	1	690	\N
709	2024-02-11	2	1	6	\N	9636	0	\N	f	1	690	\N
611	2024-01-01	1	\N	40	44240	1106	\N	\N	f	1	\N	\N
621	2024-01-01	2	2	8	\N	8848	\N	\N	f	2	611	\N
617	2024-01-01	2	3	8	\N	8848	\N	\N	f	2	611	\N
623	2024-01-06	1	\N	25	29276	1171.04	\N	\N	f	2	\N	\N
625	2024-01-06	2	3	3	\N	3513.12	\N	\N	f	2	623	\N
627	2024-01-07	1	\N	28	30974	1106.21428571429	\N	\N	f	2	\N	\N
629	2024-01-07	2	3	5	\N	5531.07142857143	\N	\N	f	2	627	\N
630	2024-01-07	2	1	21	\N	33730.5	\N	\N	f	2	627	\N
631	2024-01-13	1	\N	20	22123	1106.15	\N	\N	f	2	\N	\N
634	2024-01-14	2	3	2	\N	2212.3	\N	\N	f	2	631	\N
632	2024-01-14	2	1	2	\N	3212.3	\N	\N	f	2	631	\N
636	2024-01-15	2	1	4	\N	6424.6	\N	\N	f	2	631	\N
637	2024-01-16	2	2	2	\N	2212.3	\N	\N	f	2	631	\N
638	2024-01-16	2	1	5	\N	8030.75	\N	\N	f	2	631	\N
640	2024-01-19	2	1	10	\N	16060.6060606061	\N	\N	f	2	639	\N
644	2024-01-22	2	3	1	\N	1106.06060606061	\N	\N	f	2	639	\N
645	2024-01-22	2	2	6	\N	6636.36363636364	\N	\N	f	2	639	\N
646	2024-01-23	2	1	2	\N	3212.12121212121	\N	\N	f	2	639	\N
648	2024-01-25	1	\N	35	38710	1106	\N	\N	f	2	\N	\N
650	2024-01-25	2	3	1	\N	1106	\N	\N	f	2	648	\N
649	2024-01-25	2	1	7	\N	11242	\N	\N	f	2	648	\N
653	2024-01-27	2	1	1	\N	1606	\N	\N	f	2	648	\N
657	2024-01-28	1	\N	29	32100	1106.89655172414	\N	\N	f	2	\N	\N
659	2024-01-28	2	2	3	\N	3318	\N	\N	f	2	648	\N
656	2024-01-28	2	2	4	\N	4424	\N	\N	f	2	648	\N
658	2024-01-28	2	1	8	\N	12848	\N	\N	f	2	648	\N
670	2024-02-01	2	1	7	0	11248.275862069	0	\N	f	1	657	\N
677	2024-02-04	2	1	4	0	6429.05882352941	0	\N	f	1	672	\N
676	2024-02-04	2	1	4	0	6429.05882352941	0	\N	f	1	672	\N
689	2024-02-09	2	2	1	\N	1106	0	\N	f	1	690	\N
691	2024-02-09	2	3	1	\N	1106	0	\N	f	1	690	\N
687	2024-02-09	2	1	13	\N	20894.4411764706	0	\N	f	1	672	\N
701	2024-02-10	2	2	2	\N	2212	0	\N	f	1	690	\N
707	2024-02-11	2	2	2	\N	2212	0	\N	f	1	690	\N
708	2024-02-11	2	1	9	\N	14454	0	\N	f	1	690	\N
694	2024-02-09	4	0	\N	9000	0	1	Лыжа	f	1	\N	\N
695	2024-02-09	4	0	\N	5500	0	3	Пружина	f	1	\N	\N
696	2024-02-09	4	0	\N	4600	0	4	Тросик 	f	1	\N	\N
697	2024-02-09	4	0	\N	4600	0	5	Тросик 	f	1	\N	\N
698	2024-02-09	4	0	\N	4600	0	39	Тросик 	f	1	\N	\N
718	2024-02-17	4	0	0	1960	0	13	Шпильки, суппорт, тормозная жидкость	f	1	\N	2024-02-17 14:22:40.706435+03
719	2024-02-17	5	2	0	8000	0	0		f	1	\N	2024-02-17 14:23:51.391012+03
720	2024-02-17	8	0	0	0	0	5	Заменили моторное масло сами 	f	1	\N	2024-02-17 14:25:21.694139+03
721	2024-02-22	6	0	0	0	0	39	Порвался ремень	f	1	\N	2024-02-22 14:47:28.28463+03
724	2024-02-22	6	0	0	0	0	13	Сломалась тяга	f	1	\N	2024-02-24 09:51:31.021757+03
725	2024-02-24	8	0	0	0	0	13	Тимур починил тягу	f	1	\N	2024-02-24 09:52:05.034512+03
726	2024-02-24	5	3	0	1000	0	0	За починку 7 сокола отдали Тимуру	f	1	\N	2024-02-24 09:52:43.437704+03
727	2024-02-25	6	0	0	0	0	13	Сломался радиатор 	f	1	\N	2024-02-25 10:01:39.629479+03
728	2024-02-25	6	0	0	0	0	12	Колесо постоянно спускает	f	1	\N	2024-02-25 10:24:39.435954+03
729	2024-02-25	6	0	0	0	0	11	Сломалась ресора	f	1	\N	2024-02-25 16:36:35.146344+03
730	2024-02-26	6	0	0	0	0	39	Порвался ремень	f	1	\N	2024-02-26 15:46:34.015485+03
731	2024-02-26	6	0	0	0	0	51	Порвался ремень	f	1	\N	2024-02-26 15:47:29.70259+03
732	2024-02-28	4	0	0	5060	0	11	Купили ресору	f	1	\N	2024-02-28 11:38:41.557645+03
733	2024-02-28	5	2	0	8000	0	0	Тимур починил радиатор на розовом (7), ресор на бирюзовый (5), тягу на бирюзовом (4).	f	1	\N	2024-02-28 18:42:21.504912+03
734	2024-02-29	5	1	0	5000	0	0	В зеленчуке починили 6 и 7	f	1	\N	2024-02-29 16:00:55.838389+03
735	2024-02-29	5	1	0	8000	0	0	За эвакуатор, 6 и 7 снежики	f	1	\N	2024-02-29 20:45:59.965366+03
739	2024-02-29	6	0	0	0	0	39	Го\nДжо	f	1	\N	2024-02-29 20:47:54.350895+03
740	2024-02-29	7	0	0	0	0	39	Со мной воюет сатана	f	1	\N	2024-02-29 20:48:27.378841+03
741	2024-02-29	8	0	0	0	0	39	Годжо воскрес	f	1	\N	2024-02-29 20:48:45.119521+03
746	2024-02-29	6	0	0	0	0	39		f	1	\N	2024-02-29 21:45:56.647202+03
747	2024-02-29	7	0	0	0	0	39		f	1	\N	2024-02-29 21:46:18.915614+03
748	2024-02-29	8	0	0	0	0	39		f	1	\N	2024-02-29 21:46:30.835714+03
750	2024-03-01	5	1	0	10000	0	0	На эвакуатор в обе стороны, 2 сергеевских и 1 ахматовский	f	1	\N	2024-03-01 18:17:57.342866+03
751	2024-03-02	4	0	0	25000	0	40	Белый ахматовский	f	1	\N	2024-03-02 12:45:39.461518+03
622	2024-01-01	2	1	24	\N	38544	\N	\N	f	2	611	\N
752	2024-03-03	7	0	0	0	0	40	Не заводится Ахматовский жёлтый стелс 	f	1	\N	2024-03-03 17:31:30.538951+03
753	2024-03-03	7	0	0	0	0	11	Нет одного болта на колесе	f	1	\N	2024-03-03 18:12:15.787661+03
754	2024-03-05	6	0	0	0	0	10		f	1	\N	2024-03-05 18:10:25.616792+03
755	2024-03-06	6	0	0	0	0	11	Ресора сломалась	f	1	\N	2024-03-06 09:50:17.025138+03
756	2024-03-07	4	0	0	4640	0	11		f	1	\N	2024-03-07 10:44:43.254376+03
757	2024-03-07	4	0	0	4640	0	10		f	1	\N	2024-03-07 10:45:12.118795+03
758	2024-03-07	4	0	0	4640	0	10		f	1	\N	2024-03-07 10:45:16.055214+03
759	2024-03-07	4	0	0	500	0	9		f	1	\N	2024-03-07 10:48:25.821446+03
760	2024-03-08	8	0	0	0	0	10		f	1	\N	2024-03-08 12:32:22.788846+03
761	2024-03-08	8	0	0	0	0	11		f	1	\N	2024-03-08 12:32:32.179429+03
762	2024-03-08	8	0	0	0	0	13		f	1	\N	2024-03-08 12:32:43.259428+03
763	2024-03-09	5	2	0	10000	0	0		f	1	\N	2024-03-09 18:51:54.267094+03
765	2024-03-11	8	0	0	0	0	39	В зеленчуке починили	f	1	\N	2024-03-11 16:27:48.026743+03
766	2024-03-13	6	0	0	0	0	13	Тросик газа оторвался 	f	1	\N	2024-03-13 13:39:17.325667+03
769	2024-03-15	5	1	0	2000	0	0	За выезд из зеленчука	f	1	\N	2024-03-15 16:04:36.283372+03
770	2024-03-16	8	0	0	0	0	13	Починили газ тросик	f	1	\N	2024-03-16 16:46:41.752474+03
771	2024-03-16	5	2	0	500	0	0	Починили розовый. Тимур	f	1	\N	2024-03-16 16:47:43.613676+03
772	2024-03-19	6	0	0	0	0	9	Сразу глохнет. Привезли его с белых	f	1	\N	2024-03-19 16:22:04.212352+03
773	2024-03-21	6	0	0	0	0	13	Сломалась ресора	f	1	\N	2024-03-21 12:56:13.822618+03
774	2024-03-21	8	0	0	0	0	9	Приехали с зеленчука, поменяли бензонасос 	f	1	\N	2024-03-21 13:45:40.074613+03
775	2024-03-21	5	2	0	2000	0	0	Тимур починил 7 сокол	f	1	\N	2024-03-21 16:13:26.823755+03
776	2024-03-21	8	0	0	0	0	13	Уже написал 	f	1	\N	2024-03-21 16:13:51.300349+03
777	2024-03-21	4	0	0	3000	0	9	Бензонасос 	f	1	\N	2024-03-21 17:45:24.761669+03
779	2024-03-21	5	3	0	6000	0	0	1к за выезд 5 за диагностику квадриков	f	1	\N	2024-03-21 17:49:40.551143+03
780	2024-03-21	4	0	0	1000	0	50	За замену бензонасоса	f	1	\N	2024-03-21 17:52:31.379616+03
781	2024-03-23	8	0	0	0	0	12	Залатали колесо и поставили на место 	f	1	\N	2024-03-23 15:07:36.690075+03
624	2024-01-06	2	1	18	\N	30078.72	\N	\N	f	2	623	\N
784	2024-03-05	2	1	2	0	3227.1724137931	0	\N	f	1	810	2024-03-24 12:58:22.464893+03
785	2024-03-07	2	2	3	0	3340.75862068966	0	\N	f	1	810	2024-03-24 12:58:38.212481+03
786	2024-03-07	2	3	1	0	1113.58620689655	0	\N	f	1	810	2024-03-24 12:58:52.012997+03
787	2024-03-08	2	2	1	0	1113.58620689655	0	\N	f	1	810	2024-03-24 12:59:14.044517+03
764	2024-03-11	1	0	1	1106	1106	0	\N	f	1	\N	2024-03-11 12:43:57.507077+03
767	2024-03-14	1	0	3	3330	1110	0	\N	f	1	\N	2024-03-14 16:26:35.957458+03
768	2024-03-14	1	0	31	34303	1106.54838709677	0	\N	f	1	\N	2024-03-14 16:27:18.233147+03
782	2024-03-23	2	1	1	0	1606.54838709677	0	\N	f	1	768	2024-03-23 15:29:07.072596+03
783	2024-03-23	2	1	1	0	1606.54838709677	0	\N	f	1	768	2024-03-23 15:29:07.074007+03
788	2024-03-08	2	3	1	0	1113.58620689655	0	\N	f	1	810	2024-03-24 13:00:12.080194+03
789	2024-03-09	2	2	2	0	2227.1724137931	0	\N	f	1	810	2024-03-24 13:00:31.652218+03
803	2024-03-25	4	0	0	10000	0	12	Починили колесо	f	1	\N	2024-03-25 17:58:46.558732+03
804	2024-03-26	6	0	0	0	0	13	Сломалась ресора на белых	f	1	\N	2024-03-26 09:47:04.939768+03
805	2024-03-27	2	2	1	0	1106	0		f	1	800	2024-03-27 14:05:48.765223+03
626	2024-01-06	2	2	4	\N	4684.16	\N	\N	f	2	623	\N
641	2024-01-20	2	2	5	\N	5530.30303030303	\N	\N	f	2	639	\N
672	2024-02-03	1	0	34	37647	1107.26470588235	0	\N	f	1	\N	\N
829	2024-02-24	2	1	6	0	9679.125	0	\N	f	1	808	2024-03-27 21:40:28.616392+03
828	2024-02-24	2	2	4	0	4452.75	0	\N	f	1	808	2024-03-27 21:40:28.521279+03
855	2024-03-28	2	2	3	0	3319.6451612903224	0		f	1	768	2024-03-28 13:53:13.583775+03
842	2024-03-03	2	1	5	0	8031.66666666667	0	\N	f	1	809	2024-03-27 21:40:30.024158+03
812	2024-02-14	2	1	9	0	14454.5454545455	0	\N	f	1	806	2024-03-27 21:40:26.68017+03
790	2024-03-10	2	1	5	0	8067.93103448276	0	\N	f	1	810	2024-03-24 13:00:49.959276+03
791	2024-03-10	2	2	3	0	3340.75862068966	0	\N	f	1	810	2024-03-24 13:57:37.304318+03
792	2024-03-14	2	2	5	0	5567.93103448276	0	\N	f	1	810	2024-03-24 13:58:54.729824+03
793	2024-03-15	2	2	3	0	3340.75862068966	0	\N	f	1	810	2024-03-24 13:59:26.570497+03
794	2024-03-17	2	2	1	0	1106	0	\N	f	1	764	2024-03-24 14:04:27.180125+03
795	2024-03-19	2	2	1	0	1110	0	\N	f	1	767	2024-03-24 14:04:53.618538+03
796	2024-03-20	2	2	2	0	2220	0	\N	f	1	767	2024-03-24 14:05:48.384669+03
797	2024-03-21	2	2	1	0	1106.54838709677	0	\N	f	1	768	2024-03-24 14:06:39.892963+03
798	2024-03-22	2	2	1	0	1106.54838709677	0	\N	f	1	768	2024-03-24 14:07:17.121836+03
801	2024-03-23	2	3	1	0	1106.54838709677	0	\N	f	1	768	2024-03-24 14:17:37.265099+03
799	2024-03-23	2	2	1	0	1106.54838709677	0	\N	f	1	768	2024-03-24 14:07:37.039909+03
800	2024-03-24	1	0	8	8848	1106	0	\N	f	1	\N	2024-03-24 14:17:07.982868+03
802	2024-03-24	2	2	2	0	2213.09677419355	0	\N	f	1	768	2024-03-24 14:18:07.35349+03
723	2024-02-12	2	1	1	0	1606	0	\N	f	1	690	2024-02-22 15:51:16.966523+03
824	2024-02-19	2	3	1	0	1115.16666666667	0	\N	f	1	807	2024-03-27 21:40:27.998166+03
806	2024-02-12	1	0	33	36500	1106.06060606061	0	\N	f	1	\N	2024-03-27 20:53:32.464485+03
807	2024-02-16	1	0	24	26764	1115.16666666667	0	\N	f	1	\N	2024-03-27 20:54:30.760319+03
808	2024-02-20	1	0	32	35622	1113.1875	0	\N	f	1	\N	2024-03-27 20:55:27.950019+03
809	2024-02-26	1	0	27	29871	1106.33333333333	0	\N	f	1	\N	2024-03-27 20:57:28.746416+03
810	2024-03-03	1	0	29	32294	1113.58620689655	0	\N	f	1	\N	2024-03-27 20:58:25.166798+03
811	2024-02-12	2	1	1	0	1606.06060606061	0	\N	f	1	806	2024-03-27 21:40:26.586232+03
825	2024-02-21	2	2	2	0	2230.33333333333	0	\N	f	1	807	2024-03-27 21:40:28.217444+03
826	2024-02-22	2	2	2	0	2230.33333333333	0	\N	f	1	807	2024-03-27 21:40:28.319336+03
827	2024-02-23	2	3	2	0	2230.33333333333	0	\N	f	1	807	2024-03-27 21:40:28.417829+03
863	2024-04-01	2	2	2	0	2213.0967741935483	0		f	1	768	2024-04-01 15:59:50.2969+03
864	2024-04-04	6	0	0	0	0	10	Кажется проблема с форсункой, при работе не такой звук как должен быть	f	1	\N	2024-04-04 13:21:35.973234+03
856	2024-03-28	8	0	0	0	0	12	Колесо поставили 	f	1	\N	2024-03-28 17:40:36.58458+03
857	2024-03-29	7	0	0	0	0	9	Сломалась рама под сидением, поэтому сиденье на место не становится 	f	1	\N	2024-03-29 10:14:02.410998+03
858	2024-03-29	1	0	25	27650	1106	0		f	1	\N	2024-03-29 11:37:58.268969+03
859	2024-03-29	2	2	1	0	1106.5483870967741	0		f	1	768	2024-03-29 11:46:58.138258+03
860	2024-03-30	4	0	0	4300	0	13	Купили ресору	f	1	\N	2024-03-30 21:06:12.628302+03
861	2024-03-31	5	1	0	10000	0	0	Замена 5 пружин на снегоходах. Замена амортизатора	f	1	\N	2024-03-31 14:10:05.543908+03
862	2024-03-31	5	2	0	3000	0	0	Изготовление и установка хомута для бензобака. Выезд.	f	1	\N	2024-03-31 14:10:54.226842+03
813	2024-02-14	2	2	2	0	2212.12121212121	0	\N	f	1	806	2024-03-27 21:40:26.77323+03
814	2024-02-14	2	3	3	0	3318.18181818182	0	\N	f	1	806	2024-03-27 21:40:26.87313+03
815	2024-02-15	2	1	5	0	8030.30303030303	0	\N	f	1	806	2024-03-27 21:40:26.968154+03
816	2024-02-16	2	2	1	0	1106.06060606061	0	\N	f	1	806	2024-03-27 21:40:27.066036+03
817	2024-02-16	2	2	2	0	2212.12121212121	0	\N	f	1	806	2024-03-27 21:40:27.288175+03
818	2024-02-16	2	1	4	0	6424.24242424242	0	\N	f	1	806	2024-03-27 21:40:27.405078+03
819	2024-02-17	2	1	6	0	9636.36363636364	0	\N	f	1	806	2024-03-27 21:40:27.513118+03
820	2024-02-17	2	2	5	0	5575.83333333333	0	\N	f	1	807	2024-03-27 21:40:27.6122+03
821	2024-02-18	2	1	5	0	8075.83333333333	0	\N	f	1	807	2024-03-27 21:40:27.721127+03
822	2024-02-19	2	1	3	0	4845.5	0	\N	f	1	807	2024-03-27 21:40:27.813216+03
823	2024-02-19	2	2	4	0	4460.66666666667	0	\N	f	1	807	2024-03-27 21:40:27.906073+03
865	2024-04-04	2	2	1	0	1106.5483870967741	0		f	1	768	2024-04-04 15:25:32.742307+03
866	2024-04-06	8	0	0	0	0	10	Временно починили	f	1	\N	2024-04-06 17:21:44.125205+03
867	2024-04-08	2	2	1	0	1106.5483870967741	0		f	1	768	2024-04-08 12:10:32.769576+03
841	2024-03-03	2	2	1	0	1113.58620689655	0	\N	f	1	810	2024-03-27 21:40:29.931295+03
840	2024-03-02	2	1	5	0	8031.66666666667	0	\N	f	1	809	2024-03-27 21:40:29.745343+03
839	2024-03-02	2	2	1	0	1106.33333333333	0	\N	f	1	809	2024-03-27 21:40:29.652186+03
838	2024-03-01	2	1	5	0	8031.66666666667	0	\N	f	1	809	2024-03-27 21:40:29.557277+03
837	2024-03-01	2	2	1	0	1106.33333333333	0	\N	f	1	809	2024-03-27 21:40:29.463226+03
836	2024-02-29	2	1	6	0	9638	0	\N	f	1	809	2024-03-27 21:40:29.370427+03
835	2024-02-29	2	3	1	0	1106.33333333333	0	\N	f	1	809	2024-03-27 21:40:29.278261+03
834	2024-02-28	2	1	3	0	4839.5625	0	\N	f	1	808	2024-03-27 21:40:29.184063+03
833	2024-02-28	2	2	4	0	4452.75	0	\N	f	1	808	2024-03-27 21:40:29.091211+03
832	2024-02-27	2	1	5	0	8065.9375	0	\N	f	1	808	2024-03-27 21:40:28.99026+03
831	2024-02-26	2	1	5	0	8065.9375	0	\N	f	1	808	2024-03-27 21:40:28.897235+03
830	2024-02-25	2	1	5	0	8065.9375	0	\N	f	1	808	2024-03-27 21:40:28.709381+03
868	2024-04-09	6	0	0	0	0	10	Зажигание сломалось	f	1	\N	2024-04-09 14:16:38.094336+03
854	2024-02-17	9	0	0	2899	0	0	\N	f	2	\N	2024-03-27 22:51:13.680361+03
853	2024-02-09	9	0	0	2623	0	0	\N	f	2	\N	2024-03-27 22:50:51.11237+03
852	2024-01-17	5	1	0	25500	0	0	\N	f	2	\N	2024-03-27 22:50:15.192901+03
851	2024-01-15	5	2	0	6000	0	0	\N	f	2	\N	2024-03-27 22:49:43.864756+03
850	2024-01-10	5	2	0	25000	0	0	\N	f	2	\N	2024-03-27 22:49:09+03
849	2024-01-07	5	1	0	28000	0	0	\N	f	2	\N	2024-03-27 22:48:28+03
848	2024-01-06	5	1	0	41500	0	0	\N	f	2	\N	2024-03-27 22:47:44+03
847	2024-01-04	5	2	0	65500	0	0	\N	f	2	\N	2024-03-27 22:46:52+03
844	2024-03-04	2	2	2	0	2227.1724137931	0	\N	f	1	810	2024-03-27 21:40:30.212385+03
843	2024-03-04	2	1	3	0	4819	0	\N	f	1	809	2024-03-27 21:40:30.117143+03
869	2024-04-10	7	0	0	0	0	13	Надо купить предохранители 	f	1	\N	2024-04-10 12:41:14.537205+03
870	2024-04-10	2	2	1	0	1106.5483870967741	0		f	1	768	2024-04-10 15:22:48.784152+03
871	2024-04-10	2	3	1	0	1106.5483870967741	0		f	1	768	2024-04-10 15:22:59.601543+03
872	2024-04-10	8	0	0	0	0	51	Ибрашка поменял стартер 	f	1	\N	2024-04-10 18:08:56.971289+03
873	2024-04-10	6	0	0	0	0	9	Заглох в дороге, поменяли бензонасос но не помогло	f	1	\N	2024-04-10 18:10:48.613741+03
874	2024-04-12	2	2	1	0	1106.5483870967741	0		f	1	768	2024-04-12 14:51:53.415127+03
875	2024-04-12	2	3	1	0	1106.5483870967741	0		f	1	768	2024-04-12 14:52:32.193473+03
876	2024-04-12	2	3	1	0	1106.5483870967741	0		f	1	768	2024-04-12 17:29:08.641549+03
877	2024-04-13	2	2	1	0	1106.5483870967741	0		f	1	768	2024-04-13 13:17:35.525164+03
878	2024-04-14	8	0	0	0	0	13	Тимур починил рессору	f	1	\N	2024-04-14 13:49:49.012721+03
879	2024-04-14	4	2	0	2500	0	13	Тимуру за починку рессоры	f	1	\N	2024-04-14 13:53:19.617409+03
880	2024-04-17	2	2	2	0	2213.0967741935483	0		f	1	768	2024-04-17 12:39:51.816893+03
881	2024-04-17	7	0	0	0	0	13	Начал немного троить	f	1	\N	2024-04-17 18:16:50.931031+03
882	2024-04-22	2	2	1	0	1106.5483870967741	0		f	1	768	2024-04-22 18:28:14.260247+03
883	2024-04-22	1	0	4	4472	1118	0		f	1	\N	2024-04-22 18:31:25.895254+03
884	2024-04-23	2	2	2	0	2213.0967741935483	0		f	1	768	2024-04-23 09:26:48.063478+03
885	2024-04-25	8	0	0	0	0	9	Ваня починил	f	1	\N	2024-04-25 13:41:46.507377+03
886	2024-04-25	6	0	0	0	0	10	Сломалась рессора	f	1	\N	2024-04-25 15:33:17.876018+03
887	2024-04-27	2	3	1	0	1106.5483870967741	0		f	1	768	2024-04-27 10:21:28.933712+03
888	2024-04-27	2	2	1	0	1106.5483870967741	0		f	1	768	2024-04-27 10:21:55.201873+03
889	2024-04-27	1	0	7	7826	1118	0		f	1	\N	2024-04-27 11:28:23.352627+03
890	2024-04-27	2	2	2	0	2213.0967741935483	0		f	1	768	2024-04-27 16:43:38.940805+03
891	2024-04-27	8	0	0	0	0	10	Тимур приварил рессору	f	1	\N	2024-04-27 16:52:57.125237+03
892	2024-04-27	5	0	0	3000	0	10	Отдали тимуру	f	1	\N	2024-04-27 18:06:46.698876+03
893	2024-04-27	8	0	0	0	0	48		f	1	\N	2024-04-27 21:58:47.779192+03
894	2024-04-27	8	0	0	0	0	50		f	1	\N	2024-04-27 21:59:48.643445+03
895	2024-04-27	8	0	0	0	0	50		f	1	\N	2024-04-27 21:59:51.318945+03
896	2024-04-28	2	2	1	0	1106	0		f	1	800	2024-04-28 16:02:57.3216+03
897	2024-04-29	6	0	0	0	0	12	Сломалась рессора	f	1	\N	2024-04-29 09:30:08.416907+03
898	2024-04-30	1	0	5	5590	1118	0		f	1	\N	2024-04-30 09:49:22.452861+03
899	2024-04-30	2	3	2	0	2212	0		f	1	800	2024-04-30 09:49:46.053785+03
900	2024-04-30	2	2	3	0	3318	0		f	1	800	2024-04-30 09:50:26.936779+03
901	2024-04-30	1	0	8	8944	1118	0		f	1	\N	2024-04-30 11:09:29.739102+03
902	2024-04-30	2	3	1	0	1106	0		f	1	800	2024-04-30 11:09:42.901708+03
903	2024-05-01	4	0	0	5000	0	10	Купили рессору	f	1	\N	2024-05-01 10:52:24.113611+03
904	2024-05-01	4	0	0	5000	0	12	Рессора	f	1	\N	2024-05-01 10:53:31.549237+03
905	2024-05-01	8	0	0	0	0	12	Починили рессору	f	1	\N	2024-05-01 14:43:51.681884+03
906	2024-05-01	6	0	0	0	0	10	Слетел кардан	f	1	\N	2024-05-01 18:33:44.217118+03
907	2024-05-02	1	0	16	17888	1118	0		f	1	\N	2024-05-02 13:53:33.611852+03
908	2024-05-02	2	2	3	0	3318	0		f	1	858	2024-05-02 14:08:59.424205+03
909	2024-05-04	2	2	2	0	2212	0		f	1	858	2024-05-04 09:59:51.000027+03
910	2024-05-04	2	2	1	0	1106	0		f	1	858	2024-05-04 10:11:15.399894+03
911	2024-05-06	2	2	1	0	1106	0		f	1	858	2024-05-06 15:03:48.3398+03
912	2024-05-10	2	2	2	0	2212	0		f	1	858	2024-05-10 09:51:06.295146+03
913	2024-05-10	2	3	1	0	1106	0		f	1	858	2024-05-10 09:51:27.264895+03
914	2024-05-11	8	0	0	0	0	11	Тимур поменял крестовины	f	1	\N	2024-05-11 09:55:13.661777+03
915	2024-05-11	5	0	0	1500	0	11	За замену крестовин Тимуру	f	1	\N	2024-05-11 09:55:41.141687+03
916	2024-05-12	1	0	18	20200	1122.2222222222222	0		f	1	\N	2024-05-12 19:41:13.902039+03
917	2024-05-13	8	0	0	0	0	10	Тоже что и 5 сокол	f	1	\N	2024-05-13 21:05:50.606501+03
918	2024-05-14	2	2	2	0	2212	0		f	1	858	2024-05-14 11:47:15.893678+03
919	2024-05-14	2	3	1	0	1106	0		f	1	858	2024-05-14 14:38:02.18037+03
920	2024-05-28	7	0	0	0	0	32	Небольшие поломки пластика сзади около правой фары, переднего "багажника" над бампером, сломанная решётка у бампера. Отсутствуют зеркала, защиты от ветра на ручках, спинка сиденья. Трос зажевало внутрь.	f	1	\N	2024-05-28 20:18:40.066457+03
921	2024-05-28	7	0	0	0	0	21	Сломан пластик спереди, сзади и справа под ногами. Нет фар и бампера. Трос затянут внутрь, из-за этого не работает. Нет зеркал и защиты от ветра на правой ручке.	f	1	\N	2024-05-28 20:23:11.074579+03
922	2024-05-28	6	0	0	0	0	31	Немного побитый пластик около решётки. Вообще не включается, даже экран. Трос зажевало внутрь. Отсутствует спинка сиденья. 	f	1	\N	2024-05-28 20:24:51.988998+03
923	2024-05-28	6	0	0	0	0	22	Вообще не включается, даже экран. Отсутствуют зеркала.	f	1	\N	2024-05-28 20:27:19.720491+03
924	2024-06-01	1	0	6	6750	1125	0		f	1	\N	2024-06-01 11:06:19.560272+03
925	2024-06-02	6	0	0	0	0	13	Сломана толстая ресора	f	1	\N	2024-06-02 10:11:28.085373+03
926	2024-06-02	6	0	0	0	0	10	Не работают тормоза	f	1	\N	2024-06-02 10:12:17.559333+03
927	2024-06-02	7	0	0	0	0	11	С ходовой все плохо, скрипит, ломается. Желательно не ездить 	f	1	\N	2024-06-02 10:13:00.911581+03
928	2024-06-05	8	0	0	0	0	22	Теперь включается, остальное так же сломано 	f	1	\N	2024-06-05 18:38:31.91078+03
929	2024-06-05	8	0	0	0	0	31	Теперь включается и ездит. Остальное так же сломано	f	1	\N	2024-06-05 18:39:02.31081+03
930	2024-06-06	2	3	3	0	3318	0		f	1	858	2024-06-06 14:58:12.072043+03
931	2024-06-07	2	3	1	0	1106	0		f	1	858	2024-06-07 17:56:02.522138+03
932	2024-06-07	2	2	2	0	2212	0		f	1	858	2024-06-07 17:56:20.092274+03
933	2024-06-09	8	0	0	0	0	13	Починили рессору	f	1	\N	2024-06-09 14:31:48.344765+03
934	2024-06-12	5	0	0	3500	0	13	Рессора и крестовина 	f	1	\N	2024-06-12 18:59:20.179116+03
935	2024-05-22	5	0	0	3500	0	13	Рессора и крестовина	f	1	\N	2024-06-12 19:01:29.040709+03
936	2024-06-15	5	0	0	1500	0	11	Починил Тимур тормоза	f	1	\N	2024-06-15 15:46:44.207228+03
937	2024-06-15	5	0	0	1500	0	13		f	1	\N	2024-06-15 15:48:04.503071+03
938	2024-06-29	6	0	0	0	0	10	Нет масла в мостах и моторе	f	1	\N	2024-06-29 17:28:35.895624+03
939	2024-06-30	6	0	0	0	0	30	Сильно стучит, кажется с вариатором проблемы	f	1	\N	2024-06-30 15:15:57.165222+03
940	2024-06-30	7	0	0	0	0	12	Тормоза очень слабые, срочно сделать	f	1	\N	2024-06-30 16:53:14.243631+03
941	2024-06-30	5	0	0	3000	0	13	Ибрашке за колесо и расходы 	f	1	\N	2024-06-30 20:07:57.333712+03
942	2024-07-05	7	0	0	0	0	25	Левое переднее колесо отсутствует 1 крепление 	f	1	\N	2024-07-05 22:09:12.07175+03
943	2024-07-14	8	0	0	0	0	10	В зеленчуке починили.	f	1	\N	2024-07-14 10:19:25.329704+03
944	2024-07-14	6	0	0	0	0	12	Сломалась рессора 	f	1	\N	2024-07-14 20:10:39.462902+03
945	2024-07-17	6	0	0	0	0	22	Не включается, меняли стартер 	f	1	\N	2024-07-17 13:12:14.61143+03
946	2024-07-18	4	2	0	5340	0	0		f	1	\N	2024-07-18 17:54:54.532324+03
947	2024-07-20	8	0	0	0	0	31	Поменял самат масло моторное	f	1	\N	2024-07-20 16:22:17.099114+03
948	2024-07-20	8	0	0	0	0	30	Самат поменял масло, перестал почти стучать 	f	1	\N	2024-07-20 16:31:09.125459+03
949	2024-07-20	6	0	0	0	0	30	Не включается, стартер ужасно шумит. 	f	1	\N	2024-07-20 16:31:32.864588+03
950	2024-07-20	8	0	0	0	0	13	Без тормозов. 	f	1	\N	2024-07-20 16:33:24.331216+03
951	2024-07-20	6	0	0	0	0	10	Нет болтов на поворотном механизме колеса.	f	1	\N	2024-07-20 16:34:46.407352+03
952	2024-07-20	6	0	0	0	0	13	Без тормозов	f	1	\N	2024-07-20 16:36:39.537991+03
953	2024-07-20	6	0	0	0	0	31	Начал очень перегреваться	f	1	\N	2024-07-20 19:42:42.692384+03
954	2024-07-28	8	0	0	0	0	10	Отвезли вниз, починили крепление тяги	f	1	\N	2024-07-28 18:36:40.004167+03
955	2024-07-28	8	0	0	0	0	12	Отвезли, поменяли рессору, сделали тормоза и включается	f	1	\N	2024-07-28 18:37:43.212846+03
956	2024-07-29	6	0	0	0	0	20	Сломалась коробка, вариатор 	f	1	\N	2024-07-29 17:25:07.605538+03
957	2024-07-31	6	0	0	0	0	9	Ребёнок в дороге дёрнул скорость. Крутит стартер, не включается 	f	1	\N	2024-07-31 13:33:48.9127+03
958	2024-08-05	8	0	0	0	0	12	Нужна замена радиатора.	f	1	\N	2024-08-05 18:12:42.096609+03
959	2024-08-08	7	0	0	0	0	21	Выбивает скорость, нет гура	f	1	\N	2024-08-08 17:09:48.169321+03
960	2024-08-11	6	0	0	0	0	27	На Софие сильно поломался, улетел	f	1	\N	2024-08-11 22:42:35.894255+03
961	2024-08-15	6	0	0	0	0	12	Надо отвезти вниз. Сломалась задняя ось.	f	1	\N	2024-08-15 19:19:57.270898+03
962	2024-08-17	5	2	0	5000	0	0	Мага повозился и с квадриками и вездеходами, в особенности розовый 7	f	1	\N	2024-08-17 19:39:16.336706+03
963	2024-08-19	7	0	0	0	0	26	Ему очень плохо, либо коробка либо привод	f	1	\N	2024-08-19 19:11:24.934609+03
964	2024-08-25	4	2	0	1300	0	0		f	1	\N	2024-08-25 12:22:40.226323+03
965	2024-08-25	4	2	0	4050	0	0	3550 на запчасти, 500 на доставку 	f	1	\N	2024-08-25 13:29:35.366355+03
\.


--
-- Data for Name: payment_types; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.payment_types (id, title, emoji, deleted_at) FROM stdin;
1	Наличка	💵	\N
2	Перевод	💳	\N
3	Постоплата	💸	\N
4	Безнал	💲	\N
5	Сертификат		2024-05-06 13:58:23.66191
6	QR	🏽	\N
\.


--
-- Data for Name: penalties; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.penalties (id, date_penalty, user_id, amount, description, source_id, created_at) FROM stdin;
4	2024-02-16	2	1000	Тестовый штраф 	1	\N
5	2024-02-16	4	1000	Тестовый штраф 	1	\N
6	2024-02-16	5	1000	Тестовый штраф 	1	\N
7	2024-02-16	6	1000	Тестовый штраф 	1	\N
8	2024-02-16	7	1000	Тестовый штраф 	1	\N
9	2024-02-16	3	1000	Тестовый штраф 	1	\N
10	2024-02-16	9	1000	Тестовый штраф 	1	\N
11	2024-02-16	10	1000	Тестовый штраф 	1	\N
12	2024-02-16	14	1000	Тестовый штраф 	1	\N
13	2024-02-17	2	500		1	2024-02-17 18:43:22.490802+03
14	2024-02-17	4	500		1	2024-02-17 18:43:22.491783+03
15	2024-02-17	5	500		1	2024-02-17 18:43:22.492304+03
16	2024-02-17	6	500		1	2024-02-17 18:43:22.492859+03
17	2024-02-17	7	500		1	2024-02-17 18:43:22.493298+03
18	2024-02-17	3	500		1	2024-02-17 18:43:22.49375+03
19	2024-02-17	9	500		1	2024-02-17 18:43:22.494177+03
20	2024-02-17	10	500		1	2024-02-17 18:43:22.494641+03
21	2024-02-17	14	500		1	2024-02-17 18:43:22.495107+03
22	2024-02-18	2	4001	Пидорас	1	2024-02-18 18:16:20.389946+03
23	2024-02-23	3	10	Тест	1	2024-02-23 08:56:11.475609+03
24	2024-02-23	2	10	Тест	1	2024-02-23 08:56:11.552144+03
25	2024-02-23	6	10	Тест	1	2024-02-23 08:56:11.623321+03
26	2024-02-23	7	10	Тест	1	2024-02-23 08:56:11.740572+03
27	2024-02-23	14	10	Тест	1	2024-02-23 08:56:11.826636+03
28	2024-02-23	4	10	Тест	1	2024-02-23 08:56:11.923243+03
29	2024-02-23	4	10		1	2024-02-23 08:58:09.306748+03
30	2024-05-11	2	2000	Не подтвердил отчет ебен 	1	2024-05-11 16:17:23.573861+03
31	2024-08-05	2	1000	Опоздание 	1	2024-08-05 09:01:38.359919+03
32	2024-08-05	18	1000	Опоздание 	1	2024-08-05 09:01:38.442657+03
33	2024-09-25	2	1000		1	2024-09-25 10:00:22.657916+03
34	2024-09-25	25	1000		1	2024-09-25 10:00:22.867804+03
\.


--
-- Data for Name: ranks; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.ranks (id, rank, salary, percent, deleted_at) FROM stdin;
1	Директор	500	5	\N
2	Менеджер	500	4	\N
3	Инструктор	500	10	\N
\.


--
-- Data for Name: route_costs; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.route_costs (id, date_cost, type_technique_id, route_id, cost, created_at) FROM stdin;
1	2023-10-01	3	7	12000	\N
2	2024-01-01	2	1	10000	\N
3	2023-04-01	3	1	7000	\N
4	2023-10-01	3	8	5000	\N
5	2024-01-01	2	3	5000	\N
6	2024-01-01	3	3	4000	\N
7	2023-01-12	2	2	10000	\N
8	2023-04-01	3	2	10000	\N
9	2024-01-01	2	4	7000	\N
10	2023-04-01	3	4	5000	\N
11	2023-01-12	2	1	8000	\N
12	2023-01-01	2	1	10000	\N
13	2023-01-10	2	3	4000	\N
14	2023-01-01	2	3	5000	\N
15	2023-04-01	3	3	3000	\N
16	2023-01-01	2	2	12000	\N
17	2023-01-10	2	4	6000	\N
18	2023-01-01	2	4	6000	\N
19	2023-01-12	1	1	7000	\N
20	2023-01-01	1	1	6000	\N
21	2024-01-01	1	3	5000	\N
22	2023-01-10	1	3	3000	\N
23	2023-01-01	1	3	4000	\N
24	2023-01-12	1	2	9000	\N
25	2023-01-01	1	2	8000	\N
26	2024-01-01	1	4	6000	\N
27	2023-01-01	1	4	5000	\N
28	2024-01-01	2	1	10000	\N
29	2024-01-01	2	3	5000	\N
30	2024-01-01	3	3	4000	\N
31	2024-01-01	1	3	5000	\N
32	2024-01-01	2	4	7000	\N
33	2024-01-01	1	4	6000	\N
34	2024-01-01	2	1	10000	\N
35	2024-01-01	2	3	5000	\N
36	2024-01-01	3	3	4000	\N
37	2024-01-01	1	3	5000	\N
38	2024-01-01	2	4	7000	\N
39	2024-01-01	1	4	6000	\N
40	2024-01-01	2	1	10000	\N
41	2024-01-01	2	3	5000	\N
42	2024-01-01	3	3	4000	\N
43	2024-01-01	1	3	5000	\N
44	2024-01-01	2	4	7000	\N
45	2024-01-01	1	4	6000	\N
46	2024-01-01	2	1	10000	\N
47	2024-01-01	2	3	5000	\N
48	2024-01-01	3	3	4000	\N
49	2024-01-01	1	3	5000	\N
50	2024-01-01	2	4	7000	\N
51	2024-01-01	1	4	6000	\N
52	2024-01-01	2	1	10000	\N
53	2024-01-01	2	3	5000	\N
54	2024-01-01	3	3	4000	\N
55	2024-01-01	1	3	5000	\N
56	2024-01-01	2	4	7000	\N
57	2024-01-01	1	4	6000	\N
58	2024-01-01	2	1	10000	\N
59	2024-01-01	2	3	5000	\N
60	2024-01-01	3	3	4000	\N
61	2024-01-01	1	3	5000	\N
62	2024-01-01	2	4	7000	\N
63	2024-01-01	1	4	6000	\N
64	2024-01-01	2	1	10000	\N
65	2024-01-01	2	3	5000	\N
66	2024-01-01	3	3	4000	\N
67	2024-01-01	1	3	5000	\N
68	2024-01-01	2	4	7000	\N
69	2024-01-01	1	4	6000	\N
70	2024-01-01	2	1	10000	\N
71	2024-01-01	2	3	5000	\N
72	2024-01-01	3	3	4000	\N
73	2024-01-01	1	3	5000	\N
74	2024-01-01	2	4	7000	\N
75	2024-01-01	1	4	6000	\N
76	2024-01-01	2	1	10000	\N
77	2024-01-01	2	3	5000	\N
78	2024-01-01	3	3	4000	\N
79	2024-01-01	1	3	5000	\N
80	2024-01-01	2	4	7000	\N
81	2024-01-01	1	4	6000	\N
82	2024-01-01	2	1	10000	\N
83	2024-01-01	2	3	5000	\N
84	2024-01-01	3	3	4000	\N
85	2024-01-01	1	3	5000	\N
86	2024-01-01	2	4	7000	\N
87	2024-01-01	1	4	6000	\N
88	2024-01-01	2	1	10000	\N
89	2024-01-01	2	3	5000	\N
90	2024-01-01	3	3	4000	\N
91	2024-01-01	1	3	5000	\N
92	2024-01-01	2	4	7000	\N
93	2024-01-01	1	4	6000	\N
94	2024-01-01	2	1	10000	\N
95	2024-01-01	2	3	5000	\N
96	2024-01-01	3	3	4000	\N
97	2024-01-01	1	3	5000	\N
98	2024-01-01	2	4	7000	\N
99	2024-01-01	1	4	6000	\N
100	2024-01-01	2	1	10000	\N
101	2024-01-01	2	3	5000	\N
102	2024-01-01	3	3	4000	\N
103	2024-01-01	1	3	5000	\N
104	2024-01-01	2	4	7000	\N
105	2024-01-01	1	4	6000	\N
106	2024-05-01	2	1	10000	2024-04-30 19:28:20.907907+03
107	2024-05-01	3	1	8000	2024-04-30 19:28:20.909859+03
108	2024-05-01	2	3	4000	2024-04-30 19:28:20.910314+03
109	2024-05-01	3	3	3000	2024-04-30 19:28:20.910748+03
110	2024-05-01	2	2	12000	2024-04-30 19:28:20.911233+03
111	2024-05-01	3	2	10000	2024-04-30 19:28:20.911687+03
112	2024-05-01	2	4	6000	2024-04-30 19:28:20.913287+03
113	2024-05-01	3	4	5000	2024-04-30 19:28:20.913711+03
\.


--
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.routes (id, title, deleted_at) FROM stdin;
1	Белые водопады	\N
2	Софийские водопады	\N
3	Малый маршрут	\N
4	Часовой маршрут	\N
5	Пхия	\N
6	Аланский Путь	\N
7	Бездонное Озеро	\N
8	Дукка	\N
\.


--
-- Data for Name: salary_days; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.salary_days (date_salary, user_id, salary, percent, penalty) FROM stdin;
2024-01-01	3	500	12675	0
2024-01-01	2	500	10140	0
2024-01-01	6	500	10100	0
2024-01-01	7	500	3400	0
2024-01-01	14	500	5850	0
2024-01-02	3	500	21975	0
2024-01-02	2	500	17580	0
2024-01-02	6	500	12950	0
2024-01-02	7	500	16100	0
2024-01-02	14	500	8600	0
2024-01-03	3	500	13500	0
2024-01-03	2	500	10800	0
2024-01-03	6	500	8300	0
2024-01-03	7	500	9200	0
2024-01-03	14	500	3400	0
2024-01-04	3	500	16475	0
2024-01-04	2	500	13180	0
2024-01-04	6	500	11950	0
2024-01-04	7	500	12400	0
2024-01-04	14	500	2000	0
2024-01-05	3	500	16800	0
2024-01-05	2	500	13440	0
2024-01-05	6	500	15200	0
2024-01-05	7	500	8900	0
2024-01-05	14	500	1400	0
2024-01-06	3	500	11900	0
2024-01-06	2	500	9520	0
2024-01-06	6	500	14000	0
2024-01-06	7	500	4500	0
2024-01-06	14	500	2300	0
2024-01-07	3	500	11450	0
2024-01-07	2	500	9160	0
2024-01-07	6	500	11000	0
2024-01-07	7	500	4900	0
2024-01-07	14	500	5100	0
2024-01-08	3	500	6100	0
2024-01-08	2	500	4880	0
2024-01-08	6	500	3200	0
2024-01-08	7	500	7200	0
2024-01-09	3	500	3250	0
2024-01-09	2	500	2600	0
2024-01-09	6	500	4500	0
2024-01-09	14	500	2000	0
2024-01-10	3	500	3000	0
2024-01-10	2	500	2400	0
2024-01-10	6	500	5600	0
2024-01-10	7	500	400	0
2024-01-11	3	500	0	0
2024-01-12	3	500	10325	0
2024-01-12	2	500	8260	0
2024-01-12	6	500	10950	0
2024-01-12	7	500	6900	0
2024-01-12	14	500	2300	0
2024-01-13	3	500	11600	0
2024-01-13	2	500	9280	0
2024-01-13	6	500	14400	0
2024-01-13	7	500	4000	0
2024-01-13	14	500	4400	0
2024-01-14	3	500	6900	0
2024-01-14	6	500	6000	0
2024-01-14	7	500	3800	0
2024-01-14	14	500	4000	0
2024-01-15	3	500	2850	0
2024-01-15	6	500	3900	0
2024-01-15	7	500	1800	0
2024-01-16	3	500	4525	0
2024-01-16	6	500	1500	0
2024-01-16	7	500	7250	0
2024-01-17	3	500	2625	0
2024-01-17	2	500	2100	0
2024-01-17	6	500	1600	0
2024-01-17	7	500	1300	0
2024-01-18	3	500	3075	0
2024-01-18	2	500	2460	0
2024-01-18	7	500	4150	0
2024-01-18	14	500	2000	0
2024-01-19	3	500	3000	0
2024-01-19	2	500	2400	0
2024-01-19	7	500	4200	0
2024-01-20	3	500	7770	0
2024-01-20	2	500	6216	0
2024-01-20	6	500	6540	0
2024-01-20	7	500	4100	0
2024-01-20	14	500	3900	0
2024-01-21	3	500	6600	0
2024-01-21	2	500	5280	0
2024-01-21	6	500	7200	0
2024-01-21	7	500	3650	0
2024-01-21	14	500	2350	0
2024-01-22	3	500	6025	0
2024-01-22	2	500	4820	0
2024-01-22	6	500	5800	0
2024-01-22	7	500	3550	0
2024-01-22	14	500	2700	0
2024-01-23	3	500	3900	0
2024-01-23	2	500	3120	0
2024-01-23	6	500	4000	0
2024-01-23	7	500	2900	0
2024-01-23	14	500	900	0
2024-01-24	3	500	5000	0
2024-01-24	2	500	4000	0
2024-01-24	6	500	4600	0
2024-01-24	7	500	3600	0
2024-01-24	14	500	1800	0
2024-01-25	3	500	4000	0
2024-01-25	2	500	3200	0
2024-01-25	6	500	3500	0
2024-01-25	7	500	4500	0
2024-01-26	3	500	4840	0
2024-01-26	2	500	3872	0
2024-01-26	6	500	5580	0
2024-01-26	7	500	4100	0
2024-01-27	3	500	8735	0
2024-01-27	2	500	6988	0
2024-01-27	6	500	9050	0
2024-01-27	7	500	4600	0
2024-01-27	14	500	3820	0
2024-01-28	3	500	8350	0
2024-01-28	2	500	6680	0
2024-01-28	6	500	12000	0
2024-01-28	7	500	3800	0
2024-01-28	14	500	900	0
2024-01-29	3	500	6900	0
2024-01-29	2	500	5520	0
2024-01-29	6	500	9800	0
2024-01-29	7	500	2400	0
2024-01-29	14	500	1600	0
2024-01-30	3	500	3400	0
2024-01-30	6	500	5400	0
2024-01-30	7	500	1400	0
2024-01-31	3	500	6600	0
2024-01-31	6	500	8100	0
2024-01-31	7	500	2400	0
2024-01-31	14	500	2700	0
2024-02-01	3	500	4775	0
2024-02-01	7	500	5750	0
2024-02-01	14	500	3800	0
2024-02-02	3	500	8650	0
2024-02-02	7	500	10000	0
2024-02-02	14	500	7300	0
2024-02-03	3	500	11685	0
2024-02-03	2	500	9348	0
2024-02-03	6	500	5100	0
2024-02-03	7	500	11670	0
2024-02-03	14	500	6600	0
2024-02-04	3	500	6645	0
2024-02-04	2	500	5316	0
2024-02-04	6	500	5850	0
2024-02-04	7	500	5740	0
2024-02-04	14	500	1700	0
2024-02-05	3	500	8250	0
2024-02-05	2	500	6600	0
2024-02-05	6	500	10000	0
2024-02-05	7	500	6500	0
2024-02-06	3	500	7500	0
2024-02-06	2	500	6000	0
2024-02-06	6	500	10200	0
2024-02-06	7	500	3000	0
2024-02-06	14	500	1800	0
2024-02-07	3	500	8700	0
2024-02-07	2	500	6960	0
2024-02-07	6	500	12000	0
2024-02-07	7	500	2400	0
2024-02-07	14	500	3000	0
2024-02-08	6	500	4200	0
2024-02-08	7	500	8100	0
2024-02-08	14	500	600	0
2024-02-09	3	500	8350	0
2024-02-09	2	500	6680	0
2024-02-09	6	500	9100	0
2024-02-09	7	500	4000	0
2024-02-09	14	500	3600	0
2024-02-10	3	500	9150	0
2024-02-10	2	500	7320	0
2024-02-10	6	500	9700	0
2024-02-10	7	500	5600	0
2024-02-10	14	500	3000	0
2024-02-11	3	500	8175	0
2024-02-11	2	500	6540	0
2024-02-11	6	500	4000	0
2024-02-11	7	500	9600	0
2024-02-11	14	500	2750	0
2024-02-12	3	500	6350	0
2024-02-12	2	500	5080	0
2024-02-12	7	500	9200	0
2024-02-12	14	500	3500	0
2024-02-13	3	500	4650	0
2024-02-13	2	500	3720	0
2024-02-13	7	500	5500	0
2024-02-13	14	500	3800	0
2024-02-14	3	500	4650	0
2024-02-14	2	500	3720	0
2024-02-14	6	500	4100	0
2024-02-14	7	500	1400	0
2024-02-14	14	500	3800	0
2024-02-15	3	500	4050	0
2024-02-15	2	500	3240	0
2024-02-15	6	500	4700	0
2024-02-15	7	500	3400	0
2024-02-16	3	500	4475	1000
2024-02-16	2	500	3580	1000
2024-02-16	6	500	4600	1000
2024-02-16	7	500	4350	1000
2024-02-17	3	500	7660	500
2024-02-17	2	500	6128	500
2024-02-17	6	500	7420	500
2024-02-17	7	500	4000	500
2024-02-17	14	500	3900	500
2024-02-18	3	500	8200	0
2024-02-18	2	500	6560	4001
2024-02-18	6	500	7200	0
2024-02-18	7	500	5400	0
2024-02-18	14	500	3800	0
2024-02-19	3	500	5550	0
2024-02-19	6	500	4500	0
2024-02-19	7	500	6000	0
2024-02-19	14	500	600	0
2024-02-20	3	500	9800	0
2024-02-20	6	500	7200	0
2024-02-20	7	500	5200	0
2024-02-20	14	500	6200	0
2024-02-21	3	500	5000	0
2024-02-21	6	500	6300	0
2024-02-21	14	500	3700	0
2024-02-22	2	500	1440	0
2024-02-22	7	500	3000	0
2024-02-22	14	500	600	0
2024-02-23	3	500	9880	10
2024-02-23	6	500	6960	10
2024-02-23	7	500	4800	10
2024-02-23	14	500	8000	10
2024-02-24	3	500	10885	0
2024-02-24	2	500	8708	0
2024-02-24	6	500	10500	0
2024-02-24	7	500	6670	0
2024-02-24	14	500	4600	0
2024-02-25	3	500	5650	0
2024-02-25	2	500	4520	0
2024-02-25	6	500	5100	0
2024-02-25	7	500	3000	0
2024-02-25	14	500	3200	0
2024-02-26	3	500	4500	0
2024-02-26	2	500	3600	0
2024-02-26	6	500	4600	0
2024-02-26	7	500	4400	0
2024-02-27	3	500	2550	0
2024-02-27	2	500	2040	0
2024-02-27	6	500	900	0
2024-02-27	7	500	4200	0
2024-02-28	3	500	2550	0
2024-02-28	2	500	2040	0
2024-02-28	6	500	2900	0
2024-02-28	7	500	2200	0
2024-02-29	3	500	3800	0
2024-02-29	2	500	3040	0
2024-02-29	7	500	6600	0
2024-02-29	14	500	1000	0
2024-03-01	3	500	3500	0
2024-03-01	2	500	2800	0
2024-03-01	6	500	2800	0
2024-03-01	7	500	2600	0
2024-03-01	14	500	1600	0
2024-03-02	3	500	4550	0
2024-03-02	2	500	3640	0
2024-03-02	7	500	6900	0
2024-03-02	14	500	2200	0
2024-03-03	3	500	3350	0
2024-03-03	2	500	2680	0
2024-03-03	7	500	4700	0
2024-03-03	14	500	2000	0
2024-03-04	7	500	8200	0
2024-03-04	14	500	1000	0
2024-03-05	3	500	5975	0
2024-03-05	2	500	4780	0
2024-03-05	7	500	7450	0
2024-03-05	14	500	4500	0
2024-03-06	3	500	2350	0
2024-03-06	2	500	1880	0
2024-03-06	7	500	2700	0
2024-03-06	14	500	2000	0
2024-03-07	3	500	2200	0
2024-03-07	2	500	1760	0
2024-03-07	6	500	1400	0
2024-03-07	7	500	2000	0
2024-03-07	14	500	1000	0
2024-03-08	3	500	3800	0
2024-03-08	2	500	3040	0
2024-03-08	6	500	2100	0
2024-03-08	7	500	2700	0
2024-03-08	14	500	2800	0
2024-03-09	3	500	6000	0
2024-03-09	6	500	5200	0
2024-03-09	7	500	6800	0
2024-03-10	3	500	950	0
2024-03-10	2	500	760	0
2024-03-10	6	500	1900	0
2024-03-13	6	500	700	0
2024-03-13	7	500	5100	0
2024-03-13	14	500	3800	0
2024-03-14	6	500	3400	0
2024-03-14	7	500	3700	0
2024-03-14	14	500	1000	0
2024-03-15	3	500	3600	0
2024-03-15	2	500	2880	0
2024-03-15	6	500	1400	0
2024-03-15	14	500	5800	0
2024-03-16	3	500	1350	0
2024-03-16	2	500	1080	0
2024-03-16	6	500	500	0
2024-03-16	14	500	2200	0
2024-03-17	3	500	1820	0
2024-03-17	2	500	1456	0
2024-03-17	6	500	2640	0
2024-03-17	14	500	1000	0
2024-03-18	14	500	3600	0
2024-03-19	2	500	2560	0
2024-03-19	14	500	6400	0
2024-03-20	2	500	1200	0
2024-03-20	14	500	3000	0
2024-03-21	2	500	2760	0
2024-03-21	14	500	6900	0
2024-03-22	2	500	400	0
2024-03-23	3	500	2350	0
2024-03-23	2	500	1880	0
2024-03-23	6	500	4700	0
2024-03-24	14	500	1500	0
2024-03-25	2	500	1312	0
2024-03-26	14	500	1000	0
2024-03-27	2	500	1080	0
2024-03-27	4	500	2700	0
2024-03-28	2	500	800	0
2024-03-28	4	500	2000	0
2024-03-29	2	500	0	0
2024-03-30	2	500	480	0
2024-03-30	4	500	1200	0
2024-03-31	2	500	480	0
2024-03-31	4	500	1200	0
2024-04-01	4	500	3500	0
2024-04-02	2	500	1560	0
2024-04-02	4	500	1000	0
2024-04-03	2	500	0	0
2024-04-04	2	500	720	0
2024-04-04	4	500	1800	0
2024-04-05	2	500	100	0
2024-04-05	4	500	250	0
2024-04-07	2	500	0	0
2024-04-09	2	500	880	0
2024-04-09	4	500	2200	0
2024-04-10	2	500	400	0
2024-04-10	4	500	1000	0
2024-04-13	2	500	1320	0
2024-04-13	4	500	3300	0
2024-04-14	4	500	900	0
2024-05-19	3	500	5670	0
2024-04-15	2	500	0	0
2024-05-20	3	500	0	0
2024-04-20	4	500	3900	0
2024-04-21	2	500	680	0
2024-04-21	4	500	1700	0
2024-04-22	4	500	1200	0
2024-04-23	2	500	1040	0
2024-04-23	4	500	2600	0
2024-04-24	4	500	1600	0
2024-04-25	4	500	900	0
2024-04-26	2	500	0	0
2024-04-27	2	500	0	0
2024-04-30	6	500	6800	0
2024-04-30	4	500	3400	0
2024-05-01	2	500	3272	0
2024-05-01	6	500	600	0
2024-05-01	4	500	5000	0
2024-03-04	2	500	3280	0
2024-03-18	2	500	1440	0
2024-03-24	2	500	600	0
2024-03-26	2	500	400	0
2024-04-03	4	500	0	0
2024-04-06	4	500	0	0
2024-04-07	4	500	0	0
2024-04-11	4	500	0	0
2024-04-12	4	500	0	0
2024-04-15	4	500	0	0
2024-04-16	4	500	0	0
2024-04-17	4	500	0	0
2024-04-18	4	500	0	0
2024-04-19	4	500	0	0
2024-04-26	4	500	0	0
2024-04-27	4	500	0	0
2024-04-28	4	500	6400	0
2024-04-01	2	500	1240	0
2024-04-08	2	500	600	0
2024-04-12	2	500	0	0
2024-04-14	2	500	360	0
2024-04-16	2	500	0	0
2024-04-17	2	500	240	0
2024-04-18	2	500	0	0
2024-04-20	2	500	1400	0
2024-04-22	2	500	480	0
2024-04-24	2	500	640	0
2024-04-25	2	500	320	0
2024-04-28	2	500	2560	0
2024-04-29	2	500	2700	0
2024-04-30	2	500	5500	0
2024-04-08	4	500	1600	0
2024-03-04	3	500	4100	0
2024-05-02	3	500	800	0
2024-05-02	2	500	640	0
2024-05-02	4	500	800	0
2024-05-03	3	500	500	0
2024-05-03	2	500	400	0
2024-05-03	6	500	500	0
2024-05-05	3	500	0	0
2024-05-05	2	500	0	0
2024-05-06	3	500	500	0
2024-05-06	2	500	400	0
2024-05-06	4	500	1000	0
2024-05-07	2	500	0	0
2024-05-09	4	500	1200	0
2024-05-11	3	500	2950	0
2024-05-11	6	500	1200	0
2024-05-11	4	500	2400	0
2024-05-12	3	500	0	0
2024-05-12	2	500	0	0
2024-05-13	3	500	2400	0
2024-05-13	4	500	2900	0
2024-05-14	3	500	300	0
2024-05-14	2	500	240	0
2024-05-14	4	500	600	0
2024-05-21	3	500	0	0
2024-05-23	3	500	0	0
2024-05-01	3	500	4000	0
2024-05-04	3	500	400	0
2024-05-07	3	500	0	0
2024-05-08	3	500	0	0
2024-05-09	3	500	1050	0
2024-05-10	3	500	8050	0
2024-05-15	3	500	1500	0
2024-05-16	3	500	0	0
2024-05-17	3	500	0	0
2024-05-18	3	500	1350	0
2024-05-22	3	500	2400	0
2024-05-24	3	500	300	0
2024-05-25	3	500	1300	0
2024-05-26	3	500	0	0
2024-05-27	3	500	0	0
2024-05-28	3	500	0	0
2024-05-29	3	500	0	0
2024-05-30	3	500	500	0
2024-05-04	2	500	320	0
2024-05-08	2	500	0	0
2024-05-09	2	500	816	0
2024-05-10	2	500	6652	0
2024-05-11	2	500	2360	0
2024-05-13	2	500	2120	0
2024-05-27	2	500	0	0
2024-05-28	2	500	0	0
2024-05-29	2	500	0	0
2024-05-30	2	500	400	0
2024-05-30	4	0	0	0
2024-05-30	4	0	0	0
2024-05-30	4	0	0	0
2024-05-30	4	0	0	0
2024-06-01	4	500	700	0
2024-06-02	4	500	3400	0
2024-06-03	4	500	1820	0
2024-06-04	4	500	3070	0
2024-06-05	3	500	1520	0
2024-06-05	2	500	1216	0
2024-06-05	4	500	3040	0
2024-06-11	4	500	3080	0
2024-06-01	3	500	350	0
2024-06-02	3	500	1700	0
2024-06-03	3	500	910	0
2024-06-04	3	500	1535	0
2024-06-01	2	500	280	0
2024-06-02	2	500	1360	0
2024-06-03	2	500	728	0
2024-06-04	2	500	1228	0
2024-06-06	2	500	0	0
2024-06-07	2	500	1800	0
2024-06-08	2	500	240	0
2024-06-09	2	500	1040	0
2024-06-10	2	500	2096	0
2024-06-11	2	500	1592	0
2024-06-12	4	500	2200	0
2024-06-12	2	500	1480	0
2024-06-14	2	500	0	0
2024-06-15	3	500	9740	0
2024-06-15	4	500	7200	0
2024-06-15	20	500	11000	0
2024-06-06	3	500	0	0
2024-07-24	7	500	5300	0
2024-07-25	18	500	9920	0
2024-07-26	7	500	7500	0
2024-06-15	2	500	7792	0
2024-06-15	2	500	7792	0
2024-06-17	2	500	1928	0
2024-06-17	4	500	2820	0
2024-06-17	20	500	2000	0
2024-06-18	4	500	2500	0
2024-06-18	20	500	1700	0
2024-06-19	20	500	300	0
2024-06-20	20	500	1800	0
2024-06-22	4	500	4400	0
2024-06-23	20	500	500	0
2024-06-24	20	500	2000	0
2024-06-25	4	500	2100	0
2024-06-25	20	500	700	0
2024-06-26	4	500	1200	0
2024-06-26	20	500	600	0
2024-06-27	4	500	1640	0
2024-06-28	4	500	1200	0
2024-06-29	4	500	2280	0
2024-06-29	20	500	1100	0
2024-06-30	4	500	2160	0
2024-06-30	20	500	3100	0
2024-06-13	2	500	4080	0
2024-06-16	2	500	600	0
2024-06-18	2	500	1680	0
2024-06-19	2	500	2600	0
2024-06-20	2	500	720	0
2024-06-21	2	500	1520	0
2024-06-22	2	500	4810	0
2024-06-23	2	500	4800	0
2024-06-24	2	500	2200	0
2024-06-25	2	500	1120	0
2024-06-26	2	500	720	0
2024-06-27	2	500	656	0
2024-06-28	2	500	480	0
2024-06-29	2	500	2052	0
2024-06-30	2	500	3504	0
2024-06-07	3	500	2250	0
2024-06-08	3	500	300	0
2024-06-09	3	500	1300	0
2024-06-10	3	500	1000	0
2024-06-11	3	500	3610	0
2024-06-12	3	500	1850	0
2024-06-13	3	500	4210	0
2024-06-16	3	500	750	0
2024-06-17	3	500	2410	0
2024-06-20	3	500	900	0
2024-06-21	3	500	1400	0
2024-06-22	3	500	5075	0
2024-06-23	3	500	2300	0
2024-06-24	3	500	1500	0
2024-06-27	3	500	820	0
2024-06-29	3	500	1940	0
2024-06-30	3	500	3110	0
2024-07-01	4	500	2600	0
2024-07-02	4	500	640	0
2024-07-02	20	500	800	0
2024-07-03	20	500	500	0
2024-07-04	20	500	2000	0
2024-07-06	20	500	810	0
2024-07-10	20	500	600	0
2024-07-11	18	500	1000	0
2024-07-14	18	500	6420	0
2024-07-16	20	500	1900	0
2024-07-16	18	500	3200	0
2024-07-17	20	500	4500	0
2024-07-17	18	500	4500	0
2024-07-20	7	500	3440	0
2024-07-20	20	500	1000	0
2024-07-20	18	500	4000	0
2024-07-21	7	500	4200	0
2024-07-21	18	500	7200	0
2024-07-22	7	500	5200	0
2024-07-22	18	500	4680	0
2024-07-04	4	500	1520	0
2024-07-27	7	500	6600	0
2024-07-27	20	500	600	0
2024-07-27	18	500	4000	0
2024-07-08	18	500	2400	0
2024-07-09	18	500	4700	0
2024-07-10	18	500	5980	0
2024-07-12	18	500	3880	0
2024-07-18	18	500	3960	0
2024-07-19	18	500	5840	0
2024-07-26	18	500	5240	0
2024-07-07	18	500	5000	0
2024-07-07	7	500	1700	0
2024-07-08	7	500	2000	0
2024-07-10	7	500	2200	0
2024-07-11	7	500	3800	0
2024-07-17	7	500	5100	0
2024-07-19	7	500	6100	0
2024-07-23	7	500	6600	0
2024-07-02	2	500	3896	0
2024-07-18	7	500	7440	0
2024-06-07	20	500	4800	0
2024-06-09	20	500	2100	0
2024-06-10	20	500	3340	0
2024-06-11	20	500	2700	0
2024-06-12	20	500	1500	0
2024-06-13	20	500	5400	0
2024-06-16	20	500	600	0
2024-07-09	20	500	400	0
2024-06-07	20	500	4800	0
2024-06-09	20	500	2100	0
2024-06-10	20	500	3340	0
2024-06-11	20	500	2700	0
2024-06-12	20	500	1500	0
2024-07-25	7	500	4880	0
2024-07-05	2	500	3000	0
2024-07-16	2	500	3160	0
2024-07-06	18	500	1800	0
2024-07-09	7	500	7220	0
2024-07-09	2	500	5540	0
2024-07-14	2	500	5538	0
2024-07-15	2	500	1168	0
2024-07-27	2	500	4480	0
2024-07-01	3	500	1750	0
2024-07-04	3	500	5810	0
2024-07-05	3	500	3750	0
2024-07-14	3	0	0	0
2024-07-15	3	500	2480	0
2024-07-16	3	500	3900	0
2024-07-01	2	500	2200	0
2024-07-23	18	500	5300	0
2024-07-24	18	500	3800	0
2024-06-13	20	500	5400	0
2024-06-16	20	500	600	0
2024-07-09	20	500	400	0
2024-07-07	20	500	1300	0
2024-07-28	7	500	7000	0
2024-07-28	20	500	3000	0
2024-08-05	18	500	2700	1000
2024-08-05	2	500	3560	1000
2024-07-02	3	500	1920	0
2024-07-03	3	500	250	0
2024-07-08	3	500	2200	0
2024-07-09	3	500	6560	0
2024-07-10	3	500	4390	0
2024-07-11	3	500	2400	0
2024-07-12	3	500	1940	0
2024-07-17	3	500	7050	0
2024-07-18	3	500	5700	0
2024-07-19	3	500	5950	0
2024-07-20	3	500	4520	0
2024-07-23	3	500	5800	0
2024-07-25	3	500	8300	0
2024-07-27	3	0	0	0
2024-07-03	2	500	200	0
2024-07-04	2	500	4388	0
2024-08-05	3	500	4450	0
2024-07-07	2	500	12972	0
2024-07-08	2	500	1760	0
2024-07-10	2	500	3512	0
2024-07-11	2	500	1920	0
2024-07-12	2	500	1552	0
2024-07-17	2	500	5640	0
2024-07-18	2	0	0	0
2024-07-19	2	500	4776	0
2024-07-20	2	500	4216	0
2024-07-21	2	500	4560	0
2024-07-22	2	500	3920	0
2024-07-23	2	500	4640	0
2024-08-05	7	500	5300	0
2024-07-25	2	500	7500	0
2024-07-26	2	500	5096	0
2024-07-28	2	500	6176	0
2024-07-31	18	500	6040	0
2024-08-01	18	500	3400	0
2024-08-18	7	500	4600	0
2024-08-06	18	500	2400	0
2024-08-06	2	500	3856	0
2024-08-06	3	500	4820	0
2024-08-06	7	500	2400	0
2024-08-07	18	500	7600	0
2024-08-07	2	0	6280	0
2024-08-08	2	500	9808	0
2024-08-08	3	500	9710	0
2024-08-08	18	500	4200	0
2024-07-31	7	500	5800	0
2024-08-01	7	500	6000	0
2024-08-09	18	500	6320	0
2024-07-29	7	500	4000	0
2024-07-30	7	500	3000	0
2024-07-30	18	500	6500	0
2024-07-30	3	500	7525	0
2024-08-02	18	500	3600	0
2024-08-02	7	500	6500	0
2024-08-03	18	500	6600	0
2024-08-09	7	500	5640	0
2024-08-04	18	500	3940	0
2024-08-09	2	500	6904	0
2024-07-31	2	500	4736	0
2024-08-01	2	500	5860	0
2024-08-09	3	500	8630	0
2024-08-04	7	500	4200	0
2024-08-04	2	500	7632	0
2024-08-03	7	500	6480	0
2024-07-31	3	500	5920	0
2024-08-02	3	500	5050	0
2024-08-03	2	500	5232	0
2024-08-03	3	500	6540	0
2024-08-04	3	500	7290	0
2024-07-06	2	500	1064	0
2024-07-06	3	500	1455	0
2024-07-13	3	500	13150	0
2024-07-13	18	500	6800	0
2024-07-13	2	500	12920	0
2024-07-24	2	500	3760	0
2024-07-24	3	500	4700	0
2024-07-28	3	500	7740	0
2024-07-28	18	500	4640	0
2024-07-29	2	500	3056	0
2024-07-29	3	500	3820	0
2024-07-29	18	500	2840	0
2024-08-10	18	500	4200	0
2024-08-10	2	500	7280	0
2024-08-10	3	500	9680	0
2024-08-10	7	500	5500	0
2024-08-11	3	500	9050	0
2024-08-11	2	500	7240	0
2024-08-11	7	500	9900	0
2024-08-15	2	500	2600	0
2024-08-15	18	500	5440	0
2024-08-17	7	500	6900	0
2024-08-18	3	500	9250	0
2024-08-18	2	500	7400	0
2024-08-18	18	500	8600	0
2024-08-19	2	500	800	0
2024-08-19	7	500	9980	0
2024-08-20	7	500	5700	0
2024-08-20	18	500	4200	0
2024-08-20	2	500	8220	0
2024-08-20	3	500	9950	0
2024-08-11	18	500	8000	0
2024-08-12	18	500	3850	0
2024-08-12	7	500	5000	0
2024-08-13	18	500	4900	0
2024-08-13	7	500	7000	0
2024-08-14	18	500	3500	0
2024-08-14	7	500	3200	0
2024-08-16	7	500	4500	0
2024-08-16	18	500	5300	0
2024-08-17	18	500	4400	0
2024-08-19	18	500	3880	0
2024-08-21	7	500	6100	0
2024-08-21	18	500	7520	0
2024-08-22	7	500	4400	0
2024-08-22	18	500	700	0
2024-08-23	7	500	3440	0
2024-08-23	18	500	640	0
2024-08-24	2	500	1300	0
2024-08-24	7	500	3100	0
2024-08-24	18	500	800	0
2024-08-25	2	500	300	0
2024-08-25	7	500	3550	0
2024-08-25	18	500	5200	0
2024-08-26	2	500	1000	0
2024-08-26	7	500	1000	0
2024-08-26	18	500	5400	0
2024-08-27	3	500	1800	0
2024-08-27	2	500	1200	0
2024-08-27	18	500	1400	0
2024-08-28	7	500	1550	0
2024-08-28	18	500	3700	0
2024-08-29	7	500	4600	0
2024-08-29	18	500	1000	0
2024-08-30	2	500	300	0
2024-08-30	7	500	2500	0
2024-08-30	18	500	3600	0
2024-08-31	7	500	7640	0
2024-08-31	18	500	5000	0
2024-09-01	7	500	2000	0
2024-09-01	18	500	2700	0
2024-09-02	7	500	2000	0
2024-09-03	2	500	1000	0
2024-09-10	3	500	300	0
2024-09-10	2	500	600	0
2024-09-10	7	500	1800	0
2024-09-10	3	500	300	0
2024-09-10	2	500	600	0
2024-09-10	7	500	1800	0
2024-09-11	2	500	500	0
2024-09-11	7	500	4400	0
2024-09-12	7	500	6000	0
2024-09-16	2	500	2320	0
2024-09-16	7	500	7200	0
2024-09-16	18	500	2240	0
2024-09-17	7	500	8880	0
2024-09-22	7	500	5440	0
2024-09-22	18	500	1000	0
2024-09-25	3	500	2250	0
2024-09-25	2	500	1800	1000
2024-09-25	7	500	2000	0
2024-09-26	3	500	1500	0
2024-09-26	2	500	1200	0
2024-09-26	7	500	2200	0
2024-09-27	2	500	1536	0
2024-09-28	2	500	4456	0
2024-09-29	3	500	2225	0
2024-09-29	2	500	1780	0
2024-09-30	3	500	1620	0
2024-09-30	2	500	1296	0
2024-10-03	3	500	1150	0
2024-10-03	2	500	920	0
2024-10-03	7	500	2300	0
2024-10-06	3	500	6825	0
2024-10-06	2	500	5460	0
2024-10-06	7	500	3250	0
2024-10-06	18	500	9800	0
2024-10-07	2	500	4240	0
2024-10-07	7	500	4100	0
2024-10-08	2	500	4600	0
2024-10-08	7	500	7200	0
\.


--
-- Data for Name: sources; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.sources (id, title, deleted_at) FROM stdin;
1	Интернет	\N
2	Поляна	\N
3	Отели	\N
4	Агенты	\N
6	Инфо офис	\N
5	Стойка	2024-05-06 13:58:23.668313
\.


--
-- Data for Name: techniques; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.techniques (id, title, type_technique_id, investor_id, archive, visible, "position", deleted_at) FROM stdin;
6	Другой снегоход	1	1	f	t	10	\N
4	Stels 4	1	6	t	t	4	\N
2	Stels 2	1	5	t	t	2	\N
3	Stels 3	1	2	t	t	3	\N
1	Stels 1	1	5	t	t	1	\N
5	Stels 5	1	6	f	t	5	\N
39	Stels 6	1	1	f	t	6	\N
40	Stels 7	1	1	f	t	7	\N
41	Stels 8	1	1	f	t	8	\N
42	Stels 9	1	1	f	t	9	\N
8	Сокол 2	2	7	f	t	12	\N
9	Сокол 3	2	4	f	t	13	\N
10	Сокол 4	2	4	f	t	14	\N
11	Сокол 5	2	4	f	t	15	\N
12	Сокол 6	2	3	f	t	16	\N
35	Другой квадроцикл	3	1	f	t	39	\N
14	Другой	2	1	t	t	18	\N
13	Сокол 7	2	3	f	t	17	\N
49	Stels 2	1	5	f	t	2	\N
50	Stels 3	1	2	f	t	3	\N
51	Stels 4	1	6	f	t	4	\N
45	Stels Самат 2	1	5	t	t	2	\N
46	Stels Джамал 	1	2	t	t	3	\N
7	Сокол 1	2	6	t	t	11	\N
47	Stels Сергей 4	1	6	t	t	4	\N
43	Другой вездеход	2	1	t	t	18	\N
44	Stels Самат 1	1	5	t	t	1	\N
48	Stels 1	1	5	f	t	1	\N
52	Сокол 1	2	6	f	t	11	\N
53	Другой вездеход	2	1	f	t	18	\N
15	TGB 1	3	\N	f	t	19	\N
16	TGB 2	3	\N	f	t	20	\N
17	TGB 3	3	\N	f	t	21	\N
18	TGB 4	3	\N	f	t	22	\N
19	TGB 5	3	\N	f	t	23	\N
20	TGB 6	3	\N	f	t	24	\N
21	TGB 7	3	\N	f	t	25	\N
22	TGB 8	3	\N	f	t	26	\N
23	TGB 9	3	\N	f	t	27	\N
24	TGB 10	3	\N	f	t	28	\N
25	TGB 11	3	\N	f	t	29	\N
26	TGB 12	3	\N	f	t	30	\N
27	TGB 13	3	\N	f	t	31	\N
28	TGB 14	3	\N	f	t	32	\N
29	TGB 15	3	\N	f	t	33	\N
30	TGB 16	3	\N	f	t	34	\N
31	TGB 17	3	\N	f	t	35	\N
32	TGB 18	3	\N	f	t	36	\N
33	TGB 19	3	\N	f	t	37	\N
34	TGB 20	3	\N	f	t	38	\N
\.


--
-- Data for Name: type_expenses; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.type_expenses (id, title, visible_investor, visible_employee, "position", category_exp_id, deleted_at) FROM stdin;
1	Питание	f	f	1	1	\N
19	Аптека	f	f	2	1	\N
7	Расходники	f	f	3	2	\N
8	Репутационные издержки	f	f	4	2	\N
2	Бензин на машину	f	f	5	2	\N
3	Ремонт машины	f	f	6	2	\N
5	Услуги связи	f	f	7	2	\N
80	Снаряжение	f	f	8	2	\N
83	Налог	f	f	9	2	\N
84	Командировка	f	f	10	2	\N
85	Поддержка таблицы	f	f	11	3	\N
9	Рекламные материалы	f	f	12	3	\N
86	Фотограф	f	f	13	3	\N
87	Подписки	f	f	14	3	\N
88	Софт	f	f	15	3	\N
89	Оборудование	f	f	16	3	\N
90	Визитки	f	f	17	4	\N
91	Слайдер	f	f	18	4	\N
92	Книги	f	f	19	4	\N
93	Буклеты	f	f	20	4	\N
94	Канцелярия	f	f	21	4	\N
95	SEO	f	f	22	5	\N
139	Доработки сайта	f	f	23	5	\N
96	Инстаграм	f	f	24	5	\N
97	Закупка рекламы	f	f	25	5	\N
13	Премия	f	t	26	6	\N
12	Аванс	f	t	27	6	\N
11	Процент	f	t	28	6	\N
136	Оклад	f	t	29	6	\N
15	Проценты агентам	f	f	30	7	\N
98	Проценты курорту	f	f	31	7	\N
16	Аренда земли	f	f	32	7	\N
17	Аренда стойки	f	f	33	7	\N
14	Дивиденды	t	f	34	7	\N
99	Кешбек за отзывы	f	f	35	7	\N
18	Прочее	f	f	36	8	\N
100	Уточнить	f	f	37	8	\N
\.


--
-- Data for Name: type_operations; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.type_operations (id, title, visible_type_technique, visible_canisters, visible_amount, visible_cost_fuel, visible_technique, visible_description, deleted_at) FROM stdin;
1	Покупка бензина	f	t	t	t	f	f	\N
2	Заправка бензина	t	t	f	t	f	f	\N
6	Поломка техники	f	f	f	f	t	t	\N
7	Небольшая поломка	f	f	f	f	t	t	\N
8	Починка техники	f	f	f	f	t	t	\N
9	Заправка рабочей машины	f	f	t	f	f	t	\N
3	Питание персонала	f	f	t	f	f	t	2024-03-23 15:41:27.476481
4	Покупка запчастей	t	f	t	f	t	t	\N
5	Оплата ремонта	t	f	t	f	t	t	\N
\.


--
-- Data for Name: type_techniques; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.type_techniques (id, title, deleted_at) FROM stdin;
1	Снегоходы	\N
2	Вездеходы	\N
3	Квадроциклы	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.users (id, tg, full_name, is_manager, is_instructor, is_assistant, send_button, deposit_income, enter_operation, view_salary, contribute_expense, is_director, chat_id, comission, penalty, is_investor) FROM stdin;
21	инструкторы		f	f	f	t	f	f	f	f	f	\N	f	f	f
3	promiiinad	Самат	f	t	f	t	f	f	t	f	t	498590409	f	f	f
2	heytward	Ахматик	t	t	f	t	t	t	t	t	f	702856294	f	f	f
7	zarikw	Назар	f	t	f	t	f	f	t	f	f	276700108	f	f	f
14	roglasss	Ренат	f	f	f	t	f	f	t	f	f	1044795623	f	f	f
4	bostibra	Ибрашка	f	t	f	t	f	f	t	f	f	5649904178	f	f	f
11	alinochkaaa19	Алина	f	f	t	t	f	f	t	f	f	549667668	t	f	f
20	muhammadkip09	Мухаммад	f	t	f	t	f	f	f	f	f	6001450746	f	f	f
18	tommy359	Амир	f	t	f	t	f	f	t	f	f	5834993171	f	f	f
25	tokov17	Ренат 	f	t	f	t	f	f	f	f	f	\N	f	f	f
10		Другой	f	t	f	t	f	f	t	f	f	\N	f	f	f
22	andreylikhanov	Андрей	f	t	f	t	t	t	t	t	f	268398735	t	t	t
27	pavel_er	Павел	f	t	f	t	t	t	t	t	f	429567381	t	t	t
1	axm9t	Ахмат	f	f	f	t	f	t	t	t	f	1129601494	f	t	t
26	axm9t	Ахмат	f	f	f	t	f	t	t	t	f	1129601494	f	t	t
\.


--
-- Data for Name: web_users; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.web_users (id, username, password, role) FROM stdin;
4	superuser	$2b$12$cIPHAggzpO0PhgryVPSLlOmq2r2nC0oCMExKpXFq2nAlHSg7Jd0hC	admin
1	admin	$2b$12$VnNb3bDQXS9eDaotpGmouONvApR44FM4ebmQ0oTnwOmx1egvgARRW	admin
5	web-user	$2b$12$Xv.nTP2W0x491BIdauxVB.BRIv3xxK2qYcbGuC5u7U7Xht3mJuTZC	user
\.


--
-- Name: category_expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.category_expenses_id_seq', 9, true);


--
-- Name: comissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.comissions_id_seq', 4, true);


--
-- Name: day_employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.day_employees_id_seq', 151, true);


--
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.expenses_id_seq', 244, true);


--
-- Name: flight_techniques_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.flight_techniques_id_seq', 5952, true);


--
-- Name: flights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.flights_id_seq', 2779, true);


--
-- Name: hotels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.hotels_id_seq', 1, true);


--
-- Name: investors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.investors_id_seq', 7, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.messages_id_seq', 5034, true);


--
-- Name: oil_coefs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.oil_coefs_id_seq', 1, true);


--
-- Name: operacions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.operacions_id_seq', 9, true);


--
-- Name: operations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.operations_id_seq', 965, true);


--
-- Name: payment_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.payment_types_id_seq', 6, true);


--
-- Name: penalties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.penalties_id_seq', 34, true);


--
-- Name: ranks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.ranks_id_seq', 3, true);


--
-- Name: route_costs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.route_costs_id_seq', 113, true);


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.routes_id_seq', 8, true);


--
-- Name: sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.sources_id_seq', 6, true);


--
-- Name: techniques_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.techniques_id_seq', 53, true);


--
-- Name: type_expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.type_expenses_id_seq', 139, true);


--
-- Name: type_technique_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.type_technique_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.users_id_seq', 27, true);


--
-- Name: web_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db_admin
--

SELECT pg_catalog.setval('public.web_users_id_seq', 5, true);


--
-- Name: category_expenses category_expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.category_expenses
    ADD CONSTRAINT category_expenses_pkey PRIMARY KEY (id);


--
-- Name: comissions comissions_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.comissions
    ADD CONSTRAINT comissions_pkey PRIMARY KEY (id);


--
-- Name: day_employees day_employees_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.day_employees
    ADD CONSTRAINT day_employees_pkey PRIMARY KEY (id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: flight_techniques flight_techniques_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.flight_techniques
    ADD CONSTRAINT flight_techniques_pkey PRIMARY KEY (id);


--
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (id);


--
-- Name: hotels hotels_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_pkey PRIMARY KEY (id);


--
-- Name: investors investors_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.investors
    ADD CONSTRAINT investors_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: oil_coefs oil_coefs_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.oil_coefs
    ADD CONSTRAINT oil_coefs_pkey PRIMARY KEY (id);


--
-- Name: type_operations operacions_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.type_operations
    ADD CONSTRAINT operacions_pkey PRIMARY KEY (id);


--
-- Name: operations operations_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.operations
    ADD CONSTRAINT operations_pkey PRIMARY KEY (id);


--
-- Name: payment_types payment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.payment_types
    ADD CONSTRAINT payment_types_pkey PRIMARY KEY (id);


--
-- Name: penalties penalties_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.penalties
    ADD CONSTRAINT penalties_pkey PRIMARY KEY (id);


--
-- Name: route_costs route_costs_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.route_costs
    ADD CONSTRAINT route_costs_pkey PRIMARY KEY (id);


--
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (id);


--
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: techniques techniques_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.techniques
    ADD CONSTRAINT techniques_pkey PRIMARY KEY (id);


--
-- Name: type_expenses type_expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.type_expenses
    ADD CONSTRAINT type_expenses_pkey PRIMARY KEY (id);


--
-- Name: type_techniques type_technique_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.type_techniques
    ADD CONSTRAINT type_technique_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: web_users web_users_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.web_users
    ADD CONSTRAINT web_users_pkey PRIMARY KEY (id);


--
-- Name: web_users web_users_username_key; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.web_users
    ADD CONSTRAINT web_users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

