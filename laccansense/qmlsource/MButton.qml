/* MButton.qml
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

Image {
    id: button
    width: height
    height: hpercent(root, 8)

    signal clicked
    signal entered
    signal exited

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: parent.clicked()
        onEntered: parent.entered()
        onExited: parent.exited()
    }
}
