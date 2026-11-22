-- ticket_order — Muhammed Nusret Yavuz (FR-04 bilet satın alma, FR-05 siparişlerim / iade)
-- Sipariş toplamı saklanmaz: SUM(ticket.price_paid) ile hesaplanır.
-- users.user_id ON DELETE RESTRICT: siparişi olan kullanıcı silinmez, pasifleştirilir.
CREATE TABLE IF NOT EXISTS ticket_order (
    order_id        INT          GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id         INT          NOT NULL REFERENCES users (user_id) ON DELETE RESTRICT,
    status          VARCHAR(20)  NOT NULL DEFAULT 'pending',
    payment_method  VARCHAR(20),
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),
    paid_at         TIMESTAMPTZ,
    refunded_at     TIMESTAMPTZ,

    CONSTRAINT ticket_order_status_chk   CHECK (status IN ('pending', 'paid', 'refunded', 'cancelled')),
    CONSTRAINT ticket_order_payment_chk  CHECK (payment_method IN ('credit_card', 'debit_card', 'wallet')),
    CONSTRAINT ticket_order_paid_chk     CHECK (status <> 'paid' OR paid_at IS NOT NULL),
    CONSTRAINT ticket_order_refunded_chk CHECK (status <> 'refunded' OR refunded_at IS NOT NULL)
);

-- "Siparişlerim" sayfası kullanıcıya göre arar.
CREATE INDEX IF NOT EXISTS ticket_order_user_idx ON ticket_order (user_id);
