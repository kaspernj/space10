$(document).on('ready page:load', function () {
  $(".alert").delay(3000).slideUp(200, function() {
    $(this).alert('close');
  });
});