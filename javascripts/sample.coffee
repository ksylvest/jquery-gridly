$ -> 

  $('.gridly').gridly
    columns: 12

  $('.gridly').gridly('draggable')

  $('.gridly .brick').click (event) ->
    event.preventDefault()
    event.stopPropagation()
    $(this).toggleClass('small')
    $(this).toggleClass('large')
    size = 140 if $(this).hasClass('small') # HACK
    size = 300 if $(this).hasClass('large') # HACK
    $(this).data('width', size)
    $(this).data('height', size)
    $('.gridly').gridly 'layout'