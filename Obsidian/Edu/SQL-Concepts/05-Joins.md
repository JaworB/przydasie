# JOIN

Combining rows from multiple tables based on a related column. See [[index]] for the full schema setup (`ksiazki` + `wydawcy`, including the `wydawca_id` foreign key).

## INNER JOIN

Returns only rows that have a match in **both** tables.

```sql
SELECT ksiazki.tytul, wydawcy.nazwa, wydawcy.kraj
FROM ksiazki
INNER JOIN wydawcy ON ksiazki.wydawca_id = wydawcy.id;
```

```
          tytul          |      nazwa       |       kraj
--------------------------+------------------+------------------
 Miecz przeznaczenia     | SuperNOWA        | Polska
 Nowe przygody Wiedźmina | SuperNOWA        | Polska
 Wiedźmin                | SuperNOWA        | Polska
 Dune                    | Chilton Books    | USA
 1984                    | Secker & Warburg | Wielka Brytania
 Solaris                 | MON              | Polska
(6 rows)
```

## LEFT JOIN

Returns all rows from the left table, with `NULL`s for unmatched right-table columns.

A row with no match is excluded from `INNER JOIN` but kept by `LEFT JOIN`. Demonstrated by inserting a book with no publisher:

```sql
INSERT INTO ksiazki (tytul, autor, rok, cena, gatunek) VALUES
    ('Testowa książka', 'Nieznany', 2020, 19.99, 'inne');
```

```sql
SELECT tytul FROM ksiazki
INNER JOIN wydawcy ON ksiazki.wydawca_id = wydawcy.id;
-- SELECT 6  (Testowa książka is missing)

SELECT tytul FROM ksiazki
LEFT JOIN wydawcy ON ksiazki.wydawca_id = wydawcy.id;
-- SELECT 7  (Testowa książka is included)
```

## Finding Unmatched Rows

Combine `LEFT JOIN` with a `NULL` check to find rows with no match — a common pattern for "find orphaned records":

```sql
SELECT ksiazki.tytul, wydawcy.kraj FROM ksiazki
LEFT JOIN wydawcy ON wydawcy.id = ksiazki.wydawca_id
WHERE wydawcy.id IS NULL;
```

```
      tytul       |  kraj
------------------+--------
 Testowa książka | <null>
(1 row)
```

## JOIN + GROUP BY

```sql
SELECT wydawcy.nazwa, COUNT(*) FROM wydawcy
INNER JOIN ksiazki ON wydawcy.id = ksiazki.wydawca_id
GROUP BY wydawcy.nazwa;
```

```
      nazwa       | count
------------------+-------
 Chilton Books    | 1
 Secker & Warburg | 1
 SuperNOWA        | 3
 MON              | 1
(4 rows)
```

## Related

- [[04-Aggregation]] - Previous: GROUP BY, HAVING
- [[06-Aliases-Subqueries]] - Next: aliases and subqueries
- [[index]] - Back to SQL index
