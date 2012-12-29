# makes a list inline.

inline_list = ->
  list_style_type 'none'
  s '&, & li', ->
    margin 0
    padding 0
    display 'inline'

# makes an inline list delimited with the passed string.
# Defaults to making a comma-separated list.
#
# Please make note of the browser support issues before using this mixin:
#
# use of `content` and `:after` is not fully supported in all browsers.
# See quirksmode for the [support matrix](http://www.quirksmode.org/css/contents.html#t15)
#
# `:last-child` is not fully supported.
# see quirksmode for the [support matrix](http://www.quirksmode.org/css/contents.html#t29).
#
# IE8 ignores rules that are included on the same line as :last-child
# see http://www.richardscarrott.co.uk/posts/view/ie8-last-child-bug for details

delimited_list = (separator=', ') ->
  inline_list()
  li ->
    s '&:after', -> content '"'+separator+'"'
    s '&:last-child', ->
      s '&:after', -> content '""'
    s '&.last', ->
      s '&:after', -> content '""'

# See [delimited-list](#mixin-delimited-list)
# @deprecated
comma_delimited_list = ->
  warn "comma-delimited-list is deprecated. Please use delimited-list instead."
  delimited_list()
