SET search_path TO ip_bolt;
--  ==============================
--  Seed basic backoffice users
--  ==============================
INSERT INTO users (username, password_hash, first_name, last_name, email, phone, role, created_by)
VALUES ('admin', '$argon2id$v=19$m=12,t=3,p=1$MTdkenR2cXFhZWUwMDAwMA$WygQceqiLCRahKakqRsgiA', 'Admin', 'Adminovic',
        'admin@ipbolt.com', '+42075133769', 'ADMIN', null);

INSERT INTO users (username, password_hash, first_name, last_name, email, phone, role, created_by)
VALUES ('operator', '$argon2id$v=19$m=12,t=3,p=1$MmQ5amNka2pwejAwMDAwMA$zv/doyR+z0Gc6EEqW3BshA', 'Operator',
        'Operatorovic', 'operator@ipbolt.com', '+42075696969', 'OPERATOR', 1),
       ('manager', '$argon2id$v=19$m=12,t=3,p=1$NXBlOHZjcWNkZjkwMDAwMA$73sRAFYeQFgZLyRjC1kb7g', 'Manager',
        'Managerovic', 'manager@ipbolt.com', '+42075133769', 'MANAGER', 1);

--  ==============================
--  Seed basic client users
--  ==============================
INSERT INTO users (username, password_hash, first_name, last_name, email, phone, id_card_number, passport_number,
                   driving_license_number, role, blocked, avatar_url)
VALUES ('client1', '$argon2id$v=19$m=12,t=3,p=1$OHExeTJlZWF5bDAwMDAwMA$yJaXNuc/8XubP3RJCxPkrA', 'Domaci',
        'Bezvoznikovic', 'client1@somemail.com', '+38765111111', '11111111111111',
        null, null, 'CLIENT', FALSE, 'https://i.pravatar.cc/200'),
       ('client2', '$argon2id$v=19$m=12,t=3,p=1$OHExeTJlZWF5bDAwMDAwMA$yJaXNuc/8XubP3RJCxPkrA', 'Domaci', 'Vozackovic',
        'client2@somemail.com', '+38765222222', '22222222222222',
        null, null, 'CLIENT', FALSE, 'https://i.pravatar.cc/200'),
       ('client3', '$argon2id$v=19$m=12,t=3,p=1$OHExeTJlZWF5bDAwMDAwMA$yJaXNuc/8XubP3RJCxPkrA', 'Domaci', 'Banovanov',
        'client3@somemail.com', '+38765333333', '33333333333333',
        null, '987654321', 'CLIENT', TRUE, 'https://i.pravatar.cc/200'),
       ('client4', '$argon2id$v=19$m=12,t=3,p=1$OHExeTJlZWF5bDAwMDAwMA$yJaXNuc/8XubP3RJCxPkrA', 'Strani', 'Vozackovic',
        'client4@somemail.com', '+35455444444', null, '123456789',
        '987654321', 'CLIENT', FALSE, 'https://i.pravatar.cc/200');

--  ==============================
--  Seed manufacturers
--  ==============================
INSERT INTO manufacturers (name, country, address, phone, email, created_by)
VALUES ('Volkswagen', 'Germany', 'Volkswagen AG, Berliner Ring 2, 38440 Wolfsburg', '+49 5361 9-0', 'office@vw.de', 1),
       ('BMW', 'Germany', 'BMW AG, Petuelring 130, 80788 München', '+49 89 3820-0', 'office@bmw.de', 1),
       ('Trek Bicycle Corporation', 'USA', 'Trek Bicycle Corporation, 801 West Madison Street, Waterloo, WI 53594',
        '+1 920 478 2191', 'office@trek.us', 1),
       ('Kawasaki Heavy Industries', 'Japan', 'Kawasaki Heavy Industries, 1-14-5 Kaigan, Minato-ku, Tokyo 105-8315',
        '+81 3 3435 2111', 'office@kawasaki.jp', 1);

--  ==============================
--  Seed vehicles
--  ==============================
INSERT INTO vehicles (external_id, type, manufacturer_id, model, purchase_date, purchase_price, description,
                      range, max_speed, rent_price, image_url, created_by)
VALUES ('C-001', 'CAR', 1, 'Golf 7', '2019-01-01', 25000.00, 'Volkswagen Golf 7 1.6 TDI', null, null, 10,
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbEzsP4s-DMcNGVQeGGGxUpg75n0iqjT72tA&s', 1),
       ('C-002', 'CAR', 2, 'X5', '2019-01-01', 75000.00, 'BMW X5 3.0d', null, null, 20,
        'https://www.ultimatespecs.com/cargallery/11/819/BMW-E53-X5-1.jpg', 1),
       ('B-001', 'BIKE', 3, 'Madone SLR 9 Disc eTap', '2019-01-01', 10000.00, null, 100, null, 5,
        'https://racing.trekbikes.com/wp-content/uploads/2019/01/5X7A4593-scaled-1600x800-c-center.jpg?x26896', 1),
       ('S-001', 'SCOOTER', 4, 'Kawasaki electric scooter', '2019-01-01', 3000.00, null, null, 30, 1.5,
        'https://koka-shop.de/media/catalog/product/A/Q/AQI_KSKICKSCOOTER2BLK_1_67307_1024x900.jpg', 1);

--  ==============================
--  Seed vehicle breakdowns
--  ==============================
INSERT INTO breakdowns (vehicle_id, description, reported_at, fixed_at, reported_by)
VALUES (1, 'Engine failure', '2019-01-02T00:00:00', '2019-02-02T00:00:00', 2),
       (2, 'Gearbox failure', '2019-01-03T00:00:00', '2019-01-23T00:00:00', 2),
       (3, 'Flat tire', '2019-01-04T00:00:00', '2019-01-04T00:10:00', 2),
       (4, 'Battery failure', '2019-01-05T00:00:00', '2019-01-05T00:05:00', 2);

--  ==============================
--  Seed vehicle rentals
--  ==============================
INSERT INTO rentals (vehicle_id, user_id, start_time, end_time, start_lat, start_lng, end_lat, end_lng, price)
VALUES (1, 4, '2019-01-01T00:00:00', '2019-01-02T00:00:00', 43.8563, 18.4131, 43.8563, 18.4131, 10),
       (2, 5, '2019-01-01T00:00:00', '2019-01-02T00:00:00', 43.8563, 18.4131, 43.8563, 18.4131, 20),
       (3, 6, '2019-01-01T00:00:00', '2019-01-02T00:00:00', 43.8563, 18.4131, 43.8563, 18.4131, 5),
       (4, 7, '2019-01-01T00:00:00', '2019-01-02T00:00:00', 43.8563, 18.4131, 43.8563, 18.4131, 2);

-- ==============================
-- Seed promotions
-- ==============================
INSERT INTO promotions (type, name, description, announcement_timestamp, start_timestamp, end_timestamp, discount,
                        created_by)
VALUES ('ANNOUNCEMENT', 'The IP Bolt clone is ON!', 'Today start our renting services!',
        CURRENT_TIMESTAMP + INTERVAL '2 minutes', CURRENT_TIMESTAMP + INTERVAL '2 minutes',
        CURRENT_TIMESTAMP + INTERVAL '1 day', null, 3),
       ('PROMOTION', 'Bonus for all!', 'Have 20% off!!!', CURRENT_TIMESTAMP + INTERVAL '3 minutes',
        CURRENT_TIMESTAMP + INTERVAL '3 minutes', CURRENT_TIMESTAMP + INTERVAL '1 day', 20, 3);

-- ==============================
-- Seed users_promotions
-- ==============================
INSERT INTO users_promotions (user_id, promotion_id)
VALUES (4, 1),
       (5, 1),
       (6, 1),
       (7, 1),
       (4, 2),
       (5, 2),
       (6, 2),
       (7, 2);
