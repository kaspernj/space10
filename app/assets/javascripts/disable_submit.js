$(document).on('ready page:load', function () {
  $('body').on( 'submit', 'form.disable-after-submit', function (e){
    $(this).find('input[type="submit"]').prop('disabled', true);
  });
});