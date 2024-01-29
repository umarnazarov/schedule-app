import 'package:flutter/material.dart';
import 'package:flutter_app/common/helpers/format_time.dart';
import 'package:flutter_app/common/models/schedule.dart';
import 'package:flutter_app/common/router/router_names.dart';
import 'package:flutter_app/providers/ScheduleBloc/schedule_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ScheduleRowContentItem extends StatelessWidget {
  final Schedule schedule;
  final String dateString;

  const ScheduleRowContentItem({
    Key? key,
    required this.schedule,
    required this.dateString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
    );

    formatDateMonth(date) {
      String formattedDateMonth = DateFormat('dd MMMM').format(date);
      return formattedDateMonth;
    }

    return GestureDetector(
      onTap: () => context.goNamed(RouterNames.updateSchedule, extra: schedule),
      child: Card(
          color: !schedule.isDone
              ? const Color(0xFF3C1F7B)
              : const Color(0xFF241641),
          child: Container(
            padding: const EdgeInsets.only(
              left: 12.0,
              top: 7.0,
              right: 12.0,
              bottom: 7.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      schedule.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<ScheduleBloc>().add(
                              ScheduleEndScheduleEvent(
                                !schedule.isDone,
                                dateString,
                                schedule.id,
                              ),
                            );
                      },
                      child: schedule.isDone
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                    )
                  ],
                ),
                Divider(
                  color: !schedule.isDone
                      ? const Color(0xFFC68AFF)
                      : const Color(0xFF3C1F7B),
                  height: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Time',
                          style: labelStyle,
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Text(
                            '${formatTimePeriod(schedule.startTime, schedule.endTime)}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Finish',
                          style: labelStyle,
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Text(formatDateMonth(schedule.endTime)),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Place',
                          style: labelStyle,
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Text(schedule.place ?? "Empty"),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Note',
                          style: labelStyle,
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Text(schedule.note ?? "Empty"),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
