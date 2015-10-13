$(document).on('ready page:load', function () {
  $('form').on('click', '.upload_image', function (event) {
    $(".upload_image").on('change', function () {
      var uploader = $(this);
      console.log("done");
      var reader = new FileReader();

      reader.onload = function (e) {
          // get loaded data and render thumbnail.
          uploader.prev('.image_preview').attr('src', e.target.result);
      };

      // read the image file as a data URL.
      reader.readAsDataURL(this.files[0]);
    }); 
  }); 
});