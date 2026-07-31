# SQL (PostgreSQL)

Fundamentals of SQL using PostgreSQL, learned in a local `nauka` practice database.

## Concepts

### Fundamentals
1. [[01-Select-Where]] - SELECT, FROM, WHERE, comparison operators
2. [[02-Order-By-Limit]] - Sorting and limiting results

### Filtering
3. [[03-Pattern-Matching]] - IN, BETWEEN, LIKE

### Aggregation
4. [[04-Aggregation]] - COUNT, SUM, AVG, GROUP BY, HAVING

### Multiple Tables
5. [[05-Joins]] - INNER JOIN, LEFT JOIN
6. [[06-Aliases-Subqueries]] - Table/column aliases, subqueries

### Data Modification
7. [[07-Update-Delete-Transactions]] - UPDATE, DELETE, BEGIN/COMMIT/ROLLBACK

### Performance & Abstraction
8. [[08-Views-Indexes]] - VIEW, CREATE INDEX, EXPLAIN

## Practice Schema

All examples use the original two tables created during the lesson (column names kept as-is, in Polish, matching the actual session):

```sql
CREATE TABLE ksiazki (
    id        SERIAL PRIMARY KEY,
    tytul     VARCHAR(200),
    autor     VARCHAR(100),
    rok       INTEGER,
    cena      NUMERIC(6,2),
    gatunek   VARCHAR(50)
);

INSERT INTO ksiazki (tytul, autor, rok, cena, gatunek) VALUES
    ('Wiedźmin', 'Andrzej Sapkowski', 1990, 39.99, 'fantasy'),
    ('Dune', 'Frank Herbert', 1965, 49.99, 'sci-fi'),
    ('1984', 'George Orwell', 1949, 29.99, 'dystopia'),
    ('Solaris', 'Stanisław Lem', 1961, 34.99, 'sci-fi'),
    ('Nowe przygody Wiedźmina', 'Andrzej Sapkowski', 2023, 44.99, 'fantasy'),
    ('Miecz przeznaczenia', 'Andrzej Sapkowski', 1992, 39.99, 'fantasy');

-- Testowa książka' added later (04-Aggregation), with no publisher, price 19.99, genre 'inne'

CREATE TABLE wydawcy (
    id     SERIAL PRIMARY KEY,
    nazwa  VARCHAR(100),
    kraj   VARCHAR(50)
);

INSERT INTO wydawcy (nazwa, kraj) VALUES
    ('SuperNOWA', 'Polska'),
    ('Chilton Books', 'USA'),
    ('Secker & Warburg', 'Wielka Brytania'),
    ('MON', 'Polska');

-- added in 05-Joins:
ALTER TABLE ksiazki ADD COLUMN wydawca_id INTEGER REFERENCES wydawcy(id);
UPDATE ksiazki SET wydawca_id = 1 WHERE autor = 'Andrzej Sapkowski'; -- SuperNOWA
UPDATE ksiazki SET wydawca_id = 2 WHERE tytul = 'Dune';              -- Chilton Books
UPDATE ksiazki SET wydawca_id = 3 WHERE tytul = '1984';              -- Secker & Warburg
UPDATE ksiazki SET wydawca_id = 4 WHERE tytul = 'Solaris';           -- MON
```

## Environment Setup

- Local cluster data dir: `~/edu/sql/pgdata` (custom `PGDATA`, not the system service)
- Started via a systemd **user** service (`~/.config/systemd/user/postgres-edu.service`), enabled with `systemctl --user enable --now postgres-edu`
- Custom Unix socket directory (`-k`) means clients need `PGHOST=/home/jawor/edu/sql/pgdata` or `-h` pointing there
- CLI client: `pgcli` (syntax highlighting, autocomplete) — installed as nicer alternative to plain `psql`

## Related

- [[Bash-Scripting-Concepts]] - Shell environment / systemd units
