// ignore_for_file: sort_child_properties_last

// import 'package:calendar/important.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class theTimePage extends StatefulWidget {
  const theTimePage({super.key});

  @override
  State<theTimePage> createState() => _theTimePageState();
}

class _theTimePageState extends State<theTimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.purple,
            centerTitle: true,
            title: Text("The Time Page".tr().toString())),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
          child: Container(
            color: Colors.transparent,
            // width: 370,
            height: 380,
            child: Card(
              elevation: 5,
              // color: Colors.amber,
              shadowColor: Colors.black,
              child: Column(
                children: [
                  Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                  row_Time(
                    "8:00 ص".tr().toString(),
                    "8:30 ص".tr().toString(),
                    "9:00 ص".tr().toString(),
                    "9:30 ص".tr().toString(),
                    Colors.red.shade700,
                    Colors.green.shade700,
                  ),
                  row_Time(
                    "10:00 ص".tr().toString(),
                    "10:30 ص".tr().toString(),
                    "11:00 ص".tr().toString(),
                    "11:30 ص".tr().toString(),
                    Colors.red.shade700,
                    Colors.green.shade700,
                  ),
                  row_Time(
                    "12:00 ظ".tr().toString(),
                    "12:30 ظ".tr().toString(),
                    "1:00 ظ".tr().toString(),
                    "1:30 ظ".tr().toString(),
                    Colors.red.shade700,
                    Colors.green.shade700,
                  ),
                  row_Time(
                    "2:00 ظ".tr().toString(),
                    "2:30 ظ".tr().toString(),
                    "3:00 ظ".tr().toString(),
                    "3:30 ظ".tr().toString(),
                    Colors.red.shade700,
                    Colors.green.shade700,
                  ),
                  row_Time(
                    "4:00 م".tr().toString(),
                    "4:30 م".tr().toString(),
                    "5:00 م".tr().toString(),
                    "5:30 م".tr().toString(),
                    Colors.red.shade700,
                    Colors.green.shade700,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container_time(
                          "6:00 م".tr().toString(), Colors.red.shade700,
                          width: 160),
                      Container_time(
                          "6:30 م".tr().toString(), Colors.red.shade700,
                          width: 160),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: cro,
                    children: [
                      MaterialButton(
                        child: Text("the_previous".tr().toString()),
                        color: Colors.blue.shade900,
                        textColor: Colors.white,
                        elevation: 5,
                        splashColor: Colors.red,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      MaterialButton(
                        child: Row(
                          children: [
                            Text("Book_the_appointment".tr().toString()),
                            // Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                        color: Colors.blue.shade900,
                        textColor: Colors.white,
                        elevation: 5,
                        // height: 20,
                        // minWidth: 100,
                        splashColor: Colors.red,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),

                      // SizedBox(width: 70,),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget row_Time(String timeText1, timeText2, timeText3, timeText4,
      Color colorTimeRed, colorTimeGreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container_time(timeText1, colorTimeGreen),
        Container_time(timeText2, colorTimeRed),
        Container_time(timeText3, colorTimeGreen),
        Container_time(timeText4, colorTimeRed),
      ],
    );
  }

  Container Container_time(timeText, colortime, {double width = 75}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5), // inside
      margin: EdgeInsets.all(5), // outside
      width: width,
      height: 30,
      decoration: BoxDecoration(
          color: colortime, borderRadius: BorderRadius.circular(5)),
      child: Text(
        "$timeText",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
