import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
 import QtGraphicalEffects 1.0

Item {

    DateCalculations{
        id:calc
    }
    property var calWidth: mainPageId.width
    property var calHeight: mainPageId.height

    property var yearRectColor: "#edf0f5"
    property var monthRectColor: "transparent"
    property var dayNameRectColor: "transparent"
    property var dayNumbersRectColor: "#edf0f5"

    property var daysNamePointSize: calverhor(60)
    property var monthPointSize: calverhor(17)
    property var yearPointSize: calverhor(40)

    property var gradStop1Color:  "#008dcd"
    property var gradStop2Color : "#00d8eb"


    property alias sat : saturdayId
    property alias sun : sundayId
    property alias mon : mondayId
    property alias tue : tuesdayId
    property alias wed : wednesdayId
    property alias thu : thursdayId
    property alias fri : fridayId

    property var todayDate: calc.today()
    property int todayYear: todayDate[0]
    property int todayMonth: todayDate[1]
    property int todayDay: todayDate[2]
    property var thisMonth: calc.monthName(todayDate[1])
    property int daysInMonth:calc.dayInMonth(todayYear,todayMonth)
    property var firstDayOfMonth: calc.dayNumber(todayYear,todayMonth,1)
    property var todayNumber: calc.dayNumber(todayYear,todayMonth,todayDay)
    property var todayName: calc.dayOfWeek(todayYear,todayMonth,todayDay)


    function verhor(a){
        return mainPageId.height > mainPageId.width ? mainPageId.height/a : mainPageId.width/a;
    }
    function calverhor(a){
        return calendarRect.height > calendarRect.width ? calendarRect.height/a : calendarRect.width/a;
    }
    function nextMonth(){
        if(todayMonth==12)
            todayDate=[todayYear+1,1,1];
        else
            todayDate=[todayYear,todayMonth+1,1];
        destroyCells();
        createCells();

    }
    function previousMonth(){
        if(todayMonth==1)
            todayDate=[todayYear-1,12,1];
        else
            todayDate=[todayYear,todayMonth-1,1];
        destroyCells();
        createCells();
    }
    function selectedCellChanged(x){
        var j;
        var i;
        var counter=0;
        var selectedDay;


        for(i=0;i<6;i++)
        {
            for(j=0;j<7;j++)
            {
                if(x===""||counter>daysInMonth+1)
                    break ;
                gridId.children[j].children[i+1].children[0].children[0].color="black";
                gridId.children[j].children[i+1].border.width=0;
                if(x=== gridId.children[j].children[i+1].children[0].children[0].text)
                {
                    gridId.children[j].children[i+1].children[0].children[0].color="red";
                    gridId.children[j].children[i+1].border.width=1;
                    gridId.children[j].children[i+1].border.color="red";
                    todayDate=[todayYear,todayMonth,x]
                }
                counter++;
            }
        }
    }
    function destroyCells(){
        var i;
        var j ;
        for(i=0;i<7;i++)
        {

            gridId.children[i].children=[gridId.children[i].children[0]];

        }

    }
    function createCells(){
        var i ;
        var j ;
        var counter=1;//day counter



        for(i=0;i<6;i++){
            if(counter<=daysInMonth){
                Qt.createQmlObject('
                                            import QtQuick 2.0
        Rectangle{
            width: gridId.width/7
            height: width
            color:dayNumbersRectColor
            radius:100
            MouseArea{
                anchors.fill: parent
                onClicked: selectedCellChanged(children[0].text)
                Text{
                    text: ""
                    anchors.centerIn: parent
                }
            }
        }
                                        ', sat)
                Qt.createQmlObject('
                                            import QtQuick 2.0
        Rectangle{
            width: gridId.width/7
            height: width
            color:dayNumbersRectColor
            radius:100
            MouseArea{
                anchors.fill: parent
                onClicked: selectedCellChanged(children[0].text)
                Text{
                    text: ""
                    anchors.centerIn: parent
                }
            }
        }
                                        ', sun)
                Qt.createQmlObject('
                                            import QtQuick 2.0
        Rectangle{
            width: gridId.width/7
            height: width
            color:dayNumbersRectColor
            radius:100
            MouseArea{
                anchors.fill: parent
                onClicked: selectedCellChanged(children[0].text)
                Text{
                    text: ""
                    anchors.centerIn: parent
                }
            }
        }
                                        ', mon)
                Qt.createQmlObject('
                                            import QtQuick 2.0
        Rectangle{
            width: gridId.width/7
            height: width
            color:dayNumbersRectColor
            radius:100
            MouseArea{
                anchors.fill: parent
                onClicked: selectedCellChanged(children[0].text)
                Text{
                    text: ""
                    anchors.centerIn: parent
                }
            }
        }
                                        ', tue)
                Qt.createQmlObject('
                                            import QtQuick 2.0
        Rectangle{
            width: gridId.width/7
            height: width
            color:dayNumbersRectColor
            radius:100
            MouseArea{
                anchors.fill: parent
                onClicked: selectedCellChanged(children[0].text)
                Text{
                    text: ""
                    anchors.centerIn: parent
                }
            }
        }
                                        ', wed)
                Qt.createQmlObject('
                                            import QtQuick 2.0
        Rectangle{
            width: gridId.width/7
            height: width
            color:dayNumbersRectColor
            radius:100
            MouseArea{
                anchors.fill: parent
                onClicked: selectedCellChanged(children[0].text)
                Text{
                    text: ""
                    anchors.centerIn: parent
                }
            }
        }
                                        ', thu)
                Qt.createQmlObject('
                                            import QtQuick 2.0
        Rectangle{
            width: gridId.width/7
            height: width
            color:dayNumbersRectColor
            radius:100
            MouseArea{
                anchors.fill: parent
                onClicked: selectedCellChanged(children[0].text)
                Text{
                    text: ""
                    anchors.centerIn: parent
                }
            }
        }
                                        ', fri)
                for (j=0;j<7;j++)
                {
                    if(j===firstDayOfMonth&&counter==1){

                        gridId.children[j].children[i+1].children[0].children[0].text=counter;
                        counter++;

                    }
                    else if(counter>1&&counter<=daysInMonth)
                    {
                        gridId.children[j].children[i+1].children[0].children[0].text=counter;
                        counter++;
                    }
                }
            }

        }
        gridId.children[todayNumber].children[parseInt((todayDay/7)+1)].children[0].children[0].color="red";
        gridId.children[todayNumber].children[parseInt((todayDay/7)+1)].border.width=1;
        gridId.children[todayNumber].children[parseInt((todayDay/7)+1)].border.color="red";


    }
    Rectangle{
        id : calendarRect
        width: calWidth
        height: calHeight
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
            radius:calverhor(20)
            id:yearRectId
            width:parent.width
            height: calverhor(10)
            color:yearRectColor
            Text {
                id: yearTextId
                text: todayName +" "+todayDay+" "+thisMonth+" "+todayYear
                font.pointSize: yearPointSize
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle{
            id:monthRectId
            width: parent.width
            height: calverhor(7)
            color: monthRectColor

            anchors.top:yearRectId.bottom
            Image {
                id: rightNextId
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                source: "qrc:/images/next.png"
                sourceSize.width: parent.width/8
                sourceSize.height: parent.width/8
                MouseArea{
                    anchors.fill: parent
                    onClicked: previousMonth()
                }
            }
            Image {
                id: leftNextId
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                rotation: 180
                source: "qrc:/images/next.png"
                sourceSize.width: parent.width/8
                sourceSize.height: parent.width/8
                MouseArea{
                    anchors.fill: parent
                    onClicked: nextMonth()
                }

            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                id: monthId
                text: thisMonth
                font.pointSize:monthPointSize
            }

        }
        Grid{
            id:gridId
            width: parent.width
            height:parent.height-monthRectId.height-yearRectId.height
            anchors.top: monthRectId.bottom
            columns: 7
            Column{
                id:saturdayId
                Rectangle{
                    width: gridId.width/7
                    height: width
                    color:dayNameRectColor


                    Text{
                        text: calc.dayName(0)
                        font.pointSize: daysNamePointSize
                        anchors.centerIn: parent
                    }

                }
            }
            Column{
                id:sundayId
                Rectangle{
                    width: gridId.width/7
                    height: width
                    color:dayNameRectColor
                    Text{
                        text: calc.dayName(1)
                        font.pointSize: daysNamePointSize
                        anchors.centerIn: parent
                    }
                }
            }
            Column{
                id:mondayId
                Rectangle{
                    width: gridId.width/7
                    height: width
                    color:dayNameRectColor
                    Text{
                        text: calc.dayName(2)
                        font.pointSize: daysNamePointSize
                        anchors.centerIn: parent
                    }
                }
            }
            Column{
                id:tuesdayId
                Rectangle{
                    width: gridId.width/7
                    height: width
                    color:dayNameRectColor
                    Text{
                        text: calc.dayName(3)
                        font.pointSize: daysNamePointSize
                        anchors.centerIn: parent
                    }
                }
            }
            Column{
                id:wednesdayId
                Rectangle{
                    width: gridId.width/7
                    height: width
                    color:dayNameRectColor
                    Text{
                        text: calc.dayName(4)
                        font.pointSize: daysNamePointSize
                        anchors.centerIn: parent
                    }
                }
            }
            Column{
                id:thursdayId
                Rectangle{
                    width: gridId.width/7
                    height: width
                    color:dayNameRectColor
                    Text{
                        text: calc.dayName(5)
                        font.pointSize: daysNamePointSize
                        anchors.centerIn: parent
                    }
                }
            }
            Column{
                id:fridayId
                Rectangle{
                    width: gridId.width/7
                    height: width
                    color:dayNameRectColor
                    Text{
                        text: calc.dayName(6)
                        font.pointSize: daysNamePointSize
                        anchors.centerIn: parent
                    }
                }


            }

        }

        Component.onCompleted: createCells()
    }
}
