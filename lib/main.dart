// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calendar/CalendarTask.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

 
//////////////////////////////
Future<void> main() async {
  // await initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      child: MyApp(),
      path: "assets/translations",
      fallbackLocale: Locale("ar"),
      supportedLocales: [
        // Locale("ar"),
        Locale("en"),
        Locale("ar"),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: CalendarTask(),
      // home:
      //     Directionality(textDirection: ui.TextDirection.ltr, child: caltest()),
    );
  }
}

  /*
       Localizations.override(
        context: context,
        locale: const Locale('ar'),
        child: Builder(builder: (context) {
          return CalendarTest();
        }),
      ),
       */