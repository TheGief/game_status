GS =
  init: () ->
    this.global.tweak_flash_messages()
  user_init: () ->
    this.pusher.init()
    this.add_remove.init()
  global:
    # Flash messages need class changes based on message content due to devise issues
    tweak_flash_messages: ->
      $ ->
        alert = $('.alert')
        alert_content = alert.html()

        $(document).ready ->
          # setTimeout (-> alert.slideUp()), 5000

        # Any 'notice' type flashes that mention 'success', use bootstrap alert-success class
        if /success/i.test(alert_content) and alert.hasClass('alert-notice')
          alert.removeClass('alert-notice').addClass('alert-success')

        # Any 'alert' type flashes that mention 'invalid', use bootstrap alert-error class
        else if /invalid/i.test(alert_content) and alert.hasClass('alert-alert')
          alert.removeClass('alert-alert').addClass('alert-error')

        alert.on 'click', ->
          alert.slideUp('fast')
  pusher:
    init: () ->
      this.client = new Pusher '0608f85c7a7c783519a2'
      this.presence()
    presence: () ->
      channel = this.client.subscribe 'presence-users'
    play: () ->
      channel = this.client.subscribe 'play'
      channel.bind 'created', (data) ->
       $('#play_list').load('/play')
  add_remove:
    init: () ->
      # All add/remove buttons toggle
      toggle = (el) ->
        el.removeAttr 'disabled'
        el.toggleClass('btn-success btn-danger')
        if el.text() == 'Add'
          el.text('Remove')
        else if el.text() == 'Remove'
          el.text('Add')

      $(document).on 'click', 'a.btn.add_remove', ->
        el = $(this)
        el.bind 'ajax:success', toggle(el)
  user: {}

window.GS = GS