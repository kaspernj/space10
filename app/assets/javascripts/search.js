$(document).on('ready page:load', function () {
  init_search();
});

init_search = function() {
  $('#search_query').keyup(function () {
    if (this.value.length > 2) {
      $(this).closest('form').submit();
    };
  });
  $('#search_form input[type=radio]').on( 'change', function() {
    $(this).closest('form').submit();
  });
}