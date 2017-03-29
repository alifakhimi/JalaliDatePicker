import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Universal 2.1
import QtQuick.Layouts 1.1
//import "logic/jalali.js" as Jalali
import "logic/persian-date-0.1.8.js" as PersianDate

Popup {
    id: pJalaliPickerId
    padding: 0
    modal: true
    clip: true

    property string date: "today"
    property string fontFamily: "samim"
    property string iconFont: "Material Icons"
    property var selectedPersianDate: new PersianDate.PersianDate()
    property string selectedPersianDateString: selectedPersianDate.format("YYYY-MM-DD")
    //Material.elevation: 6

    Component.onCompleted: {
        loaderPanelId.sourceComponent = cmpMonthPanelId
    }

    background: Rectangle {}

    ColumnLayout {
        anchors.fill: parent
        layoutDirection: Qt.RightToLeft
        spacing: 10

        // Header
        Pane {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.25
            Material.background: Material.primary
            Material.foreground: "white"

            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                Label {
                    Layout.fillWidth: true
                    text: selectedPersianDate.format("YYYY")
                    font.family: fontFamily
                    font.pixelSize: 14

                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        onClicked: {
                            yearClicked()
                        }
                    }
                }
                Label {
                    Layout.fillWidth: true
                    text: selectedPersianDate.format("dddd، DD MMMM")
                    font.family: fontFamily
                    font.pixelSize: 28
                    font.bold: true

                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        onClicked: {

                        }
                    }
                }
            }
        }

        Loader {
            id: loaderPanelId
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        // Days arrage panel
        Component {
            id: cmpMonthPanelId
            MonthPanel { }
        }

        // Action Buttons
        Pane {
            Layout.fillWidth: true

            Row {
                //layoutDirection: Qt.RightToLeft
                spacing: 5
                Button {
                    text: "OK"
                    flat: true
                    Universal.foreground: Material.primary
                    font.bold: true
                }
                Button {
                    text: "CANCEL"
                    flat: true
                    Universal.foreground: Material.primary
                    font.bold: true
                }
            }
        }
    }
}
