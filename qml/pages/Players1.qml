import QtQuick 2.0
import Sailfish.Silica 1.0
import "../"

Page {
    id: page
    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
            }
            MenuItem {
                text: qsTr("Pick amount of players")
                onClicked: {
                    resetAllStats()
                    listModel.clear()
                    pageStack.replace(Qt.resolvedUrl("FirstPage.qml"))
                }
            }
            MenuItem {
                text: qsTr("Reset")
                onClicked: {
                    resetAllStats()
                    listModel.clear()
                }
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
            // This is the name of Player 1. It's editable, but defaults to "Player 1"
            TextInput {
                x: Theme.horizontalPageMargin
                text: qsTr(player1name)
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }

            //This is the life counter of player 1, it defaults to 20, but can be set to anything. It's editable and should only accept numbers.
            TextInput {
                id: p1life
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr(hp) //
                inputMethodHints: Qt.ImhFormattedNumbersOnly // hopefully prevents one from inputing any random character, only numbers are allowed
                color: Theme.secondaryHighlightColor //this makes it fit in with the native look
                font.pixelSize: Theme.fontSizeExtraLarge + Theme.fontSizeLarge //make it large so it's easy to read
                onAccepted: {
                    hp = parseFloat(p1life.text)
                    column.historyLog("Life", hp)
            }
            }

            // there is a history log at the bottom, an this is a custom function to add to it. It saves having to rewrite things a bunch of times.
            function historyLog (type, value) {

                //Get Time
                var currentdate = new Date(); // ty stack overflow~https://stackoverflow.com/questions/10211145/getting-current-date-and-time-in-javascript
                function pad(n) { // ty stackoverflow~ https://stackoverflow.com/questions/8089875/show-a-leading-zero-if-a-number-is-less-than-10
                    return (n < 10) ? ("0" + n) : n;
                }
                listModel.append({"sliderValue": currentdate.getHours() + ":" + pad(currentdate.getMinutes()) +  ":" + pad(currentdate.getSeconds()) + " | " + type + " is now: " + value})
                listModel.sortModel() //I think I have to call this here, as the one bellow (look at the listModel part inside the repeater at the end) doesn't actually work....
            }

            function buttonAdd (addamount) {
            hp = parseFloat(hp) + parseFloat(addamount)
                column.historyLog("Life", hp)
            }

            function buttonSubtract (subtractamount) {
            hp = parseFloat(hp) - parseFloat(subtractamount)
                column.historyLog("Life", hp)
            }

            // @disable-check M300 //ButtonLayout is weirdly not recognized but works, at least in Hossa. This is also used by the Component Gallery app for the Call and SMS button examples.
            ButtonLayout { //I actually found this in the source of the componentgallery app
                Button {
                    text: "+1"
                    onClicked: column.buttonAdd(1)
                }
                Button {
                    text: "+10"
                    onClicked: column.buttonAdd(10.000000 )
                }
            }

            // @disable-check M300 //Same again
            ButtonLayout {
                Button {
                    text: "-1"
                    onClicked: column.buttonSubtract(1)
                }
                Button {
                    text: "-10"
                    onClicked: column.buttonSubtract(10.000000)
                }
            }

            Slider {
                id: p1poison
                label: "Poison"
                width: parent.width
                minimumValue: 0; maximumValue: 10; stepSize: 1
                value: player1poison
                valueText: value
                onReleased: {
                    player1poison = p1poison.value
                    column.historyLog("Poison", p1poison.value)
                }
            }

            Label {
                x: Theme.horizontalPageMargin
                text: qsTr("History")
                color: Theme.secondaryHighlightColor
                //font.pixelSize: Theme.fontSizeExtraLarge
            }

            Repeater { // Thank you SFOS documentation! https://sailfishos.org/develop/docs/silica/sailfish-silica-introduction.html/
                model: ListModel {
                    id: listModel
                    function sortModel()  // Thank you StackOverflow, once again~ https://stackoverflow.com/questions/29429710/how-to-auto-sort-qml-listelements-in-sections
                    {
                        for(var i=0; i<count; i++)
                        {
                            for(var j=0; j<i; j++)
                            {
                                if(get(i).section == get(j).section)
                                    move(i,j,1)
                                break
                            }
                        }
                    }
                    Component.onCompleted: sortModel() //I don't think this actually works, but it doens't harm anyone so let's leave it :)
                }
                Label { x: Theme.horizontalPageMargin; text: model.sliderValue }
            }

            Button {
                text: "Clear History"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    listModel.clear()
                 }
            }
            VerticalScrollDecorator {}
        }
    }
}
