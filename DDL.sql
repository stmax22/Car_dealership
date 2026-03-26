-- Создаем схему raw_data.
CREATE SCHEMA IF NOT EXISTS raw_data;

-- Создаем таблицу для хранения сырых данных.
CREATE TABLE IF NOT EXISTS raw_data.sales(
	id INTEGER,
	auto VARCHAR,
	gasoline_consumption REAL,
	price NUMERIC(9, 2),
	date DATE,
	person_name VARCHAR,
	phone VARCHAR,
	discount SMALLINT,
	brand_origin VARCHAR
);

-- Создаем схему car_shop.
CREATE SCHEMA IF NOT EXISTS car_shop;

-- Создаем таблицу для хранения цвета авто.
CREATE TABLE car_shop.colors(
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL UNIQUE
);

-- Создаем таблицу для хранения данных о клиентах.
CREATE TABLE car_shop.clients(
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL,
	phone VARCHAR NOT NULL,
	CONSTRAINT clients_unique UNIQUE(name, phone)
);

-- Создаем таблицу для хранения страны производителя авто.
CREATE TABLE car_shop.brand_origin(
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL
);

-- Создаем таблицу для хранения брендов авто.
CREATE TABLE car_shop.brand_name(
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL UNIQUE,
	brand_origin_id INTEGER REFERENCES car_shop.brand_origin(id)
); 

-- Создаем таблицу для хранения данных о авто.
CREATE TABLE car_shop.autos(
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	model_name VARCHAR NOT NULL UNIQUE,
	gasoline_consumption NUMERIC(3, 1),
	brand INTEGER REFERENCES car_shop.brand_name(id)
);

-- Создаем таблицу для связи (многие ко многим) авто с цветом.
CREATE TABLE car_shop.color_autos(
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	auto_id INTEGER REFERENCES car_shop.autos(id) NOT NULL,
	color_id INTEGER REFERENCES car_shop.colors(id) NOT NULL
);

-- Создаем таблицу для хранения данных о продаже авто.
CREATE TABLE car_shop.sales(
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	date DATE NOT NULL,
	price NUMERIC(9, 2) NOT NULL,
	discount SMALLINT DEFAULT 0,
	color_autos_id INTEGER REFERENCES car_shop.color_autos(id),
	client_id INTEGER REFERENCES car_shop.clients(id)
);