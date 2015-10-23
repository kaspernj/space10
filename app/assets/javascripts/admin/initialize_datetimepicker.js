$(document).on('ready page:load', function () {
	$('.datetimepicker').each(function(i, obj) {
	  $(this).datetimepicker({
	  	format: "D/M/YYYY HH:mm"
	  });
	});
});