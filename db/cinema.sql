DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds MONEY
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price MONEY
);

CREATE TABLE screenings(
  id SERIAL4 PRIMARY KEY,
  screening TIME,
  film_id INT4 REFERENCES films (id) ON DELETE CASCADE
);

CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers (id) ON DELETE CASCADE,
  screening_id INT4 REFERENCES screenings (id) ON DELETE CASCADE
);
