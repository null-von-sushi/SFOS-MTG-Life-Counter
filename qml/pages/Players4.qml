import QtQuick 2.0
import Sailfish.Silica 1.0

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
                onClicked:  {
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

            // there is a history log at the bottom, an this is a custom function to add to it. It saves having to rewrite things a bunch of times.
            function historyLog (type, value, playernr) {

                //Get Time
                var currentdate = new Date(); // ty stack overflow~https://stackoverflow.com/questions/10211145/getting-current-date-and-time-in-javascript
                function pad(n) { // ty stackoverflow~ https://stackoverflow.com/questions/8089875/show-a-leading-zero-if-a-number-is-less-than-10
                    return (n < 10) ? ("0" + n) : n;
                }
                listModel.append({"sliderValue": currentdate.getHours() + ":" + pad(currentdate.getMinutes()) +  ":" + pad(currentdate.getSeconds()) + " | Player " + playernr + " " + type + " is now: " + value})
                listModel.sortModel() //I think I have to call this here, as the one bellow (look at the listModel part inside the repeater at the end) doesn't actually work....
            }

            //Players 1 & 2
            Row {

                // Player 1
                Column {
                    id: player1column
                    width: page.width / 2

                    // This is the name of Player 1. It's editable, but defaults to "Player 1"
                    TextInput {
                        x: Theme.horizontalPageMargin
                        text: qsTr(player1name)
                        color: Theme.secondaryHighlightColor
                        font.pixelSize: Theme.fontSizeLarge
                    }

                    //This is the life counter of player 1, it defaults to 20, but can be set to anything. It's editable and should only accept numbers.
                    TextInput {
                        id: p1life
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr(hp) //
                        inputMethodHints: Qt.ImhFormattedNumbersOnly // hopefully prevents one from inputing any random character, only numbers are allowed
                        color: Theme.secondaryHighlightColor //this makes it fit in with the native look
                        font.pixelSize: Theme.fontSizeExtraLarge + Theme.fontSizeMedium //make it large so it's easy to read
                        onAccepted: {
                            hp = parseFloat(p1life.text)
                            column.historyLog("Life", hp, 1)
                        }
                    }

                    function buttonAdd (addamount) {
                        hp = parseFloat(hp) + parseFloat(addamount)
                        column.historyLog("Life", hp, 1)
                    }

                    function buttonSubtract (subtractamount) {
                        hp = parseFloat(hp) - parseFloat(subtractamount)
                        column.historyLog("Life", hp, 1)
                    }

                    // @disable-check M300 //ButtonLayout is weirdly not recognized but works, at least in Hossa. This is also used by the Component Gallery app for the Call and SMS button examples.
                    ButtonLayout { //I actually found this in the source of the componentgallery app
                        Button {
                            text: "+1"
                            onClicked: player1column.buttonAdd(1)
                        }
                        Button {
                            text: "-1"
                            onClicked: player1column.buttonSubtract(1)
                        }
                        Button {
                            text: "+10"
                            onClicked: player1column.buttonAdd(10.000000 )
                        }
                        Button {
                            text: "-10"
                            onClicked: player1column.buttonSubtract(10.000000)
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
                            column.historyLog("Poison", p1poison.value, 1)
                        }
                    }
                }

                //Player 2
                Column {
                    id: player2column
                    width: page.width / 2

                    // Player 2 stuff now
                    TextInput {
                        x: Theme.horizontalPageMargin
                        text: qsTr(player2name)
                        color: Theme.secondaryHighlightColor
                        font.pixelSize: Theme.fontSizeLarge
                    }

                    TextInput {
                        id: p2life
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr(hp2) //
                        inputMethodHints: Qt.ImhFormattedNumbersOnly // hopefully prevents one from inputing any random character, only numbers are allowed
                        color: Theme.secondaryHighlightColor //this makes it fit in with the native look
                        font.pixelSize: Theme.fontSizeExtraLarge + Theme.fontSizeMedium //make it large so it's easy to read
                        onAccepted: {
                            hp2 = parseFloat(p2life.text)
                            column.historyLog("Life", hp2, 2)
                        }
                    }

                    function button2Add (addamount) {
                        hp2 = parseFloat(hp2) + parseFloat(addamount)
                        column.historyLog("Life", hp2, 2)
                    }

                    function button2Subtract (subtractamount) {
                        hp2 = parseFloat(hp2) - parseFloat(subtractamount)
                        column.historyLog("Life", hp2, 2)
                    }

                    // @disable-check M300 //ButtonLayout is weirdly not recognized but works, at least in Hossa. This is also used by the Component Gallery app for the Call and SMS button examples.
                    ButtonLayout { //I actually found this in the source of the componentgallery app
                        Button {
                            text: "+1"
                            onClicked: player2column.button2Add(1)
                        }
                        Button {
                            text: "-1"
                            onClicked: player2column.button2Subtract(1)
                        }
                        Button {
                            text: "+10"
                            onClicked: player2column.button2Add(10.000000 )
                        }
                        Button {
                            text: "-10"
                            onClicked: player2column.button2Subtract(10.000000)
                        }
                    }

                    Slider {
                        id: p2poison
                        label: "Poison"
                        width: parent.width
                        minimumValue: 0; maximumValue: 10; stepSize: 1
                        value: player2poison
                        valueText: value
                        onReleased: {
                            player2poison = p2poison.value
                            column.historyLog("Poison", p2poison.value, 2)
                        }
                    }
                }
            }

            // Second Row
            Row {

                //Player 3
                Column {
                    id: player3column
                    width: page.width / 2

                    // Player 3 stuff now
                    TextInput {
                        x: Theme.horizontalPageMargin
                        text: qsTr(player3name)
                        color: Theme.secondaryHighlightColor
                        font.pixelSize: Theme.fontSizeLarge
                    }

                    TextInput {
                        id: p3life
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr(hp3) //
                        inputMethodHints: Qt.ImhFormattedNumbersOnly // hopefully prevents one from inputing any random character, only numbers are allowed
                        color: Theme.secondaryHighlightColor //this makes it fit in with the native look
                        font.pixelSize: Theme.fontSizeExtraLarge + Theme.fontSizeMedium //make it large so it's easy to read
                        onAccepted: {
                            hp3 = parseFloat(p3life.text)
                            column.historyLog("Life", hp3, 3)
                        }
                    }

                    function button3Add (addamount) {
                        hp3 = parseFloat(hp3) + parseFloat(addamount)
                        column.historyLog("Life", hp3, 3)
                    }

                    function button3Subtract (subtractamount) {
                        hp3 = parseFloat(hp3) - parseFloat(subtractamount)
                        column.historyLog("Life", hp3, 3)
                    }

                    // @disable-check M300 //ButtonLayout is weirdly not recognized but works, at least in Hossa. This is also used by the Component Gallery app for the Call and SMS button examples.
                    ButtonLayout { //I actually found this in the source of the componentgallery app
                        Button {
                            text: "+1"
                            onClicked: player3column.button3Add(1)
                        }
                        Button {
                            text: "-1"
                            onClicked: player3column.button3Subtract(1)
                        }
                        Button {
                            text: "+10"
                            onClicked: player3column.button3Add(10.000000 )
                        }
                        Button {
                            text: "-10"
                            onClicked: player3column.button3Subtract(10.000000)
                        }
                    }

                    Slider {
                        id: p3poison
                        label: "Poison"
                        width: parent.width
                        minimumValue: 0; maximumValue: 10; stepSize: 1
                        value: player3poison
                        valueText: value
                        onReleased: {
                            player3poison = p3poison.value
                            column.historyLog("Poison", p3poison.value, 3)
                        }
                    }
                }

                //Player 4
                Column {
                    id: player4column
                    width: page.width / 2

                    // Player 4 stuff now
                    TextInput {
                        x: Theme.horizontalPageMargin
                        text: qsTr(player4name)
                        color: Theme.secondaryHighlightColor
                        font.pixelSize: Theme.fontSizeLarge
                    }

                    TextInput {
                        id: p4life
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr(hp4) //
                        inputMethodHints: Qt.ImhFormattedNumbersOnly // hopefully prevents one from inputing any random character, only numbers are allowed
                        color: Theme.secondaryHighlightColor //this makes it fit in with the native look
                        font.pixelSize: Theme.fontSizeExtraLarge + Theme.fontSizeMedium //make it large so it's easy to read
                        onAccepted: {
                            hp4 = parseFloat(p4life.text)
                            column.historyLog("Life", hp4, 4)
                        }
                    }

                    function button4Add (addamount) {
                        hp4 = parseFloat(hp4) + parseFloat(addamount)
                        column.historyLog("Life", hp4, 4)
                    }

                    function button4Subtract (subtractamount) {
                        hp4 = parseFloat(hp4) - parseFloat(subtractamount)
                        column.historyLog("Life", hp4, 4)
                    }

                    // @disable-check M300 //ButtonLayout is weirdly not recognized but works, at least in Hossa. This is also used by the Component Gallery app for the Call and SMS button examples.
                    ButtonLayout { //I actually found this in the source of the componentgallery app
                        Button {
                            text: "+1"
                            onClicked: player4column.button4Add(1)
                        }
                        Button {
                            text: "-1"
                            onClicked: player4column.button4Subtract(1)
                        }
                        Button {
                            text: "+10"
                            onClicked: player4column.button4Add(10.000000 )
                        }
                        Button {
                            text: "-10"
                            onClicked: player4column.button4Subtract(10.000000)
                        }
                    }

                    Slider {
                        id: p4poison
                        label: "Poison"
                        width: parent.width
                        minimumValue: 0; maximumValue: 10; stepSize: 1
                        value: player4poison
                        valueText: value
                        onReleased: {
                            player4poison = p4poison.value
                            column.historyLog("Poison", p4poison.value, 4)
                        }
                    }
                }
            }

            //History log here
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
                    //Component.onCompleted: sortModel() //I don't think this actually works, but it doens't harm anyone so let's leave it :)
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
