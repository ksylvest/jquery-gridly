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

  compare: ($dragging, $static) ->
    return 'equal' if $draggging is $static
    position = $element.position()
    x = $element.position().left + $element.width() / 2
    y = $element.position().top + $element.height() / 2

  draggable: () ->
    @$('> *').draggable
      zIndex: 800
      drag: @drag
      stop: @stop

  drag: (event, ui) =>
    $element = $(event.target)
    position = $element.position()
    x = $element.position().left + $element.width() / 2
    y = $element.position().top + $element.height() / 2
    @structure(@$('> *'))

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
        $element: $element
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
