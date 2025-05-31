INSERT INTO authorities (name)
VALUES ('USER'),
       ('ADMIN'),
       ('AIRLINE');


-- у всех пароли "qwerty"
INSERT INTO users (user_name, password, email, account_type)
SELECT 'Maksat',
       '$2a$12$B5Rvf3QpG5Vlv4se8.NDQuIe.sxoG.UVWV8eQRpbwMK980dX/V1ZK',
       'zer0icemax@gmail.com',
       (SELECT id FROM authorities WHERE name = 'USER')
UNION ALL
-- пароль admin
SELECT 'Admin',
       '$2a$12$EQ3Sj7pKeCRY9tGtgW54k.kr2Lm.o2E9XVl4tgNiTBYWCUPwXfxpO',
       'admin@gmail.com',
       (SELECT id FROM authorities WHERE name = 'ADMIN')
UNION ALL
SELECT 'Emirates',
       '$2a$12$B5Rvf3QpG5Vlv4se8.NDQuIe.sxoG.UVWV8eQRpbwMK980dX/V1ZK',
       'contact@emirates.com',
       (SELECT id FROM authorities WHERE name = 'AIRLINE')
UNION ALL
SELECT 'QatarAirways',
       '$2a$12$B5Rvf3QpG5Vlv4se8.NDQuIe.sxoG.UVWV8eQRpbwMK980dX/V1ZK',
       'support@qatarairways.com',
       (SELECT id FROM authorities WHERE name = 'AIRLINE')
UNION ALL
SELECT 'SingaporeAirlines',
       '$2a$12$B5Rvf3QpG5Vlv4se8.NDQuIe.sxoG.UVWV8eQRpbwMK980dX/V1ZK',
       'info@singaporeair.com',
       (SELECT id FROM authorities WHERE name = 'AIRLINE')
UNION ALL
SELECT 'TurkishAirlines',
       '$2a$12$B5Rvf3QpG5Vlv4se8.NDQuIe.sxoG.UVWV8eQRpbwMK980dX/V1ZK',
       'help@turkishairlines.com',
       (SELECT id FROM authorities WHERE name = 'AIRLINE')
UNION ALL
SELECT 'Lufthansa',
       '$2a$12$B5Rvf3QpG5Vlv4se8.NDQuIe.sxoG.UVWV8eQRpbwMK980dX/V1ZK',
       'service@lufthansa.com',
       (SELECT id FROM authorities WHERE name = 'AIRLINE');