$(document).on('ajax:beforeSend', "form[data-remote='true']", function(){
  $(this).find("input[type='submit']").prop("disabled",true);
  $(this).find(".loading-indicator").show();
});
$(document).on('ajax:beforeSend', "a[data-remote='true']", function(){
  $(this).href = null;
});