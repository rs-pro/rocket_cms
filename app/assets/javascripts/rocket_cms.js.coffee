$(document).on('click.close_flash', 'a.close_flash', ->
  $(this).parents('.message').fadeOut()
)
