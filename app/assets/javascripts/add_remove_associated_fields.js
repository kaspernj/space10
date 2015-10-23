$(document).on('ready page:load', function () {

		$('form').on('click', '.remove_fields', function (event) {
		  $(this).prevAll('input.destroy').first().val('1');
		  $(this).closest('fieldset').hide();
		  event.preventDefault();
		});

		$('form').on('click', '.add_fields', function (event) {
		  time = new Date().getTime();
		  regexp = new RegExp($(this).data('id'), 'g');
		  $(this).closest('.add_fields_here').before($(this).data('fields').replace(regexp, time));
		  init_sortable();
		  init_summernote();
		  event.preventDefault()
		});
});