let menu = {
  _meal: '',
  set _meal(newMeal){
    if (typeof newMeal === 'string') {
      this.meal = newMeal;
    } else {
      console.log('Meal should be string') 
    }
  },
  _price: 0,
  set _price(newPrice){
    if (typeof newPrice === 'number') {
      this.price = newPrice;
    } else {
      console.log(`Price should be an number`)
    }
  },
  get todaysSpecial() {
    if (this.price && this.meal) {
      return `${this.meal} ${this.price}`;
    }
  }


}

menu._meal = `dupa`
menu._price = 12

console.log(menu.todaysSpecial)