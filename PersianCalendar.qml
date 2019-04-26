import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import "date-conversion.js" as DateConversion

Item {
    property var calWidth: parent.width
    property var calHeight: parent.height

    property color yearRectColor: "#edf0f5"
    property color monthRectColor: "transparent"
    property color dayNameRectColor: "transparent"
    property color dayNumberBackColor: "#edf0f5"
    property color daysTextColor: "black"
    property color selectedDayColor: "red"
    property int selectedDayBorderWidth: 3

    property var daysNamePointSize: calverhor(60) === 0 ? application.font.pixelSize : calverhor(60)
    property var monthPointSize: calverhor(17) === 0 ? application.font.pixelSize : calverhor(17)
    property var yearPointSize: calverhor(40) === 0 ? application.font.pixelSize : calverhor(40)

    property color gradStop1Color:  "#008dcd"
    property color gradStop2Color : "#00d8eb"

    property var sat
    property var sun
    property var mon
    property var tue
    property var wed
    property var thu
    property var fri

    property var currentDate: DateConversion.today()
    property int todayYear: currentDate["y"]
    property int todayMonth: currentDate["m"]
    property int todayDay: currentDate["d"]
    property var thisMonth: DateConversion.monthName(currentDate["m"])
    property int daysInMonth: DateConversion.dayInMonth(todayYear, todayMonth)
    property var firstDayOfMonth: DateConversion.dayNumber(todayYear, todayMonth,1)
    property var todayNumber: DateConversion.dayNumber(todayYear, todayMonth, todayDay)
    property var todayName: DateConversion.dayOfWeek(todayYear, todayMonth, todayDay)

    property int cellMax: gridId.height/7
    property int maxPointSize: 20

    signal dateSelected

    clip: true

    function calverhor(a) {
        return calHeight > calWidth ? calHeight / a : calWidth / a
    }

    function nextMonth() {
        if (todayMonth == 12)
            currentDate = {"y": todayYear + 1, "m": 1, "d": 1}
        else
            currentDate = {"y": todayYear, "m": todayMonth + 1, "d": 1}

        destroyCells()
        createCells()

    }

    function previousMonth() {
        if (todayMonth == 1)
            currentDate = {"y": todayYear - 1, "m": 12, "d": 1}
        else
            currentDate = {"y": todayYear, "m": todayMonth - 1, "d": 1}

        destroyCells()
        createCells()
    }

    function selectedCellChanged(x) {
        var j;
        var i;
        var counter = -firstDayOfMonth;
        var selectedDay;

        for (i = 0; i < 6; i++) {
            for (j = 0; j < 7; j++) {
                if (x === "" || counter > daysInMonth + 1)
                    break;

                if (x === gridId.children[j].children[i + 1].children[0].children[0].text) {
                    gridId.children[j].children[i + 1].children[0].children[0].color = selectedDayColor
                    gridId.children[j].children[i + 1].border.color = selectedDayColor
                    currentDate = {"y": todayYear, "m": todayMonth, "d": DateConversion.fromFarsiNumber(x)}
                } else {
                    gridId.children[j].children[i + 1].children[0].children[0].color = daysTextColor
                    gridId.children[j].children[i + 1].border.color = dayNumberBackColor
                }

                counter++;
            }
        }
    }

    function destroyCells() {
        var i;
        var j;

        for (i = 0; i < 7; i++)
        {
            for (j = 1; j < gridId.children[i].children.length; j++)
                gridId.children[i].children[j].anchors.horizontalCenter = undefined

            gridId.children[i].children = gridId.children[i].children[0]
        }
    }

    function createColumns() {
        sat = monthColumns.createObject(gridId, {"text": DateConversion.dayName(0)})
        sun = monthColumns.createObject(gridId, {"text": DateConversion.dayName(1)})
        mon = monthColumns.createObject(gridId, {"text": DateConversion.dayName(2)})
        tue = monthColumns.createObject(gridId, {"text": DateConversion.dayName(3)})
        wed = monthColumns.createObject(gridId, {"text": DateConversion.dayName(4)})
        thu = monthColumns.createObject(gridId, {"text": DateConversion.dayName(5)})
        fri = monthColumns.createObject(gridId, {"text": DateConversion.dayName(6)})
    }

    function createCells() {
        var i;
        var j;
        var counter = 1; //day counter

        for (i = 0; i < 6; i++) {
            if (counter <= daysInMonth) {
                calendarCell.createObject(sat)
                calendarCell.createObject(sun)
                calendarCell.createObject(mon)
                calendarCell.createObject(tue)
                calendarCell.createObject(wed)
                calendarCell.createObject(thu)
                calendarCell.createObject(fri)

                for (j = 0; j < 7; j++) {
                    if ((j === firstDayOfMonth && counter === 1) ||
                            (counter > 1 && counter <= daysInMonth)) {
                        gridId.children[j].children[i + 1].children[0].children[0].text = DateConversion.toFarsiNumber(counter);
                        counter++;
                    } else {
                        gridId.children[j].children[i + 1].children[0].children[0].text = ""
                    }

                    gridId.children[j].children[i + 1].children[0].children[0].color = daysTextColor
                    gridId.children[j].children[i + 1].border.color = dayNumberBackColor
                }
            }

        }

        if (gridId.children[todayNumber].children[parseInt((todayDay / 7) + 1)].children[0].children[0].text !== "") {
            gridId.children[todayNumber].children[parseInt((todayDay / 7) + 1)].children[0].children[0].color = selectedDayColor;
            gridId.children[todayNumber].children[parseInt((todayDay / 7) + 1)].border.color = selectedDayColor;
        } else {
            gridId.children[todayNumber].children[parseInt((todayDay / 7) + 2)].children[0].children[0].color = selectedDayColor;
            gridId.children[todayNumber].children[parseInt((todayDay / 7) + 2)].border.color = selectedDayColor;
        }
    }

    implicitHeight: calendarRect.height
    implicitWidth: calendarRect.width

    Component {
        id: calendarCell

        Rectangle {
            width: Math.min(cellMax, calverhor(7)) - 3
            height: width
            border.color: dayNumberBackColor
            border.width: selectedDayBorderWidth
            color: dayNumberBackColor
            radius: width
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    selectedCellChanged(children[0].text)
                }

                onClicked: {
                    selectedCellChanged(children[0].text)
                    dateSelected()
                }

                onDoubleClicked: {
                    selectedCellChanged(children[0].text)
                    dateSelected()
                }

                Text {
                    text: ""
                    font.pointSize: yearPointSize
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    Component {
        id: monthColumns

        Column {
            id: column
            property alias text: text.text

            spacing: 3

            Rectangle {
                width: gridId.width/7
                height: calverhor(12)
                color: dayNameRectColor

                Text {
                    id: text
                    text: column.text
                    font.pointSize: daysNamePointSize
                    anchors.centerIn: parent
                }

            }
        }
    }

    Rectangle{
        id: calendarRect
        width: calWidth
        height: calverhor(1)

        gradient : Gradient {
            GradientStop {
                position: 0.0
                color:gradStop1Color
            }
            GradientStop {
                position: 1.0
                color: gradStop2Color
            }
        }

        Rectangle{
            radius: calverhor(20)
            id: yearRectId
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 5
            height: calverhor(10)
            color: yearRectColor

            Text {
                id: yearTextId
                text: DateConversion.dayOfWeek(todayYear, todayMonth, todayDay) +
                      " " +
                      DateConversion.toFarsiNumber(todayDay) +
                      " " +
                      DateConversion.monthName(todayMonth) +
                      " " +
                      DateConversion.toFarsiNumber(todayYear)
                font.pointSize: Math.min(yearPointSize, maxPointSize)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id:monthRectId
            width: parent.width
            height: calverhor(7)
            color: monthRectColor
            anchors.top: yearRectId.bottom

            Image {
                id: rightNextId
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                rotation: LayoutMirroring.enabled ? 180 : 0
                source: "qrc:/images/next.png"
                sourceSize.width: parent.width / 8
                sourceSize.height: parent.width / 8

                MouseArea{
                    anchors.fill: parent
                    onClicked: nextMonth()
                }
            }

            Image {
                id: leftNextId
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                rotation: LayoutMirroring.enabled ? 0 : 180
                source: "qrc:/images/next.png"
                sourceSize.width: parent.width / 8
                sourceSize.height: parent.width / 8

                MouseArea{
                    anchors.fill: parent
                    onClicked: previousMonth()
                }

            }

            Text {
                id: monthId
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: thisMonth
                font.pointSize:Math.min(monthPointSize,maxPointSize*2)
            }
        }

        Grid {
            id: gridId
            width: parent.width
            height: parent.height - monthRectId.height - yearRectId.height
            anchors.top: monthRectId.bottom
            columns: 7

            Component.onCompleted: {
                createColumns()
                createCells()
            }
        }
    }
}
