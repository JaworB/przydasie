# Podstawy asynchroniczności

Obsługa operacji asynchronicznych w JavaScript.

## Callbacki (Tradycyjne)

```javascript
// Wzorzec callbacka
function pobierzDane(callback) {
  setTimeout(() => {
    callback({ dane: "Jakieś dane" });
  }, 1000);
}

pobierzDane(wynik => {
  console.log(wynik.dane);
});
```

## Promises

```javascript
// Tworzenie promise
const pobierzDane = () => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const sukces = true;
      if (sukces) {
        resolve({ dane: "Jakieś dane" });
      } else {
        reject(new Error("Nie udało się pobrać"));
      }
    }, 1000);
  });
};

// Konsumowanie promise
pobierzDane()
  .then(wynik => {
    console.log(wynik.dane);
    return wynik;
  })
  .catch(błąd => {
    console.error(błąd);
  });
```

## async/await (ES8+)

```javascript
async function pobierzDane() {
  try {
    const wynik = await pobierzDane();
    console.log(wynik.dane);
    return wynik;
  } catch (błąd) {
    console.error(błąd);
  }
}

// Funkcja strzałkowa async
const pobierzDane = async () => {
  const wynik = await pobierzDane();
  return wynik;
};
```

## Operacje równoległe

```javascript
const pobierz1 = pobierzDane();
const pobierz2 = pobierzDane();

// Promise.all - czekaj na wszystkie
Promise.all([pobierz1, pobierz2])
  .then(([wynik1, wynik2]) => {
    console.log(wynik1, wynik2);
  })
  .catch(błąd => console.error(błąd));

// Promise.race - pierwszy do ukończenia
Promise.race([pobierz1, pobierz2])
  .then(wynik => console.log(wynik));
```

## Powiązane

- [[07-Loops_PL]] - Poprzednie: Pętle
- [[09-Modules_PL]] - Następne: Moduły
- [[03-Functions_PL]] - Funkcje

## Następne kroki

Przejdź do [[09-Modules_PL]] aby dowiedzieć się o modułach JavaScript.
