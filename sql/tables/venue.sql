CREATE TABLE IF NOT EXISTS venue (
    venue_id    INT           GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_by  INT           REFERENCES users (user_id) ON DELETE SET NULL,
    name        VARCHAR(150)  NOT NULL,
    address     VARCHAR(255)  NOT NULL,
    district    VARCHAR(50)   NOT NULL,
    city        VARCHAR(50)   NOT NULL,
    capacity    INT           NOT NULL,
    created_at  TIMESTAMPTZ   NOT NULL DEFAULT now(),

    CONSTRAINT venue_name_city_uq       UNIQUE (name, city),
    CONSTRAINT venue_capacity_chk       CHECK (capacity > 0),
    CONSTRAINT venue_name_not_blank     CHECK (length(trim(name)) > 0),
    CONSTRAINT venue_address_not_blank  CHECK (length(trim(address)) > 0),
    CONSTRAINT venue_district_not_blank CHECK (length(trim(district)) > 0),
    CONSTRAINT venue_city_not_blank     CHECK (length(trim(city)) > 0)
);

CREATE INDEX IF NOT EXISTS venue_city_idx ON venue (city);
CREATE INDEX IF NOT EXISTS venue_created_by_idx ON venue (created_by);
