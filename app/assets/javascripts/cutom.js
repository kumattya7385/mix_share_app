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

  $('#countdown').on('input',function(){
    var remain = 255 - $(this).val().length;

    $('#countdown-number').text("残り"+remain+"文字");
    if (remain < 0) {
        $('#countdown-number').css('color', 'red');
    } else {
        $('##countdown-number').css('color', 'grey');
    }
});
});