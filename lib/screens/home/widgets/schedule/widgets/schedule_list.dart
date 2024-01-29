import 'package:flutter/material.dart';
import 'package:flutter_app/common/models/schedule.dart';
import 'package:flutter_app/screens/home/widgets/schedule/widgets/schedule_row.dart';

class ScheduleList extends StatelessWidget {
  final List<Map<String, List<Schedule>>> schedules;
  const ScheduleList({
    Key? key,
    required this.schedules,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: schedules.map((scheduleMap) {
        return Column(
          key: UniqueKey(),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: scheduleMap.entries.map((entry) {
            return ScheduleRowWidget(scheduleGroup: entry);
          }).toList(),
        );
      }).toList(),
    );
  }
}
