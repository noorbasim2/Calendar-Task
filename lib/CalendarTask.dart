// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:easy_localization/easy_localization.dart' as localized;
import 'dart:ui' as ui;

class CalendarTask extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<CalendarTask> {
  DateRangePickerController _controller = DateRangePickerController();

  dynamic languagecode = 'en';
  bool languagebool = true;
  // String? are_Available;
  // String? selectedColor;
  late DateTime selectdate;
  bool? isAddSpecialDate;

  List<DateTime> specialDatesTime = [
    // // SUNDAY
    // DateTime(2023, 04, 2),
    // DateTime(2023, 04, 9),
    // DateTime(2023, 04, 16),
    // DateTime(2023, 04, 23),
    // DateTime(2023, 04, 30),
    // // THU
    // DateTime(2023, 04, 6),
    // DateTime(2023, 04, 13),
    // DateTime(2023, 04, 20),
    // DateTime(2023, 04, 27),
  ];
  //
  List<DateTime> blackoutDatesTime = [
    // // MONDAY
    // DateTime(2023, 04, 3),
    // DateTime(2023, 04, 10),
    // DateTime(2023, 04, 17),
    // DateTime(2023, 04, 24),
    // // WED
    // DateTime(2023, 04, 5),
    // DateTime(2023, 04, 12),
    // DateTime(2023, 04, 19),
    // DateTime(2023, 04, 26),
  ];

  addNewTask() {
    setState(() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          builder: (BuildContext context) {
            return Container(
                padding: EdgeInsets.all(15), // inside
                margin: EdgeInsets.all(8), // outside
                decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                height: 400,
                child: Column(children: [
                  Text("Are_You".tr().toString(),
                      //  textDirection: ui.TextDirection.ltr,
                      style: TextStyle(fontSize: 25)),
                  RadioListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      secondary: Icon(Icons.event_available),
                      title: Text("Available".tr().toString()),
                      activeColor: Colors.purple,
                      value: true,
                      groupValue: isAddSpecialDate,
                      onChanged: (value) {
                        setState(
                          () {
                            if (specialDatesTime.contains(selectdate)) {
                              specialDatesTime.remove(selectdate);
                              // Navigator.pop(context);
                            } else if (isAddSpecialDate = value!) {
                              specialDatesTime.add(selectdate);
                              isAddSpecialDate = false;
                            }
                          },
                        );
                        _saveDates();
                        Navigator.pop(context);
                      }),
                  //
                  RadioListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      secondary: Icon(Icons.do_disturb),
                      title: Text("Not_Available".tr().toString()),
                      activeColor: Colors.purple,
                      value: true,
                      groupValue: isAddSpecialDate,
                      // value: "Not_Available",
                      // groupValue: are_Available,
                      onChanged: (value) async {
                        setState(
                          () {
                            if (blackoutDatesTime.contains(selectdate)) {
                              blackoutDatesTime.remove(selectdate);

                              // Navigator.pop(context);
                            } else if (isAddSpecialDate = value!) {
                              blackoutDatesTime.add(selectdate);
                              isAddSpecialDate = false;
                            }
                          },
                        );
                        _saveDates();
                        Navigator.pop(context);
                      }),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.purple.shade500,
                        borderRadius: BorderRadius.all(Radius.circular(19))),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close)),
                  )
                ]));
          });
    });
  }

//
  @override
  void initState() {
    super.initState();
    _controller.view = DateRangePickerView.month;
    _loadDates();
  }

  // Load the saved dates from shared preferences
  _loadDates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the special dates list from shared preferences
    List<String> specialDatesTimeStringList =
        prefs.getStringList('specialDatesTime') ?? [];
    specialDatesTime = specialDatesTimeStringList
        .map((dateString) => DateTime.parse(dateString))
        .toList();

    // Retrieve the blackout dates list from shared preferences
    List<String> blackoutDatesTimeStringList =
        prefs.getStringList('blackoutDatesTime') ?? [];
    blackoutDatesTime = blackoutDatesTimeStringList
        .map((dateString) => DateTime.parse(dateString))
        .toList();
    setState(() {});
  }

  // Save the current lists to shared preferences
  _saveDates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the special dates list to a list of string representations
    List<String> specialDatesTimeStringList =
        specialDatesTime.map((date) => date.toIso8601String()).toList();
    prefs.setStringList('specialDatesTime', specialDatesTimeStringList);

    // Convert the blackout dates list to a list of string representations
    List<String> blackoutDatesTimeStringList =
        blackoutDatesTime.map((date) => date.toIso8601String()).toList();
    prefs.setStringList('blackoutDatesTime', blackoutDatesTimeStringList);
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple,
          title: Text("Calendar_Task".tr().toString()),
          actions: [
            IconButton(
                onPressed: () async {
                  setState(() {
                    if (languagebool == true) {
                      languagecode = 'en';
                    } else {
                      languagecode = 'ar';
                    }
                    languagebool = !languagebool;
                    context.locale = Locale("$languagecode");
                  });
                },
                icon: Icon(Icons.language))
          ]),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10), // inside
        // margin: EdgeInsets.all(8), // outside
        color: Colors.purple.shade200,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.purple.shade300,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    padding: EdgeInsets.all(10), // inside
                    // margin: EdgeInsets.all(8), // outside
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Not_Available".tr().toString(),
                              style: TextStyle(fontSize: 16.5)),
                          Icon(Icons.circle,
                              color: Colors.red.shade700, size: 20),
                          SizedBox(width: 12),
                          Text("Available".tr().toString(),
                              style: TextStyle(fontSize: 16.5)),
                          Icon(Icons.circle,
                              color: Colors.green.shade700, size: 20)
                        ]))),
            Container(
              padding: EdgeInsets.all(8), // inside
              // margin: EdgeInsets.all(8), // outside
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              height: 500,
              width: 450,
              child: Builder(builder: (context) {
                return SfDateRangePicker(
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs) {
                      selectdate = DateRangePickerSelectionChangedArgs.value;
                      setState(() {
                        addNewTask();
                      });
                    },
                    controller: _controller,
                    cellBuilder: newMethod,
                    selectionColor: Colors.purple.shade200,
                    selectionTextStyle: TextStyle(color: Colors.black),
                    // backgroundColor: Colors.white, // ✔️
                    showTodayButton: true, // ✔️
                    todayHighlightColor: Colors.purple,
                    // selectionShape: DateRangePickerSelectionShape.rectangle,
                    headerStyle: const DateRangePickerHeaderStyle(
                        // textAlign: TextAlign.left,
                        // backgroundColor: Colors.white,
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 1,
                            wordSpacing: 1)),
                    monthViewSettings: DateRangePickerMonthViewSettings(
                        viewHeaderHeight: 40,
                        firstDayOfWeek: 6,
                        dayFormat: 'E',
                        // blackoutDates: blackoutDatesTime,
                        specialDates: specialDatesTime,
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                            textStyle: TextStyle(
                                color: Colors.black54, fontSize: 16))),
                    monthCellStyle: DateRangePickerMonthCellStyle(
                        // specialDatesTextStyle:  TextStyle(color: Colors.white),
                        // specialDatesDecoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     color: Colors.green,
                        //     shape: BoxShape.rectangle),
                        // blackoutDateTextStyle: TextStyle(color: Colors.white),
                        // blackoutDatesDecoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     color: Colors.red.shade700,
                        //     shape: BoxShape.rectangle),
                        todayTextStyle: TextStyle(color: Colors.purple)));
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget newMethod(context, cellDetails) {
    //  var datetoday = selectdate ;
    bool isSpecialDate = specialDatesTime.contains(cellDetails.date);
    bool isBlackoutDate = blackoutDatesTime.contains(cellDetails.date);
    final bool isToday = isSameDay(cellDetails.date, DateTime.now());

    if (_controller.view == DateRangePickerView.month) {
      if (isSpecialDate) {
        return Container(
            margin: EdgeInsets.all(2), // outside
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green.shade700,
                shape: BoxShape.rectangle),
            child: Center(
                child: Text(cellDetails.date.day.toString(),
                    style: TextStyle(color: Colors.white))));
      } else if (isBlackoutDate) {
        return Container(
            margin: EdgeInsets.all(2), // outside
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red.shade700,
                shape: BoxShape.rectangle),
            child: Center(
                child: Text(cellDetails.date.day.toString(),
                    style: TextStyle(color: Colors.white))));
      } else {
        return Container(
            margin: EdgeInsets.all(2), // outside
            decoration: isToday
                ? BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.purple))
                : null,
            child: Center(
                child: Text('${cellDetails.date.day}',
                    style: TextStyle(
                        color: isToday ? Colors.purple : null,
                        fontWeight: isToday ? FontWeight.bold : null))));
      }
    } else if (_controller.view == DateRangePickerView.year) {
      return Container(
          margin: EdgeInsets.all(2), // outside
          width: cellDetails.bounds.width,
          height: cellDetails.bounds.height,
          alignment: Alignment.center,
          child: Text(cellDetails.date.month.toString()));
    } else if (_controller.view == DateRangePickerView.decade) {
      return Container(
          margin: EdgeInsets.all(2), // outside
          width: cellDetails.bounds.width,
          height: cellDetails.bounds.height,
          alignment: Alignment.center,
          child: Text(cellDetails.date.year.toString()));
    } else {
      final int yearValue = (cellDetails.date.year ~/ 10) * 10;
      return Container(
          margin: EdgeInsets.all(2), // outside
          width: cellDetails.bounds.width,
          height: cellDetails.bounds.height,
          alignment: Alignment.center,
          child:
              Text(yearValue.toString() + ' - ' + (yearValue + 9).toString()));
    }
  }
}
