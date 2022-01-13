import 'package:breath/src/presentation/views/home_page.dart';

import 'package:flutter/material.dart';

const kApplicationName = "Mindful Breathing";

class MindfulBreathingApp extends StatelessWidget {
  const MindfulBreathingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kApplicationName,
      theme: ThemeData(
        primarySwatch: Colors.grey,
          primaryColor: Colors.black,
          appBarTheme: const AppBarTheme(
            color: Colors.white
          ),
          primaryTextTheme: const TextTheme(
            headline3: TextStyle(
              color: Colors.black
            ),
            headline5: TextStyle(
                color: Colors.black
            )
          ),
      ),
      home: const HomePage(title: kApplicationName),
    );
  }
}