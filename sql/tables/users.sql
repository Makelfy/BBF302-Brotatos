CREATE TABLE  IF NOT EXISTS users (
    user_id       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email          VARCHAR(255) NOT NULL UNIQUE,
    password_hash  VARCHAR(255) NOT NULL,
    full_name      VARCHAR(100) NOT NULL,
    phone          VARCHAR(20),
    role           VARCHAR(20)  NOT NULL DEFAULT 'user',
    is_active      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at     TIMESTAMPTZ  NOT NULL DEFAULT now(),

    CONSTRAINT users_role_chk      CHECK (role IN ('user', 'organizer', 'admin')),
    CONSTRAINT users_email_lower   CHECK (email = lower(email)),
    CONSTRAINT users_email_format  CHECK (email LIKE '%_@_%._%'),
    CONSTRAINT users_name_not_blank CHECK (length(trim(full_name)) > 0)
)