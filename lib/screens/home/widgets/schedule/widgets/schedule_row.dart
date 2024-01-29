import 'package:flutter/material.dart';
import 'package:flutter_app/common/models/schedule.dart';
import 'package:flutter_app/screens/home/widgets/schedule/widgets/schedule_row_content.dart';
import 'package:flutter_app/screens/home/widgets/schedule/widgets/schedule_row_label.dart';

class ScheduleRowWidget extends StatelessWidget {
  final MapEntry<String, List<Schedule>> scheduleGroup;

  const ScheduleRowWidget({
    Key? key,
    required this.scheduleGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateString = scheduleGroup.key;

    return Row(
      key: UniqueKey(),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScheduleRowLabel(dateString: dateString),
        const SizedBox(width: 12),
        ScheduleRowContent(scheduleGroup: scheduleGroup),
        const SizedBox(height: 13),
      ],
    );
  }
}
