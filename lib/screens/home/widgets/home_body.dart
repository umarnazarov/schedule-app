import 'package:flutter/material.dart';
import 'package:flutter_app/common/widgets/secmented_control.dart';
import 'package:flutter_app/common/widgets/linear_gradient_decoration.dart';
import 'package:flutter_app/screens/home/widgets/notes/notes_content.dart';
import 'package:flutter_app/screens/home/widgets/schedule/schedule_content.dart';

Widget buildBody() {
  return Container(
    decoration: linearGradientDecoration(),
    child: const ReusableCupertinoSegmentedControl(
      children: {
        0: Text("Schedule"),
        1: Text("Notes"),
      },
      content: {
        0: ScheduleContent(),
        1: NotesContent(),
      },
    ),
  );
}
