import 'package:flutter/material.dart';
import 'package:flutter_app/common/widgets/app_text_field.dart';
import 'package:flutter_app/common/widgets/left_right_text.dart';
import 'package:flutter_app/common/widgets/linear_gradient_decoration.dart';

class AddScheduleBody extends StatelessWidget {
  final DateTime startFrom;
  final DateTime finish;
  final TextEditingController title;
  final TextEditingController place;
  final TextEditingController note;
  final Function() handleStartFrom;
  final Function() handleFinish;
  final Function() handleReminder;
  final Function() getReminderText;
  const AddScheduleBody({
    Key? key,
    required this.handleStartFrom,
    required this.handleFinish,
    required this.handleReminder,
    required this.getReminderText,
    required this.startFrom,
    required this.finish,
    required this.note,
    required this.title,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: linearGradientDecoration(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Schedule",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              hintMsg: 'Meeting with Anomali Team',
              textController: title,
            ),
            Column(
              children: [
                const SizedBox(height: 24),
                LeftRightText(
                  callback: handleStartFrom,
                  leftText: "Start from",
                  rightText: startFrom,
                ),
                const SizedBox(height: 24),
                LeftRightText(
                  callback: handleFinish,
                  leftText: "Finish",
                  rightText: finish,
                ),
                const SizedBox(height: 24),
                LeftRightText(
                    callback: handleReminder,
                    leftText: "Reminder",
                    rightText: getReminderText()),
                const SizedBox(height: 24),
                AppTextField(
                  hintMsg: 'Place',
                  textController: place,
                ),
                const SizedBox(height: 24),
                AppTextField(
                  hintMsg: 'Note',
                  textController: note,
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
