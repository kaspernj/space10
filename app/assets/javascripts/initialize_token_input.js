initialize_tokeninput = function() {
  var tokeninput_field = $('[data-provider="tokeninput"]');
  
  tokeninput_field.tokenInput('/tags.json', {
    propertyToSearch: 'title',
    theme: 'bootstrap',
    prePopulate: $('[data-provider="tokeninput"]').data('load'),
    zindex: 99999,
    placeholder: 'Tags'
  });
  // $('[data-provider="tokeninput"]').prev('ul').find('input').keypress(function(e) {
  //   alert(e.which)
  // });
  tokeninput_field.prev('ul').find('input').on('keydown', function(e) { 
    if (e.which == 13) { 
      alert('enter')
    } 
  });
}
$(document).on('ready page:load', function () {
  initialize_tokeninput();
});
$(document).bind('ajax:complete', function() {
  initialize_tokeninput();
});