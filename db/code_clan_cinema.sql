DROP TABLE customers;
DROP TABLE films;
DROP TABLE tickets;

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customer(id) ON DELETE CASCADE,
  film_id INT REFERENCES film(id) ON DELETE CASCADE,
);

CREATE TABLE films (
  SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE customers (
  SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

-- SELECT * FROM films
-- INNER JOIN customers
-- ON films.id = customers.films_id
-- INNER JOIN tickets
-- ON tickets.id = customers.tickets_id;
