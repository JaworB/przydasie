# UPDATE, DELETE, Transactions

Modifying and removing data, and grouping statements into atomic units. See [[index]] for the practice schema (`ksiazki` table).

## UPDATE

Modifies existing rows. Without `WHERE`, **every** row is updated — always check the `WHERE` clause before running.

```sql
UPDATE ksiazki SET cena = 42.99 WHERE tytul = 'Dune';
UPDATE ksiazki SET cena = 24.99 WHERE tytul = '1984';
```

## DELETE

Removes rows. Same rule applies — no `WHERE` means the whole table is emptied.

```sql
DELETE FROM ksiazki WHERE tytul = 'Testowa książka';
```

## Transactions

`BEGIN` / `COMMIT` / `ROLLBACK` group statements into one atomic unit: either everything applies, or nothing does. Changes made after `BEGIN` are visible only in the current session until `COMMIT`.

```sql
BEGIN;
UPDATE ksiazki SET cena = cena * 1.1 WHERE gatunek = 'fantasy';
SELECT tytul, cena FROM ksiazki WHERE gatunek = 'fantasy';
ROLLBACK;
```

`ROLLBACK` discards the price increase — a follow-up `SELECT` confirms the original prices (39.99 / 44.99 / 39.99) are back.

A committed transaction, run as an exercise (raise `Solaris` by 5):

```sql
begin;
update ksiazki set cena = cena + 5 where tytul = 'Solaris';
select tytul, cena FROM ksiazki;
```

```
          tytul          | cena
--------------------------+-------
 Wiedźmin                | 39.99
 Nowe przygody Wiedźmina | 44.99
 Miecz przeznaczenia     | 39.99
 Testowa książka         | 19.99
 Dune                    | 42.99
 1984                    | 24.99
 Solaris                 | 39.99
(7 rows)
```

```sql
commit;
```

`Solaris` went from 34.99 to 39.99 as expected, and the change persisted after `COMMIT`.

> **Gotcha:** always close a transaction (`COMMIT` or `ROLLBACK`) before starting the next one with `BEGIN`. Starting a new `BEGIN` while one is still open triggers `WARNING: there is already a transaction in progress` — the new statements just join the still-open transaction instead of starting a fresh one.

## Related

- [[06-Aliases-Subqueries]] - Previous: aliases and subqueries
- [[08-Views-Indexes]] - Next: views and indexes
- [[index]] - Back to SQL index
