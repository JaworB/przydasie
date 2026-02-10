let raceNumber = Math.floor(Math.random() * 1000);


registerEarly = false;
runnerAge = 18;

if (registerEarly && runnerAge > 18) {
  raceNumber = raceNumber + 1000;
}

if (registerEarly && runnerAge > 18) {
  console.log(raceNumber + ' starts at 9:30 am.');
  }
else if (!registerEarly && runnerAge > 18) {
    console.log(raceNumber + ' starts at 11:00 am.');
}
else if (runnerAge < 18) {
    console.log(raceNumber + ' starts at 12:30 pm.');
}
else {
  console.log('Please see the registration desk.');
}