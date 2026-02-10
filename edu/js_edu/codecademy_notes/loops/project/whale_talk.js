const input = 'Cokolwiek';
const vowels = ['a','e','i','o','u'];
let resultArray = [];

for (i = 0 ; i < input.length ; i ++) {
  if (input[i] === 'e' || input[i] === 'u'){
    resultArray.push(input[i])
  }
  for (j = 0 ; j < vowels.length; j++){
    if (input[i] === vowels[j]) {
      resultArray.push(vowels[j])
    }
  }
}
let resultString =  resultArray.join('').toUpperCase();
console.log(resultString)