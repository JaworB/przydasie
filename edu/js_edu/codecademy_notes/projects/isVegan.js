// Write your code here:
// Write your code here:
const isPlant = item => {
  return item.source === 'plant';
}

const isTheDinnerVegan = arr => {
  return arr.every(isPlant);
}





// Feel free to comment out the code below to test your function

const dinner = [{name: 'hamburger', source: 'meat'}, {name: 'cheese', source: 'dairy'}, {name: 'ketchup', source:'plant'}, {name: 'bun', source: 'plant'}, {name: 'dessert twinkies', source:'unknown'}];

console.log(isTheDinnerVegan(dinner))
// Should print false
