$ ->
  # Show how many friends you will notifiy and their usernames
  friend_count = ->
      game_id = $('#play_time_game_id').val()
      console_id = $('#play_time_console_id').val()
      $.ajax(
        url: '/users/with/game/' + game_id + '/console/' + console_id
      ).done (json) ->
        console.log json
        $('#tell_count').text json.length
        $('#tell_names').text json.join ', '

  if $('body.play_times').length > 0
    friend_count()

  $(document).on 'change', 'body.play_times select', ->
    friend_count()


  # Form field tips
  $(".pop").popover {trigger: 'focus'}


  # Gravatar images have username tips
  $("img.attendee, abbr").tooltip()