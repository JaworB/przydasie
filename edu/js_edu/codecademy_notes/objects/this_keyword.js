const robot = {
  model: '1E78V2',
  energyLevel: 100,
  provideInfo(){
    console.log(`I am ${this.model} and my current energy level is ${this.energyLevel}.`)
  }
};

robot.provideInfo()