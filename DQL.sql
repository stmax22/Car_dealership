-- 1. Запрос, который выведет процент моделей машин, у которых нет параметра `gasoline_consumption`.
SELECT (COUNT(id) - COUNT(gasoline_consumption)) / (COUNT(id)::REAL / 100) AS nulls_percentage_gasoline_consumption
FROM car_shop.autos AS a;


-- 2. Запрос, который покажет название бренда и среднюю цену его автомобилей в разбивке по всем годам с учётом скидки.
SELECT
	bn.name,
	EXTRACT(YEAR FROM s.date) AS year,
	ROUND(AVG(s.price), 2) AS price_avg
FROM car_shop.brand_name AS bn
INNER JOIN car_shop.autos AS a ON bn.id = a.brand
INNER JOIN car_shop.color_autos AS ca ON a.id = ca.auto_id
INNER JOIN car_shop.sales AS s ON ca.id = s.color_autos_id
GROUP BY bn.name, EXTRACT(YEAR FROM s.date)
ORDER BY bn.name, EXTRACT(YEAR FROM s.date);

-- 3. Запрос, который считает среднюю цену всех автомобилей с разбивкой по месяцам в 2022 году с учётом скидки.
SELECT
	EXTRACT(MONTH FROM s.date) AS month,
	EXTRACT(YEAR FROM s.date) AS year,
	ROUND(AVG(s.price), 2) AS price_avg
FROM car_shop.sales AS s
WHERE EXTRACT(YEAR FROM s.date) = 2022
GROUP BY EXTRACT(MONTH FROM s.date), EXTRACT(YEAR FROM s.date)
ORDER BY month;

-- 4. Запрос, который выведет список купленных машин у каждого пользователя.
SELECT
	c.name AS person,
	STRING_AGG(bn.name || ' ' || a.model_name, ', ') AS cars
FROM car_shop.brand_name AS bn
INNER JOIN car_shop.autos AS a ON bn.id = a.brand
INNER JOIN car_shop.color_autos AS ca ON a.id = ca.auto_id
INNER JOIN car_shop.sales AS s ON ca.id = s.color_autos_id
INNER JOIN car_shop.clients AS c ON s.client_id = c.id
GROUP BY c.name
ORDER BY person;

-- 5. Запрос, который вернёт самую большую и самую маленькую цену продажи автомобиля с разбивкой по стране без учёта скидки.
SELECT 
	b.name AS brand_origin,
	ROUND(MAX((s.price * 100) / (100 - s.discount)), 2) AS price_max,
	ROUND(MIN((s.price * 100) / (100 - s.discount)), 2) AS price_min
FROM car_shop.brand_origin AS b
INNER JOIN car_shop.brand_name AS bn ON b.id = bn.brand_origin_id
INNER JOIN car_shop.autos AS a ON bn.id = a.brand
INNER JOIN car_shop.color_autos AS ca ON a.id = ca.auto_id
INNER JOIN car_shop.sales AS s ON ca.id = s.color_autos_id
GROUP BY b.name;

-- 6. Запрос, который покажет количество всех пользователей из США.
SELECT COUNT(phone) AS persons_from_usa_count
FROM car_shop.clients
WHERE phone LIKE '+1%';