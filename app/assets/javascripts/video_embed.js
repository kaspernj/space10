$(document).on('ready page:load', function () {
	$('.video-play-button').click(function(e){
		var container = $(this).closest('.video-container');
		container.find('.video-poster').hide();
		var src = container.find('.video-embed').data('embed-src')
		container.find('.video-embed').show().find('iframe').attr('src', src);
		return false
	})
});