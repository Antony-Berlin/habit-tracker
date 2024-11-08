import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  //initate Hive
  await Hive.initFlutter();
  
  //open a box
  await Hive.openBox("Habit_Database");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}