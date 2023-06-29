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

/* Вывести информацию (автора, название и цену) о  книгах, цены которых меньше или равны средней цене книг на складе. 
Информацию вывести в отсортированном по убыванию цены виде. Среднее вычислить как среднее по цене книги. */

SELECT author, title, price
FROM book
WHERE price <= (SELECT SUM(price) / COUNT(amount)
From book)
ORDER BY price DESC

/* Вывести информацию (автора, название и цену) о тех книгах, 
цены которых превышают минимальную цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде. */

SELECT author, title, price
From book
WHERE ABS(price - (SELECT MIN(price) FROM book)) <= 150
ORDER BY price 

/* Вывести информацию (автора, книгу и количество) о тех книгах, количество экземпляров которых в таблице book не дублируется. */

SELECT author, title, amount
FROM book
WHERE amount IN ( 
SELECT amount FROM book
GROUP BY amount
HAVING COUNT(amount) = 1
);

/* Вывести информацию о книгах(автор, название, цена), цена которых меньше самой большой из минимальных цен, вычисленных для каждого автора. */

SELECT author, title, price
FROM book
WHERE price < ANY (
SELECT MIN(price)
FROM book
GROUP BY author
);

/* Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, чтобы на складе стало одинаковое количество экземпляров каждой книги, 
равное значению самого большего количества экземпляров одной книги на складе. 
Вывести название книги, ее автора, текущее количество экземпляров на складе и количество заказываемых экземпляров книг. Последнему столбцу присвоить имя Заказ. 
В результат не включать книги, которые заказывать не нужно. */

SELECT title, author, amount, 
((SELECT MAX(amount) FROM book) - amount) AS Заказ
FROM book
WHERE ((SELECT MAX(amount) FROM book) - amount) > 0





