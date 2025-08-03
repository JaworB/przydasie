
const greetAliens = (namesArray) => {
  for (names in namesArray) {
    console.log(`Oh powerful ${namesArray[names]}, we humans offer our unconditional surrender!`);
  }
}

// When you're ready to test your code, uncomment the below and run:

const aliens = ["Blorgous", "Glamyx", "Wegord", "SpaceKing"];

greetAliens(aliens);

