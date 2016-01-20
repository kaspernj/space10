$(document).on('ready page:load', function () {
	$('.slick-variable-width').each(function(){
		var currentSlider = $(this)
		$(this).slick({
		  infinite: true,
		  centerMode: false,
		  variableWidth: true,
		  arrows: false,
		  dots: false,
		  initialSlide: 0
		});
		$(this).find('img').on("load", function() {
		  currentSlider.slick('slickGoTo', 0, true);
		}).each(function() {
		  if(this.complete) $(this).load();
		});
	});
	$('body').on('click', '.slick-slide:not(.slick-active)', function(){
		$(this).closest('.slick-variable-width').slick('slickNext');
		return false
	});
});

function slickGoToStart(img) {
	$(img).closest('.slick-variable-width').slick('slickGoTo', 0, true);
}