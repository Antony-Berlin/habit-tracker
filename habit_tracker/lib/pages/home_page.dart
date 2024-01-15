import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/components/my_alert_box.dart';
import 'package:habit_tracker/data/Habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");


  @override
  void initState() {
    
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }
    else {
      db.loadData();
    }
    
    db.updateDatabase();

    super.initState();
  }


  //text feild controller
  final _newHabitController = TextEditingController();


  void checkBoxTapped(bool? value, int index){
    setState(() {
      db.todayHabitList[index][1] = value!;
    });
    db.updateDatabase();
  }
//create new habit
  void createNewHabit() {
    showDialog(context: context, builder: (context){
      return MyAlertBox(
        controller: _newHabitController,
        hintText: "enter a habit",
        onCancel: cancelDialogBox,
        onSave: onSave,
      );
    });
  }
//on save function
  void onSave(){
    //add habit to list
    setState(() {
      db.todayHabitList.add([_newHabitController.text, false]);
    });
    
    //clear textfeild
    _newHabitController.clear();
    //pop the dialogbox
    Navigator.of(context).pop();
    db.updateDatabase();
  }
// on cancel function
  void cancelDialogBox(){
    //clear text feild
    _newHabitController.clear();
    //pop dialogbox
    Navigator.of(context).pop();
  }



//edit tha habbit
  void openHabitSettings(int index){
    showDialog(
      context: context,
       builder: (context){
        return MyAlertBox(
        controller: _newHabitController,
        hintText: db.todayHabitList[index][0],
        onCancel: cancelDialogBox,
        onSave: () => saveExistingHabit(index),
        );
       }
    );
  }

  //editing a habit 
  void saveExistingHabit(int index){
    setState(() {
      db.todayHabitList[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }
// delete a habit
  void deleteHabit(int index){
    setState(() {
      db.todayHabitList.removeAt(index);
    });
    db.updateDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton:  MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      body: ListView.builder(
        itemCount: db.todayHabitList.length,
        itemBuilder: (context, index){
          return HabitTile(
            habitName: db.todayHabitList[index][0],
            habitCompleted: db.todayHabitList[index][1],
            onchanged: (value) => checkBoxTapped(value, index),
            settingTapped: (context) => openHabitSettings(index),
            deleteTapped: (context) => deleteHabit(index),
          );
        }
        )      
    );
  }
}