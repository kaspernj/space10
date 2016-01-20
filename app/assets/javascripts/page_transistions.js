$(document).on('ready page:fetch', function () {
  // if ($('#svg_logo').is(':visible')) {
  //   $('#svg_logo').hide();
  //   $('#gif_logo').show();
  // }
  var src = $('#gif_logo').attr('src');
  $('#gif_logo').attr('src', src);
  $('#page_content').removeClass('animated fadeIn')
  $('#page_content').addClass('animated fadeOut')
});
$(document).on('ready page:change', function () {
  // if ($('#gif_logo').is(':visible')) {
  //   $('#gif_logo').hide();
  //   $('#svg_logo').show();
  // }
  $('#page_content').removeClass('animated fadeOut')
  $('#page_content').addClass('animated fadeIn')
});