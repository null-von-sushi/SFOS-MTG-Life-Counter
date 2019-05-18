import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"



ApplicationWindow
{
    //Thanks to "mal" from #SailfishOS on freenode for answering my dumb questions :)
    //Thanks to them  I was able to make this application show a cover!

    property string player1name: "Player 1"
    property string player2name: "Player 2"
    property string player3name: "Player 3"
    property string player4name: "Player 4"

    property string player1poison: "0"
    property string player2poison: "0"
    property string player3poison: "0"
    property string player4poison: "0"

    property string hp: "20" // this is the default life total. Variables are used because I would like to eventually make the default configurable. Global variables are not a thing I think, so I am using this. I got this from, you guessed it, stack exchange
    property string hp2: "20"
    property string hp3: "20"
    property string hp4: "20"

    property string amountOfPlayers: "0" //This is the amount of players the user will select in FirstPage.qml

    function resetAllStats() {
        hp = 20
        player1poison = 0
        hp2 = 20
        player2poison = 0
        hp3 = 20
        player3poison = 0
        hp4 = 20
        player4poison = 0
    }

    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All //defaultAllowedOrientations
}

