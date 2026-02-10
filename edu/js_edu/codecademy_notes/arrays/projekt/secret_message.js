let secretMessage = ['Learning', 'is', 'not', 'about', 'what', 'you', 'get', 'easily', 'the', 'first', 'time,', 'it', 'is', 'about', 'what', 'you', 'can', 'figure', 'out.', '-2015,', 'Chris', 'Pine,', 'Learn', 'JavaScript'];
secretMessage.pop();
secretMessage.length;
secretMessage.push('to', 'Program');
secretMessage[secretMessage.indexOf('easily')] = 'right'
secretMessage.shift()
secretMessage.unshift('Programming')
console.log(secretMessage)
console.log(`${secretMessage.indexOf('get')}, ${secretMessage.indexOf('time,')}`)
secretMessage.splice(secretMessage.indexOf('get'), 6 , 'know')
console.log(`${secretMessage} 'Length: ${secretMessage.length}'`)

console.log(secretMessage.join())