## Создание и заполнение БД
Файл [DDL.sql](https://github.com/stmax22/Car_dealership/blob/4250a81592d4a0f5ed91f7681ac6dbb9fff2d7e1/DDL.sql) создаёт схемы и таблицы для автосалона.

Файл [DML.sql](https://github.com/stmax22/Car_dealership/blob/4250a81592d4a0f5ed91f7681ac6dbb9fff2d7e1/DML.sql) заполняет таблицы автосалона данными.

### Описание таблиц
#### Таблица sales
Содержит сырые данные из csv файла.
| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | integer | ID сделки, первичный ключ |
| `auto` | varchar | Бренд автомобиля |
| `gasoline_consumption` | real | Потребление топлива на 100 км |
| `price` | numeric(9, 2) | Цена в $ с учётом скидки |
| `date` | date | Дата сделки |
| `person_name` | varchar | Ф.И.О. клиента |
| `phone` | varchar | Номер телефона клиента |
| `discount` | smallint | Скидка в процентах |
| `brand_origin` | varchar | Название страны |

#### Таблица colors
Описывает возможные цвета автомобилей.
| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | integer | ID цвета, первичный ключ |
| `name` | varchar | Название цвета |

#### Таблица clients
Содержит информацию о клиентах.
| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | integer | ID клиента, первичный ключ |
| `name` | varchar | Ф.И.О. клиента |
| `phone` | varchar | Номер телефона клиента |

#### Таблица brand_origin
Содержит информацию о странах-производителях.
| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | integer | ID страны, первичный ключ |
| `name` | varchar | Название страны |

#### Таблица brand_name
Содержит информацию о брендах авто.
| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | integer | ID бренда, первичный ключ |
| `name` | varchar | Бренд автомобиля |
| `brand_origin_id` | integer | Внешний ключ на brand_origin(id) |

#### Таблица autos
Содержит информацию об автомобилях.
| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | integer | ID автомобиля, первичный ключ |
| `model_name` | varchar | Модель автомобиля |
| `gasoline_consumption` | numeric(3, 1) | Потребление топлива на 100 км |
| `brand` | integer | Внешний ключ на brand_name(id) |

#### Таблица color_autos
Соединяющая таблица для создания связи "многие ко многим".
| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | integer | Первичный ключ |
| `auto_id` | integer | Внешний ключ на autos(id) |
| `color_id` | integer | Внешний ключ на colors(id) |

#### Таблица sales
Содержит данные о всех сделках.
| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | integer | ID сделки, первичный ключ |
| `date` | date | Дата сделки |
| `price` | numeric(9, 2) | Цена в $ с учётом скидки |
| `discount` | smallint | Скидка в процентах |
| `color_autos_id` | integer | Внешний ключ на color_autos(id) |
| `client_id` | integer | Внешний ключ на clients(id) |

#### Диаграмма
![](https://github.com/stmax22/Car_dealership/blob/4250a81592d4a0f5ed91f7681ac6dbb9fff2d7e1/diagram.png)

## Запросы к данным
Файл [DQL.sql](https://github.com/stmax22/Car_dealership/blob/4250a81592d4a0f5ed91f7681ac6dbb9fff2d7e1/DQL.sql) содержит запросы к данными для аналитики.