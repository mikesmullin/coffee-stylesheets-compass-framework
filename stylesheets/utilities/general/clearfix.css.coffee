# @doc off
# Extends the bottom of the element to enclose any floats it contains.
# @doc on

#  require hacks.css.coffee

# This basic method is preferred for the usual case, when positioned
# content will not show outside the bounds of the container.
#
# Recommendations include using this in conjunction with a width.
# Credit: [quirksmode.org](http://www.quirksmode.org/blog/archives/2005/03/clearing_floats.html)
clearfix = ->
  overflow 'hidden'
  has_layout()

# This older method from Position Is Everything called
# [Easy Clearing](http://www.positioniseverything.net/easyclearing.html)
# has the advantage of allowing positioned elements to hang
# outside the bounds of the container at the expense of more tricky CSS.
legacy_pie_clearfix = ->
  s '&:after', ->
    content    "\u0010"
    display    'block'
    height     0
    clear      'both'
    overflow   'hidden'
    visibility 'hidden'
  has_layout()

# This is an updated version of the PIE clearfix method that reduces the amount of CSS output.
# If you need to support Firefox before 3.5 you need to use `legacy-pie-clearfix` instead.
#
# Adapted from: [A new micro clearfix hack](http://nicolasgallagher.com/micro-clearfix-hack/)
pie_clearfix = ->
  s '&:after', ->
    content '""'
    display 'table'
    clear 'both'
  has_layout()
