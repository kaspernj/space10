$(document).on('ready page:load', function () {
	align_containers = function(e) {
		var margin_left = $('.container').first().css("margin-left");
		$(".container-align-left").each(function(s){
			$(this).css("margin-left", margin_left);
		});
	};	

	$(window).bind('resize', function () {
    align_containers();
	}).trigger('resize');
});