import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleRowLabel extends StatelessWidget {
  final String dateString;

  const ScheduleRowLabel({
    Key? key,
    required this.dateString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(dateString);
    String formattedDay = DateFormat('d').format(parsedDate);
    String formattedMonth = DateFormat('MMM').format(parsedDate);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF3C1F7B),
        border: Border.all(
          color: const Color(0xFF7E64FF),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            formattedDay,
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          Text(
            formattedMonth,
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
