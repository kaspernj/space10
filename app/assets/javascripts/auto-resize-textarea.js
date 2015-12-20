$(document).on('ready page:load', function () {
  // $('body').on( 'keyup', 'textarea.auto-resize', function (){
  //     $(this).height( 0 );
  //     $(this).height( this.scrollHeight );
  // });
  // $('body').find( 'textarea.auto-resize' ).keyup();
  $('body').on( 'keyup', 'textarea.auto-resize', function (e){
    autosize($(this));
  });
});