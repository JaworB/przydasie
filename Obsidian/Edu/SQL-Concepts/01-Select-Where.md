# SELECT, FROM, WHERE

Basic queries and row filtering. See [[index]] for the practice schema (`ksiazki` table).

## Selecting Columns

```sql
SELECT * FROM ksiazki;
```

```
 id |          tytul          |       autor       | rok  | cena  | gatunek
----+--------------------------+-------------------+------+-------+----------
  1 | Wiedźmin                | Andrzej Sapkowski | 1990 | 39.99 | fantasy
  2 | Dune                    | Frank Herbert     | 1965 | 49.99 | sci-fi
  3 | 1984                    | George Orwell     | 1949 | 29.99 | dystopia
  4 | Solaris                 | Stanisław Lem     | 1961 | 34.99 | sci-fi
  5 | Nowe przygody Wiedźmina | Andrzej Sapkowski | 2023 | 44.99 | fantasy
  6 | Miecz przeznaczenia     | Andrzej Sapkowski | 1992 | 39.99 | fantasy
(6 rows)
```

```sql
SELECT tytul, autor FROM ksiazki;
```

## Filtering with WHERE

```sql
SELECT tytul, cena FROM ksiazki WHERE gatunek = 'fantasy';
```

```sql
SELECT * FROM ksiazki WHERE rok > 1980;
```

```sql
SELECT * FROM ksiazki WHERE cena < 40 AND gatunek = 'sci-fi';
```

```
 tytul   | cena
---------+-------
 Solaris | 34.99
(1 row)
```

Only `Solaris` (34.99) qualifies — `Dune` (49.99) is sci-fi but fails the price condition.

Comparison operators: `=`, `!=` / `<>`, `<`, `>`, `<=`, `>=`.

Combine conditions with `AND` / `OR`.

## Exercises Solved

```sql
-- books published before 1990
SELECT tytul, autor FROM ksiazki WHERE rok < 1990;
```

```
  tytul  |     autor
---------+---------------
 Dune    | Frank Herbert
 1984    | George Orwell
 Solaris | Stanisław Lem
(3 rows)
```

```sql
-- books priced at exactly 39.99
SELECT * FROM ksiazki WHERE cena = 39.99;
```

```
        tytul
---------------------
 Wiedźmin
 Miecz przeznaczenia
(2 rows)
```

```sql
-- Sapkowski books published after 2000
SELECT tytul FROM ksiazki WHERE autor = 'Andrzej Sapkowski' AND rok > 2000;
```

```
          tytul
-------------------------
 Nowe przygody Wiedźmina
(1 row)
```

## Related

- [[02-Order-By-Limit]] - Next: sorting and limiting
- [[index]] - Back to SQL index
