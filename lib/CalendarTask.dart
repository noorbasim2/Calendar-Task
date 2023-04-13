// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, non_constant_identifier_names

 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:ui' as ui;

class CalendarTask extends StatefulWidget {
  const CalendarTask({super.key});

  @override
  State<CalendarTask> createState() => _CalendarTaskState();
}

class _CalendarTaskState extends State<CalendarTask> {
  List<DateTime> AvailableDate = [
    // SUNDAY
    DateTime(2023, 04, 2),
    DateTime(2023, 04, 9),
    DateTime(2023, 04, 16),
    DateTime(2023, 04, 23),
    DateTime(2023, 04, 30),
    // THU
    DateTime(2023, 04, 6),
    DateTime(2023, 04, 13),
    DateTime(2023, 04, 20),
    DateTime(2023, 04, 27),
  ];
  //
  List<DateTime> NotAvailableDate = [
    // MONDAY
    DateTime(2023, 04, 3),
    DateTime(2023, 04, 10),
    DateTime(2023, 04, 17),
    DateTime(2023, 04, 24),
    // WED
    DateTime(2023, 04, 5),
    DateTime(2023, 04, 12),
    DateTime(2023, 04, 19),
    DateTime(2023, 04, 26),
  ];

  DateRangePickerController _controller = DateRangePickerController();
  dynamic language_code = 'en';
  bool language_bool = false;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _controller.view = DateRangePickerView.month;
   }

 
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
                if (language_bool == true) {
                  language_code = 'en';
                } else {
                  language_code = 'ar';
                }
                language_bool = !language_bool;
                context.locale = Locale(language_code);
                setState(() {});
              },
              icon: Icon(Icons.language)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
        child: Container(
          height: 500,
          child: Card(
            shadowColor: Colors.black,
            elevation: 4,
            child: Column(
              children: [
                Container(
                  width: 240,
                   padding: EdgeInsets.all(17), // inside
                  // margin: EdgeInsets.all(8), // outside
                  child: Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not_Available".tr().toString(),
                            style: TextStyle(fontSize: 16.5)),
                        Icon(Icons.circle,
                            color: Colors.red.shade700, size: 15),
                        SizedBox(width: 12),
                        Text("Available".tr().toString(),
                            style: TextStyle(fontSize: 16.5)),
                        Icon(Icons.circle,
                            color: Colors.green.shade700, size: 15)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SfDateRangePicker(
                    //
                    controller: _controller,
                    cellBuilder: cellBuilder,
                    onSelectionChanged: onSelectionChanged,
                    selectionColor: Colors.transparent, // مهم
                    showNavigationArrow: true,
                    // ====== the header ======
                    monthFormat: "MMM",
                    headerStyle: DateRangePickerHeaderStyle(
                      backgroundColor: Colors.transparent,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                          color: Colors.black, fontSize: 16, letterSpacing: 1),
                    ),

                    // ====== month Cell Style (the current Weekday)======
                    monthCellStyle: DateRangePickerMonthCellStyle(
                        todayTextStyle: TextStyle(color: Colors.black54)),

                    // ====== month View Settings (the Weekdays) ======
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      viewHeaderHeight: 40,
                      firstDayOfWeek: 6,
                      dayFormat: 'E',
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle:
                              TextStyle(color: Colors.black54, fontSize: 15)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    selectedDate = args.value;
    if (!AvailableDate.contains(selectedDate)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Not_Available".tr().toString()),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.black,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Available".tr().toString()),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.black,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating));

      Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
        return theTimePage();
      })));
    }
  }

  Widget cellBuilder(context, cellDetails) {
    bool isAvailableDate = AvailableDate.contains(cellDetails.date);
    bool isNotAvailableDate = NotAvailableDate.contains(cellDetails.date);
    final bool isToday = isSameDay(cellDetails.date, DateTime.now());
    if (_controller.view == DateRangePickerView.month) {
      if (isAvailableDate) {
        return Container(
          margin: EdgeInsets.all(2), // outside
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green.shade700,
              shape: BoxShape.rectangle),
          child: Center(
            child: Text(
              cellDetails.date.day.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (isNotAvailableDate) {
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
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(15),
                )
              : BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(15),
                ),
          child: Center(
            child: Text(
              '${cellDetails.date.day}',
              style: TextStyle(
                color: isToday ? Colors.grey : Colors.grey,
                // fontWeight: isToday ? FontWeight.w400 :  FontWeight.w400,
              ),
            ),
          ),
        );
      }
    } else if (_controller.view == DateRangePickerView.year) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(2), // outside
        width: cellDetails.bounds.width,
        height: cellDetails.bounds.height,
        alignment: Alignment.center,
        child: Text(
          cellDetails.date.month.toString(),
        ),
      );
    } else if (_controller.view == DateRangePickerView.decade) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.green.shade400,
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(2), // outside
          width: cellDetails.bounds.width,
          height: cellDetails.bounds.height,
          alignment: Alignment.center,
          child: Text(cellDetails.date.year.toString()));
    } else {
      final int yearValue = (cellDetails.date.year ~/ 10) * 10;
      return Container(
          decoration: BoxDecoration(
              color: Colors.green.shade400,
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(2), // outside
          width: cellDetails.bounds.width,
          height: cellDetails.bounds.height,
          alignment: Alignment.center,
          child:
              Text(yearValue.toString() + ' - ' + (yearValue + 9).toString()));
    }
  }
  
  theTimePage() {}
}
