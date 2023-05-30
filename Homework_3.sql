DROP DATABASE IF EXISTS lesson3;
CREATE DATABASE IF NOT EXISTS `lesson3` ;
USE lesson3;

-- Cоздаём и заполняем таблицы

-- Таблица 1 Продавцы
-- создаем таблицу 
DROP TABLE IF EXISTS salespeople;
CREATE TABLE salespeople (
	snum SERIAL PRIMARY KEY,
    sname VARCHAR(30) NOT NULL,
    city VARCHAR(30) NOT NULL,
    comm VARCHAR(30) NOT NULL
);
-- проверяем
DESCRIBE salespeople;
-- заполняем

INSERT INTO salespeople (snum, sname, city, comm) 
VALUES
  (1001, 'Peel', 'London', '.12'),
  (1002, 'Serres', 'San Jose', '.13'),
  (1004, 'Motika', 'London', '.11'),
  (1007, 'Rifkin', 'Barcelona', '.15'),
  (1003, 'Axelrod', 'New York', '.10');
  
-- проверяем
SELECT * FROM salespeople;

-- Таблица 2 Заказчики
-- создаем таблицу 
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
	cnum SERIAL PRIMARY KEY,
    cname VARCHAR(30) NOT NULL,
    city VARCHAR(30) NOT NULL,
    rating INT,
    snum INT NOT NULL
);
-- проверяем
DESCRIBE customers;
-- заполняем

INSERT INTO customers (cnum, cname, city, rating, snum) 
VALUES
  (2001, 'Hoffman', 'London', 100, 1001),
  (2002, 'Giovanni', 'Rome', 200, 1003),
  (2003, 'Liu', 'SanJose', 200, 1002),
  (2004, 'Grass', 'Berlin', 300, 1002),
  (2006, 'Clemens', 'London', 100, 1001),
  (2008, 'Cisneros', 'SanJose', 300, 1007),
  (2007, 'Pereira', 'Rome', 100, 1004);
  
-- проверяем
SELECT * FROM customers;

-- Таблица 3 Заказы
-- создаем таблицу 
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	onum SERIAL PRIMARY KEY,
    amt DECIMAL(7,2),
    odate DATE NOT NULL,
    cnum INT NOT NULL,
    snum INT NOT NULL
);
-- проверяем
DESCRIBE orders;
-- заполняем

INSERT INTO orders (onum, amt, odate, cnum, snum) 
VALUES
  (3001, 18.69, '1990-03-10', 2008, 1007),
  (3003, 767.19, '1990-03-10', 2001, 1001),
  (3002, 1900.10, '1990-03-10', 2007, 1004),
  (3005, 5160.45, '1990-03-10', 2003, 1002),
  (3006, 1098.16, '1990-03-10', 2008, 1007),
  (3009, 1713.23, '1990-04-10', 2002, 1003),
  (3007, 75.75, '1990-04-10', 2004, 1002),
  (3008, 4723.00, '1990-05-10', 2006, 1001),
  (3010, 1309.95, '1990-06-10', 2004, 1002),
  (3011, 9891.88, '1990-06-10', 2006, 1001);
  
-- проверяем
SELECT onum, amt, date_format(odate, '%d/%m/%Y') AS odate, cnum, snum 
  FROM orders;

-- задание 1.1
SELECT city, sname, snum, comm
  FROM salespeople;

-- задание 1.2
SELECT rating, cname
  FROM customers
 WHERE city = 'SanJose';

-- задание 1.3
SELECT DISTINCT snum
  FROM orders;

-- задание 1.4
SELECT cname
  FROM customers
 WHERE cname LIKE 'G%';

-- задание 1.5
SELECT *
  FROM orders
 WHERE amt > 1000;

-- задание 1.6
SELECT onum, amt, date_format(odate, '%d/%m/%Y') AS odate, cnum, snum
  FROM orders
 WHERE amt = (SELECT MIN(amt) FROM orders);


-- задание 1.7
SELECT *
  FROM customers
 WHERE rating > 100 AND city != 'Rome';

-- Задание 2
-- Создание таблицы
CREATE TABLE IF NOT EXISTS staff (
  id INT AUTO_INCREMENT PRIMARY KEY, 
  first_name VARCHAR(45), 
  last_name VARCHAR(45), 
  post VARCHAR(45), 
  seniority INT, 
  salary DECIMAL(8, 2), 
  age INT
);
-- проверяем
DESCRIBE staff;
-- заполняем

INSERT  staff (first_name, last_name, post, seniority, salary, age)
VALUES
	 ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
	 ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
	 ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
	 ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
	 ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
	 ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
	 ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
	 ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
	 ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
	 ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
	 ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
	 ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
     
-- проверяем 
SELECT * FROM staff;

-- задание 2.1
SELECT * 
  FROM staff
 ORDER BY salary;

SELECT * 
  FROM staff
 ORDER BY salary DESC;

-- задание 2.2
SELECT *
  FROM (
    SELECT * 
    FROM staff 
    ORDER BY salary DESC 
    LIMIT 5) AS tb
 ORDER BY salary; 

-- задание 2.3
SELECT post, SUM(salary)
  FROM staff
 GROUP BY post
  HAVING SUM(salary) > 100000;
