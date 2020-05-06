$(document).on('turbolinks:load', function() {
  $('button#account-btn').on('click', () => {
    $("ul.drop-menu").slideToggle(220);
  });

  $(document).on('click', function(e) {
    if(!$(e.target).is("button#account-btn")) {
      $("ul.drop-menu").slideUp(220);
    }
  });

  $('.tab').on('click',function(){
    $('.is-active').removeClass('is-active');
    $(this).addClass('is-active');
    $('.is-show').removeClass('is-show');
    const index = $(this).index();
    $('.ranking-group').eq(index).addClass('is-show');
    $('.midashi').eq(index).addClass('is-show');
  });
});