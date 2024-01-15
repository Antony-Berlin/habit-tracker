import 'package:habit_tracker/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';


final _myBox = Hive.box("Habit_Database");

class HabitDatabase{
  List todayHabitList = [];

  //create initial data
  void createDefaultData(){
      todayHabitList = [
        ["Run", false],
        ["Code", false]
      ];

      _myBox.put("START_DATE",todayDateFormatted());
  }
  //load data if already exist
  void loadData(){
    
    if(_myBox.get(todayDateFormatted()) == null){
      todayHabitList = _myBox.get("CURRENT_HABIT_LIST");
      for(int i = 0; i < todayHabitList.length; i++){
        todayHabitList[i][1] = false;
      }
    }
    else{
      todayHabitList = _myBox.get(todayDateFormatted());
    }
  }
  //update database
  void updateDatabase(){
    _myBox.put(todayDateFormatted(), todayHabitList);

    _myBox.put("CURRENT_HABIT_LIST",todayHabitList);
  }
}