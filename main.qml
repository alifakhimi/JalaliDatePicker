import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Jalali DatePicker")

    JalaliDatePicker {
        id: jalaliDatePickerId
        width: 330
        height: 450
    }

    Component.onCompleted: {
        jalaliDatePickerId.open()
    }
}
