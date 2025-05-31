CREATE TABLE flights
(
    id              BIGINT auto_increment PRIMARY KEY,
    flight_number   VARCHAR(20) UNIQUE,
    place_departure BIGINT REFERENCES destination (id),
    destination     BIGINT REFERENCES destination (id),
    departure_time  TIMESTAMP,
    arrival_time    TIMESTAMP,
    price           DOUBLE,
    business_price  DOUBLE,
    airplane_id     BIGINT REFERENCES airplanes (id),
    user_id         BIGINT REFERENCES users (id)
);