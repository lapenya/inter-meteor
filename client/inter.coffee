Players   = new Meteor.Collection("players")
Games     = new Meteor.Collection("games")
Responses = new Meteor.Collection("responses")

getURLParameter = (name) ->
  match = RegExp(name + "=" + "(.+?)(&|$)").exec(location.search)
  decodeURI (match[1]) if match

currentPlayer = -> Session.get 'current_user'
findPlayer = (name) -> Players.findOne({name: name})
isCurrentPlayer = (name) -> name == currentPlayer()
allPlayers = -> Players.find {}, sort: name: 1

login = (name) ->
  login_user = name || getURLParameter('player') || amplify.store('player')
  if login_user
    player = findPlayer(login_user)
    name = player and player.name
    Session.set 'current_user', name
    amplify.store('player', name)

Template.global.current_user = ->
  currentPlayer() || login()

Template.player.current_user = ->
  currentPlayer()

Template.players_games.players = ->
  allPlayers()

Template.players_games.dates = ->
  dates = []
  Games.find({}, sort: when: 1).forEach (game) ->
    players_in = Responses.find
      value: 'Sí'
      game: game._id
    dates.push date: formatDate(game.when), rival: game.rival, players_in: players_in.count()

  dates

Template.players_games.responses = ->
  player = @
  responses = []
  Games.find({}, sort: when: 1).forEach (game) ->
    responses.push game: game, player: player.name
  responses

# Login
Template.players_list.players = ->
  allPlayers()

Template.player.events = click: (evt) ->
  $(evt.target).parents('td').effect('highlight')
  login(@name)

Template.games_list.games = ->
  missing_responses = Responses.find
    player: currentPlayer()
    value: ''

  games = []
  missing_responses.forEach (resp) ->
    games.push player: currentPlayer(), game: Games.findOne resp.game

  games

Template.game.date = ->
  game = Games.findOne @game._id
  formatDate(game.when)

Template.response.is_current_user = ->
  isCurrentPlayer @player

Template.response.si_class = ->
  resp = Responses.findOne
    player: @player
    game: @game._id
  val = resp and resp.value
  r = ''
  r += 'btn-success' if val == 'Sí'
  r += 'disabled' unless isCurrentPlayer(@player)
  r

Template.response.no_class = ->
  resp = Responses.findOne
    player: @player
    game: @game._id
  val = resp and resp.value
  r = ''
  r += 'btn-inverse' if val == 'No'
  r += 'disabled' unless isCurrentPlayer(@player)
  r

Template.response.value = ->
  resp = Responses.findOne
    player: @player
    game: @game._id
  resp and resp.value

Template.response.events = click: (evt) ->
  value = $(evt.target).text()
  Responses.update(
    {player: @player
    game: @game._id},
    {$set:
      {value:
        value}}
    )

  # And send me email
  #Meteor.call 'sendEmail', @player, @game.when, value, -> console.log "Sent email"

