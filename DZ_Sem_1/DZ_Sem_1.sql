use dz_sem_1;

-- Задача 1
-- Создайте таблицу с мобильными телефонами, используя графический интерфейс. Заполните БД данными (поля и наполнение см. в презентации)

select id, product_name, manufacturer, product_count, price from tasks;


-- Задача 2
-- Выведите название, производителя и цену для товаров, количество которых превышает 2

select id, product_name, manufacturer, price from tasks where product_count > 2;


-- Задача 3
-- Выведите весь ассортимент товаров марки "Samsung"

select id, product_name, price, manufacturer from tasks where manufacturer = 'Samsung';


-- Задача 4.1.
-- Товары, в которых есть упоминание "Iphone"

select id, product_name, price, manufacturer from tasks where product_name like 'iPhone%';


-- Задача 4.2.
-- Товары, в которых есть упоминание"Samsung"

select id, product_name, price, manufacturer from tasks where manufacturer like 'Samsung%';


-- Задача 4.3.
-- Товары, в которых есть ЦИФРЫ

select id, product_name, price, manufacturer from tasks where product_name REGEXP '[0-9]';


-- Задача 4.4.
-- Товары, в которых есть ЦИФРА "8"

select id, product_name, price, manufacturer from tasks where product_name REGEXP '8';


