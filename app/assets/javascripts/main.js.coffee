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