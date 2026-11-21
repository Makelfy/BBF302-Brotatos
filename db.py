import os
from pathlib import Path

import psycopg
from dotenv import load_dotenv

load_dotenv()

TABLES_DIR = Path(__file__).resolve().parent / "sql" / "tables"

# Ordered by foreign-key dependencies so every referenced table exists first.
TABLE_ORDER = [
    "users.sql",
    "organizer_profile.sql",
    "category.sql",
    "venue.sql",
    "event.sql",
    "ticket_category.sql",
    "ticket_order.sql",
    "follow.sql",
    "favorite.sql",
    "ticket.sql",
]


def get_database_url() -> str:
    """Return DATABASE_URL from environment variables."""
    url = os.environ.get("DATABASE_URL")
    if not url:
        raise RuntimeError("DATABASE_URL environment variable is not set.")
    return url


def get_connection() -> psycopg.Connection:
    """Open a new psycopg3 connection using DATABASE_URL."""
    return psycopg.connect(get_database_url(), connect_timeout=10)


def init_db(strict: bool = False) -> tuple[list[str], list[str]]:
    """Execute table DDL scripts in dependency order inside a single transaction.

    Returns (applied, skipped) lists of filenames.
    """
    applied: list[str] = []
    skipped: list[str] = []

    with get_connection() as conn:
        with conn.cursor() as cur:
            for filename in TABLE_ORDER:
                path = TABLES_DIR / filename
                if not path.exists():
                    if strict:
                        raise FileNotFoundError(f"Missing table script: {path}")
                    skipped.append(filename)
                    continue
                cur.execute(path.read_text(encoding="utf-8"))
                applied.append(filename)

    return applied, skipped


if __name__ == "__main__":
    applied_files, skipped_files = init_db()
    print("Applied:", ", ".join(applied_files) or "none")
    if skipped_files:
        print("Skipped (not yet created):", ", ".join(skipped_files))
