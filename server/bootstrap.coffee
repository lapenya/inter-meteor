Players   = new Meteor.Collection("players")
Games     = new Meteor.Collection("games")
Responses = new Meteor.Collection("responses")

###
Meteor.startup ->
  Players.remove({})
  names = [ "Pablo", "Edu", "Abel", "Negro", "Dani",
            "Paco", "Oscar", "Raúl", "Jaime", "David"
            "Angel" ]
  i = 0

  while i < names.length
    Players.insert
      name: names[i]
    i++

  Games.remove({})
  Games.insert
    when: Date.parse('2012-12-18 10:54:00 UTC')
    rival: 'Ellos F.C.'
  Games.insert
    when: Date.parse('2012-10-09 17:05:02 UTC')
    rival: 'Antes F.C.'

  Responses.remove({})
  Players.find().forEach (player) ->
    Games.find({}, sort: when: 1).forEach (game) ->
      Responses.insert
        player: player.name
        game: game._id
        value: ''
###

