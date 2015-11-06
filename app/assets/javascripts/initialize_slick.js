$(document).on('ready page:load', function () {
	$('.slick-variable-width').slick({
	  infinite: true,
	  centerMode: false,
	  variableWidth: true,
	  arrows: false,
	  dots: false,
	  initialSlide: 0,
	  lazyLoad: 'ondemand'
	});
	$('body').on('click', '.slick-slide:not(.slick-active)', function(){
		$('.slick-variable-width').slick('slickNext');
		return false
	});
});