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
    return +1 if d.y > s.y + s.h
    return -1 if s.y > d.y + d.h
    return +1 if (d.x + (d.w / 2)) > (s.x + (s.w / 2))
    return -1 if (s.x + (s.w / 2)) > (d.x + (d.w / 2))
    return 0

  draggable: ->
    @$('> *').draggable
      zIndex: 800
      drag: @drag
      start: @start
      stop: @stop

  swap: (array, from, to) ->
    element = array[from]
    array.splice(from, 1)
    to-- if from < to
    array.splice(to, 0, element)
    return array

  start: (event, ui) =>
    $dragging = $(event.target)
    $elements = @$('> *')
    $dragging.data('sort', 'target')
    for i in [0 .. $elements.length]
      $element = $($elements[i])
      $element.data('position', i)

  stop: (event, ui) =>
    return

  $sorted: ($elements = @$('> *')) =>
    $elements.sort (a,b) ->
      aVal = parseInt($(a).data('position'))
      bVal = parseInt($(b).data('position'))
      return -1 if aVal < bVal
      return +1 if aVal > bVal
      return 0

  drag: (event, ui) =>
    $dragging = $(event.target)
    $elements = @$sorted()
    positions = @structure($elements).positions
    index = $dragging.data('position')
    original = index

    coordinate = 
      x: $dragging.position().left
      y: $dragging.position().top
      w: $dragging.width()
      h: $dragging.height()
    
    for i in [0 ... $elements.length]
      $element = $($elements[i])
      continue if $element.is($dragging)

      position = positions[i]
      if @compare(coordinate, position) < 0
        index = i
        break

    $dragging.data('position', index + 0.5)
    @layout(@$sorted())

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

  layout: ($elements = @$('> *')) =>
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
