part of 'schedule_bloc.dart';

@immutable
sealed class ScheduleEvent {}

class ScheduleAddScheduleEvent extends ScheduleEvent {
  final Schedule schedule;

  ScheduleAddScheduleEvent(
    this.schedule,
  );
}

class ScheduleUpdateScheduleEvent extends ScheduleEvent {
  final Schedule schedule;
  ScheduleUpdateScheduleEvent(
    this.schedule,
  );
}

class ScheduleSelectedDayEvent extends ScheduleEvent {
  final DateTime day;

  ScheduleSelectedDayEvent(
    this.day,
  );
}

class ScheduleEndScheduleEvent extends ScheduleEvent {
  final bool isDone;
  final String date;
  final String id;

  ScheduleEndScheduleEvent(
    this.isDone,
    this.date,
    this.id,
  );
}

class ScheduleFilterShedulesEvent extends ScheduleEvent {
  final DateTime date;

  ScheduleFilterShedulesEvent(
    this.date,
  );
}
