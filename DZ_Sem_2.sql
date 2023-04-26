DROP DATABASE IF EXISTS dz_sem_2;
CREATE DATABASE dz_sem_2;
USE dz_sem_2;



-- ЗАДАЧА 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными.
-- Создание таблицы "sales".

CREATE TABLE sales
(
   id SERIAL PRIMARY KEY,
   order_data Date NOT NULL,
   count_product INT DEFAULT 0
);


-- Заполнение таблицы данными.
INSERT INTO `sales` (order_data, count_product)
VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);


-- Задача 2. Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва :
-- меньше 100 - Маленький заказ;
-- от 100 до 300 - Средний заказ; 
-- больше 300 - Большой заказ.

SELECT 
	id AS 'Номер закза',
	order_data AS 'Дата заказа',
	count_product AS 'Количество штук товара',
	CASE 
		WHEN count_product < 100 THEN 'Маленький заказ'
		WHEN count_product BETWEEN 100 AND 300 THEN 'Средний заказ'
		WHEN count_product > 300 THEN 'Большой заказ'
		ELSE 'Нет заказа'
	END AS 'Тип заказа'	
FROM sales;
 
SELECT 
     id AS 'Номер закза',
     order_data AS 'Дата заказа',
     count_product AS 'Количество штук товара',
     IF (count_product < 100, 'Маленький заказ',
       IF(count_product BETWEEN 100 AND 300, 'Средний заказ',
         IF(count_product > 300, 'Большой заказ', 'Нет заказа')
       )  
     )AS 'Тип заказа'
FROM sales; 


-- Задача 3. Создайте таблицу “orders”, заполните ее значениями. 
-- Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status: 
-- OPEN – «Order is in open state» ; 
-- CLOSED - «Order is closed»; 
-- CANCELLED - «Order is cancelled»

CREATE TABLE orders
(
   id SERIAL PRIMARY KEY,
   employee_id VARCHAR(10) NOT NULL UNIQUE,
   amount FLOAT DEFAULT 0
);


-- Заполнение таблицы данными.
INSERT INTO `orders` (employee_id, amount)
VALUES
('e03', 15.00),
('e01', 25.50),
('e05', 100.70),
('e02', 22.18),
('04', 9.50);



SELECT 
	id AS 'Номер закза',
	employee_id 'employee_id',
	amount AS 'amount',
	CASE 
		WHEN amount < 10 THEN 'CANCELLED'
		WHEN amount BETWEEN 10 AND 100 THEN 'OPEN'
		WHEN amount > 100 THEN 'CLOSED'
		ELSE 'NO VALUES'
	END AS 'order_status'	
FROM orders;
