Template.leaderboard.players = ->
  Players.find {},
    sort:
      name: 1

Template.leaderboard.selected_name = ->
  player = Players.findOne(Session.get("selected_player"))
  player and player.name

Template.player.selected = ->
  (if Session.equals("selected_player", @_id) then "selected" else "")

Template.player.events = click: ->
  player = Players.findOne(@_id)
  Session.set "selected_player", @_id
  Players.update Session.get("selected_player"),
    $set:
      response: if player.response == 'Si' then 'No' else 'Si'

