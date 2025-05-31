INSERT INTO class_type_airplane (name)
VALUES ('BUSINESS'), ('ECONOMY');

INSERT INTO airplanes (model, capacity, business_capacity, user_id)
SELECT model_data.model,
       model_data.capacity,
       model_data.business_capacity,
       (SELECT id FROM users WHERE user_name = model_data.airline_name) AS user_id
FROM (
         VALUES
             ('Boeing 737-800', 189, 12, 'Emirates'),
             ('Airbus A320', 180, 8, 'Emirates'),
             ('Boeing 777-300ER', 396, 42, 'QatarAirways'),
             ('Airbus A350', 440, 36, 'QatarAirways'),
             ('Airbus A150', 100, 4, 'SingaporeAirlines'),
             ('Boeing 787 Dreamliner', 330, 30, 'SingaporeAirlines'),
             ('Boeing 747-8', 410, 50, 'TurkishAirlines'),
             ('Airbus A330-300', 277, 24, 'TurkishAirlines'),
             ('Boeing 737 MAX 8', 210, 16, 'Lufthansa'),
             ('Airbus A310', 280, 20, 'Lufthansa'),
             ('McDonnell Douglas MD-11', 293, 18, 'Emirates'),
             ('Bombardier CRJ900', 90, 6, 'QatarAirways'),
             ('Embraer E195', 120, 8, 'SingaporeAirlines'),
             ('Tupolev Tu-204', 210, 12, 'TurkishAirlines'),
             ('Sukhoi Superjet 100', 98, 8, 'Lufthansa'),
             ('Boeing 737-900ER', 220, 20, 'Emirates'),
             ('Airbus A321neo', 240, 16, 'QatarAirways'),
             ('Boeing 767-300ER', 245, 24, 'SingaporeAirlines'),
             ('Airbus A380', 853, 78, 'TurkishAirlines'),
             ('Embraer E190', 114, 6, 'Lufthansa'),
             ('Boeing 737-700', 148, 8, 'Emirates'),
             ('Airbus A319', 156, 8, 'QatarAirways'),
             ('Boeing 757-200', 228, 16, 'SingaporeAirlines'),
             ('Airbus A340-600', 380, 42, 'TurkishAirlines'),
             ('Boeing 787-9', 296, 28, 'Lufthansa'),
             ('Embraer E175', 88, 6, 'Emirates'),
             ('Bombardier CS300', 160, 12, 'QatarAirways'),
             ('Boeing 747-400', 416, 42, 'SingaporeAirlines'),
             ('Airbus A330-200', 246, 24, 'TurkishAirlines'),
             ('Boeing 717', 134, 8, 'Lufthansa'),
             ('Bombardier Q400', 78, 0, 'Emirates')
         ) AS model_data(model, capacity, business_capacity, airline_name);

INSERT INTO destination (name)
VALUES
    ('Москва (Шереметьево)'),
    ('Санкт-Петербург (Пулково)'),
    ('Нью-Йорк (JFK)'),
    ('Лондон (Хитроу)'),
    ('Париж (Шарль де Голль)'),
    ('Дубай (Международный)'),
    ('Токио (Ханеда)'),
    ('Сидней (Кингсфорд Смит)'),
    ('Пекин (Столичный)'),
    ('Стамбул (Аэропорт)'),
    ('Бангкок (Суварнабхуми)'),
    ('Сингапур (Чанги)'),
    ('Лос-Анджелес (LAX)'),
    ('Рим (Фьюмичино)'),
    ('Барселона (Эль-Прат)');

UPDATE airplanes
SET capacity = 7,
    business_capacity = 3
WHERE id IN (SELECT id FROM airplanes);