# Aliases, Subqueries

Readability shortcuts and queries nested inside other queries. See [[index]] for the full schema (`ksiazki` + `wydawcy`).

## Aliases (AS)

Shortens table/column names, especially useful once queries involve multiple tables.

```sql
SELECT k.tytul, w.nazwa AS wydawca
FROM ksiazki AS k
JOIN wydawcy AS w ON k.wydawca_id = w.id;
```

```
          tytul          |     wydawca
--------------------------+------------------
 Miecz przeznaczenia     | SuperNOWA
 Nowe przygody Wiedźmina | SuperNOWA
 Wiedźmin                | SuperNOWA
 Dune                    | Chilton Books
 1984                    | Secker & Warburg
 Solaris                 | MON
(6 rows)
```

`AS` is optional for table aliases (`ksiazki k` works the same) but improves readability.

## Subqueries

A query nested inside another query. The inner query runs first and its result is used by the outer query.

### Scalar subquery (returns one value)

```sql
-- books priced above the overall average (avg ≈ 37.13, including 'Testowa książka')
SELECT tytul, cena FROM ksiazki
WHERE cena > (SELECT AVG(cena) FROM ksiazki);
```

```
          tytul          | cena
--------------------------+-------
 Wiedźmin                | 39.99
 Nowe przygody Wiedźmina | 44.99
 Miecz przeznaczenia     | 39.99
 Dune                    | 49.99
(4 rows)
```

The inverse (`<` instead of `>`) gives the cheaper-than-average books:

```
      tytul      | cena
------------------+-------
 1984            | 29.99
 Solaris         | 34.99
 Testowa książka | 19.99
(3 rows)
```

### Subquery with IN (returns a list)

```sql
-- books published by a Polish publisher
SELECT tytul FROM ksiazki
WHERE wydawca_id IN (SELECT id FROM wydawcy WHERE kraj = 'Polska');
```

```
          tytul
--------------------------
 Wiedźmin
 Nowe przygody Wiedźmina
 Miecz przeznaczenia
 Solaris
(4 rows)
```

```sql
-- publishers that have published at least one fantasy book
SELECT nazwa FROM wydawcy
WHERE id IN (SELECT wydawca_id FROM ksiazki WHERE gatunek = 'fantasy');
```

```
   nazwa
-----------
 SuperNOWA
(1 row)
```

## Related

- [[05-Joins]] - Previous: combining tables
- [[07-Update-Delete-Transactions]] - Next: UPDATE, DELETE, transactions
- [[index]] - Back to SQL index
