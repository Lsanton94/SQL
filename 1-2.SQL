-- Создаем таблицу

CREATE TABLE book(
  book_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(50),
  author VARCHAR(30),
  price DECIMAL(8,2),
  amount INT
);
  
  INSERT INTO book (title, author, price, amount)
  VALUES ("Мастер и Маргарита", "Булгаков М.А", 670.99, 3);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Белая гвардия", "Булгаков М.А.", 540.50, 5);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Идиот", "Достоевский Ф.М.", 460.00, 10);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Братья Карамазовы", "Достоевский Ф.М.", 799.01, 2);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Стихотворения и поэмы", "Есенин С.А.", 650.00, 15);
 
-- Выводим всю таблицу

SELECT * FROM book

-- Выбрать названия книг и их количества из таблицы book 

SELECT author, title, price FROM book;

-- Выбрать названия книг и авторов из таблицы book, для поля title задать имя(псевдоним) Название, для поля author –  Автор. 

SELECT title as Название, author as Автор FROM book;

-- Для упаковки каждой книги требуется один лист бумаги, цена которого 1 рубль 65 копеек. Посчитать стоимость упаковки для каждой книги (сколько денег потребуется, чтобы упаковать все экземпляры книги). 
   В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack. 
    
SELECT title, amount, amount * 1.65 AS pack FROM book

-- В конце года цену всех книг на складе пересчитывают – снижают ее на 30%.
   Написать SQL запрос, который из таблицы book выбирает названия, авторов, количества и вычисляет новые цены книг.
   Столбец с новой ценой назвать new_price, цену округлить до 2-х знаков после запятой.
   
SELECT title, author, amount, ROUND((price-((price/100)*30)),2) AS new_price FROM book

-- При анализе продаж книг выяснилось, что наибольшей популярностью пользуются книги Михаила Булгакова, на втором месте книги Сергея Есенина. 
   Исходя из этого решили поднять цену книг Булгакова на 10%, а цену книг Есенина - на 5%.
   Написать запрос, куда включить автора, название книги и новую цену, последний столбец назвать new_price. Значение округлить до двух знаков после запятой.
   
SELECT author, title,
	ROUND(IF(author = "Булгаков М.А.", price + ((price/100)*10), 
          IF(author = "Есенин С.А.", price + ((price/100)*5), price)),2) AS new_price
FROM book;

-- Вывести автора, название  и цены тех книг, количество которых меньше 10.

SELECT author, title, price FROM book
WHERE amount < 10;

-- Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600, а стоимость всех экземпляров этих книг больше или равна 5000.

SELECT title, author, price, amount FROM book
WHERE (price<500 OR price >600) and price * amount >= 5000;

-- Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),  а количество или 2, или 3, или 5, или 7 .

SELECT title, author FROM book
WHERE (amount IN (2, 3, 5, 7)) AND (price BETWEEN 540.50 AND 800);

-- Вывести  автора и название  книг, количество которых принадлежит интервалу от 2 до 14 (включая границы). 
   Информацию  отсортировать сначала по авторам (в обратном алфавитном порядке), а затем по названиям книг (по алфавиту).

SELECT author, title FROM book
WHERE amount BETWEEN 2 AND 14
ORDER BY author DESC, title;

-- Изменяем таблицу на более объемную

  INSERT INTO book (title, author, price, amount)
  VALUES ("Мастер и Маргарита", "Булгаков М.А", 670.99, 3);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Белая гвардия", "Булгаков М.А.", 540.50, 5);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Идиот", "Достоевский Ф.М.", 460.00, 10);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Братья Карамазовы", "Достоевский Ф.М.", 799.01, 2);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Стихотворения и поэмы", "Есенин С.А.", 650.00, 15);
  INSERT INTO book (title, author, price, amount)
  VALUES (" ", "Иванов С.С.", 50.00, 10);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Дети полуночи", "Рушди Салман", 950.00, 5);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Лирика", "Гумилев Н.С.", 460.00, 10);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Поэмы", "Бехтерев С.С.", 460.00, 10);
  INSERT INTO book (title, author, price, amount)
  VALUES ("Капитанская дочка", "Пушкин А.С.", 520.50, 7)

-- Вывести название и автора тех книг, название которых состоит из двух и более слов, а инициалы автора содержат букву «С». 
   Считать, что в названии слова отделяются друг от друга пробелами и не содержат знаков препинания, между фамилией автора и инициалами обязателен пробел, 
   инициалы записываются без пробела в формате: буква, точка, буква, точка. 
   Информацию отсортировать по названию книги в алфавитном порядке.

SELECT title, author FROM book
WHERE title LIKE "_% _%" AND (author LIKE "% С._." OR author LIKE "% _.С.")
ORDER BY author DESC

-- Определить стоимость доставки:
- для книг стоимостью 500 и менее, установить в размере 99,99
- при количестве книг на складе менее 5, установить в размере 149.99
- для остальных случаев доставка должна быть бесплатной
Определить новую стоимость для книг:
- для книг, совокупной стоимостью более 5000, добавить 20% к стоимости за экземпляр
- для остальных случаев снизить стоимость одного экземпляра на 20%
Настроить фильтр при выборке:
- только позиции творчества авторов: Булгаков и Есенин, при количестве экземпляров на складе: от 3 до 14 включительно.
Сортировку выполнить:
- по имени автора в порядке возрастания
- затем по названию в порядке убывания
- по стоимости доставки (от меньшей к большей)
В таблице должны быть отображены данные:
- автора
- название
- цену, как real_price
- количество
- новую цену, как new_price
- стоимость доставки, как delivery_price

SELECT author, 
	   title,
	   price AS real_price, 
       amount, 
       IF (price*amount > 5000, ROUND (price + ((price/ 100) *20),2), 
           ROUND (price - ((price/ 100)*20),2)) AS new_price,
       IF (price <=500, 99.99, 
           IF (amount <5, 149.99, 0.00)) AS delivery_price
FROM book
WHERE (author IN ("Булгаков М.А.", "Есенин С.А.")) AND (amount BETWEEN 3 AND 14) 
ORDER BY author ASC, title DESC, delivery_price ASC

   
