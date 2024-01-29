import 'package:flutter/material.dart';

Future<TimeOfDay?> pickTime(
    BuildContext context, TimeOfDay intitialTime) async {
  TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: intitialTime,
  );
  return selectedTime;
}
