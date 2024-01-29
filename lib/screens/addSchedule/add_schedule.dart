import 'package:flutter/material.dart';
import 'package:flutter_app/common/helpers/pick_date.dart';
import 'package:flutter_app/common/helpers/pick_time.dart';
import 'package:flutter_app/common/helpers/show_alert.dart';
import 'package:flutter_app/common/models/schedule.dart';
import 'package:flutter_app/common/services/local_notification.dart';
import 'package:flutter_app/providers/ScheduleBloc/schedule_bloc.dart';
import 'package:flutter_app/screens/addSchedule/widgets/add_schedule_app_bar.dart';
import 'package:flutter_app/screens/addSchedule/widgets/add_schedule_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddSchedule extends StatefulWidget {
  final Schedule? schedule;
  const AddSchedule({super.key, this.schedule});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  late DateTime _finish;
  late DateTime start;
  late TimeOfDay reminder;
  late TextEditingController place;
  late TextEditingController note;
  late TextEditingController _title;
  late bool isChecked = false;
  late ScheduleBloc scheduleBloc;
  late final NotificationService notificationService;

  @override
  void initState() {
    super.initState();
    scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
    if (widget.schedule != null) {
      Schedule schedule = widget.schedule!;
      _finish = schedule.endTime;
      start = schedule.startTime;
      reminder = schedule.reminder;
      place = TextEditingController(text: schedule.place);
      note = TextEditingController(text: schedule.note);
      _title = TextEditingController(text: schedule.title);
      isChecked = schedule.isDone;
    } else {
      start = scheduleBloc.state.selectedDay;
      _finish = scheduleBloc.state.selectedDay.add(const Duration(days: 1));
      reminder = const TimeOfDay(hour: 0, minute: 5);
      place = TextEditingController(text: "");
      note = TextEditingController(text: "");
      _title = TextEditingController(text: "");
      isChecked = false;
    }
    notificationService = NotificationService();
  }

  bool isValidForm() {
    if (_title.text.isEmpty) {
      showAlertDialog(context, 'Please add title for schedule');
      return false;
    } else if (start.isAfter(_finish) || start.isAtSameMomentAs(_finish)) {
      showAlertDialog(context, "Selected time is after finish time");
      return false;
    } else {
      Duration duration = _finish.difference(start);
      int reminderInMinutes = reminder.hour * 60 + reminder.minute;
      Duration reminderDuration = Duration(minutes: reminderInMinutes);
      if (duration < reminderDuration) {
        showAlertDialog(context,
            'Duration between start and finish is more than the reminder time');
        return false;
      }
    }
    return true;
  }

  void handleSaveSchedule() {
    final scheduleBloc = context.read<ScheduleBloc>();
    if (isValidForm()) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(start);
      Schedule newSchedule = Schedule(
        id: const Uuid().v4(),
        title: _title.text,
        startTime: start,
        endTime: _finish,
        note: note.text,
        place: place.text,
        isDone: isChecked,
        reminder: reminder,
      );

      scheduleBloc.add(ScheduleAddScheduleEvent(newSchedule));

      notificationService.showScheduledNotification(
        id: newSchedule.id.hashCode,
        title: _title.text,
        body: "You have scheduled $_title, from $formattedDate",
        scheduledTime: start,
        reminderTime: reminder,
      );
      Navigator.of(context).pop();
    }
  }

  void handleUpdateSchedule() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(start);

    final scheduleBloc = context.read<ScheduleBloc>();
    if (isValidForm()) {
      Schedule updatedSchedule = Schedule(
        id: widget.schedule!.id,
        title: _title.text,
        startTime: start,
        endTime: _finish,
        note: note.text,
        place: place.text,
        isDone: isChecked,
        reminder: reminder,
      );

      scheduleBloc.add(ScheduleUpdateScheduleEvent(updatedSchedule));

      notificationService.updateScheduledNotification(
        id: widget.schedule!.id.hashCode,
        title: _title.text,
        body: "You have scheduled $_title, from $formattedDate",
        scheduledTime: start,
        reminderTime: reminder,
      );
      Navigator.of(context).pop();
    }
  }

  void handleCheck() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  void handleStartFrom() async {
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime(DateTime.now().year + 2);
    DateTime? picked = await pickDateTime(
      context,
      initialDate: start,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (!context.mounted) return;

    if (picked != null) {
      context.read<ScheduleBloc>().add(ScheduleSelectedDayEvent(picked));
      setState(() {
        start = picked;
      });
    }
  }

  void handleFinish() async {
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime(DateTime.now().year + 2);
    DateTime? picked = await pickDateTime(
      context,
      initialDate: _finish,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      setState(() {
        _finish = picked;
      });
    }
  }

  void handleReminder() async {
    TimeOfDay? selectedTime = await pickTime(context, reminder);
    if (selectedTime != null) {
      setState(() {
        reminder = selectedTime;
      });
    }
  }

  String getReminderText() {
    int hour = reminder.hour;
    int minute = reminder.minute;
    if (hour > 0 && minute > 0) {
      return "Before $hour h and $minute m";
    } else if (hour > 0) {
      return "Before $hour h";
    } else if (minute > 0) {
      return "Before $minute m";
    } else {
      return "No reminder";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AddScheduleAppBar(
          handleCheck: handleCheck,
          handleSaveSchedule: widget.schedule != null
              ? handleUpdateSchedule
              : handleSaveSchedule,
          isChecked: isChecked,
        ),
        body: AddScheduleBody(
          title: _title,
          note: note,
          place: place,
          getReminderText: getReminderText,
          handleFinish: handleFinish,
          handleReminder: handleReminder,
          handleStartFrom: handleStartFrom,
          finish: _finish,
          startFrom: start,
        ));
  }
}
