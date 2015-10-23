$(document).on('ready page:load', function () {
	$('.slick-variable-width').slick({
	  dots: false,
	  infinite: true,
	  centerMode: false,
	  variableWidth: true,
	  arrows: false,
	  lazyload: 'ondemand'
	});
});