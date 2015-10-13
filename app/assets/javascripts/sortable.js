$(document).on('ready page:load', function () {
	set_positions = function(el){
    // loop through and give each task a data-pos
    // attribute that holds its position in the DOM
    el.closest('.sortable').find('.sortable_item').each(function(i){
        $(this).find("input.row_order").first().attr('value',i+1);
    });
	};

	init_sortable = function() {
		$('.sortable').sortable({
			items: '.sortable_item',
			handle: '.handle',
			forcePlaceholderSize: true
		});

		$('.sortable').sortable().bind('sortupdate', function(e, ui) {
			set_positions(ui.item);
		});

		$('.sortable').sortable().bind('sortstart', function(e, ui) {
			ui.placeholder.height(ui.item.outerHeight());
			ui.placeholder.width(ui.item.outerWidth());
			ui.placeholder.css('margin', ui.item.css('margin'));
		});
	};

	init_sortable();

});