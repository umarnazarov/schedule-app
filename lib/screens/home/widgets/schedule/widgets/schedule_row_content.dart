import 'package:flutter/material.dart';
import 'package:flutter_app/common/models/schedule.dart';
import 'package:flutter_app/screens/home/widgets/schedule/widgets/schedule_row_content_item.dart';

class ScheduleRowContent extends StatelessWidget {
  final MapEntry<String, List<Schedule>> scheduleGroup;
  const ScheduleRowContent({
    Key? key,
    required this.scheduleGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: scheduleGroup.value.map((schedule) {
          return ScheduleRowContentItem(
            schedule: schedule,
            dateString: scheduleGroup.key,
          );
        }).toList(),
      ),
    );
  }
}
