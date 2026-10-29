# library_db

A ready-made library database with six tables and sample rows. Use it as your starting database.

| File | Use it with |
|---|---|
| `library_db.sqlite` | DB Browser for SQLite (open the file directly, no setup) |
| `library_db.sql` | PostgreSQL (pgAdmin). Run it once in a fresh, empty database |

## Tables and row counts

| Table | Rows |
|---|---|
| categories | 5 |
| members | 8 |
| books | 10 |
| borrowing_records | 12 |
| reservations | 3 |
| fines | 3 |

## Open in DB Browser for SQLite

1. Download `library_db.sqlite`.
2. Open DB Browser for SQLite, then File, then Open Database, then pick the file.
3. Browse Data shows the rows. Execute SQL lets you change them.

## Load in PostgreSQL (pgAdmin)

1. Create a new, empty database (right-click Databases, Create, Database).
2. Open the Query Tool on it and open `library_db.sql`.
3. Press Run once. Rerunning on the same database fails with `relation "categories" already exists`, so drop the database and recreate it to start over.

The two files hold the same data. The SQLite file uses `INTEGER PRIMARY KEY AUTOINCREMENT` in place of `SERIAL`, since SQLite has no `SERIAL`.
