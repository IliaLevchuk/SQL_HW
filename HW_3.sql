
DROP TABLE IF EXISTS catalogs;
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


INSERT INTO orders VALUES (DEFAULT, 1), (DEFAULT, 3), (DEFAULT, 6);
SELECT * FROM orders ;

ALTER TABLE orders ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE orders ADD CONSTRAINT fk_catalog_id FOREIGN KEY (catalog_id) REFERENCES catalogs(id) ON DELETE RESTRICT ON UPDATE RESTRICT;

UPDATE orders SET updated_at = NOW() WHERE created_at is NULL;

SELECT u.id AS users_id, u.name AS user_name, o.id AS order_id FROM users AS u RIGHT JOIN orders AS o ON u.id = o.user_id ;

SELECT p.id AS product_id, p.name, p.price, c.id AS CATALOG_id, c.name AS catalog
	FROM products AS p RIGHT JOIN catalogs AS c ON p.catalog_id = c.id ;


CREATE TABLE flights (
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	`FROM` text,
	`TO` text
);

CREATE TABLE cities (
	label text,
	name text
);

SELECT * FROM cities;

INSERT INTO cities VALUES
('Moscow', 'Москва'),
('Saint Petersburg', 'Санкт-Петербург'),
('Omsk', 'Омск'),
('Tomsk', 'Томск'),
('Ufa', 'Уфа');

INSERT INTO flights VALUES
	(NULL, 'Moscow', 'Saint Petersburg'),
    (NULL, 'Saint Petersburg', 'Omsk'),
    (NULL, 'Omsk', 'Tomsk'),
 	(NULL, 'Tomsk', 'Ufa'),
    (NULL, 'Ufa', 'Moscow');

   SELECT
	id AS flight_id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM
	flights
ORDER BY
	flight_id;
