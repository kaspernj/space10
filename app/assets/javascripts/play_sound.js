function PlaySound(soundobj) {
  var thissound=document.getElementById(soundobj);
  thissound.play();
}

function StopSound(soundobj) {
  var thissound=document.getElementById(soundobj);
  thissound.pause();
  thissound.currentTime = 0;
}

$(document).on('ready page:load', function () {
  $('.play_sound a').mouseover(function(){
    $(this).next('audio')[0].play();
  })
});