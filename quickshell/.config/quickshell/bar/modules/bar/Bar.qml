import QtQuick
import Quickshell
import Quickshell.Hyprland
// import Quickshell.SystemClock

PanelWindow {
    id: panel

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 15
    color: Qt.rgba(1,1,1,0)

    margins {
        top: 4
        left: 4
        right: 4
    }

    Rectangle {
            id: bar
            anchors.fill: parent
            color: Qt.rgba(0.3,0.3,0.3,0.35)
            radius: 15
            border.color: "#333333"
            border.width: 0

            Row{
                id: workspacsRow

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 8
                }

                spacing: 4

                Repeater {
                    model: Hyprland.workspaces

                    Rectangle {
                        width: 11
                        height: 11
                        radius: 10
                        color: modelData.active ? "#4a94ff" : "#333333"
                        border.color: "#555555"
                        border.width: 0

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("workspace " + modelData.id )
                        }

                        Text {
                            text: modelData.id
                            anchors.centerIn: parent
                            color: modelData.active ? "#ffffff" : "#cccccc"
                            font.pixelSize: 7
                            font.family: "etBrainsMonoNLNerdFont-Regular, sans-serif"
                        }
                    }
                }

                Text {
                    visible: Hyprland.workspaces.length === 0
                    text: "No Workspaces Open"
                    color: "#ffffff"
                    font.pixelSize: 7
                    font.family: "etBrainsMonoNLNerdFont-Regular, sans-serif"                    
                }
            }

            Text {
                id: timeDisplay
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                    rightMargin: 8
                }

                property string currentTime: ""

                text: currentTime
                color: "#ffffff"
                font.pixelSize: 7
                font.family: "etBrainsMonoNLNerdFont-Regular, sans-serif"

                SystemClock {
                    id: clock
                    precision: SystemClock.Seconds
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        var now = new Date()
                        timeDisplay.currentTime = Qt.formatDate(new Date(), "MMM dd") + " " + Qt.formatTime(new Date(), "hh:mm:ss")
                    }
                }

                Component.onCompleted: {
                    var now = new Date()
                    timeDisplay.currentTime = Qt.formatDate(new Date(), "MMM dd") + " " + Qt.formatTime(new Date(), "hh:mm:ss")
                }
            }
        }
}
