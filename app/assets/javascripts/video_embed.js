$(document).on('ready page:load', function () {
  $('body').on('click', '.video-play-button', function () {
    var clickedContainer = $(this).closest('.video-container');

    // Reset
    $('.video-container').each(function(){
      $(this).find('.video-poster').show();
      $(this).find('.video-embed').hide().find('iframe').attr('src', '');
    });

    var largeContainer = $('.video-container-large');
    var mq = window.matchMedia( "(min-width: 500px)" );

    if (clickedContainer != largeContainer && mq.matches) {
      var largeHtml = largeContainer.html();
      var smallHtml = clickedContainer.html();

      largeContainer.html(smallHtml);
      clickedContainer.html(largeHtml);

      clickedContainer = largeContainer;
    }
    clickedContainer.find('.video-poster').hide();
    var src = clickedContainer.find('.video-embed').data('embed-src')
    clickedContainer.find('.video-embed').show().find('iframe').attr('src', src);

    return false;
	});
});