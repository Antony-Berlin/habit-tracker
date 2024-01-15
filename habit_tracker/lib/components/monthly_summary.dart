import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {

  final Map<DateTime, int>? datasets;
  final String  startdate;
  const MonthlySummary({
    super.key,
    required this.startdate,
    required this.datasets
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: HeatMap(
        
        startDate: createDateTimeObject(startdate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(20, 104,81,164),
          2: Color.fromARGB(40, 104,81,164),
          3: Color.fromARGB(60, 104,81,164),
          4: Color.fromARGB(80, 104,81,164),
          5: Color.fromARGB(100, 104,81,164),
          6: Color.fromARGB(120, 104,81,164),
          7: Color.fromARGB(150, 104,81,164),
          8: Color.fromARGB(180, 104,81,164),
          9: Color.fromARGB(220, 104,81,164),
          10: Color.fromARGB(255, 104,81,164),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
        },

      )
      ,
    );
  }
}