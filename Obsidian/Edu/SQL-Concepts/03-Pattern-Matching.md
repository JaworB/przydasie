# IN, BETWEEN, LIKE

Additional `WHERE` operators for matching sets, ranges, and text patterns. See [[index]] for the practice schema (`ksiazki` table).

## IN

Matches against a list of values.

```sql
SELECT tytul FROM ksiazki WHERE autor IN ('George Orwell', 'Frank Herbert');
```

```
 tytul
-------
 Dune
 1984
(2 rows)
```

## BETWEEN

Inclusive range check.

```sql
SELECT tytul FROM ksiazki WHERE cena BETWEEN 30 AND 40;
```

```
        tytul
---------------------
 Wiedźmin
 Solaris
 Miecz przeznaczenia
(3 rows)
```

## LIKE

Text pattern matching. `%` matches any sequence of characters, `_` matches exactly one character.

```sql
-- starts with 'S'
SELECT tytul FROM ksiazki WHERE tytul LIKE 'S%';
```

```
  tytul
---------
 Solaris
(1 row)
```

```sql
-- contains 'Wiedźmin' anywhere in the title
SELECT tytul FROM ksiazki WHERE tytul LIKE '%Wiedźmin%';
```

```
          tytul
--------------------------
 Wiedźmin
 Nowe przygody Wiedźmina
(2 rows)
```

Note this does **not** match `Miecz przeznaczenia` — the word "Wiedźmin" doesn't appear in that title even though it's the same book series.

## Related

- [[02-Order-By-Limit]] - Previous: sorting
- [[04-Aggregation]] - Next: aggregate functions
- [[index]] - Back to SQL index
