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

function loadStylesheet(url) {
  $('head').append('<link rel="stylesheet" type="text/css" href="'+url+'" title="suse counter">');
}

$(document).ready(function() {
  //console.log('foo');
  var prefix = ''; //base location of the script
  var message = localized_message();

  loadStylesheet('counter.css');
  var releasedate = new Date();
  releasedate.setFullYear(2009,11,12); 
  var today = new Date();
  var daystogo = days_remaining(today,releasedate);
  //var daystogo = 0;

  $('#nojavascriptlink').hide();
  if (daystogo>0) {
    $('#countercontainer').append("<div id='SUSEcounter'></div>");
    $('#SUSEcounter').append("<div id='SUSEdaystogo'>" + daystogo + "</div>");
    $('#SUSEdaystogo').hide().fadeIn();
    $('#SUSEcounter').append("<div id='SUSEdays'>" + message + "</div>");
    $('#SUSEdays').hide().fadeIn(2000);
  } else {
    //it's time, get it!
    $('#countercontainer').append("<div id='SUSEcounter'><a class='message' href='http://software.opensuse.org'>download here!</div>");
  }
});
