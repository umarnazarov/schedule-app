part of 'schedule_bloc.dart';

class ScheduleState {
  final List<Map<String, List<Schedule>>> scheduleList;
  final List<Map<String, List<Schedule>>> filteredScheduleList;
  final DateTime selectedDay;

  ScheduleState({
    required this.scheduleList,
    required this.selectedDay,
    required this.filteredScheduleList,
  });

  ScheduleState copyWith({
    List<Map<String, List<Schedule>>>? scheduleList,
    List<Map<String, List<Schedule>>>? filteredScheduleList,
    DateTime? selectedDay,
  }) {
    return ScheduleState(
      scheduleList: scheduleList ?? this.scheduleList,
      filteredScheduleList: filteredScheduleList ?? this.filteredScheduleList,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scheduleList': scheduleList.map((entry) {
        return {
          for (var key in entry.keys)
            key: entry[key]!.map((schedule) => schedule.toJson()).toList(),
        };
      }).toList(),
      'filteredScheduleList': filteredScheduleList.map((entry) {
        return {
          for (var key in entry.keys)
            key: entry[key]!.map((schedule) => schedule.toJson()).toList(),
        };
      }).toList(),
      'selectedDay': selectedDay.toIso8601String(),
    };
  }

  factory ScheduleState.fromJson(Map<String, dynamic> json) {
    final scheduleList =
        (json['scheduleList'] as List<dynamic>).cast<Map<String, dynamic>>();
    final filteredScheduleList = (json['filteredScheduleList'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    return ScheduleState(
      scheduleList: scheduleList.map((item) {
        return {
          for (var entry in item.entries)
            entry.key: (entry.value as List<dynamic>)
                .map((scheduleJson) =>
                    Schedule.fromJson(scheduleJson as Map<String, dynamic>))
                .toList(),
        };
      }).toList(),
      filteredScheduleList: filteredScheduleList.map((item) {
        return {
          for (var entry in item.entries)
            entry.key: (entry.value as List<dynamic>)
                .map((scheduleJson) =>
                    Schedule.fromJson(scheduleJson as Map<String, dynamic>))
                .toList(),
        };
      }).toList(),
      selectedDay: DateTime.parse(json['selectedDay']),
    );
  }
}
