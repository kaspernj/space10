// $(document).on('ready page:load', function () {
//   function startTime() {
//     var clock = document.getElementById('clock');

//     if(! clock){ return };

//     var today=new Date();
    
//     var days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
//     var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];

//     var day = days[ today.getDay() ];
//     var month = months[ today.getMonth() ];
//     var date = today.getDate();

//     var h=today.getHours();
//     var m=today.getMinutes();
//     var s=today.getSeconds();

//     m = checkTime(m);
//     s = checkTime(s);

//     clock.innerHTML = day + ", " + month + " " + date + " &mdash; " + h+":"+m;
//     var t = setTimeout(function(){startTime()},500);
//   }

//   function checkTime(i) {
//     if (i<10) {i = "0" + i};  // add zero in front of numbers < 10
//     return i;
//   }

//   startTime()

// });