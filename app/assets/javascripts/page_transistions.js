$(document).on('ready page:fetch', function () {
  // if ($('#svg_logo').is(':visible')) {
  //   $('#svg_logo').hide();
  //   $('#gif_logo').show();
  // }
  var src = $('#gif_logo').attr('src');
  $('#gif_logo').attr('src', src);
  var src = $('#shrink_logo').attr('src');
  $('#shrink_logo').attr('src', src);
  var src = $('#mobile_logo').attr('src');
  $('#mobile_logo').attr('src', src);
  
  $('#page_content').removeClass('animated fadeIn')
  $('#page_content').addClass('animated fadeOut')

  if ($('.navbar-fixed-bottom').is(':visible')) {  
    $('#modal-navigate').removeClass('animated fadeIn')
    $('#modal-navigate').addClass('animated fadeOut')
    $('.navbar-fixed-bottom').removeClass('animated fadeIn')
    $('.navbar-fixed-bottom').addClass('animated fadeOut')
  }
});
$(document).on('ready page:change', function () {
  // if ($('#gif_logo').is(':visible')) {
  //   $('#gif_logo').hide();
  //   $('#svg_logo').show();
  // }
  $('#page_content').removeClass('animated fadeOut')
  $('#page_content').addClass('animated fadeIn')

  if ($('.navbar-fixed-bottom').is(':visible')) {  
    $('#modal-navigate').removeClass('animated fadeOut')
    $('#modal-navigate').addClass('animated fadeIn')
    $('.navbar-fixed-bottom').removeClass('animated fadeOut')
    $('.navbar-fixed-bottom').addClass('animated fadeIn')
  }
});