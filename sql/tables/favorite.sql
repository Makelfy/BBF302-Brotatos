-- favorite — Mehmet Furkan Unutan (FR-03 favori kaydet/kaldır, FR-06 öneriler)
-- users ile event arasındaki M:N "saves" ilişkisinin bağlantı tablosu.
-- Yalnızca 'published' etkinlik favorilenebilir: tablolar arası kural olduğu için
-- CHECK ile yazılamaz, ekleme sorgusu (INSERT ... SELECT ... WHERE status = 'published') uygular.
CREATE TABLE IF NOT EXISTS favorite (
    favorite_id  INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id      INT          NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
    event_id     INT          NOT NULL REFERENCES event (event_id) ON DELETE CASCADE,
    notes        VARCHAR(500),
    created_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),

    CONSTRAINT favorite_user_event_uq UNIQUE (user_id, event_id)
);

-- Etkinlik başına favori sayısı (etkinlik sayfası, öneriler, raporlar).
-- Kullanıcı bazlı aramaları UNIQUE (user_id, event_id) indeksi zaten karşılar.
CREATE INDEX IF NOT EXISTS favorite_event_idx ON favorite (event_id);
