color_stops = ->
  _color_stops = Array::slice.apply arguments
  # the original auto-calculates position but i find that unnecessary and misleading
  # see also: http://compass-style.org/reference/compass/helpers/color-stops/

linear_gradient = ->
  "linear-gradient(#{color_stops.apply(null, arguments).join(', ')})"

radial_gradient = ->
  "radial-gradient(#{color_stops.apply(null, arguments).join(', ')})"

prefixed = ->
  return true # for now
  # original goes on to check for a custom .supports() method extended onto each arg value. kind of lame
  #a = Array::slice.apply arguments
  #prefix = a[0]
  #args = a.slice 1
  #aspect = prefix.replace /^-/, ''
  #return needed = args.

background_image = ->
  # TODO: "original webkit" case makes this function a pain in the ass to translate
  #       since i don't use that, won't include it here
  _images = arguments
  _add_pie_bg = _images.length > 1 # or prefixed(-pie, _images)

  if _images.length > 1 or
    _images[0].indexOf('linear-gradient(') isnt -1 or
    _images[0].indexOf('radial-gradient(') isnt -1
      for k, _image of _images
        if _experimental_support_for_svg # and prefixed(-svg, _images)
          prop 'background-image', '-svg-'+_image
          background_size '100%'
        if _support_for_original_webkit_gradients # and prefixed(-owg, _images)
          prop 'background-image', '-owg-'+_image
        if _experimental_support_for_webkit # and prefixed(-webkit, _images)
          prop 'background-image', '-webkit-'+_image
        if _experimental_support_for_mozilla # and prefixed(-moz, _images)
          prop 'background-image', '-moz-'+_image
        if _experimental_support_for_opera # and prefixed(-o, _images)
          prop 'background-image', '-o-'+_image
        if _experimental_support_for_pie and _add_pie_bg
          warn 'PIE does not support background_image. Use background() instead.'
        prop 'background-image', _image
  else
    prop 'background-image', _images[0]
