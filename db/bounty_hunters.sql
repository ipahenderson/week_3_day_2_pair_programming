DROP TABLE IF EXISTS bounties;
CREATE TABLE bounties(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  bounty_value INT2,
  homeworld VARCHAR(255),
  cashed_in VARCHAR(255)
);
