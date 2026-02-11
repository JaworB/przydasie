# 18-Blocks

Bloki grupują zadania i umożliwiają obsługę błędów.

## Składnia bloku

```yaml
- name: Nazwa bloku
  block:
    - name: Zadanie 1
      moduł1:
        opcja: wartość

    - name: Zadanie 2
      moduł2:
        opcja: wartość
  rescue:
    - name: Zadanie ratunkowe
      moduł3:
        opcja: wartość
  always:
    - name: Zadanie zawsze
      moduł4:
        opcja: wartość
```

## Sekcje bloku

| Sekcja | Przeznaczenie |
|---------|-------------|
| `block` | Główne zadania do wykonania |
| `rescue` | Zadania gdy block zawodzi |
| `always` | Zadania, które zawsze się wykonują |

## Block z obsługą błędów

```yaml
- name: Zainstaluj pakiet z awaryjnym rozwiązaniem
  block:
    - name: Spróbuj zainstalować pakiet
      ansible.builtin.apt:
        name: specjalny-pakiet
        state: present
  rescue:
    - name: Zainstaluj alternatywę
      ansible.builtin.apt:
        name: standardowy-pakiet
        state: present
    - name: Powiadom o błędzie
      debug:
        msg: "Oryginalny pakiet niedostępny, zainstalowano alternatywę"
  always:
    - name: Zawsze powiadom
      debug:
        msg: "Próba instalacji zakończona"
```

## Block z warunkiem when

```yaml
- name: Block z warunkiem
  when: ansible_os_family == "Debian"
  block:
    - name: Zadanie 1
      debug:
        msg: "Zadanie specyficzne dla Debian"

    - name: Zadanie 2
      debug:
        msg: "Kolejne zadanie Debian"
```

## Block z tagami

```yaml
- name: Oznaczony block
  tags: web
  block:
    - name: Zadanie 1
      debug:
        msg: "Zadanie web"

    - name: Zadanie 2
      debug:
        msg: "Kolejne zadanie web"
```

## Zagnieżdżone bloki

```yaml
- name: Zewnętrzny block
  block:
    - name: Wewnętrzny block 1
      block:
        - name: Zadanie 1
          debug:
            msg: "Zadanie 1"

    - name: Wewnętrzny block 2
      block:
        - name: Zadanie 2
          debug:
            msg: "Zadanie 2"
```

## Przypadki użycia

1. **Obsługa błędów** - Łagodne niepowodzenie i odzyskiwanie
2. **Grupowanie** - Organizuj powiązane zadania
3. **Bloki warunkowe** - Zastosuj warunek do wielu zadań
4. **Czyszczenie** - Zawsze uruchamiaj zadania czyszczące
5. **Logika ponawiania** - Połącz z `until` dla ponawiania

## Powiązane

- [[17-Tags_PL]] - Poprzednie: Tagi
- [[19-Error-Handling_PL]] - Następne: Obsługa błędów
