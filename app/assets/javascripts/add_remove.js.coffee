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
