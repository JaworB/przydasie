const shoutGreetings = arr => {
  newArr = []
  arr.forEach(word => {
  newArr.push(word.toUpperCase() + `!`)
  })
  return newArr
}

const greetings = ['hello', 'hi', 'heya', 'oi', 'hey', 'yo'];

console.log(shoutGreetings(greetings))
// Should print [ 'HELLO!', 'HI!', 'HEYA!', 'OI!', 'HEY!', 'YO!' ]

