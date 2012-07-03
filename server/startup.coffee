Players = new Meteor.Collection("players")

Meteor.startup ->
  if Players.find().count() is 0
    Players.remove({})
    names = [ "Pablo", "Edu", "Abel", "Negro", "Dani",
              "Paco", "Óscar", "Raúl", "Jaime", "David"
              "Fede" ]
    i = 0

    while i < names.length
      Players.insert
        name: names[i]
        response: 'No'
      i++
