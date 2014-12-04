$ ->

  brick = "<div class='brick small'><div class='delete'>&times;</div></div>"

  $(document).on "click touchend", ".gridly .brick", (event) ->
    event.preventDefault()
    event.stopPropagation()
    $this = $(this)

    $this.toggleClass('small')
    $this.toggleClass('large')
    size = 140 if $this.hasClass('small') # HACK
    size = 300 if $this.hasClass('large') # HACK
    $this.data('width', size)
    $this.data('height', size)
    $('.gridly').gridly 'layout'

  $(document).on "click", ".gridly .delete", (event) ->
    event.preventDefault()
    event.stopPropagation()
    $this = $(this)

    $this.closest('.brick').remove()
    $('.gridly').gridly 'layout'

  $(document).on "click", ".add", (event) ->
    event.preventDefault()
    event.stopPropagation()
    $('.gridly').append(brick)
    $('.gridly').gridly()

  $('.gridly').gridly()
