initialize_tokeninput = function() {
  $('[data-provider="tokeninput"]').tokenInput('/tags.json', {
    propertyToSearch: 'title',
    theme: 'bootstrap',
    prePopulate: $('[data-provider="tokeninput"]').data('load'),
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