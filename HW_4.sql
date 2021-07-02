
CREATE TABLE catalogs (
  id bigint unsigned NOT NULL auto_increment UNIQUE PRIMARY KEY,
  name VARCHAR(255) 
) ;

CREATE TABLE users (
  id bigint unsigned NOT NULL auto_increment UNIQUE PRIMARY KEY ,
  name VARCHAR(255) ,
  birthday_at DATE ,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE products (
  id bigint unsigned NOT NULL auto_increment UNIQUE PRIMARY KEY,
  name VARCHAR(255),
  desription TEXT ,
  price DECIMAL (11,2) ,
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE orders (
  id bigint unsigned NOT NULL auto_increment UNIQUE PRIMARY KEY,
  user_id bigint UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users (id)
 );

CREATE TABLE orders_products (
  id bigint unsigned NOT NULL auto_increment UNIQUE PRIMARY KEY,
  order_id bigint UNSIGNED,
  product_id bigint UNSIGNED,
  total bigint UNSIGNED DEFAULT 1 ,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

CREATE TABLE discounts (
  id bigint unsigned NOT NULL auto_increment UNIQUE PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED 
) ;

CREATE TABLE storehouses (
  id INT SERIAL PRIMARY KEY,
  name VARCHAR(255) ,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

CREATE TABLE storehouses_products (
  id bigint unsigned NOT NULL auto_increment UNIQUE PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED ,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--Транзакции
EX.1:
START TRANSACTION;
INSERT INTO sample.users SELECT * FROM hw_3.users WHERE id = 1;
COMMIT;

EX.2:
CREATE OR REPLACE VIEW prods_desc(prod_id, prod_name, cat_name)
AS SELECT p.id AS prod_id, p.name, cat.name FROM products AS p right JOIN catalogs AS cat 
ON p.catalog_id = cat.id ;
--Хранимые процедуры и функции, триггеры

EX.1:

delimiter //

CREATE PROCEDURE hello()
BEGIN 
	CASE 
		WHEN
	curtime() BETWEEN '06:00:00' AND '12:00:00' THEN SELECT 'Good morning !';
		WHEN
	curtime() BETWEEN '12:00:00' AND '18:00:00' THEN SELECT 'Good day !';
		WHEN
	curtime() BETWEEN '18:00:00' AND '00:00:00' THEN SELECT 'Good evening !';
		ELSE
		SELECT 'Good night !';
	END CASE;
END//
 

EX.2:
CREATE TRIGGER check_products_insert BEFORE INSERT ON products  
FOR EACH ROW 
BEGIN 
	IF(isnull(NEW.name) AND isnull(NEW.desription) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Value insert error';
	END IF;
END //



