CREATE TABLE IF NOT EXISTS ticket_category (
    ticket_category_id  INT            GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    event_id            INT            NOT NULL REFERENCES event (event_id) ON DELETE CASCADE,
    name                VARCHAR(50)    NOT NULL,
    price               NUMERIC(10,2)  NOT NULL,
    quota               INT            NOT NULL,
    sales_start         TIMESTAMPTZ    NOT NULL,
    sales_end           TIMESTAMPTZ    NOT NULL,

    CONSTRAINT ticket_category_event_name_uq  UNIQUE (event_id, name),
    CONSTRAINT ticket_category_price_chk      CHECK (price >= 0),
    CONSTRAINT ticket_category_quota_chk      CHECK (quota > 0),
    CONSTRAINT ticket_category_sales_chk      CHECK (sales_end > sales_start),
    CONSTRAINT ticket_category_name_not_blank CHECK (length(trim(name)) > 0)
);
