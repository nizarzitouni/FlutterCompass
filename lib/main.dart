import 'package:compass_app/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    CompassApp(),
  );
}

class CompassApp extends StatelessWidget {
  const CompassApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
