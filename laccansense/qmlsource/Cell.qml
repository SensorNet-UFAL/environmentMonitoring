/* Cell.qml
 *
 * @author: Geymerson Ramos
 * @email: geymerson@laccan.ufal.br
 * Last-Updated:
 *           By: Geymerson Ramos
 *     Update #:
 */

/* Change Log:
 *
 */

import QtQuick 2.5

Rectangle {
    property alias title: title.text
    property alias titleColor: title.color
    property alias titleSize: title.font.pixelSize
    width: wpercent(root, 25)
    height: hpercent(root, 6)
    color: "white"
    border.color: "black"
    clip: true

    Text {
        id: title
        height:hpercent(parent,100); width: wpercent(parent,100);
                font { pixelSize: wpercent(this,9.5) }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
        text:"----"; color:"#000"
        anchors.centerIn: parent
        clip: true
    }
}
