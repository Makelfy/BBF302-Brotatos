CREATE TABLE IF NOT EXISTS organizer_profile (
    organizer_id   INT          PRIMARY KEY REFERENCES users (user_id) ON DELETE CASCADE,
    display_name   VARCHAR(100) NOT NULL,
    bio            TEXT,
    contact_email  VARCHAR(255),
    website        VARCHAR(255),
    status         VARCHAR(20)  NOT NULL DEFAULT 'pending',
    applied_at     TIMESTAMPTZ  NOT NULL DEFAULT now(),
    verified_at    TIMESTAMPTZ,
    verified_by    INT          REFERENCES users (user_id) ON DELETE SET NULL,

    CONSTRAINT organizer_profile_status_chk     CHECK (status IN ('pending', 'verified', 'suspended')),
    CONSTRAINT organizer_profile_name_not_blank CHECK (length(trim(display_name)) > 0),
    CONSTRAINT organizer_profile_email_format   CHECK (contact_email IS NULL OR contact_email LIKE '%_@_%._%')
);
