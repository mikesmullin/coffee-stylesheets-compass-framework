# The `zoom` approach generates less CSS but does not validate.
# Set this to `block` to use the display-property to hack the
# element to gain layout.
default_has_layout_approach = 'zoom'

# This mixin causes an element matching the selector
# to gain the "hasLayout" property in internet explorer.
# More information on [hasLayout](http://reference.sitepoint.com/css/haslayout).
has_layout = (approach=default_has_layout_approach) ->
  if legacy_support_for_ie?
    if approach is 'zoom'
      has_layout_zoom
    else if approach is 'block'
      has_layout_block
    else
      warn "Unknown has-layout approach: #{approach}"
      has_layout_zoom()

has_layout_zoom = ->
  if legacy_support_for_ie6? or legacy_support_for_ie7?
    prop 'zoom', 1

has_layout_block = ->
  if legacy_support_for_ie?
    # This makes ie6 get layout
    display 'inline-block'
    # and this puts it back to block
    s '&', -> display 'block'

# A hack to supply IE6 (and below) with a different property value.
# [Read more](http://www.cssportal.com/css-hacks/#in_css-important).
bang_hack = (property, value, ie6_value) ->
  if legacy_support_for_ie6
    prop property, "#{value} !important"
    prop property, "#{ie6_value}"
