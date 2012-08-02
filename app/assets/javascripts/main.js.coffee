RecaptchaOptions =
  theme : 'clean'

$ -> 
  # Open external links on a new tab

  $("a").each ->
    a = new RegExp("/" + window.location.host + "/")
    unless a.test(@href)
      $(this).live 'click', (event) ->
        event.preventDefault()
        event.stopPropagation()
        window.open @href, "_blank" 
        
  # Open links with class='new-tab' on a new tab

  $("a.new-tab").live 'click', (ev) ->
    ev.preventDefault()
    window.open @href, "_blank"

$ ->
  # Auto-resizing textarea
  $('textarea.autoresize').autoResize(
    extraSpace: 0
  )

$ ->
  $("textarea.steroid").tinymce
    theme : 'advanced'
    plugins : "autoresize"
    height : '20'
    theme_advanced_toolbar_location : "top"
    theme_advanced_toolbar_align : "left"
    theme_advanced_buttons1 : 'bold, italic, underline, strikethrough, separator, bullist, numlist, blockquote, separator, link, unlink'
    theme_advanced_buttons2 : ''
    theme_advanced_buttons3 : ''
    # force_br_newlines : false
    # force_p_newlines : true
    remove_linebreaks : true
    theme_advanced_path : false
    theme_advanced_font_sizes: "13px"
    content_css : "/assets/application.css"  
    handle_event_callback: () ->
      chars = tinyMCE.activeEditor.getContent().length
      excess = -3500 + chars
      if excess > 0
        $('#bouncer').html('<p><b>' + excess + ' character(s) too long (including formatting) </b></p>')
      else
        $('#bouncer').html('')

$ -> 
  # Show/hide by click (click-magic), click => show cm-b

  $('a.click-magic-show').live 'click', (event) ->
    event.preventDefault()
    switch_tag = $(this).attr('data-cm-tag')
    $('.click-magic-front[data-cm-tag='+ switch_tag + ']').hide()
    $('.click-magic-back[data-cm-tag='+ switch_tag + ']').show()

  $('a.click-magic-hide').live 'click', (event) ->
    event.preventDefault()
    switch_tag = $(this).attr('data-cm-tag')
    $('.click-magic-front[data-cm-tag='+ switch_tag + ']').show()    
    $('.click-magic-back[data-cm-tag='+ switch_tag + ']').hide()

  $('a.click-magic-showall').live 'click', (event) ->
    event.preventDefault()
    switch_tag = $(this).attr('data-cm-tag')
    $('.click-magic-front[data-cm-tag='+ switch_tag + ']').show()
    $(this).hide()    
    
$ -> 
  # Show/hide by click (click-magic), click => show cm-b
  # CMF = CLICK MAGIC FAST 

  $('a.cmf-toggle').live 'click', (event) ->
    event.preventDefault()
    switch_tag = $(this).attr('data-cmf-tag')
    $('.cmf-area[data-cmf-tag='+ switch_tag + ']').toggle()
  
  $('a.cmf-show').live 'click', (event) ->
    event.preventDefault()
    switch_tag = $(this).attr('data-cmf-tag')
    $('.cmf-area[data-cmf-tag='+ switch_tag + ']').show()

  $('a.cmf-hide').live 'click', (event) ->
    event.preventDefault()
    switch_tag = $(this).attr('data-cmf-tag')
    $('.cmf-area[data-cmf-tag='+ switch_tag + ']').hide()

$ ->
  # Show and teleport
  
  $('a.sat-switch').live 'click', (event) ->
    switch_tag = $(this).attr('data-sat-tag')
    # new_position = $(this).attr('href')
    $('.sat-area[data-sat-tag='+ switch_tag + ']').show()
    
$ ->
  $('.expanding-form-area input[type=text]').live 'focus', (event) ->
    $(this).closest('.expanding-form-area').find('.hidden-panel').show()