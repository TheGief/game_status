$ ->
  el = $(this.activeElement)

  el.toggleClass('btn-success btn-danger')

  if el.text() == 'Add'
    el.text('Remove')
  else if el.text() == 'Remove'
    el.text('Add')