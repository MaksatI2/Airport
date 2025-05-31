INSERT INTO flights (flight_number, place_departure, destination, departure_time, arrival_time, price, business_price, airplane_id, user_id)
SELECT
    flight_data.flight_num,
    d_from.id,
    d_to.id,
    flight_data.dep_time,
    flight_data.arr_time,
    flight_data.price,
    flight_data.business_price,
    flight_data.plane_id,
    (SELECT user_id FROM airplanes WHERE id = flight_data.plane_id) AS user_id
FROM (
         SELECT 'SU-01' AS flight_num, 'Санкт-Петербург (Пулково)' AS place_from, 'Москва (Шереметьево)' AS dest,
                TIMESTAMPADD(HOUR, 6, CURRENT_TIMESTAMP) AS dep_time,
                TIMESTAMPADD(HOUR, 8, CURRENT_TIMESTAMP) AS arr_time,
                250 AS price, 750 AS business_price,
                (SELECT id FROM airplanes WHERE model = 'Boeing 737-800' LIMIT 1) AS plane_id
         UNION ALL SELECT 'SU-02', 'Москва (Шереметьево)', 'Санкт-Петербург (Пулково)',
                          TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 9, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 11, CURRENT_TIMESTAMP)),
                          850, 2550,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A320' LIMIT 1)
         UNION ALL SELECT 'SU-03', 'Москва (Шереметьево)', 'Нью-Йорк (JFK)',
                          TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 12, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 22, CURRENT_TIMESTAMP)),
                          450, 1350,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 777-300ER' LIMIT 1)

         UNION ALL SELECT 'SU-04', 'Москва (Шереметьево)', 'Лондон (Хитроу)',
                          TIMESTAMPADD(DAY, 2, TIMESTAMPADD(HOUR, 15, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 2, TIMESTAMPADD(HOUR, 19, CURRENT_TIMESTAMP)),
                          280, 840,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A350' LIMIT 1)
         UNION ALL SELECT 'SU-05', 'Москва (Шереметьево)', 'Париж (Шарль де Голль)',
                          TIMESTAMPADD(DAY, 3, TIMESTAMPADD(HOUR, 18, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 3, TIMESTAMPADD(HOUR, 22, CURRENT_TIMESTAMP)),
                          320, 960,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A150' LIMIT 1)

         UNION ALL SELECT 'SU-06', 'Москва (Шереметьево)', 'Дубай (Международный)',
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(HOUR, 21, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(HOUR, 27, CURRENT_TIMESTAMP)),
                          380, 1140,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 737-800' LIMIT 1)
         UNION ALL SELECT 'SU-07', 'Москва (Шереметьево)', 'Токио (Ханеда)',
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 6, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 19, CURRENT_TIMESTAMP))),
                          520, 1560,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A320' LIMIT 1)

         UNION ALL SELECT 'SU-08', 'Москва (Шереметьево)', 'Сидней (Кингсфорд Смит)',
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(HOUR, 9, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 13, CURRENT_TIMESTAMP))),
                          680, 2040,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 777-300ER' LIMIT 1)
         UNION ALL SELECT 'SU-09', 'Москва (Шереметьево)', 'Пекин (Столичный)',
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 2, TIMESTAMPADD(HOUR, 12, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 2, TIMESTAMPADD(HOUR, 19, CURRENT_TIMESTAMP))),
                          410, 1230,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A350' LIMIT 1)

         UNION ALL SELECT 'SU-10', 'Москва (Шереметьево)', 'Стамбул (Аэропорт)',
                          TIMESTAMPADD(WEEK, 3, TIMESTAMPADD(HOUR, 15, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(WEEK, 3, TIMESTAMPADD(HOUR, 18, CURRENT_TIMESTAMP)),
                          250, 750,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A150' LIMIT 1)
         UNION ALL SELECT 'SU-11', 'Москва (Шереметьево)', 'Бангкок (Суварнабхуми)',
                          TIMESTAMPADD(WEEK, 3, TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 18, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(WEEK, 3, TIMESTAMPADD(DAY, 2, TIMESTAMPADD(HOUR, 3, CURRENT_TIMESTAMP))),
                          470, 1410,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 737-800' LIMIT 1)

         UNION ALL SELECT 'SU-12', 'Москва (Шереметьево)', 'Сингапур (Чанги)',
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(HOUR, 9, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(HOUR, 18, CURRENT_TIMESTAMP)),
                          490, 1470,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A320' LIMIT 1)
         UNION ALL SELECT 'SU-13', 'Москва (Шереметьево)', 'Лос-Анджелес (LAX)',
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 2, TIMESTAMPADD(HOUR, 12, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 3, TIMESTAMPADD(HOUR, 1, CURRENT_TIMESTAMP))),
                          620, 1860,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 777-300ER' LIMIT 1)

         UNION ALL SELECT 'SU-14', 'Москва (Шереметьево)', 'Рим (Фьюмичино)',
                          TIMESTAMPADD(DAY, 4, TIMESTAMPADD(HOUR, 15, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 4, TIMESTAMPADD(HOUR, 18, CURRENT_TIMESTAMP)),
                          290, 870,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A350' LIMIT 1)
         UNION ALL SELECT 'SU-15', 'Москва (Шереметьево)', 'Барселона (Эль-Прат)',
                          TIMESTAMPADD(DAY, 5, TIMESTAMPADD(HOUR, 18, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 5, TIMESTAMPADD(HOUR, 21, CURRENT_TIMESTAMP)),
                          270, 810,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A150' LIMIT 1)
         UNION ALL SELECT 'SU-16', 'Москва (Шереметьево)', 'Москва (Шереметьево)',
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(DAY, 3, TIMESTAMPADD(HOUR, 12, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(DAY, 3, TIMESTAMPADD(HOUR, 14, CURRENT_TIMESTAMP))),
                          1250, 3750,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 737-800' LIMIT 1)
         UNION ALL SELECT 'SU-17', 'Москва (Шереметьево)', 'Санкт-Петербург (Пулково)',
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 9, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 11, CURRENT_TIMESTAMP))),
                          900, 2700,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A320' LIMIT 1)
         UNION ALL SELECT 'SU-18', 'Москва (Шереметьево)', 'Нью-Йорк (JFK)',
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 5, TIMESTAMPADD(HOUR, 15, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 6, TIMESTAMPADD(HOUR, 1, CURRENT_TIMESTAMP))),
                          480, 1440,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 777-300ER' LIMIT 1)
         UNION ALL SELECT 'SU-19', 'Москва (Шереметьево)', 'Лондон (Хитроу)',
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 10, TIMESTAMPADD(HOUR, 18, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 10, TIMESTAMPADD(HOUR, 22, CURRENT_TIMESTAMP))),
                          300, 900,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A350' LIMIT 1)
         UNION ALL SELECT 'SU-20', 'Москва (Шереметьево)', 'Париж (Шарль де Голль)',
                          TIMESTAMPADD(DAY, 7, TIMESTAMPADD(HOUR, 21, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 7, TIMESTAMPADD(HOUR, 25, CURRENT_TIMESTAMP)),
                          340, 1020,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A150' LIMIT 1)

         UNION ALL SELECT 'SU-21', 'Санкт-Петербург (Пулково)', 'Нью-Йорк (JFK)',
                          TIMESTAMPADD(DAY, 3, TIMESTAMPADD(HOUR, 10, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 3, TIMESTAMPADD(HOUR, 20, CURRENT_TIMESTAMP)),
                          550, 1650,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 787 Dreamliner' LIMIT 1)
         UNION ALL SELECT 'SU-22', 'Москва (Шереметьево)', 'Дубай (Международный)',
                          TIMESTAMPADD(DAY, 4, TIMESTAMPADD(HOUR, 14, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 4, TIMESTAMPADD(HOUR, 20, CURRENT_TIMESTAMP)),
                          420, 1260,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 747-8' LIMIT 1)
         UNION ALL SELECT 'SU-23', 'Санкт-Петербург (Пулково)', 'Лондон (Хитроу)',
                          TIMESTAMPADD(DAY, 5, TIMESTAMPADD(HOUR, 11, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 5, TIMESTAMPADD(HOUR, 14, CURRENT_TIMESTAMP)),
                          310, 930,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A330-300' LIMIT 1)
         UNION ALL SELECT 'SU-24', 'Москва (Шереметьево)', 'Токио (Ханеда)',
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(HOUR, 8, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(HOUR, 21, CURRENT_TIMESTAMP)),
                          580, 1740,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 737 MAX 8' LIMIT 1)
         UNION ALL SELECT 'SU-25', 'Нью-Йорк (JFK)', 'Москва (Шереметьево)',
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(HOUR, 16, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(HOUR, 6, CURRENT_TIMESTAMP)),
                          600, 1800,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A310' LIMIT 1)
         UNION ALL SELECT 'SU-26', 'Лондон (Хитроу)', 'Санкт-Петербург (Пулково)',
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 2, TIMESTAMPADD(HOUR, 13, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 2, TIMESTAMPADD(HOUR, 18, CURRENT_TIMESTAMP))),
                          350, 1050,
                          (SELECT id FROM airplanes WHERE model = 'McDonnell Douglas MD-11' LIMIT 1)
         UNION ALL SELECT 'SU-27', 'Париж (Шарль де Голль)', 'Москва (Шереметьево)',
                          TIMESTAMPADD(WEEK, 3, TIMESTAMPADD(HOUR, 19, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(WEEK, 3, TIMESTAMPADD(HOUR, 23, CURRENT_TIMESTAMP)),
                          330, 990,
                          (SELECT id FROM airplanes WHERE model = 'Bombardier CRJ900' LIMIT 1)
         UNION ALL SELECT 'SU-28', 'Дубай (Международный)', 'Санкт-Петербург (Пулково)',
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(HOUR, 22, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 4, CURRENT_TIMESTAMP))),
                          450, 1350,
                          (SELECT id FROM airplanes WHERE model = 'Embraer E195' LIMIT 1)
         UNION ALL SELECT 'SU-29', 'Токио (Ханеда)', 'Москва (Шереметьево)',
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 3, TIMESTAMPADD(HOUR, 10, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 3, TIMESTAMPADD(HOUR, 16, CURRENT_TIMESTAMP))),
                          540, 1620,
                          (SELECT id FROM airplanes WHERE model = 'Tupolev Tu-204' LIMIT 1)
         UNION ALL SELECT 'SU-30', 'Сидней (Кингсфорд Смит)', 'Москва (Шереметьево)',
                          TIMESTAMPADD(MONTH, 2, TIMESTAMPADD(HOUR, 8, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(MONTH, 2, TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 12, CURRENT_TIMESTAMP))),
                          700, 2100,
                          (SELECT id FROM airplanes WHERE model = 'Sukhoi Superjet 100' LIMIT 1)
         UNION ALL SELECT 'SU-31', 'Пекин (Столичный)', 'Москва (Шереметьево)',
                          TIMESTAMPADD(DAY, 6, TIMESTAMPADD(HOUR, 7, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 6, TIMESTAMPADD(HOUR, 12, CURRENT_TIMESTAMP)),
                          380, 1140,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 737-900ER' LIMIT 1)
         UNION ALL SELECT 'SU-32', 'Стамбул (Аэропорт)', 'Санкт-Петербург (Пулково)',
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(HOUR, 16, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(HOUR, 19, CURRENT_TIMESTAMP)),
                          270, 810,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A321neo' LIMIT 1)
         UNION ALL SELECT 'SU-33', 'Бангкок (Суварнабхуми)', 'Москва (Шереметьево)',
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 3, TIMESTAMPADD(HOUR, 21, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 4, TIMESTAMPADD(HOUR, 6, CURRENT_TIMESTAMP))),
                          490, 1470,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 767-300ER' LIMIT 1)
         UNION ALL SELECT 'SU-34', 'Сингапур (Чанги)', 'Москва (Шереметьево)',
                          TIMESTAMPADD(WEEK, 3, TIMESTAMPADD(HOUR, 11, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(WEEK, 3, TIMESTAMPADD(HOUR, 20, CURRENT_TIMESTAMP)),
                          510, 1530,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A380' LIMIT 1)
         UNION ALL SELECT 'SU-35', 'Лос-Анджелес (LAX)', 'Санкт-Петербург (Пулково)',
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 4, TIMESTAMPADD(HOUR, 14, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 5, TIMESTAMPADD(HOUR, 3, CURRENT_TIMESTAMP))),
                          650, 1950,
                          (SELECT id FROM airplanes WHERE model = 'Embraer E190' LIMIT 1)
         UNION ALL SELECT 'SU-36', 'Рим (Фьюмичино)', 'Москва (Шереметьево)',
                          TIMESTAMPADD(DAY, 8, TIMESTAMPADD(HOUR, 10, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(DAY, 8, TIMESTAMPADD(HOUR, 14, CURRENT_TIMESTAMP)),
                          290, 870,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 737-700' LIMIT 1)
         UNION ALL SELECT 'SU-37', 'Барселона (Эль-Прат)', 'Санкт-Петербург (Пулково)',
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(DAY, 4, TIMESTAMPADD(HOUR, 17, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(WEEK, 1, TIMESTAMPADD(DAY, 4, TIMESTAMPADD(HOUR, 21, CURRENT_TIMESTAMP))),
                          280, 840,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A319' LIMIT 1)
         UNION ALL SELECT 'SU-38', 'Москва (Шереметьево)', 'Пекин (Столичный)',
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 5, TIMESTAMPADD(HOUR, 8, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(WEEK, 2, TIMESTAMPADD(DAY, 5, TIMESTAMPADD(HOUR, 15, CURRENT_TIMESTAMP))),
                          420, 1260,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 757-200' LIMIT 1)
         UNION ALL SELECT 'SU-39', 'Санкт-Петербург (Пулково)', 'Стамбул (Аэропорт)',
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 6, TIMESTAMPADD(HOUR, 12, CURRENT_TIMESTAMP))),
                          TIMESTAMPADD(MONTH, 1, TIMESTAMPADD(DAY, 6, TIMESTAMPADD(HOUR, 15, CURRENT_TIMESTAMP))),
                          260, 780,
                          (SELECT id FROM airplanes WHERE model = 'Airbus A340-600' LIMIT 1)
         UNION ALL SELECT 'SU-40', 'Нью-Йорк (JFK)', 'Санкт-Петербург (Пулково)',
                          TIMESTAMPADD(MONTH, 2, TIMESTAMPADD(HOUR, 19, CURRENT_TIMESTAMP)),
                          TIMESTAMPADD(MONTH, 2, TIMESTAMPADD(DAY, 1, TIMESTAMPADD(HOUR, 9, CURRENT_TIMESTAMP))),
                          580, 1740,
                          (SELECT id FROM airplanes WHERE model = 'Boeing 787-9' LIMIT 1)
     ) AS flight_data
         JOIN destination d_to ON d_to.name = flight_data.dest
         JOIN destination d_from ON d_from.name = flight_data.place_from;