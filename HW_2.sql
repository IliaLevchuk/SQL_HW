
DROP TABLE users ;


CREATE TABLE IF NOT EXISTS users(
	id bigint unsigned NOT NULL auto_increment UNIQUE PRIMARY KEY,
	firstname varchar(25) NOT NULL,
	lastname varchar(25) NOT NULL,
	created_at datetime NOT NULL, 
	updated_at datetime NOT NULL 
);

INSERT INTO users VALUES (DEFAULT, 'Jhon', 'Get', NOW(), NOW());
INSERT INTO users VALUES (DEFAULT, 'May', 'Hugan', NOW(), NOW());
INSERT INTO users VALUES (DEFAULT, 'Ken', 'Che', NOW(), NOW());

ALTER TABLE users ADD COLUMN Age datetime NOT NULL;

ALTER TABLE users ADD CONSTRAINT DF_usres DEFAULT CURRENT_TIMESTAMP FOR created_at, updated_at ;

INSERT INTO users (Age) VALUES ('1999-03-31'), ('1984-11-12'), ('1988-02-14'), ('1998-01-12'), ('2001-11-08');



CREATE TABLE IF NOT EXISTS users_2(
	id bigint unsigned NOT NULL auto_increment UNIQUE PRIMARY KEY,
	firstname varchar(30),
	lastname varchar(30),
	created_at varchar(40),
	updated_at varchar(40)
);

INSERT INTO users_2 VALUES (DEFAULT, 'Jhon', 'Get', NOW(), NOW(), );
INSERT INTO users_2 VALUES (DEFAULT, 'May', 'Hugan', NOW(), NOW());
INSERT INTO users_2 VALUES (DEFAULT, 'Ken', 'Che', NOW(), NOW());


ALTER TABLE users_2 MODIFY created_at datetime ;
ALTER TABLE users_2 MODIFY updated_at datetime ;


CREATE TABLE storehouses_products(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	name varchar(30) NOT NULL,
	value bigint NOT NULL,
	price decimal(7.2) NOT NULL  
);

INSERT INTO storehouses_products VALUES (DEFAULT, 'Canon', 0, 4000);
INSERT INTO storehouses_products VALUES (DEFAULT, 'Phelips', 234, 1500);
INSERT INTO storehouses_products VALUES (DEFAULT, 'Apple', 832, 350);
INSERT INTO storehouses_products VALUES (DEFAULT, 'Sony', 35, 819);


SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN 100000 ELSE value END ;


SELECT * FROM users_3;

SELECT * FROM users_3 WHERE month_of_berthday RLIKE '^[AM]';

SELECT * FROM storehouses_products ORDER BY CASE id WHEN 5 THEN 1 WHEN 1 THEN 2 WHEN 2 THEN 3 ELSE 5 END LIMIT 3;
SELECT * FROM storehouses_products WHERE id IN (5, 1, 2) ORDER BY field(id, 5, 1, 2);

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, created_at, NOW())), 0) AS AVG_Age FROM users;




