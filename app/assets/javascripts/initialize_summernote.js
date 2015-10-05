$(document).on('ready page:load', function () {
	$('#event_content').summernote({
		height:300,
		disableDragAndDrop: true,
		toolbar: [
	    ['style', ['style']],
	    ['font', ['bold', 'italic', 'underline', 'clear']],
	    // ['color', ['color']],
	    ['para', ['ul', 'ol']],
	    // ['table', ['table']],
	    ['insert', ['link']],
	    ['view', ['fullscreen', 'codeview']]
	  ],
	});
});

