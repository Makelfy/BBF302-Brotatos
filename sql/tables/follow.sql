CREATE TABLE IF NOT EXISTS follow (
    follow_id     INT         GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id       INT         NOT NULL REFERENCES users (user_id)                  ON DELETE CASCADE,
    organizer_id  INT         NOT NULL REFERENCES organizer_profile (organizer_id) ON DELETE CASCADE,
    followed_at   TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT follow_user_organizer_uq UNIQUE (user_id, organizer_id),
    CONSTRAINT follow_no_self_chk       CHECK (user_id <> organizer_id)
);
