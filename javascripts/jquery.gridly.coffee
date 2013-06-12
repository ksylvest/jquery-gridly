###
jQuery Gridly
Copyright 2013 Kevin Sylvestre
###

"use strict"

$ = jQuery

class Animation
  @transitions:
    "webkitTransition": "webkitTransitionEnd"
    "mozTransition": "mozTransitionEnd"
    "msTransition": "msTransitionEnd"
    "oTransition": "oTransitionEnd"
    "transition": "transitionend"

  @transition: ($el) ->
    el = $el[0]
    return result for type, result of @transitions when el.style[type]?

  @execute: ($el, callback) ->
    transition = @transition($el)
    if transition? then $el.one(transition, callback) else callback()

class Gridly

  @settings:
    base: 60
    gutter: 20
    columns: 12
    draggable: 'enable'

  @gridly: ($el, options = {}) ->
    new Gridly($el, options)

  constructor: ($el, settings = {}) ->
    @$el = $el
    @settings = $.extend {}, Gridly.settings, settings

  $: (selector) =>
    @$el.find(selector)

  grow: ->
    @grid.push()

  compare: (d, s) ->
    return -1 if d.y > s.y + Math.max(s.h, d.h)
    return +1 if s.y > d.y + Math.max(s.h, d.h)
    return -1 if (d.y + (d.w / 2)) > (s.y + (s.w / 2))
    return +1 if (s.y + (s.w / 2)) > (d.y + (d.w / 2))
    return 0

  draggable: ->
    @$('> *').draggable
      zIndex: 800
      drag: @drag
      stop: @stop

  drag: (event, ui) =>
    $dragging = $(event.target)
    $elements = @$('> *')
    positions = @structure($elements).positions
    index = $elements.index(event.target)

    coordinate = 
      x: $dragging.position().left
      y: $dragging.position().top
      w: $dragging.width()
      h: $dragging.height()
    
    for i in [0 ... $elements.length]
      continue if index is i

      position = positions[i]

      if @compare coordinate, position > 0
        index = i
        break

    console.debug index
    # console.debug($elements[..@_index] + [$elements[@_index]] + $elements[@_index..])
    # $elements = $elements[..@_index] + [$elements[@_index]] + $elements[@_index..]

  stop: (event, ui) =>
    setTimeout @layout, 0 # Animate

  position: ($element, columns) =>
    size = (($element.data('width') || $element.width()) + @settings.gutter) / (@settings.base + @settings.gutter)

    height = Infinity
    column = 0

    for i in [0 ... (columns.length - size)]
      max = Math.max columns[i ... (i + size)]...
      if max < height
        height = max
        column = i

    for i in [column ... column + size]
      columns[i] = height + ($element.data('height') || $element.height()) + @settings.gutter

    x: (column * (@settings.base + @settings.gutter))
    y: height

  structure: ($elements = @$('> *')) =>
    positions = []
    columns = (0 for i in [0 .. @settings.columns])

    $elements.each (index, element) =>
      $element = $(element)

      position = @position($element, columns)
      positions.push
        x: position.x
        y: position.y
        w: $element.width()
        h: $element.height()

    height: Math.max columns...
    positions: positions

  layout: =>
    $elements = @$('> *')
    structure = @structure($elements)

    $elements.each (index, element) =>
      $element = $(element)
      position = structure.positions[index]

      $element.css
        position: 'absolute'
        left: position.x
        top:  position.y

    @$el.css
      height: structure.height

$.fn.extend
  gridly: (option = {}) ->
    @each ->
      $this = $(@)

      options = $.extend {}, $.fn.gridly.defaults, typeof option is "object" and option
      action = if typeof option is "string" then option else option.action
      action ?= "layout"

      Gridly.gridly($this, options)[action]()
