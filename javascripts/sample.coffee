$ -> 

  $('.gridly').gridly
    columns: 12
    callbacks:
      reorder: (originals) ->
        results = []
        columns = 0
        while originals.length > 0
          selected = null

          index = 0
          for index in [0...originals.length]
            $element = $(originals[index])
            break if ($element.hasClass('large') and columns % 2 is 0) or ($element.hasClass('small'))
        
          index = 0 if index is originals.length
          $element = $(originals[index])
          columns += 1 if $element.hasClass('small')
          columns += 2 if $element.hasClass('large')

          # Move from originals into results
          results.push(originals.splice(index,1)[0])

        return results

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