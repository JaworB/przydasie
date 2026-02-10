// Arrow Function and Object Example
// Does not support arrow functions as methods in objects

const robot = {
  energyLevel: 100,
  checkEnergy(){
    console.log(`Energy is currently at ${this.energyLevel}%.`)
  }
}

robot.checkEnergy();