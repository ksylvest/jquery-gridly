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

  @gridly: ($el, options = {}) ->
    new Gridly($el, options)

  constructor: ($el, settings = {}) ->
    @$el = $el
    @settings = $.extend {}, Gridly.settings, settings

  $: (selector) =>
    @$el.find(selector)

  grow: ->
    @grid.push()

  layout: =>
    @$el.offset() # Reflow
    columns = (0 for i in [0 .. @settings.columns])

    @$('> *').each (index, element) =>
      $element = $(element)
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

      $element.css
        position: 'absolute'
        left: (column * (@settings.base + @settings.gutter))
        top: height

    @$el.css
      height: Math.max columns...

$.fn.extend
  gridly: (option = {}) ->
    @each ->
      $this = $(@)

      options = $.extend {}, $.fn.gridly.defaults, typeof option is "object" and option
      action = if typeof option is "string" then option else option.action
      action ?= "layout"

      Gridly.gridly($this, options)[action]()
