import './index.sass';

$(document).on("click", 'a.close_flash', function() {
  $(this).parent().fadeOut(function() {
    let $box = $(this).parents('.flash');
    $(this).remove();
    if ($box.children().length == 0) {
      $box.remove();
    }
  })
});

