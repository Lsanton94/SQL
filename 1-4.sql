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

