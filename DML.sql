-- Заполняем таблицу сырыми данными из csv файла.
COPY raw_data.sales FROM 'D:\Car_dealership\cars.csv'
WITH (FORMAT CSV, HEADER, NULL 'null');

-- Заполняем таблицу цветами авто.
INSERT INTO car_shop.colors(
	name
) 
SELECT DISTINCT
	SPLIT_PART(auto, ', ', -1)
FROM raw_data.sales;

-- Заполняем таблицу данными о клиентах.
INSERT INTO car_shop.clients(
	name,
	phone
)
SELECT DISTINCT
	person_name,
	phone
FROM raw_data.sales;

-- Заполняем таблицу данными о странах производителей авто.
INSERT INTO car_shop.brand_origin(
	name
)
SELECT DISTINCT
	brand_origin
FROM raw_data.sales
WHERE brand_origin IS NOT NULL;

-- Заполняем таблицу данными брендов.
INSERT INTO car_shop.brand_name(
	name,
	brand_origin_id
)
SELECT DISTINCT 
	SPLIT_PART(SPLIT_PART(s.auto, ', ', 1), ' ', 1),
	b.id
FROM raw_data.sales AS s
LEFT JOIN car_shop.brand_origin AS b ON b.name = s.brand_origin;

-- Заполняем таблицу данными о авто.
INSERT INTO car_shop.autos(
	model_name, 
	gasoline_consumption, 
	brand
)
SELECT DISTINCT 
	SUBSTR(SPLIT_PART(s.auto, ', ', 1), (STRPOS(SPLIT_PART(s.auto, ', ', 1), ' ') + 1)),
	s.gasoline_consumption,
	b.id
FROM raw_data.sales AS s
LEFT JOIN car_shop.brand_name AS b ON b.name = SPLIT_PART(SPLIT_PART(s.auto, ', ', 1), ' ', 1);

-- Заполняем таблицу id-шниками авто и цветом этого авто.
INSERT INTO car_shop.color_autos(
	auto_id,
	color_id
)
SELECT DISTINCT
	a.id,
	c.id
FROM raw_data.sales AS s
LEFT JOIN car_shop.brand_name AS b ON b.name = SPLIT_PART(SPLIT_PART(s.auto, ', ', 1), ' ', 1)
LEFT JOIN car_shop.autos AS a ON s.auto LIKE (b.name || ' ' || a.model_name || '%')
LEFT JOIN car_shop.colors AS c ON c.name = SPLIT_PART(s.auto, ', ', -1);

-- Заполняем таблицу данными о продаже авто.
INSERT INTO car_shop.sales(
	date,
	price,
	discount,
	color_autos_id,
	client_id
)
SELECT DISTINCT 
	s.date, 
	s.price, 
	s.discount,
	ca.id,
	cl.id
FROM raw_data.sales AS s
LEFT JOIN car_shop.autos AS a ON a.model_name = SUBSTR(SPLIT_PART(s.auto, ', ', 1), (STRPOS(SPLIT_PART(s.auto, ', ', 1), ' ') + 1))
LEFT JOIN car_shop.colors AS c ON c.name = SPLIT_PART(auto, ', ', -1)
LEFT JOIN car_shop.color_autos AS ca ON a.id = ca.auto_id AND c.id = ca.color_id
LEFT JOIN car_shop.clients AS cl ON cl.name = s.person_name AND cl.phone = s.phone;