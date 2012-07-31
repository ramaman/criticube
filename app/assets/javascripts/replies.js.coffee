$ ->
  # Reply to
  $('a.reply-to').live 'click', (event) ->
    meta = $(this).closest('.meta')
    form = $(this).closest('.reply-to-area').find('form.reply')
    reply_to_tag = form.find('span.reply_to_indicator')
    parent_id_input = form.find('input#reply_parent_id')
    reply_to_tag.html(meta.attr('data-anchor'))
    parent_id_input.val(meta.attr('data-id'))