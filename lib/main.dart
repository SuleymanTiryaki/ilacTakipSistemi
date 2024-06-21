import 'package:flutter/material.dart';
import 'homepage.dart';
import 'textfield.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: Locale("tr","TR"),
    home:Homepage(),
  );
  }
}