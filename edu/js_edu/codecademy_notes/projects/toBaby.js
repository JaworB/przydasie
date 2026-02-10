// Write your code here:

const convertToBaby = (array) => {
  let newArray = [];
  for (let i = 0; i < array.length; i++)  {
    console.log(array[i])
    let babyAnimal = `baby ${array[i]}`
    newArray[i] = babyAnimal
  }
  return newArray;
}


const animals = ['panda', 'turtle', 'giraffe', 'hippo', 'sloth', 'human'];

console.log(convertToBaby(animals)) 

