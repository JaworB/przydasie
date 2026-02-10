const team = {
  _players: [
    { firstName: `name1`, lastName: `lastName1`, age: 21 },
    { firstName: `name2`, lastName: `lastName2`, age: 22 },
    { firstName: `name3`, lastName: `lastName3`, age: 23 },
  ],
  _games: [
    { opponent: "oponent1", teamPoints: 11, opponentPoints: 10 },
    { opponent: "oponent2", teamPoints: 11, opponentPoints: 10 },
    { opponent: "oponent3", teamPoints: 11, opponentPoints: 10 },
  ],

  get players() {
    return this._players;
  },
  get games() {
    return this._games;
  },

  addPlayer(newFirstName, newlastName, newAge) {
    let player = {
      firstName: newFirstName,
      lastName: newlastName,
      age: newAge,
    };
    this.players.push(player);
  },
  addGame(newOpponent, newTeamPoints, newOpponentPoints) {
    let game = {
      opponent: newOpponent,
      teamPoints: newTeamPoints,
      opponentPoints: newOpponentPoints,
    };
    this.games.push(game);
  },
};

team.addPlayer(`Bunny`, `Bugs`, 76);
team.addGame("Dupa", 20, 30);
console.log(team.players);
console.log(team.games);
