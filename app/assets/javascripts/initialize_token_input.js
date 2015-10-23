$(document).on('ready page:load', function () {
	$('[data-provider="tokeninput"]').tokenInput('/tags.json', {
		propertyToSearch: 'title',
		theme: 'bootstrap',
		prePopulate: $('[data-provider="tokeninput"]').data('load')
	})
});