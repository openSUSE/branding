$(document).ready (function () {

    var user_agent = navigator.userAgent.toLowerCase ();
    var platforms = {
        "suse":      "openSUSE",
        "sled":      "openSUSE",
        "opensuse":  "openSUSE",
        "osx":       "Mac OS X",
        "ubuntu":    "Ubuntu",
        "mandriva":  "Mandriva",
        "fedora":    "Fedora",
        "foresight": "Foresight",
        "firefox":   "Firefox",
        "generic":   "Source Code"
    };
    
    var platform_id = "generic";
    var platform_name = platforms[platform_id];
    
    for (i in platforms) {
        if (user_agent.match (i)) {
            platform_id = i;
            platform_name = platforms[i];
            if (platform_id == "suse" || platform_id == "sled") {
                platform_id = "opensuse";
            }
            break;
        }
    }
    Cufon.replace('h1,h2,h3,h4,.menu>li>a,.title', { 'font-family': 'WallaWalla' });  
    $(".screenshots a").addLoupe().fancybox(); 
});

(function ($) {
    $.fn.colorHover = function (animtime, fromColor, toColor) {
        $(this).hover (function () {
            return $(this).css ("color", fromColor).stop ().animate ({"color": toColor}, animtime);
        }, function () {
            return $(this).stop ().animate ({"color": fromColor}, animtime);
        });
    };
  
    $.fn.alphaHover = function (animtime, fromAlpha) {
        $(this).hover (function () {
            return $(this).css ("opacity", fromAlpha).stop ().animate ({"opacity": "1"}, animtime);
        }, function () {
            return $(this).stop ().animate ({"opacity": fromAlpha}, animtime);
        });
    };
    $.fn.addLoupe = function () {
        return $(this).append('<span class="loupe">');
    }
}) (jQuery);

