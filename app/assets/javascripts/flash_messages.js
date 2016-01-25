var fade_flash = function() {
  $(".alert").delay(3000).slideUp(200, function() {
    $(this).alert('close');
  });
};
fade_flash();

var show_ajax_message = function(msg, type) {
  $("#flash-message").html('<div id="flash_'+type+'" class="alert flash_'+type+'">'+
    '<div class="container">'+msg+'</div></div>');
  fade_flash();
};

$(document).ajaxComplete(function(event, request) {
    var msg = request.getResponseHeader('X-Message');
    var type = request.getResponseHeader('X-Message-Type');
    show_ajax_message(msg, type); //use whatever popup, notification or whatever plugin you want
});