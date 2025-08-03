// Write your code here:

const justCoolStuff = (array1, array2) => {
  newArr = []
  for (i = 0; i < array1.length; i++) {
    console.log(array1[i])
    for (j = 0 ; j < array2.length; j++) {
      console.log(array2[j])
      newArr.filter()
    }
  }
};

// Feel free to uncomment the code below to test your function

const coolStuff = [
  "gameboys",
  "skateboards",
  "backwards hats",
  "fruit-by-the-foot",
  "pogs",
  "my room",
  "temporary tattoos",
];

const myStuff = [
  "rules",
  "fruit-by-the-foot",
  "wedgies",
  "sweaters",
  "skateboards",
  "family-night",
  "my room",
  "braces",
  "the information superhighway",
];

console.log(justCoolStuff(myStuff, coolStuff));
// Should print [ 'fruit-by-the-foot', 'skateboards', 'my room' ]
