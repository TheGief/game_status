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


# Flash messages need class changes based on message content due to devise issues
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
