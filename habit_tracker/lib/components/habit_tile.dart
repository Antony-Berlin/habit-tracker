import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  
  final Function(bool?)? onchanged;
  final Function(BuildContext)? settingTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile(
      {
        super.key,
        required this.habitName,
        required this.habitCompleted,
        required this.onchanged,
        required this.settingTapped,
        required this.deleteTapped
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Slidable(
        endActionPane:ActionPane(
              motion: const StretchMotion(), 
              children: [
                SlidableAction(
                  onPressed: settingTapped,
                  backgroundColor: Colors.grey.shade800,
                  icon: Icons.settings,
                  borderRadius: BorderRadius.circular(20),    
                ),
                SlidableAction(
                  onPressed: deleteTapped,
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  borderRadius: BorderRadius.circular(20),    
                )
            ]
          ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Checkbox(value: habitCompleted, onChanged: onchanged),
              Container(child: Text(habitName), width: 210,),
              Icon(Icons.arrow_back_outlined, color: Colors.deepPurple,)
            ],
            
          ),
        ),
      ),
    );
  }
}
