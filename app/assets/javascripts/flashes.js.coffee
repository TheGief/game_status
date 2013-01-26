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
