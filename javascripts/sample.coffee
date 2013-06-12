$ -> 
  gridly = $('.gridly').gridly base: 60, gutter: 20, columns: 12

  $('.gridly .brick').click (event) ->
    event.preventDefault()
    event.stopPropagation()
    $(this).toggleClass('small')
    $(this).toggleClass('large')
    size = 140 if $(this).hasClass('small') # HACK
    size = 300 if $(this).hasClass('large') # HACK
    $(this).data('width',  size) # HACK
    $(this).data('height', size) # HACK
    $('.gridly').gridly 'layout'