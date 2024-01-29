import 'package:flutter/material.dart';
import 'package:flutter_app/common/models/schedule.dart';
import 'package:flutter_app/providers/ScheduleBloc/schedule_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCalender extends StatelessWidget {
  AppCalender({super.key});

  List<Schedule> _eventLoader(day, filteredScheduleList) {
    final formattedDay = DateFormat("yyyy-MM-dd").format(day);

    final schedulesForDay = filteredScheduleList.firstWhere(
      (Map<String, dynamic> scheduleMap) =>
          scheduleMap.containsKey(formattedDay),
      orElse: () => <String, List<Schedule>>{formattedDay: []},
    );

    final schedules = schedulesForDay[formattedDay] ?? [];

    return List<Schedule>.from(schedules);
  }

  final HeaderStyle _headerStyle = HeaderStyle(
    formatButtonVisible: false,
    titleCentered: true,
    leftChevronVisible: false,
    rightChevronVisible: false,
    headerPadding: const EdgeInsets.only(top: 28.0, bottom: 28.0),
    titleTextFormatter: (DateTime focusedDay, _) {
      return DateFormat('MMMM yyyy').format(focusedDay).toUpperCase();
    },
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        return Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: state.selectedDay,
              eventLoader: (day) =>
                  _eventLoader(day, state.filteredScheduleList),
              selectedDayPredicate: (DateTime day) =>
                  isSameDay(day, state.selectedDay),
              headerStyle: _headerStyle,
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      bottom: 0,
                      child: Container(
                        height: 2,
                        width: 40,
                        color: Colors.white,
                      ),
                    );
                  }
                  return null;
                },
              ),
              weekendDays: const [DateTime.sunday],
              daysOfWeekHeight: 48,
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) =>
                    DateFormat('EEE').format(date).toUpperCase(),
                weekdayStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                weekendStyle: const TextStyle(
                  color: Color(0xFFFF636C),
                  fontWeight: FontWeight.w700,
                ),
              ),
              calendarStyle: const CalendarStyle(
                weekendTextStyle: TextStyle(color: Color(0xFFFF636C)),
              ),
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              onDaySelected: (DateTime day, _) => context
                  .read<ScheduleBloc>()
                  .add(ScheduleSelectedDayEvent(day)),
              onPageChanged: (focusedDay) {
                final bloc = context.read<ScheduleBloc>();
                bloc.add(ScheduleSelectedDayEvent(focusedDay));
                bloc.add(ScheduleFilterShedulesEvent(focusedDay));
              },
            ),
          ],
        );
      },
    );
  }
}
