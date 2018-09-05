
{Style} = require "react-validators"

parseOptions = require "parseOptions"
ReactType = require "modx/lib/Type"
ImageView = require "modx/lib/ImageView"
Toggle = require "Toggle"
Shape = require "Shape"

IconSize = Shape {width: Number, height: Number}

type = ReactType "IconToggle"

type.defineArgs ->
  required: yes
  types:
    size: IconSize
    icons: Array

type.defineValues (options) ->

  _size: options.size

  _toggle: Toggle do ->
    parseOptions Toggle, options,
      assign: {modes: options.icons}

type.defineAnimatedValues ->

  _icon: @_toggle.mode

type.defineBoundMethods

  _onToggle: (icon, index) ->
    @_icon.set icon
    @props.onToggle? index

type.definePrototype

  value:
    get: -> @_toggle.value
    set: (newValue) ->
      @_toggle.value = newValue

  icon:
    get: -> @_icon.get()
    set: (newValue) ->
      @_icon.set newValue

type.defineMethods

  toggle: ->
    @_toggle.toggle()

  resetIcon: ->
    @_icon.set @_toggle.mode

#
# Rendering
#

type.defineProps
  style: Style
  onToggle: Function

type.render ->
  @_toggle.render
    style: @props.style
    children: @_renderIcon()
    onToggle: @_onToggle

type.defineMethods

  _renderIcon: ->
    return ImageView
      style: @_size
      source: @_icon

module.exports = type.build()
