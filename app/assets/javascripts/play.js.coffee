$(document).on 'ready page:load page:change change', '#play_time_game_id, #play_time_console_id', ->
  game_id = $('#play_time_game_id').val()
  console_id = $('#play_time_console_id').val()

  $.ajax(
    url: '/users/with/game/' + game_id + '/console/' + console_id
  ).done (data) ->
    $('#tell').text(data)