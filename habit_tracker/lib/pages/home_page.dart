import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/components/my_alert_box.dart';

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
  //text feild controller
  final _newHabitController = TextEditingController();


  void checkBoxTapped(bool? value, int index){
    setState(() {
      todayHabitList[index][1] = value!;
    });
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
      todayHabitList.add([_newHabitController.text, false]);
    });
    
    //clear textfeild
    _newHabitController.clear();
    //pop the dialogbox
    Navigator.of(context).pop();
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
        hintText: todayHabitList[index][0],
        onCancel: cancelDialogBox,
        onSave: () => saveExistingHabit(index),
        );
       }
    );
  }

  //editing a habit 
  void saveExistingHabit(int index){
    setState(() {
      todayHabitList[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
  }
// delete a habit
  void deleteHabit(int index){
    setState(() {
      todayHabitList.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton:  MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      body: ListView.builder(
        itemCount: todayHabitList.length,
        itemBuilder: (context, index){
          return HabitTile(
            habitName: todayHabitList[index][0],
            habitCompleted: todayHabitList[index][1],
            onchanged: (value) => checkBoxTapped(value, index),
            settingTapped: (context) => openHabitSettings(index),
            deleteTapped: (context) => deleteHabit(index),
          );
        }
        )      
    );
  }
}