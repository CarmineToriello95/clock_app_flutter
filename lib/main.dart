import 'package:clock_app/di_config.dart';
import 'package:clock_app/features/clock/presentation/pages/clock_page.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: 'Flutter Demo', home: ClockPage());
}
