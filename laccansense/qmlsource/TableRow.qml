/* TableRow.qml
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
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Item {
    width: cell1.width*10
    height: cell1.height

    property var rowColor: "white"
    property alias cell1Text: cell1.title
    property alias cell2Text: cell2.title
    property alias cell3Text: cell3.title
    property alias cell4Text: cell4.title
    property alias cell5Text: cell5.title
    property alias cell6Text: cell6.title
    property alias cell7Text: cell7.title
    property alias cell8Text: cell8.title
    property alias cell9Text: cell9.title
    property alias cell10Text: cell10.title


    Row {
        id: rows
        Cell {
            id: cell1
            title: "cell1"
            color: rowColor
        }

        Cell {
            id: cell2
            title: "cell2"
            color: rowColor
        }

        Cell {
            id: cell3
            title: "cell3"
            color: rowColor
        }

        Cell {
            id: cell4
            title: "cell4"
            color: rowColor
        }

        Cell {
            id: cell5
            title: "cell5"
            color: rowColor
        }

        Cell {
            id: cell6
            title: "cell16"
            color: rowColor
        }

        Cell {
            id: cell7
            title: "cell7"
            color: rowColor
        }

        Cell {
            id: cell8
            title: "cell8"
            color: rowColor
        }

        Cell {
            id: cell9
            title: "cell9"
            color: rowColor
        }

        Cell {
            id: cell10
            title: "cell10"
            color: rowColor
        }
    }
}

