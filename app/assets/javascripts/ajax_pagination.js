$(document).on('ready page:load', function () {
  init_ajax_pagination = function() {
    $(".ajax_pagination .pagination a").attr('data-remote', 'true');
  };
  init_ajax_pagination();
});