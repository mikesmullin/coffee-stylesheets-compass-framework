DEFAULT_DISPLAY =
  'block':  'address article aside blockquote center dir div dd details dl dt fieldset '+
            'figcaption figure form footer frameset h1 h2 h3 h4 h5 h6 hr header hgroup '+
            'isindex menu nav noframes noscript ol p pre section summary ul'
  'inline': 'a abbr acronym audio b basefont bdo big br canvas cite code command '+
            'datalist dfn em embed font i img input keygen kbd label mark meter output '+
            'progress q rp rt ruby s samp select small span strike strong sub '+
            'sup textarea time tt u var video wbr'
  'inline-block': 'img'
  'table': 'table'
  'list-item': 'li'
  'table-row-group': 'tbody'
  'table-header-group': 'thead'
  'table-footer-group': 'tfoot'
  'table-row': 'tr'
  'table-cell': 'th td'
  'html5-block': 'article aside details figcaption figure footer header hgroup menu nav section summary'
  'html5-inline': 'audio canvas command datalist embed keygen mark meter output progress rp rt ruby time video wbr'

DEFAULT_DISPLAY['html5'] = (DEFAULT_DISPLAY['html5-block']+' '+DEFAULT_DISPLAY['html5-inline'])

# returns a comma delimited string for all the
# elements according to their default css3 display value.
elements_of_type = (display) ->
  DEFAULT_DISPLAY[display].split(' ').join(', ')
