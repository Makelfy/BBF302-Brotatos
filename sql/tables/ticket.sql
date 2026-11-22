-- ticket — Muhammed Nusret Yavuz (FR-04 satın alma, FR-05 biletlerim, FR-09 kapıda check-in)
-- Her satır bir kişilik giriş hakkı. Etkinlik ve alıcı tekrar saklanmaz:
-- ticket_category ve ticket_order üzerinden bulunur.
-- ticket_code uygulamada üretilir (secrets.token_hex(8)).
-- Kota aşımı CHECK ile engellenemez (tablolar arası kural): satın alma işlemi
-- ticket_category satırını SELECT ... FOR UPDATE ile kilitleyip satılanları sayar.
CREATE TABLE IF NOT EXISTS ticket (
    ticket_id           INT            GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id            INT            NOT NULL REFERENCES ticket_order (order_id) ON DELETE CASCADE,
    ticket_category_id  INT            NOT NULL REFERENCES ticket_category (ticket_category_id) ON DELETE RESTRICT,
    ticket_code         VARCHAR(16)    NOT NULL,
    price_paid          NUMERIC(10,2)  NOT NULL,
    user_name           VARCHAR(100)   NOT NULL,
    status              VARCHAR(20)    NOT NULL DEFAULT 'valid',
    checked_in_at       TIMESTAMPTZ,

    CONSTRAINT ticket_code_uq          UNIQUE (ticket_code),
    CONSTRAINT ticket_price_chk        CHECK (price_paid >= 0),
    CONSTRAINT ticket_user_name_chk    CHECK (length(trim(user_name)) > 0),
    CONSTRAINT ticket_status_chk       CHECK (status IN ('valid', 'used', 'cancelled')),
    CONSTRAINT ticket_checked_in_chk   CHECK (status <> 'used' OR checked_in_at IS NOT NULL)
);

-- Sipariş detayı ve satılan bilet sayımı (kalan kota, satış raporu) için.
CREATE INDEX IF NOT EXISTS ticket_order_id_idx         ON ticket (order_id);
CREATE INDEX IF NOT EXISTS ticket_ticket_category_idx  ON ticket (ticket_category_id);
