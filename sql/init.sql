-- Run from the repository root with: psql "$DATABASE_URL" -f sql/init.sql
\set ON_ERROR_STOP on

BEGIN;

\i sql/tables/users.sql
;
\i sql/tables/organizer_profile.sql
\i sql/tables/category.sql
\i sql/tables/venue.sql
\i sql/tables/event.sql
\i sql/tables/ticket_category.sql
\i sql/tables/ticket_order.sql
\i sql/tables/follow.sql
\i sql/tables/favorite.sql
\i sql/tables/ticket.sql

COMMIT;
