$(document).on('ajax:beforeSend', "form[data-remote='true']", function(){
  $(this).find("input[type='submit']").prop("disabled",true);
  $(this).find(".loading-indicator").show();
});