# Aggregate Functions, GROUP BY, HAVING

Computing values across sets of rows. See [[index]] for the practice schema (`ksiazki` table).

## Aggregate Functions

```sql
SELECT COUNT(*) FROM ksiazki;
SELECT AVG(cena) FROM ksiazki;
SELECT MIN(cena), MAX(cena) FROM ksiazki;
```

## GROUP BY

Groups rows and applies an aggregate **per group** instead of over the whole table.

```sql
-- number of books per genre
SELECT gatunek, COUNT(gatunek) FROM ksiazki GROUP BY gatunek;
```

```
 gatunek  | count
----------+-------
 dystopia |     1
 fantasy  |     3
 sci-fi   |     2
(3 rows)
```

```sql
-- total price of books per author
SELECT autor, SUM(cena) FROM ksiazki GROUP BY autor;
```

```
       autor       |  sum
--------------------+--------
 Frank Herbert     |  49.99
 Andrzej Sapkowski | 124.97
 George Orwell     |  29.99
 Stanisław Lem     |  34.99
(4 rows)
```

## HAVING

`WHERE` filters rows **before** grouping; `HAVING` filters groups **after** aggregation. You cannot put an aggregate function inside `WHERE`.

```sql
-- genres with average price above 38
SELECT gatunek, AVG(cena) FROM ksiazki GROUP BY gatunek HAVING AVG(cena) > 38;
```

```
 gatunek |         avg
---------+---------------------
 fantasy | 41.6566666666666667
 sci-fi  | 42.4900000000000000
(2 rows)
```

```sql
-- authors with more than one book
SELECT autor FROM ksiazki GROUP BY autor HAVING COUNT(*) > 1;
```

```
       autor
-------------------
 Andrzej Sapkowski
(1 row)
```

## Related

- [[03-Pattern-Matching]] - Previous: IN, BETWEEN, LIKE
- [[05-Joins]] - Next: combining tables
- [[index]] - Back to SQL index
