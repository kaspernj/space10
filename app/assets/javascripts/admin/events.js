$(document).on('ready page:load', function () {
	$('.datetimepicker').each(function(i, obj) {
	  $(this).datetimepicker({
	  	format: "M/D/YYYY HH:mm"
	  });
	});
});