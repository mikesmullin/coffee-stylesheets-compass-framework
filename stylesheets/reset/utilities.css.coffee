# Based on [Eric Meyer's reset 2.0](http://meyerweb.com/eric/tools/css/reset/index.html)
# Global reset rules.
# For more specific resets, use the reset mixins provided below
global_reset = ->
  s '''html, body, div, span, applet, object, iframe,
  h1, h2, h3, h4, h5, h6, p, blockquote, pre,
  a, abbr, acronym, address, big, cite, code,
  del, dfn, em, img, ins, kbd, q, s, samp,
  small, strike, strong, sub, sup, tt, var,
  b, u, i, center,
  dl, dt, dd, ol, ul, li,
  fieldset, form, label, legend,
  table, caption, tbody, tfoot, thead, tr, th, td,
  article, aside, canvas, details, embed,
  figure, figcaption, footer, header, hgroup,
  menu, nav, output, ruby, section, summary,
  time, mark, audio, video''', ->
    reset_box_model()
    reset_font()
  # Unlike Eric's original reset, we reset the html element to be compatible
  # with the vertical rhythm mixins.
  html ->
    reset_body()
  s 'ol, ul', ->
    reset_list_style()
  table ->
    reset_table()
  s 'caption, th, td', ->
    reset_table_cell()
  s 'q, blockquote', ->
    reset_quotation()
  s 'a img', ->
    reset_image_anchor_border()
  reset_html5()

# Reset all elements within some selector scope. To reset the selector itself,
# mixin the appropriate reset mixin for that element type as well. This could be
# useful if you want to style a part of your page in a dramatically different way.
nested_reset = ->
  s '''div, span, applet, object, iframe,
  h1, h2, h3, h4, h5, h6, p, blockquote, pre,
  a, abbr, acronym, address, big, cite, code,
  del, dfn, em, img, ins, kbd, q, s, samp,
  small, strike, strong, sub, sup, tt, var,
  b, u, i, center,
  dl, dt, dd, ol, ul, li,
  fieldset, form, label, legend,
  table, caption, tbody, tfoot, thead, tr, th, td,
  article, aside, canvas, details, embed,
  figure, figcaption, footer, header, hgroup,
  menu, nav, output, ruby, section, summary,
  time, mark, audio, video''', ->
    reset_box_model()
    reset_font()
  s 'table', ->
    reset_table()
  s 'caption, th, td', ->
    reset_table_cell()
  s 'q, blockquote', ->
    reset_quotation()
  s 'a img', ->
    reset_image_anchor_border()

# Reset the box model measurements.
reset_box_model = ->
  margin 0
  padding 0
  border 0

# Reset the font and vertical alignment.
reset_font = ->
  font 'inherit'
  font_size '100%'
  vertical_align 'baseline'

# Resets the outline when focus.
# For accessibility you need to apply some styling in its place.
reset_focus = ->
  outline 0

# Reset a body element.
reset_body = ->
  line_height 1

# Reset the list style of an element.
reset_list_style = ->
  list_style 'none'

# Reset a table
reset_table = ->
  border_collapse 'collapse'
  border_spacing 0

# Reset a table cell (`th`, `td`)
reset_table_cell = ->
  text_align 'left'
  font_weight 'normal'
  vertical_align 'middle'

# Reset a quotation (`q`, `blockquote`)
reset_quotation = ->
  quotes 'none'
  s '&:before, &:after', ->
    content '""'
    content 'none'

# Resets the border.
reset_image_anchor_border = ->
  border 'none'

# Unrecognized elements are displayed inline.
# This reset provides a basic reset for block html5 elements
# so they are rendered correctly in browsers that don't recognize them
# and reset in browsers that have default styles for them.
reset_html5 = ->
  s elements_of_type('html5-block'), ->
    display 'block'

# Resets the display of inline and block elements to their default display
# according to their tag type. Elements that have a default display that varies across
# versions of html or browser are not handled here, but this covers the 90% use case.
# Usage Example:
#
#     # Turn off the display for both of these classes
#     .unregistered-only, .registered-only
#       display 'none'
#     # Now turn only one of them back on depending on some other context.
#     body.registered
#       reset_display '.registered-only'
#     body.unregistered
#       reset_display '.unregistered-only'
reset_display = (selector='', important='false') ->
  s elements_of_type('inline')+' '+selector, ->
    if important isnt 'false'
      display 'inline !important'
    else
      display 'inline'
  s elements_of_type('block')+' '+selector, ->
    if important isnt 'false'
      display 'block !important'
    else
      display 'block'
