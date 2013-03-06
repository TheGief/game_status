$(
  friend_count = ->
    game_id = $('#play_time_game_id').val()
    console_id = $('#play_time_console_id').val()
    $.ajax(
      url: '/users/with/game/' + game_id + '/console/' + console_id
    ).done (json) ->
      console.log json
      $('#tell_count').text json.length
      $('#tell_names').text json.join ', '

  $(document).on 'change', '#play_time_game_id, #play_time_console_id', ->
    friend_count()
) 
