$(document).on('ready page:load', function () {
  $('body').on( 'click', '#rating-show-content', function (e){
    $("#rating-additional-inputs-controls").hide();
    $("#rating-additional-inputs-form").show();
    $("#rating_content").focus();
    return false
  });
});