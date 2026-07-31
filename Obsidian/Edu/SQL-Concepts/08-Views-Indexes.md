# VIEW, Indexes, EXPLAIN

Saved queries that behave like virtual tables, and speeding up lookups on a column. See [[index]] for the practice schema (`ksiazki` + `wydawcy`).

## VIEW

A stored query that can be queried like a regular table.

```sql
CREATE VIEW ksiazki_polskie AS
SELECT k.tytul, k.autor, w.nazwa AS wydawca
FROM ksiazki k
JOIN wydawcy w ON k.wydawca_id = w.id
WHERE w.kraj = 'Polska';

SELECT * FROM ksiazki_polskie;
```

```
          tytul          |       autor       | wydawca
--------------------------+-------------------+-----------
 Wiedźmin                | Andrzej Sapkowski | SuperNOWA
 Nowe przygody Wiedźmina | Andrzej Sapkowski | SuperNOWA
 Miecz przeznaczenia     | Andrzej Sapkowski | SuperNOWA
 Solaris                 | Stanisław Lem     | MON
(4 rows)
```

Another example — books priced above 40:

```sql
CREATE VIEW ksiazki_drogie AS
SELECT k.tytul, k.cena FROM ksiazki k
WHERE k.cena > 40;

SELECT * FROM ksiazki_drogie;
```

```
          tytul          | cena
--------------------------+-------
 Nowe przygody Wiedźmina | 44.99
 Dune                    | 42.99
(2 rows)
```

Dropping a view:

```sql
DROP VIEW ksiazki_polskie;
```

## Indexes

Speed up lookups on a given column, at the cost of extra storage and slightly slower writes.

```sql
CREATE INDEX idx_ksiazki_autor ON ksiazki(autor);
CREATE INDEX idx_ksiazki_gatunek ON ksiazki(gatunek);
```

## EXPLAIN

Shows the query plan the planner picked.

```sql
EXPLAIN SELECT * FROM ksiazki WHERE autor = 'Andrzej Sapkowski';
```

```
                        QUERY PLAN
-----------------------------------------------------------
 Seq Scan on ksiazki  (cost=0.00..1.07 rows=1 width=780)
   Filter: ((autor)::text = 'Andrzej Sapkowski'::text)
```

Even with the index in place, PostgreSQL chose a **sequential scan** instead of using it. On a table this small (a handful of rows), scanning the whole table is cheaper than the random-access overhead of an index lookup — the planner would switch to `Index Scan` once the table holds enough rows for the index to pay off.

## Related

- [[07-Update-Delete-Transactions]] - Previous: UPDATE, DELETE, transactions
- [[index]] - Back to SQL index
