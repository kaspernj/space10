$(document).on('ready page:load', function () {
  $('body').on('focusin', '.autocomplete', function(){
    
    var geocoder = new google.maps.Geocoder();
    $(this).autocomplete({
      source: function(request,response) {

        // the geocode method takes an address or LatLng to search for
        // and a callback function which should process the results into
        // a format accepted by jqueryUI autocomplete
        geocoder.geocode( {'address': request.term }, function(results, status) {
          response($.map(results, function(item) {
            return {
              label: item.formatted_address, // appears in dropdown box
              value: item.formatted_address, // inserted into input element when selected
              geocode: item                  // all geocode data: used in select callback event
            }
          }));
        })
      }
    });

  });
});