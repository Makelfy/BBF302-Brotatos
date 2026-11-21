CREATE TABLE IF NOT EXISTS event (
    event_id        INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    organizer_id    INT          NOT NULL REFERENCES organizer_profile (organizer_id) ON DELETE RESTRICT,
    venue_id        INT          NOT NULL REFERENCES venue (venue_id)                 ON DELETE RESTRICT,
    category_id     INT          NOT NULL REFERENCES category (category_id)           ON DELETE RESTRICT,
    title           VARCHAR(150) NOT NULL,
    description     TEXT,
    start_datetime  TIMESTAMPTZ  NOT NULL,
    end_datetime    TIMESTAMPTZ  NOT NULL,
    status          VARCHAR(20)  NOT NULL DEFAULT 'draft',
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),

    CONSTRAINT event_status_chk      CHECK (status IN ('draft', 'published', 'cancelled', 'completed')),
    CONSTRAINT event_dates_chk       CHECK (end_datetime > start_datetime),
    CONSTRAINT event_title_not_blank CHECK (length(trim(title)) > 0)
);