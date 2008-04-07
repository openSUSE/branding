// 
//
// (c) 2008 Jakub Steiner <jimmac AT gmail.com>
//
//
// code & images redistributable under the GNU LGPL v2 or later
//
function days_remaining(date1, date2) {
    var dayinmiliseconds = 1000 * 60 * 60 * 24

    // Convert both dates to milliseconds
    var date1_ms = date1.getTime()
    var date2_ms = date2.getTime()

    var diffinms = date2_ms - date1_ms
    var diff = Math.round(diffinms/dayinmiliseconds)
    if (diff > 0) {
      return diff;
    } else {
      return 0;
    }

}

function localized_message() {
  var lang = window.navigator.language; //FIXME: this is broken, 
                                        //it's not the user set language-accept.
                                        //I cannot figure out how to read HTTP headers either.

  var message = new Object();
  message.en = "days to go.";
  message.de = "Tage bis zum release."; //FIXME: denglish
  message.cs = "dní do vydání.";

  if (message[lang]) { //default to english if not localized
    return message[lang];
  } else {
    return message['en'];
  }
}

$(document).ready(function() {
  var prefix = 'http://forgeftp.novell.com/opensuse-art/openSUSE11/web-banner/'; //base location of the script
  var message = localized_message();

  
  var releasedate = new Date();
  releasedate.setFullYear(2008,5,19); //19.6.2008
  var today = new Date();
  var daystogo = days_remaining(today,releasedate);

  $('#nojavascriptlink').hide();
  $('#countercontainer').append("<div id='SUSEcounter'></div>");
  $('#SUSEcounter').css({
    'overflow': 'hidden',
    'position': 'relative',
    'width':  '256px',
    'height':  '256px',
    'background-image': 'url(' + prefix + 'images/background.png)'
  });
  $('#SUSEcounter').append("<div id='SUSEdaystogo'>" + daystogo + "</div>");

  $('#SUSEdaystogo').hide().css({
    'color': '#ffffff',
    'font-family': "'Trebuchet MS', Sans-Serif",
    'font-size':  '60pt',
    'height':  '1em',
    'font-weight': 'bold',
    'line-height': '1em',
    'text-align': 'center',
    'margin-top': '43%'
  }).fadeIn();
  $('#SUSEcounter').append("<div id='SUSEdays'>" + message + "</div>");
  $('#SUSEdays').hide().css({
    'position': 'absolute',
    'bottom': '30px',
    'right': '30px',
    'color': '#ffffff',
    'line-height': '1em',
    'font-size':  '16pt',
    'font-family': "'Trebuchet MS', Sans-Serif"
  }).fadeIn(2000);
});
