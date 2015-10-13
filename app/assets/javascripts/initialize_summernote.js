$(document).on('ready page:load', function () {
	init_summernote = function() {
		$('[data-provider="summernote"]').summernote({
			height:250,
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
	};
	init_summernote();
});

