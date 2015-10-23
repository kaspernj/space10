$(document).on('ready page:load', function () {
  $('body').on('click','#get_video_preview', function() {
    console.log("shit");
    var video_url = $('input.video_url_field').val();
    console.log(video_url);
    $.ajax({
        type: "POST",
        url: '/video_preview', //sumbits it to the given url of the form
        data: {'video_url': video_url}
    }).success(function(json){
        console.log("success", json);
        if (json !== undefined || json !== null) {
            $('.video_title_field').val(json.title)
            $('.video_description_field').val(json.description)
            $('.provider_field').val(json.provider_name)
            $('.video_id_field').val(json.video_id)
            $('.video_image_field').val(json.thumbnail_url)
        }
    }).error(function(){
        alert('Link could not be parsed. Try another!')
    });
    return false; // prevents normal behaviour
  });
});