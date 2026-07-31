# ORDER BY, LIMIT

Sorting results and capping the number of rows returned. See [[index]] for the practice schema (`ksiazki` table).

## ORDER BY

```sql
-- ascending (default) - oldest to newest
SELECT tytul, rok FROM ksiazki ORDER BY rok;
```

```
          tytul          | rok
--------------------------+------
 1984                    | 1949
 Solaris                 | 1961
 Dune                    | 1965
 Wiedźmin                | 1990
 Miecz przeznaczenia     | 1992
 Nowe przygody Wiedźmina | 2023
(6 rows)
```

```sql
-- multiple columns: sort by author, then by price descending within each author
SELECT tytul, autor, cena FROM ksiazki ORDER BY autor, cena DESC;
```

```
          tytul          |       autor       | cena
--------------------------+-------------------+-------
 Nowe przygody Wiedźmina | Andrzej Sapkowski | 44.99
 Wiedźmin                | Andrzej Sapkowski | 39.99
 Miecz przeznaczenia     | Andrzej Sapkowski | 39.99
 Dune                    | Frank Herbert     | 49.99
 1984                    | George Orwell     | 29.99
 Solaris                 | Stanisław Lem     | 34.99
(6 rows)
```

`DESC` only applies to the column it directly follows (here `cena`) — `autor` stays ascending. Writing `ORDER BY autor, cena` without `DESC` sorts both ascending, which does **not** give descending price within an author.

## LIMIT

```sql
-- 3 cheapest books
SELECT tytul, cena FROM ksiazki ORDER BY cena ASC LIMIT 3;
```

```
  tytul   | cena
----------+-------
 1984     | 29.99
 Solaris  | 34.99
 Wiedźmin | 39.99
(3 rows)
```

## Related

- [[01-Select-Where]] - Previous: filtering
- [[03-Pattern-Matching]] - Next: IN, BETWEEN, LIKE
- [[index]] - Back to SQL index
