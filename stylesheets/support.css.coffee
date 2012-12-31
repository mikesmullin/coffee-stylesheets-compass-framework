# Usually compass hacks apply to both ie6 & 7 -- set this to false to disable support for both.
_legacy_support_for_ie = true

# Setting this to false will result in smaller output, but no support for ie6 hacks
_legacy_support_for_ie6 = _legacy_support_for_ie

# Setting this to false will result in smaller output, but no support for ie7 hacks
_legacy_support_for_ie7 = _legacy_support_for_ie

# Setting this to false will result in smaller output, but no support for legacy ie8 hacks
_legacy_support_for_ie8 = _legacy_support_for_ie

# @private
# The user can simply set _legacy_support_for_ie and 6, 7, and 8 will be set accordingly,
# But in case the user set each of those explicitly, we need to sync the value of
# this combined variable.
_legacy_support_for_ie = _legacy_support_for_ie6 or _legacy_support_for_ie7 or _legacy_support_for_ie8

# Whether to output legacy support for mozilla.
# Usually this means hacks to support Firefox 3.6 or earlier.
_legacy_support_for_mozilla = true

# Support for mozilla in experimental css3 properties (-moz).
_experimental_support_for_mozilla       = true
# Support for webkit in experimental css3 properties (-webkit).
_experimental_support_for_webkit        = true
# Support for webkit's original (non-standard) gradient syntax.
_support_for_original_webkit_gradients  = true
# Support for opera in experimental css3 properties (-o).
_experimental_support_for_opera         = true
# Support for microsoft in experimental css3 properties (-ms).
_experimental_support_for_microsoft     = true
# Support for khtml in experimental css3 properties (-khtml).
_experimental_support_for_khtml         = false
# Support for svg in experimental css3 properties.
# Setting this to true might add significant size to your
# generated stylesheets.
_experimental_support_for_svg           = false
# Support for CSS PIE in experimental css3 properties (-pie).
_experimental_support_for_pie           = false
