import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/my_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List todayHabitList = [
    ["morning run", false],
    ["read books", false]
  ];

  void checkBoxTapped(bool? value, int index){
    setState(() {
      todayHabitList[index][1] = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: const MyFloatingActionButton(),
      body: ListView.builder(
        itemCount: todayHabitList.length,
        itemBuilder: (context, index){
          return HabitTile(
            habitName: todayHabitList[index][0],
            habitCompleted: todayHabitList[index][1],
            onchanged: (value) => checkBoxTapped(value, index),
          );
        }
        )      
    );
  }
}