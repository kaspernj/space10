$(document).on('ready page:load', function () {
	$('.video-play-button').click(function(e){
		var group = $(this).closest('.video-group');
		group.find('.video-poster').hide();
		var src = group.find('.video-embed').data('embed-src')
		group.find('.video-embed').show().find('iframe').attr('src', src);
		return false
	})
});