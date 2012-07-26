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

