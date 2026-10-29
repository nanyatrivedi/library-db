# library_db

A PostgreSQL library database with six tables and sample rows. Use it as your starting database.

| File | Use it for |
|---|---|
| `library_db.sql` | Plain SQL script. Run it in pgAdmin to build the database. |
| `library_db.dump` | PostgreSQL custom-format dump. Restore it with pg_restore. |

## Tables and row counts

| Table | Rows |
|---|---|
| categories | 5 |
| members | 8 |
| books | 10 |
| borrowing_records | 12 |
| reservations | 3 |
| fines | 3 |

## Load in pgAdmin (recommended)

1. Create a new, empty database (right-click Databases, Create, Database), for example `library_db`.
2. Open the Query Tool on it and open `library_db.sql`.
3. Press Run once.

Running the script twice on the same database fails with `relation "categories" already exists`. To start over, drop the database and recreate it.

## Restore the dump (optional)

```bash
createdb library_db
pg_restore --no-owner -d library_db library_db.dump
```
