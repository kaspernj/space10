initialize_tokeninput = function() {
  var tokeninput_field = $('[data-provider="tokeninput"]');
  var type = tokeninput_field.data('tokentype');
  if (type == 'ProfileTag') {
    var url = '/tags.json?type=profile'
  } else {
    var url = '/tags.json'
  }
  
  tokeninput_field.tokenInput(url, {
    propertyToSearch: 'title',
    theme: 'bootstrap',
    prePopulate: tokeninput_field.data('load'),
    zindex: 99999,
    placeholder: 'Tags'
  });
}
$(document).on('ready page:load', function () {
  initialize_tokeninput();
});
$(document).bind('ajax:complete', function() {
  initialize_tokeninput();
});