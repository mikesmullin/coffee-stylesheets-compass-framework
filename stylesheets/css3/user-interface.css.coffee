# User Interface ------------------------------------------------------------
# This file can be expanded to handle all the user interface properties as
# they become available in browsers:
# http://www.w3.org/TR/2000/WD-css3-userint-20000216

# require shared.css.coffee


# This property controls the selection model and granularity of an element.
#
# @param $select
#   [ none | text | toggle | element | elements | all | inherit ]
user_select = (_select) ->
  experimental 'user-select', _select, '-moz', '-webkit', not '-o', not '-ms', '-khtml', 'official'
