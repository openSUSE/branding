/*   vim:set foldenable foldmethod=marker:
 *
 *   Copyright (C) 2011 Ivan Cukic <ivan.cukic(at)kde.org>
 *   Copyright (C) 2013 Bruno Friedmann <bruno(dot)friedmann(at)opensuse(dot)org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

/*
 * Note on 12.3 Version 
 * The big geeko in the middle of the screen is just commented
 * as it already exist on the leaves grow background
 * So We just keep kde logo middle centered on the screen
 * 
 */

import Qt 4.7

Item {
    id: main

    width: screenSize.width
    height: screenSize.height

    /* property declarations --------------------------{{{ */
    property int stage
    property int iconSize: (screenSize.width <= 1024) ? 96 : 192
    //property int logoSW: (screenSize.width <= 1024) ? 301 : 602
    //property int logoSH: (screenSize.width <= 1024) ? 179 : 358
    /* }}} */

    /* signal declarations ----------------------------{{{ */

    /* }}} */

    /* JavaScript functions ---------------------------{{{ */
    onStageChanged: {
        if (stage == 1) {
          background.opacity = 1
          gear.opacity = 0.5
          geeko.opacity = 0.5
//          mask.opacity = 0.5
        }
        if (stage == 2) {
	  background.opacity = 0.8
          gear.opacity = 0.8
          // geeko.opacity = 0.8
//          mask.opacity = 1
          letter.opacity = 1
        }
        if (stage == 3) {
	  background.opacity = 0.6
          gear.opacity = 1
          // geeko.opacity = 1
//          mask.opacity = 1
          letter.opacity = 1
        }
        if (stage == 4) {
	  background.opacity = 0.5
        }
        if (stage == 5) {
	  background.opacity = 0.3
          letter.opacity = 0.5
          gear.opacity = 0.5
//          mask.opacity = 0.5
	  logo.opacity = 1
        }
        if (stage == 6) {
	  background.opacity = 0.1
          letter.opacity = 0
          gear.opacity = 0
//          mask.opacity = 0
	  logo.opacity = 0  
        }
    }
    /* }}} */

    /* object properties ------------------------------{{{ */

    /* }}} */

    /* child objects ----------------------------------{{{ */

    Image {
        id: background
        source: "images/background.jpg"

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        opacity: 1
        Behavior on opacity { NumberAnimation { duration: 500; easing { type: Easing.OutInQuad } } }
    }
/*
    Image {
        id: geeko

        height: logoSH
        width: logoSW
        smooth: true

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        source: "images/opensuselogo.svgz"

        opacity: 0
        Behavior on opacity { NumberAnimation { duration: 500; easing { type: Easing.OutInQuad } } }
    }
*/
/*Not used
     Image {
        id: mask

        height: iconSize
        width: iconSize
        smooth: true

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
//        y: ((parent.height - height) / 2) + geeko.y 

        source: "images/kdemask.png"

        opacity: 0
        Behavior on opacity { NumberAnimation { duration: 1000; easing { type: Easing.InOutQuad } } }
    }
*/

  Image {
        id: gear

        height: iconSize
        width: iconSize
        smooth: true

        x: (parent.width - width) / 2 
        y: (parent.height - height) / 2 + 2
	//y: ((parent.height - height) / 2) + geeko.y 

        source: "images/kdegear.png"

        opacity: 0
        Behavior on opacity { NumberAnimation { duration: 1000; easing { type: Easing.InOutQuad } } }

        NumberAnimation {
            id: animateRotation
            target: gear
            properties: "rotation"
            from: 0
            to: 360
            duration: 2250

            loops: Animation.Infinite
            running: true
        }

    }

    Image {
        id: letter

        height: iconSize
        width: iconSize
        smooth: true

        x: (parent.width - width) / 2 
        y: (parent.height - height) / 2 - 1  
        //y: (parent.height - height) / 2  + (geeko.y - 3)

        source: "images/kdeletter.png"

        opacity: 0
        Behavior on opacity { NumberAnimation { duration: 1000; easing { type: Easing.InOutQuad } } }
    }

    Image {
        id: logo

        height: iconSize
        width: iconSize
        smooth: true

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2  
//        y: (parent.height - height) / 2  + (geeko.y - 1)

        source: "images/kdelogo-contrast.png"

        opacity: 0
        Behavior on opacity { NumberAnimation { duration: 1000; easing { type: Easing.InOutQuad } } }
    }

    /* }}} */

    /* stages -----------------------------------------{{{ */

    /* }}} */

    /* transitions ------------------------------------{{{ */

    /* }}} */
}

