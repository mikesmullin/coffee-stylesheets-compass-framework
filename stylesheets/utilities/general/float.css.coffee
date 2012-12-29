# Direction independent float mixin that fixes the
# [double-margin bug in IE5/6](http://www.positioniseverything.net/explorer/doubled-margin.html)
float = (side='left') ->
  display 'inline'
  prop 'float', side

# Implementation of float:left with fix for the
# [double-margin bug in IE5/6](http://www.positioniseverything.net/explorer/doubled-margin.html)
float_left = ->
  float 'left'

# Implementation of float:right with fix for the
# [double-margin bug in IE5/6](http://www.positioniseverything.net/explorer/doubled-margin.html)
float_right = ->
  float 'right'

# Resets floated elements back to their default of `float: none` and defaults
# to `display: block` unless you pass `inline` as an argument
#
# Usage Example:
#
#     s 'body.homepage', ->
#       s '#footer li', ->
#         float_left()
#     s 'body.signup', ->
#       s '#footer li', ->
#         reset_float()
reset_float = (_display='block') ->
  float 'none'
  display _display
