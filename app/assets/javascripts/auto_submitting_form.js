$(document).on('ready page:load', function () {
  $('form.auto_submit').on('change', function(){
    $(this).submit();
  });
});