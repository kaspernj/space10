// function PlaySound(soundobj) {
//   var thissound = soundobj.next('audio')[0]
//   thissound.play();
// }

// function StopSound(soundobj) {
//   var thissound = soundobj.next('audio')[0]
//   thissound.pause();
//   thissound.currentTime = 0;
// }

$(document).on('ready page:load', function () {
  $('.play_sound a').each(function(){
    $(this).next('audio')[0].pause();
    $(this).next('audio')[0].currentTime = 0;
  });
  $('.play_sound a').mouseenter(function(){
    $(this).next('audio')[0].play();
  })
});