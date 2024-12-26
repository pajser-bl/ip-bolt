DROP SCHEMA if EXISTS ip_bolt CASCADE;
CREATE SCHEMA ip_bolt;

SET
search_path TO ip_bolt;

-- ==============================
-- 1. USERS
-- ==============================
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users
(
    id                     SERIAL PRIMARY KEY,
    username               VARCHAR(50)  NOT NULL UNIQUE,
    password_hash          VARCHAR(255) NOT NULL,
    first_name             VARCHAR(50)  NOT NULL,
    last_name              VARCHAR(50)  NOT NULL,
    email                  VARCHAR(100) NOT NULL UNIQUE,
    phone                  VARCHAR(20),
    id_card_number         VARCHAR(30),
    passport_number        VARCHAR(30),
    driving_license_number VARCHAR(30),
    role                   VARCHAR(20)  NOT NULL, -- 'ADMIN','OPERATOR','MANAGER','CLIENT'
    blocked                BOOLEAN               DEFAULT FALSE,
    avatar_url             VARCHAR(255),
    created_at             TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by             INT REFERENCES users (id),
    modified_at            TIMESTAMP,
    modified_by            INT REFERENCES users (id)
);

-- ==============================
-- 2. MANUFACTURERS
-- ==============================
DROP TABLE IF EXISTS manufacturers CASCADE;
CREATE TABLE manufacturers
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    country     VARCHAR(50),
    address     VARCHAR(100),
    phone       VARCHAR(20),
    email       VARCHAR(100),
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by  INT          NOT NULL REFERENCES users (id),
    modified_at TIMESTAMP,
    modified_by INT REFERENCES users (id)
);

-- ==============================
-- 3. VEHICLES
-- ==============================
DROP TABLE IF EXISTS vehicles CASCADE;
CREATE TABLE vehicles
(
    id              SERIAL PRIMARY KEY,
    external_id     VARCHAR(50)  NOT NULL UNIQUE,
    type            VARCHAR(10)  NOT NULL, -- 'CAR','BIKE','SCOOTER'
    manufacturer_id INT          NOT NULL REFERENCES manufacturers (id),
    model           VARCHAR(100) NOT NULL,
    purchase_date   DATE,
    purchase_price  DECIMAL(12, 2),
    description     TEXT,                  -- For cars
    range           INT,                   -- For bikes
    max_speed       INT,                   -- For scooters
    rent_price      DECIMAL(12, 2),
    image_url       VARCHAR(255),
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by      INT          NOT NULL REFERENCES users (id),
    modified_at     TIMESTAMP,
    modified_by     INT REFERENCES users (id)
);

-- ==============================
-- 4. BREAKDOWNS
-- ==============================
DROP TABLE IF EXISTS breakdowns CASCADE;
CREATE TABLE breakdowns
(
    id          SERIAL PRIMARY KEY,
    vehicle_id  INT       NOT NULL REFERENCES vehicles (id),
    description TEXT      NOT NULL,
    fixed_at    TIMESTAMP,
    reported_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reported_by INT       NOT NULL REFERENCES users (id)
);

-- ==============================
-- 5. RENTALS
-- ==============================
DROP TABLE IF EXISTS rentals CASCADE;
CREATE TABLE rentals
(
    id         SERIAL PRIMARY KEY,
    vehicle_id INT            NOT NULL REFERENCES vehicles (id),
    user_id    INT            NOT NULL REFERENCES users (id),
    start_time TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_time   TIMESTAMP,
    start_lat  DECIMAL(9, 6)  NOT NULL,
    start_lng  DECIMAL(9, 6)  NOT NULL,
    end_lat    DECIMAL(9, 6),
    end_lng    DECIMAL(9, 6),
    price      DECIMAL(12, 2) NOT NULL
);

-- ==============================
-- 6. PROMOTIONS
-- ==============================
DROP TABLE IF EXISTS promotions CASCADE;
CREATE TABLE promotions
(
    id                     SERIAL PRIMARY KEY,
    type                   VARCHAR(20)  NOT NULL, -- 'PROMOTION','ANNOUNCEMENT'
    name                   VARCHAR(255) NOT NULL,
    description            TEXT         NOT NULL,
    announcement_timestamp TIMESTAMP    NOT NULL,
    start_timestamp        TIMESTAMP    NOT NULL,
    end_timestamp          TIMESTAMP    NOT NULL,
    discount               DECIMAL(15, 8),
    created_by             INT          NOT NULL REFERENCES users (id),
    created_at             TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- 7. USERS_PROMOTIONS
-- ==============================
DROP TABLE IF EXISTS users_promotions CASCADE;
CREATE TABLE users_promotions
(
    user_id      INT NOT NULL REFERENCES users (id),
    promotion_id INT NOT NULL REFERENCES promotions (id),
    PRIMARY KEY (user_id, promotion_id)
);

