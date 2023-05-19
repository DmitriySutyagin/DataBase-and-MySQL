-- Задача 1. Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой можно переместить любого (одного) пользователя из таблицы users в 
-- таблицу users_old. (использование транзакции с выбором commit или rollback – обязательно).
DROP DATABASE IF EXISTS dz_sem_6;
CREATE DATABASE dz_sem_6;
USE lesson_4;



DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);



DROP PROCEDURE IF EXISTS Transferring_users;

DELIMITER //

CREATE PROCEDURE Transferring_users(u_id int,OUT tran_result varchar(100))
BEGIN
	DECLARE `_rollback` BIT DEFAULT b'0';
	DECLARE code varchar(100);
	DECLARE error_string varchar(100); 

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET `_rollback` = b'1';
 		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
	END;
	
	START TRANSACTION;
	
	INSERT INTO users_old (id, firstname, lastname, email)
	SELECT id, firstname, lastname, email FROM users WHERE id = u_id;

	DELETE FROM users
	WHERE id=u_id;

	IF `_rollback` THEN
		SET tran_result = CONCAT('Ошибка: ', code, ' Текст ошибки: ', error_string);
		ROLLBACK;
	ELSE
		SET tran_result = 'O K';
		COMMIT;
	END IF;
		
END//

DELIMITER ;

-- CALL Transferring_users(3, @tran_result);
SELECT  @tran_result;



SELECT id, firstname, lastname, email FROM users_old;



-- Задача 2.Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
DELIMITER $$
CREATE FUNCTION hello() 
	RETURNS VARCHAR(25)
BEGIN
DECLARE Greeting VARCHAR(25);
SELECT CASE 
	WHEN CURRENT_TIME >= '12:00:00' AND  CURRENT_TIME < '18:00:00' THEN 'Добрый день'
	WHEN CURRENT_TIME >= '06:00:00' AND  CURRENT_TIME < '12:00:00' THEN 'Доброе утро'
	WHEN CURRENT_TIME >= '00:00:00' AND  CURRENT_TIME < '06:00:00' THEN 'Доброй ночи'
	ELSE 'Добрый вечер'
END INTO Greeting ;
RETURN Greeting ;
END$$

DELIMITER ;

SELECT hello(); -- Проверяем.







