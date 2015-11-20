$(document).on('ready page:change', function () {
  $('body').removeClass('animated fadeOut')
  $('body').addClass('animated fadeIn')
});
$(document).on('ready page:fetch', function () {
  $('body').removeClass('animated fadeIn')
  $('body').addClass('animated fadeOut')
});