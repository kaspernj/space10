$(document).on('ready page:load', function () {
  $('body').on( 'change', 'form.auto_submit', function (e){
    $(this).submit();
  });
});