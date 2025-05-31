
INSERT INTO bookings (flight_id, seat_number, class_type_id)
SELECT
    f.id as flight_id,
    seat_data.seat_number,
    seat_data.class_type_id
FROM flights f
         CROSS JOIN (

    SELECT '1A' as seat_number, (SELECT id FROM class_type_airplane WHERE name = 'BUSINESS') as class_type_id
    UNION ALL SELECT '1B', (SELECT id FROM class_type_airplane WHERE name = 'BUSINESS')
    UNION ALL SELECT '1C', (SELECT id FROM class_type_airplane WHERE name = 'BUSINESS')

    UNION ALL SELECT '1D', (SELECT id FROM class_type_airplane WHERE name = 'ECONOMY')
    UNION ALL SELECT '1E', (SELECT id FROM class_type_airplane WHERE name = 'ECONOMY')
    UNION ALL SELECT '1F', (SELECT id FROM class_type_airplane WHERE name = 'ECONOMY')
    UNION ALL SELECT '2A', (SELECT id FROM class_type_airplane WHERE name = 'ECONOMY')
    UNION ALL SELECT '2B', (SELECT id FROM class_type_airplane WHERE name = 'ECONOMY')
    UNION ALL SELECT '2C', (SELECT id FROM class_type_airplane WHERE name = 'ECONOMY')
    UNION ALL SELECT '2D', (SELECT id FROM class_type_airplane WHERE name = 'ECONOMY')
) as seat_data
WHERE f.flight_number LIKE 'SU-%'
ORDER BY f.id,
         CASE WHEN seat_data.class_type_id = (SELECT id FROM class_type_airplane WHERE name = 'BUSINESS')
                  THEN 1 ELSE 2 END,
         seat_data.seat_number;