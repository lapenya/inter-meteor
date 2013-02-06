Players   = new Meteor.Collection("players")
Games     = new Meteor.Collection("games")
Responses = new Meteor.Collection("responses")

Meteor.startup ->
  Responses.remove({})
  Players.find().forEach (player) ->
    Games.find({}, sort: when: 1).forEach (game) ->
      Responses.insert
        player: player.name
        game: game._id
        value: ''

###
  Games.insert
    when: Date.parse('2012-10-09 17:05:02 UTC')
    rival: 'Antes F.C.'
###

