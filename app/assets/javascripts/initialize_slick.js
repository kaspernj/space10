$(document).on('ready page:load', function () {
	$('.slick-variable-width').each(function(){
		$(this).slick({
		  infinite: true,
		  centerMode: false,
		  variableWidth: true,
		  arrows: false,
		  dots: false,
		  initialSlide: -1
		}).slick('slickGoTo','0');
	});
	$('body').on('click', '.slick-slide:not(.slick-active)', function(){
		$(this).closest('.slick-variable-width').slick('slickNext');
		return false
	});
});