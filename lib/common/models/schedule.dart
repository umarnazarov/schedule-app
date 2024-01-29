import 'package:flutter/material.dart';

class Schedule {
  String id;
  String title;
  String? note;
  String? place;
  DateTime startTime;
  DateTime endTime;
  TimeOfDay reminder;
  bool isDone;

  Schedule(
      {required this.title,
      required this.startTime,
      required this.endTime,
      required this.note,
      required this.isDone,
      required this.reminder,
      required this.place,
      required this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'place': place,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isDone': isDone,
      'reminderHour': reminder.hour,
      'reminderMinute': reminder.minute,
    };
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      place: json['place'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      isDone: json['isDone'],
      reminder: TimeOfDay(
        hour: json['reminderHour'],
        minute: json['reminderMinute'],
      ),
    );
  }
}
