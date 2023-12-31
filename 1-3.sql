-- Создаем таблицу

CREATE TABLE book(
  book_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(50),
  author VARCHAR(50),
  price DECIMAL(8.2),
  amount INT
);

INSERT INTO book (title, author, price, amount)
VALUES ("Мастер и Маргарита", "Булгаков М.А.", 670.99, 3);
INSERT INTO book (title, author, price, amount)
VALUES ("Белая гвардия", "Булгаков М.А.", 540.50, 5);
INSERT INTO book (title, author, price, amount)
VALUES ("Идиот", "Достоевский Ф.М.", 460.00, 10);
INSERT INTO book (title, author, price, amount)
VALUES ("Братья Карамазовы", "Достоевский Ф.М.", 799.01, 3);
INSERT INTO book (title, author, price, amount)
VALUES ("Игрок", "Достоевский Ф.М.", 480.50, 10);
INSERT INTO book (title, author, price, amount)
VALUES ("Стихотворения и поэмы", "Есенин С.А.", 650.00, 15);

-- Отобрать различные (уникальные) элементы столбца amount таблицы book.

SELECT DISTINCT amount FROM book

--ИЛИ

SELECT amount FROM book
ORDER BY amount

-- Посчитать, количество различных книг и количество экземпляров книг каждого автора , хранящихся на складе.  Столбцы назвать Автор, Различных_книг и Количество_экземпляров соответственно.

SELECT author AS Автор, COUNT(amount) AS Различных_книг, SUM(amount) AS Количество_экземпляров FROM book
GROUP BY author

-- Вывести фамилию и инициалы автора, минимальную, максимальную и среднюю цену книг каждого автора . Вычисляемые столбцы назвать Минимальная_цена, Максимальная_цена и Средняя_цена соответственно.

SELECT author Автор, 
	MIN(price) Минимальная_цена, 
    MAX(price) Максимальная_цена, 
    ROUND (AVG(price), 2) Средняя_цена
    
FROM book
GROUP BY author

/* Для каждого автора вычислить суммарную стоимость книг S (имя столбца Стоимость), а также вычислить налог на добавленную стоимость  для полученных сумм (имя столбца НДС ) , 
   который включен в стоимость и составляет 18% (k=18),  а также стоимость книг  (Стоимость_без_НДС) без него.*/
   
SELECT author AS Автор,
	SUM(price * amount) AS Стоимость,
    ROUND(SUM(((price * amount) * (18 / 100)) / (1 + (18 / 100))), 2) AS НДС,
    ROUND(SUM((price * amount) / (1 + (18 / 100))), 2) AS Стоимость_без_НДС
    
FROM book
GROUP BY author

/* Вывести  цену самой дешевой книги, цену самой дорогой и среднюю цену уникальных книг на складе. 
   Названия столбцов Минимальная_цена, Максимальная_цена, Средняя_цена соответственно. Среднюю цену округлить до двух знаков после запятой.*/

SELECT 
	MIN(price) AS Минимальная_цена,
	MAX(price) AS Максимальная_цена,
    ROUND(AVG(price), 2) AS Средняя_цена
    
FROM book

/* Вычислить среднюю цену и суммарную стоимость тех книг, количество экземпляров которых принадлежит интервалу от 5 до 14, включительно.
   Столбцы назвать Средняя_цена и Стоимость, значения округлить до 2-х знаков после запятой. */
   
SELECT
	ROUND(
      AVG(price),
      2)
      AS Средняя_цена,
    SUM(price*amount)
      AS Стоимость
      
FROM book

WHERE amount BETWEEN 5 AND 14

/* Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и «Белая гвардия». 
   В результат включить только тех авторов, у которых суммарная стоимость книг (без учета книг «Идиот» и «Белая гвардия») более 5000 руб. 
   Вычисляемый столбец назвать Стоимость. Результат отсортировать по убыванию стоимости. */
   
SELECT author,
	SUM(price * amount) AS Стоимость
FROM book
WHERE title <> "Идиот" AND title <> "Белая гвардия"
GROUP BY author
HAVING (Стоимость) > 5000
ORDER BY Стоимость DESC

/*Сколько денег понадобиться покупателю, чтобы приобрести все виды книг по одному экземпляру каждой?
 Имена результирующих столбцов:
- Стоимость_всех_книг_по_одному_экз
- Количество_купленных_книг */

SELECT 
    SUM(price) AS Стоимость_всех_книг_по_1_экземпляру,
    COUNT(amount) AS Количество_купленных_книг
FROM book
WHERE amount > 0

-- Вывести авторов и суммарную стоимость их книг, если хотя бы одна их книга по цене выше средней.

SELECT 
    author AS Автор,
    SUM(price * amount) AS Суммарная_стоимость
FROM book  
WHERE price > (SELECT avg(price) FROM book)
GROUP BY author




