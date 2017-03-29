import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.1
import "logic/persian-date-0.1.8.js" as PersianDate

Pane {
    id: pnArrageDaysId

    property int monthNo: 0

    // Prev Month
    RoundButton {
        id: prevMonthId
        anchors.right: parent.right
        font.family: iconFont
        font.pixelSize: 24
        flat: true
        text: "\ue315"

        onClicked: {
            stkMonthPaneId.replaceEnter = transPrevEnterId
            stkMonthPaneId.replaceExit = transPrevExitId
            stkMonthPaneId.replace(cmpMonthPanelId, {"persianDate": selectedPersianDate.prevMonth(--pnArrageDaysId.monthNo)})
        }
    }
    // Next Month
    RoundButton {
        id: nextMonthId
        anchors.left: parent.left
        font.family: iconFont
        font.pixelSize: 24
        flat: true
        text: "\ue314"

        onClicked: {
            stkMonthPaneId.replaceEnter = transNextEnterId
            stkMonthPaneId.replaceExit = transNextExitId
            stkMonthPaneId.replace(cmpMonthPanelId, {"persianDate": selectedPersianDate.nextMonth(++pnArrageDaysId.monthNo)})
        }
    }
    // Panel
    StackView {
        id: stkMonthPaneId
        anchors.fill: parent
        anchors.topMargin: 14

        initialItem: cmpMonthPanelId

        replaceEnter: transNextEnterId
        replaceExit: transNextExitId
    }

    Transition {
        id: transNextEnterId
        XAnimator { from: -stkMonthPaneId.width; to: 0; duration: 300; easing.type: Easing.OutCubic }
    }

    Transition {
        id: transNextExitId
        XAnimator { from: 0; to: +stkMonthPaneId.width; duration: 200; easing.type: Easing.OutCubic }
    }

    Transition {
        id: transPrevEnterId
        XAnimator { from: stkMonthPaneId.width; to: 0; duration: 300; easing.type: Easing.OutCubic }
    }

    Transition {
        id: transPrevExitId
        XAnimator { from: 0; to: -stkMonthPaneId.width; duration: 200; easing.type: Easing.OutCubic }
    }

    Component {
        id: cmpMonthPanelId
        ColumnLayout {
            id: daysPanelId
            layoutDirection: Qt.RightToLeft
            spacing: 0
            Material.foreground: Qt.rgba(0, 0, 0, 0.87)
            Material.accent: Material.primary

            property var persianDate: selectedPersianDate

            onPersianDateChanged: {
                console.log(persianDate.gDate)
            }

            Label {
                Layout.fillWidth: true
                font.family: fontFamily
                font.pixelSize: 14
                text: persianDate.format("MMMM YYYY")
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }

            Row {
                id: layDaysNameId
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * (1 / 6)
                layoutDirection: Qt.RightToLeft
                spacing: 0
                opacity: 0.5
                Repeater {
                    model: ListModel {
                        ListElement { name: "ش" }
                        ListElement { name: "ی" }
                        ListElement { name: "د" }
                        ListElement { name: "س" }
                        ListElement { name: "چ" }
                        ListElement { name: "پ" }
                        ListElement { name: "ج" }
                    }
                    delegate: Item {
                        width: layDaysNameId.width * (1 / 7)
                        height: parent.height
                        Label {
                            anchors.centerIn: parent
                            font.family: fontFamily
                            font.pixelSize: 12
                            text: name
                        }
                    }
                }
            }
            Column {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 5

                ButtonGroup {
                    id: btnGroupId
                }

                Repeater {
                    model: 5

                    delegate: Row {
                        id: rowWeekId
                        width: parent.width
                        height: parent.height * (1 / 5)
                        spacing: 0
                        layoutDirection: Qt.RightToLeft
                        property int rowNo: index

                        Repeater {
                            model: 7
                            delegate: Item {
                                width: rowWeekId.width * (1 / 7)
                                height: rowWeekId.height

                                RoundButton {
                                    id: btnDayId
                                    property int dayNo: (rowWeekId.rowNo * 7) + index - persianDate.getFirstWeekDayOfMonth() + 2
                                    property var pDate: new PersianDate.PersianDate([persianDate.year(), persianDate.month(), dayNo])

                                    anchors.centerIn: parent
                                    width: parent.width < parent.height ? parent.width : parent.height
                                    height: parent.height
                                    flat: true
                                    font.family: fontFamily
                                    text: String(dayNo).toPersianDigit()
                                    visible: dayNo >= 1 && dayNo <= persianDate.daysInMonth()
                                    padding: 0
                                    checkable: true
                                    ButtonGroup.group: btnGroupId
                                    Material.foreground: hovered || checked ? "white" : Qt.rgba(0, 0, 0, 0.87)
                                    background: Rectangle {
                                        anchors.fill: parent
                                        radius: btnDayId.radius
                                        color: Material.accent
                                        opacity: btnDayId.checked ? 1.0 : btnDayId.hovered && !btnDayId.down ? 0.5 : btnDayId.down ? 1.0 : 0.0
                                    }

                                    Component.onCompleted: {
                                        //console.log("persianDate: " + persianDate.sod().gDate)
                                        //console.log("pDate: " + pDate.sod().gDate)
                                        //console.log("=======" + (pDate.sod().gDate.getTime() === persianDate.sod().gDate.getTime()))
                                        checked = pDate.sod().gDate.getTime() === selectedPersianDate.sod().gDate.getTime()
                                    }

                                    onCheckedChanged: {
                                        if(!checked) return

                                        monthNo = 0
                                        selectedPersianDate = pDate
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
