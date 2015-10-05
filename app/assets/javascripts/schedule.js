$(document).on('ready page:load', function () {
	check_publish_at();
	
	$('#schedule_post').click(function(){
    check_publish_at();
	});

	function check_publish_at() {
		if($('#schedule_post').is(':checked')){
      $('#publish_at_form_group').show();

			$('input[value="Save"]').hide();
			$('input[value="Schedule"]').show();
			$('input[value="Publish now"]').hide();
    } else {
      $('#publish_at_form_group').hide();

      $('input[value="Save"]').show();
      $('input[value="Schedule"]').hide();
			$('input[value="Publish now"]').show();
    }
	}
});