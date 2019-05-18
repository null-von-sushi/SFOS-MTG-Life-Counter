import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages"

CoverBackground {

    onStatusChanged: {
        //This part specifies what the cover shows
        if (amountOfPlayers == 0) {
                    coverlabel.text = "Untap"
                    coverlabel.font.pixelSize = Theme.fontSizeExtraLarge
                    coverlabel.width = parent.width

                    coverlabelDivider.width = 0

                    coverlabel2.width = 0
                    coverlabel2.text = ""
                }
        else if (amountOfPlayers == 1) {
            coverlabel.text = "<b>" + player1name + "</b>"
                    + "<br>Life: " + hp
                    + "<br>Poison: " + player1poison
            coverlabel.font.pixelSize = Theme.fontSizeExtraLarge
            coverlabel.width = parent.width

            coverlabelDivider.width = 0

            coverlabel2.width = 0
            coverlabel2.text = ""
        }
        else if (amountOfPlayers == 2) {
            coverlabel.text  = "<b>" + player1name + "</b>"
                    + "<br>Life: " + hp
                    + "<br>Poison: " + player1poison
                    + "<br>"
                    + "<br><b>" + player2name + "</b>"
                    + "<br>Life: " + hp2
                    + "<br>Poison: " + player2poison
            coverlabel.font.pixelSize = Theme.fontSizeMedium * 1.20
            coverlabel.width = parent.width

            coverlabelDivider.width = 0

            coverlabel2.width = 0
            coverlabel2.text = ""
        }
        else if (amountOfPlayers == 3) {
            coverlabel.text  = "<b>" + player1name + "</b>"
                    + "<br>Life:<br>" + hp
                    + "<br>Poison:<br>" + player1poison
                    + "<br><b>" + player3name + "</b>"
                    + "<br>Life:<br>" + hp3
                    + "<br>Poison:<br>" + player3poison
            coverlabel.font.pixelSize = Theme.fontSizeMedium * .90
            coverlabel.width = parent.width * 0.48

            coverlabelDivider.width = 4

            coverlabel2.text  = "<b>" + player2name + "</b>"
                    + "<br>Life:<br>" + hp2
                    + "<br>Poison:<br>" + player2poison
            coverlabel2.font.pixelSize = Theme.fontSizeMedium * .90
            coverlabel2.width = parent.width * 0.48
        }
        else if (amountOfPlayers == 4)  {
            coverlabel.text  = "<b>" + player1name + "</b>"
                    + "<br>Life:<br>" + hp
                    + "<br>Poison:<br>" + player1poison
                    + "<br><b>" + player3name + "</b>"
                    + "<br>Life:<br>" + hp3
                    + "<br>Poison:<br>" + player3poison
            coverlabel.font.pixelSize = Theme.fontSizeMedium * .90
            coverlabel.width = parent.width * 0.48

            coverlabelDivider.width = 4

            coverlabel2.text  = "<b>" + player2name + "</b>"
                    + "<br>Life:<br>" + hp2
                    + "<br>Poison:<br>" + player2poison
                    + "<br><b>" + player4name + "</b>"
                    + "<br>Life:<br>" + hp4
                    + "<br>Poison:<br>" + player4poison
            coverlabel2.font.pixelSize = Theme.fontSizeMedium * .90
            coverlabel2.width = parent.width * 0.48
        }

        switch (status ){
        case PageStatus.Activating:
            console.log("PageStatus.Activating") //I think I stole these debug messages from harbor-tooter. Sidenote, if anyone is reading this, I will legitimately pay someone 5 Pound Sterling using PayPal if they can fix it to work reliably with pleroma.
            break;
        case PageStatus.Inactive:
            console.log("PageStatus.Inactive")
            break;
        }
    }
    Row {
        Label {
            id: coverlabel
            anchors.left: parent.Left
            anchors.top: parent.Top
            anchors.right: coverlabelDivider.Left
            // For some fucking reason margins are just ignored >:(

            font.pixelSize: Theme.fontSizeMedium
            text: qsTr("")
        }

        Label { //Don't even ask. I do not even know for sure if this works....
            id: coverlabelDivider
            text: qsTr("")
            width: 4
            anchors.left: coverlabel.Right
            anchors.right: coverlabel2.Left
            anchors.centerIn: parent.Center
        }

        Label {
            id: coverlabel2
            anchors.right: parent.Right
            anchors.top: parent.Top
            anchors.left: coverlabelDivider.Right
            font.pixelSize: Theme.fontSizeMedium
            text: qsTr("")
        }
    }

//    CoverActionList {
//        id: coverAction

//        CoverAction {
//            iconSource: "image://theme/icon-cover-next"
//        }

//        CoverAction {
//            iconSource: "image://theme/icon-cover-pause"
//        }
//    }

}
