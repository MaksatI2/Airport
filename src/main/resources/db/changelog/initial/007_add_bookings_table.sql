CREATE TABLE bookings
(
    id           BIGINT auto_increment PRIMARY KEY,
    user_id      BIGINT REFERENCES users (id),
    flight_id    BIGINT REFERENCES flights (id),
    seat_number  VARCHAR(5),
    class_type_id   BIGINT REFERENCES class_type_airplane (id),
    booking_time TIMESTAMP
);