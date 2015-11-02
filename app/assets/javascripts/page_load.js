$(document).on('ready page:change', function () {
	$('#svg_logo').show();
	$('#gif_logo').hide();
}).on('ready page:fetch', function () {
  if( $('#svg_logo').is(':visible') ) {
    $('#svg_logo').hide();
    $('#gif_logo').show();
  }
});