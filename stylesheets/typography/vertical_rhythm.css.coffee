#= require ../layout/grid-background.css.coffee

# The base font size.
base_font_size = '16px'

# The base line height determines the basic unit of vertical rhythm.
base_line_height = '24px'

# Set the default border style for rhythm borders.
default_rhythm_border_style = 'solid'

# The default font size in all browsers.
browser_default_font_size = '16px'

# Set to false if you want to use absolute pixels in sizing your typography.
relative_font_sizing = 'true'

# Allows the `adjust_font_size_to` mixin and the `lines_for_font_size` function
# to round the line height to the nearest half line height instead of the
# nearest integral line height to avoid large spacing between lines.
round_to_nearest_half_line = false

# Ensure there is at least this many pixels
# of vertical padding above and below the text.
min_line_padding = '2px'

# base_font_size but in your output unit of choice.
# Defaults to 1em when `$relative_font_sizing` is true.
font_unit = if relative_font_sizing then '1em' else base_font_size

# The basic unit of font rhythm.
base_rhythm_unit = __mul(__div(base_line_height, base_font_size), font_unit)

# The leader is the amount of whitespace in a line.
# It might be useful in your calculations.
base_leader = __div(__mul(__sub(base_line_height, base_font_size), font_unit), base_font_size)

# The half-leader is the amount of whitespace above and below a line.
# It might be useful in your calculations.
base_half_leader = __div(base_leader, 2)

# True if a number has a relative unit.
relative_unit = (number) ->
  return unit(number) == "%" or unit(number) == "em" or unit(number) == "rem"

# True if a number has an absolute unit.
absolute_unit = (number) ->
  return not (relative_unit(number) or unitless(number))

if relative_font_sizing and not relative_unit(font_unit)
  warn "relative_font_sizing is true but font_unit is set to #{font_unit} which is not a relative unit."

# Establishes a font baseline for the given font_size.
establish_baseline = (_font_size = base_font_size) ->
  # IE 6 refuses to resize fonts set in pixels and it weirdly resizes fonts
  # whose root is set in ems. So we set the root font size in percentages of
  # the default font size.
  s '* html', ->
    font_size __mul('100%', __div(_font_size, browser_default_font_size))

  html ->
    font_size _font_size
    adjust_leading_to 1, if relative_font_sizing then _font_size else base_font_size

# Resets the line_height to 1 vertical rhythm unit.
# Does not work on elements whose font_size is different from $base_font_size.
#
# @deprecated This mixin will be removed in the next release.
# Please use the `adjust_leading_to` mixin instead.
reset_baseline = ->
  adjust_leading_to 1, if relative_font_sizing then base_font_size else base_font_size

# Show a background image that can be used to debug your alignments.
# Include the $img argument if you would rather use your own image than the
# Compass default gradient image.
debug_vertical_alignment = (img = false) ->
  if img
    background image_url img
  else
    baseline_grid_background base_rhythm_unit

# Adjust a block to have a different font size and line height to maintain the
# rhythm. $lines specifies how many multiples of the baseline rhythm each line
# of this font should use up. It does not have to be an integer, but it
# defaults to the smallest integer that is large enough to fit the font.
# Use $from_size to adjust from a font_size other than the base font_size.
adjust_font_size_to = (to_size, lines = lines_for_font_size(to_size), from_size = base_font_size) ->
  if not relative_font_sizing and from_size isnt base_font_size
    warn "relative_font_sizing is false but a relative font size was passed to adjust_font_size_to"

  font_size __div(__mul(font_unit, to_size), from_size)
  adjust_leading_to lines, if relative_font_sizing then to_size else base_font_size

# Adjust a block to have different line height to maintain the rhythm.
# $lines specifies how many multiples of the baseline rhythm each line of this
# font should use up. It does not have to be an integer, but it defaults to the
# smallest integer that is large enough to fit the font.
adjust_leading_to = (lines, _font_size = base_font_size) ->
  a = rhythm lines, _font_size
  line_height a

# Calculate rhythm units.
rhythm = (
  lines = 1,
  _font_size = base_font_size,
  offset = 0
) ->
  if not relative_font_sizing and _font_size != base_font_size
    warn "relative_font_sizing is false but a relative font size was passed to the rhythm function"

  _rhythm = __div(__mul(font_unit, __sub(__mul(lines, base_line_height), offset)), _font_size)
  # Round the pixels down to nearest integer.
  if unit(_rhythm) is 'px'
    _rhythm = __floor(_rhythm)

  return _rhythm

# Calculate the minimum multiple of rhythm units needed to contain the font_size.
lines_for_font_size = (_font_size) ->
  lines = if round_to_nearest_half_line
      __ceil(__div(__mul(_font_size, 2), base_line_height)) / 2
    else
      __ceil(__div(_font_size, base_line_height))
  if __sub(__mul(base_line_height, lines), _font_size) < min_line_padding * 2
    lines = lines + if round_to_nearest_half_line then 0.5 else 1
  return lines

# Apply leading whitespace. The $property can be margin or padding.
leader = (lines = 1, _font_size = base_font_size, property = 'margin') ->
  prop property+'-top', rhythm(lines, _font_size)

# Apply leading whitespace as padding.
padding_leader = (lines = 1, _font_size = base_font_size) ->
  padding_top rhythm(lines, _font_size)

# Apply leading whitespace as margin.
margin_leader = (lines = 1, _font_size = base_font_size) ->
  margin_top rhythm(lines, _font_size)

# Apply trailing whitespace. The $property can be margin or padding.
trailer = (lines = 1, _font_size = base_font_size, property = 'margin') ->
  prop property+'-bottom', rhythm(lines, _font_size)

# Apply trailing whitespace as padding.
padding_trailer = (lines = 1, _font_size = base_font_size) ->
  padding_bottom rhythm(lines, _font_size)

# Apply trailing whitespace as margin.
margin_trailer = (lines = 1, _font_size = base_font_size) ->
  margin_bottom rhythm(lines, _font_size)

# Shorthand mixin to apply whitespace for top and bottom margins and padding.
# NOTE: was called "rhythm" but since functions and mixins are the same in this context, it needed a new name
rhythm_mixin = (_leader = 0, padding_leader = 0, padding_trailer = 0, trailer = 0, _font_size = base_font_size) ->
  leader(_leader, _font_size)
  padding_leader(padding_leader, _font_size)
  padding_trailer(padding_trailer, _font_size)
  trailer(trailer, _font_size)

# Apply a border and whitespace to any side without destroying the vertical
# rhythm. The whitespace must be greater than the width of the border.
apply_side_rhythm_border = (side, _width = '1px', lines = 1, _font_size = base_font_size, _border_style = default_rhythm_border_style) ->
  if not relative_font_sizing and _font_size isnt base_font_size
    warn "$relative_font_sizing is false but a relative font size was passed to apply_side_rhythm_border"

  prop "border-#{side}-style", _border_style
  prop "border-#{side}-width", __div(__mul(font_unit, _width), _font_size)

  prop "padding-#{side}", rhythm(lines, _font_size, offset = _width)

# Apply borders and whitespace equally to all sides.
rhythm_borders = (_width = '1px', lines = 1, _font_size = base_font_size, _border_style = default_rhythm_border_style) ->
  if not relative_font_sizing and _font_size isnt base_font_size
    warn "$relative_font_sizing is false but a relative font size was passed to rhythm_borders"

  prop 'border-style', _border_style
  prop 'border-width', __div(__mul(font_unit, _width), _font_size)
  padding rhythm(lines, _font_size, offset = _width)

# Apply a leading border.
leading_border = (_width = '1px', lines = 1, _font_size = base_font_size, _border_style = default_rhythm_border_style) ->
  apply_side_rhythm_border('top', _width, lines, _font_size, _border_style)

# Apply a trailing border.
trailing_border = (_width = '1px', lines = 1, _font_size = base_font_size, _border_style = default_rhythm_border_style) ->
  apply_side_rhythm_border('bottom', _width, lines, _font_size, _border_style)

# Apply both leading and trailing borders.
horizontal_borders = (_width = '1px', lines = 1, _font_size = base_font_size, _border_style = default_rhythm_border_style) ->
  leading_border(_width, lines, _font_size, _border_style)
  trailing_border(_width, lines, _font_size, _border_style)

# Alias for `horizontal_borders` mixin.
h_borders = (_width = '1px', lines = 1, _font_size = base_font_size, _border_style = default_rhythm_border_style) ->
  horizontal_borders(_width, lines, _font_size, _border_style)
