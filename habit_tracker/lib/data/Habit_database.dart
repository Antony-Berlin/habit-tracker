// ignore: file_names
import 'package:habit_tracker/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';


final _myBox = Hive.box("Habit_Database");

class HabitDatabase{
  List todayHabitList = [];
  Map<DateTime, int> heatmapDatasets = {};

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

    calculateHabitpercentage();
  print(heatmapDatasets);
    loadHeatMap();
  }

   void calculateHabitpercentage(){
    
    int completedCount = 0;
    for( int i = 0; i < todayHabitList.length; i++){
      if(todayHabitList[i][1]) {
        completedCount++;
      }
    }
    String percent = todayHabitList.isEmpty ? "0.0" : (completedCount/todayHabitList.length).toStringAsFixed(1);

    _myBox.put("PERCENT_SUMMARY_${todayDateFormatted()}", percent);
   }

  void loadHeatMap(){
    DateTime startdate = createDateTimeObject(_myBox.get("START_DATE"));

    int dayBetween = DateTime.now().difference(startdate).inDays;
    print(dayBetween);
    for(int i = 0; i <= dayBetween ; i++){

      DateTime temp = startdate.add(Duration(days: i));
      String yyyymmdd = convertDateTimeToString(temp,);
      double strength = double.parse(
        _myBox.get("PERCENT_SUMMARY_$yyyymmdd") ?? "0.0",
      );
      
      int year = temp.year;
      int month = temp.month;
      int day = temp.day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day) : (10*strength).toInt(),
      };
      print("hello");
      heatmapDatasets.addEntries(percentForEachDay.entries);
      print(heatmapDatasets);
    }
  }
}