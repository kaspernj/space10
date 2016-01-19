// $(document).on('ready page:change', function () {
//   if ($('#gif_logo').is(':visible')) {
//     $('#gif_logo').hide();
//     $('#svg_logo').show();
//   }
// });
// $(document).on('ready page:fetch', function () {
//   if ($('#svg_logo').is(':visible')) {
//     $('#svg_logo').hide();
//     $('#gif_logo').show();
//   }
// });
$(document).on('ready page:change', function () {
  $('body').removeClass('animated fadeOut')
  $('body').addClass('animated fadeIn')
});
$(document).on('ready page:fetch', function () {
  $('body').removeClass('animated fadeIn')
  $('body').addClass('animated fadeOut')
});