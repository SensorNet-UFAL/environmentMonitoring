/* MTableFlickArea.qml
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

Flickable {
    id: flickArea
    contentWidth: table.width

    property alias tableData: table.tableData

    Table {
        id: table
        tableData: sensorList
    }

    onTableDataChanged: {
        destroy();
    }
}
