
DROP TABLE IF EXISTS loot;
DROP TABLE IF EXISTS loot;

CREATE TABLE loot (
  id SERIAL PRIMARY KEY,
  item_name VARCHAR(100) NOT NULL UNIQUE,
  item_owner_id VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  user_name VARCHAR(20) NOT NULL UNIQUE
)
