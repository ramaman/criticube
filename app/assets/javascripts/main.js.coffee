$ ->
# Cleans dirty hash

  if (window.location.hash == "#_=_")
    window.location.hash = "";

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
  # Expanding form area
  $('.expanding-form-area input[type=text]').live 'focus', (event) ->
    $(this).closest('.expanding-form-area').find('.hidden-panel').removeClass('hidden-panel')
    
$ ->
  # Main search

  $("#main_search").smartAutoComplete
    filter: (term) ->
      $.getJSON("/search.json?utf8=✓&q=" + term ).success (data) ->
        data  

    resultsContainer: "ul.items#main-search-results "
    
    resultFormatter: (r) ->
      "<li class='hit item'><a href='" + r.path + "'>" + r.name.replace(new RegExp($(this.context).val(),"gi"), "<strong>$&</strong>") + " <span class='minor'> - " + r.extra + "</span> </li></a>"

    maxResults: 12

    minCharLimit: 0
    
    delay: 200

    typeAhead: false

  $("#main_search").live
    #focusin: ->
    #  $('.topbar-search-ext').slideDown()

    keyIn: ->
      $(this).smartAutoComplete().clearResults()
      if $('input[type=text]#main_search').val().length > 0
        $('.topbar-search-ext').show()
      else
        $('.topbar-search-ext').hide()      
      $("ul#main-search-results").append "<li class = 'hit item'>Searching..</li>"

    noResults: (ev) ->
      ev.preventDefault()
      $('.topbar-search-ext').show()
      $("ul#main-search-results").append "<li class = 'hit item'> No results found</li>"

    showResults: (ev) ->
      ev.preventDefault()
      $('.topbar-search-ext').show()

      term = $('input[type=text]#main_search').val()
      $('ul#main-search-results').append(
        "<li class='hit item'><a href='/search?utf8=✓&q=" + term + "'>" + 'View all results for : '+ term + "</li>"
        )

      items = $('ul#main-search-results li')
      items.first().addClass "selected"

      if items.length > 0

        # Use arrow keys to navigate search results
        $(window).keydown (e) ->
          i_old = items.filter(".selected")
          i_new = i_old

          switch e.keyCode
            when 38
              i_new = i_old.prev()
            when 40
              i_new = i_old.next()
            #when 13
              #window.location.href = i_old.find('a').attr('href')

          if i_new.is("li")
            i_old.removeClass "selected"
            i_new.addClass "selected"
        
        # Mouse hover will trigger hit item as selected
        items.live 'mouseenter', () ->
          items.filter(".selected").removeClass 'selected'
          $(this).addClass 'selected'

        # Pressing enter will open the selcted hit          
        items.live 'click', () ->
          href = $('ul#main-search-results').find('li.selected a').attr('href')
          if href.length > 0
            window.location.href = href

        # Empty search field will close the results container
      if $('input[type=text]#main_search').val().length == 0
        $('.topbar-search-ext').hide()
           

    itemSelect: (ev) ->
      ev.preventDefault()
      href = $('ul#main-search-results').find('li.selected a').attr('href')
      if href.length > 0
        window.location.href = href

    itemFocus: (ev) ->
      ev.preventDefault()

    itemUnfocus: (ev) ->
      ev.preventDefault()

    lostFocus: (ev) ->
      ev.preventDefault()
      #window.location.href = $('ul#main-search-results').find('li.selected a').attr('href')
      #$('.topbar-search-ext').hide()  

    $('body').live 'click', (ev) ->
      $('.topbar-search-ext').hide()
    $('.topbar-search-ext').live 'click', (ev) ->
      $('.topbar-search-ext').hide()      
      
$ ->
  # Text truncation
  $('.truncate').truncate()          