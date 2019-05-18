import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.Portrait

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Untap")
            }
            Label {
                x: Theme.horizontalPageMargin
                text: qsTr("Welcome")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }

            Slider {
                id: slider
                label: "Players"
                width: parent.width
                minimumValue: 1; maximumValue: 4; stepSize: 1
                value: 1
                valueText: value
            }

            Button {
                text: "Start"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    amountOfPlayers = slider.value
                    pageStack.replace(Qt.resolvedUrl("Players" + slider.value + ".qml"))
                }
            }
        }
    }
}
