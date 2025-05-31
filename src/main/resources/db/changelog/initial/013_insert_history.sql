INSERT INTO flights (flight_number, place_departure, destination, departure_time, arrival_time, price, business_price, airplane_id, user_id)
SELECT
    'BOE-' || ABS(FLOOR(RAND() * 10000)),
    (SELECT id FROM destination ORDER BY RAND() LIMIT 1),
    (SELECT id FROM destination WHERE id NOT IN (SELECT place_departure FROM flights ORDER BY RAND() LIMIT 1) ORDER BY RAND() LIMIT 1),
    TIMESTAMPADD('MONTH', -1, TIMESTAMPADD('HOUR', -ABS(FLOOR(RAND() * 10)), CURRENT_TIMESTAMP)),
    TIMESTAMPADD('MONTH', -1, TIMESTAMPADD('HOUR', ABS(FLOOR(RAND() * 5 + 2)), TIMESTAMPADD('HOUR', -ABS(FLOOR(RAND() * 10)), CURRENT_TIMESTAMP))),
    100 + (RAND() * 200),
    300 + (RAND() * 400),
    (SELECT id FROM airplanes WHERE model = 'Boeing 737-100'),
    (SELECT id FROM users WHERE user_name = 'ADIS');

INSERT INTO flights (flight_number, place_departure, destination, departure_time, arrival_time, price, business_price, airplane_id, user_id)
SELECT
    'AIR-' || ABS(FLOOR(RAND() * 10000)),
    (SELECT id FROM destination ORDER BY RAND() LIMIT 1),
    (SELECT id FROM destination WHERE id NOT IN (SELECT place_departure FROM flights ORDER BY RAND() LIMIT 1) ORDER BY RAND() LIMIT 1),
    TIMESTAMPADD('YEAR', -1, TIMESTAMPADD('HOUR', -ABS(FLOOR(RAND() * 10)), CURRENT_TIMESTAMP)),
    TIMESTAMPADD('YEAR', -1, TIMESTAMPADD('HOUR', ABS(FLOOR(RAND() * 5 + 2)), TIMESTAMPADD('HOUR', -ABS(FLOOR(RAND() * 10)), CURRENT_TIMESTAMP))),
    120 + (RAND() * 250),
    350 + (RAND() * 450),
    (SELECT id FROM airplanes WHERE model = 'Airbus A220'),
    (SELECT id FROM users WHERE user_name = 'ADIS');

INSERT INTO bookings (user_id, flight_id, seat_number, class_type_id, booking_time)
SELECT
    (SELECT id FROM users WHERE user_name = 'ADIS'),
    (SELECT id FROM flights WHERE airplane_id = (SELECT id FROM airplanes WHERE model = 'Boeing 737-100') ORDER BY departure_time DESC LIMIT 1),
    ABS(FLOOR(RAND() * 30) + 1) || CHAR(65 + FLOOR(RAND() * 6)),
    (SELECT id FROM class_type_airplane WHERE name = 'ECONOMY'),
    TIMESTAMPADD('DAY', -ABS(FLOOR(RAND() * 5 + 1)), (SELECT departure_time FROM flights WHERE airplane_id = (SELECT id FROM airplanes WHERE model = 'Boeing 737-100') ORDER BY departure_time DESC LIMIT 1));

INSERT INTO bookings (user_id, flight_id, seat_number, class_type_id, booking_time)
SELECT
    (SELECT id FROM users WHERE user_name = 'ADIS'),
    (SELECT id FROM flights WHERE airplane_id = (SELECT id FROM airplanes WHERE model = 'Airbus A220') ORDER BY departure_time DESC LIMIT 1),
    ABS(FLOOR(RAND() * 30) + 1) || CHAR(65 + FLOOR(RAND() * 6)),
    (SELECT id FROM class_type_airplane WHERE name = 'BUSINESS'),
    TIMESTAMPADD('DAY', -ABS(FLOOR(RAND() * 5 + 1)), (SELECT departure_time FROM flights WHERE airplane_id = (SELECT id FROM airplanes WHERE model = 'Airbus A220') ORDER BY departure_time DESC LIMIT 1));