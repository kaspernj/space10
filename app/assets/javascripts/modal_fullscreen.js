$(document).on('ready page:load', function () {
  $("a[data-toggle='modal']").on('click', function(){
    $(this).addClass('modal-toggle-pressed');
  });
  $(".modal-fullscreen").on('show.bs.modal', function () {
    var color = $(this).data('backdrop-color') || 'white'
    setTimeout( function() {
      $(".modal-backdrop").addClass("modal-backdrop-fullscreen modal-backdrop-" + color);
    }, 0);
  });
  $(".modal-fullscreen").on('hide.bs.modal', function () {
    $("a[data-toggle='modal']").removeClass('modal-toggle-pressed');
  });
  $(".modal-fullscreen").on('hidden.bs.modal', function () {
    var color = $(this).data('backdrop-color') || 'white'
    $(".modal-backdrop").removeClass("modal-backdrop-fullscreen modal-backdrop-" + color);
  });
  $('.modal').on('hidden.bs.modal', function(event){
    setTimeout(function(){
      $('[data-toggle="modal"]').blur();
    });
  });
});