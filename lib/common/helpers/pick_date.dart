import 'package:flutter/material.dart';
import 'package:flutter_app/common/helpers/pick_time.dart';

Future<DateTime?> pickDateTime(
  BuildContext context, {
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (!context.mounted) return null;
  if (selectedDate != null) {
    TimeOfDay? selectedTime = await pickTime(context, TimeOfDay.now());
    selectedDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime!.hour,
      selectedTime.minute,
    );
    return selectedDate;
  }

  return null;
}
