# Based on a [blog post by Ryan Fait](http://ryanfait.com/resources/footer_stick_to_bottom_of_page/).
#
# Must be mixed into the top level of your stylesheet.
#
# Footer element must be outside of root wrapper element.
#
# Footer must be a fixed height.

sticky_footer = (footer_height, root_selector="#root", root_footer_selector="#root_footer", footer_selector="#footer") ->
  s 'html, body', ->
    height '100%'
  s root_selector, ->
    clear 'both'
    min_height '100%'
    height 'auto !important'
    height '100%'
    margin_bottom __mul(footer_height, -1)
    s root_footer_selector, ->
      height footer_height
  s footer_selector, ->
    clear 'both'
    position 'relative'
    height footer_height
