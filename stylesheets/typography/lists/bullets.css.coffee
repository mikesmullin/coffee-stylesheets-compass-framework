# Turn off the bullet for an element of a list
no_bullet = ->
  list_style_image  'none'
  list_style_type   'none'
  margin_left       0

# turns off the bullets for an entire list
no_bullets = ->
  list_style 'none'
  li ->
    no_bullet()

# Make a list(ul/ol) have an image bullet.
#
# The mixin should be used like this for an icon that is 5x7:
#
#     ul.pretty
#       pretty_bullets "my-icon.png", '5px', '7px'
#
# Additionally, if the image dimensions are not provided,
# The image dimensions will be extracted from the image itself.
#
#     ul.pretty
#       pretty_bullets "my-icon.png"
#
pretty_bullets = (_bullet_icon, _width=image_width(bullet_icon), height=image_height(bullet_icon), line_height='18px', _padding='14px') ->
  margin_left 0
  li ->
    padding_left _padding
    background "#{image_url _bullet_icon} no-repeat #{__div(__sub(_padding, _width), 2)} #{__div(__sub(_line_height, _height), 2)}"
    list_style_type 'none'
