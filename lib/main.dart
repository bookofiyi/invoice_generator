import 'package:flutter/material.dart';
import 'package:invoice_generator/constants.dart';
import 'package:invoice_generator/form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice Generator',
      theme: ThemeData(
        primaryColor: kred,
        primarySwatch: Colors.red,
        fontFamily: 'San Francisco',
        appBarTheme: const AppBarTheme(
          backgroundColor: kred,
          elevation: 0,
        ),
      ),

      // theme: ThemeData.light().copyWith(
      //   primaryColor: Colors.redAccent,
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: Colors.redAccent,
      //     elevation: 0,
      //   ),
      // ),

      // theme: ThemeData.dark().copyWith(
      //   primaryColor: const Color(0xFF0A0E21),
      //   scaffoldBackgroundColor: const Color(0xFF0A0E21),
      //   // focusColor: Colors.redAccent,
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: Colors.redAccent,
      //     elevation: 1,
      //   ),
      // colorScheme:
      //     ColorScheme.fromSwatch().copyWith(secondary: Colors.redAccent),
      home: const FormScreen(),
    );
  }
}
