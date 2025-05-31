CREATE TABLE airplanes
(
    id               BIGINT AUTO_INCREMENT PRIMARY KEY,
    model            VARCHAR(100),
    capacity         INT,
    business_capacity INT,
    user_id          BIGINT REFERENCES users (id)
);