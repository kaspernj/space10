$(document).on('ready page:load', function () {
	$('.slick-variable-width').slick({
	  infinite: true,
	  centerMode: false,
	  variableWidth: true,
	  arrows: false,
	  dots: false,
	  initialSlide: -1,
	  lazyLoad: 'ondemand',
	});
});