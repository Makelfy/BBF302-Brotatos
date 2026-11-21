-- category — Mehmet Furkan Unutan (FR-14; FR-01 filtre, FR-08 etkinlik formu)
-- event.category_id → category(category_id) ON DELETE RESTRICT: kullanılan kategori silinemez.
CREATE TABLE IF NOT EXISTS category (
    category_id  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name         VARCHAR(50) NOT NULL,
    description  TEXT,

    CONSTRAINT category_name_not_blank CHECK (length(trim(name)) > 0)
);

-- "Konser" ve "konser" aynı kategori sayılır: büyük/küçük harf duyarsız tekillik.
CREATE UNIQUE INDEX IF NOT EXISTS category_name_lower_uq ON category (lower(name));
