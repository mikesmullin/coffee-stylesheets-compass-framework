# require ../compass/support.css.coffee

# This mixin provides basic support for CSS3 properties and
# their corresponding experimental CSS2 properties when
# the implementations are identical except for the property
# prefix.
experimental = (_property, _value, _moz=_experimental_support_for_mozilla, _webkit=_experimental_support_for_webkit, _o=_experimental_support_for_opera, _ms=_experimental_support_for_microsoft, _khtml=_experimental_support_for_khtml, _official=true) ->
  if _webkit and _experimental_support_for_webkit
    prop "-webkit-#{_property}", _value
  if _khtml and _experimental_support_for_khtml
    prop "-khtml-#{_property}", _value
  if _moz and _experimental_support_for_mozilla
    prop "-moz-#{_property}", _value
  if _ms and _experimental_support_for_microsoft
    prop "-ms-#{_property}", _value
  if _o and _experimental_support_for_opera
    prop "-o-#{_property}", _value
  if _official
    prop _property, _value

# Same as experimental(), but for cases when the property is the same and the value is vendorized
#@mixin experimental-value($property, $value,
#  $moz      : $experimental-support-for-mozilla,
#  $webkit   : $experimental-support-for-webkit,
#  $o        : $experimental-support-for-opera,
#  $ms       : $experimental-support-for-microsoft,
#  $khtml    : $experimental-support-for-khtml,
#  $official : true
#) {
#  @if $webkit  and $experimental-support-for-webkit    { #{$property} : -webkit-#{$value}; }
#  @if $khtml   and $experimental-support-for-khtml     { #{$property} :  -khtml-#{$value}; }
#  @if $moz     and $experimental-support-for-mozilla   { #{$property} :    -moz-#{$value}; }
#  @if $ms      and $experimental-support-for-microsoft { #{$property} :     -ms-#{$value}; }
#  @if $o       and $experimental-support-for-opera     { #{$property} :      -o-#{$value}; }
#  @if $official                                        { #{$property} :         #{$value}; }
#}
