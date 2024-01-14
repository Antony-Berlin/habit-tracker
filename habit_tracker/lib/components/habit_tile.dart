import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onchanged;

  const HabitTile({
    super.key,
    required this.habitName,
    required this. habitCompleted,
    required this.onchanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10)
        ),

        child: Row(
          children: [
            Checkbox(
              value: habitCompleted, 
              onChanged: onchanged
            ),
            Text(habitName),
          ],
        ),
      ),
    );
  }
}