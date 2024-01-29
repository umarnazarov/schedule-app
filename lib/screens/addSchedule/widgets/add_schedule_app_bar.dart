import 'package:flutter/material.dart';

class AddScheduleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isChecked;
  final Function() handleSaveSchedule;
  final Function() handleCheck;

  const AddScheduleAppBar(
      {Key? key,
      required this.isChecked,
      required this.handleSaveSchedule,
      required this.handleCheck})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: handleCheck,
            icon: Icon(
              size: 24.0,
              isChecked ? Icons.check_box : Icons.check_box_outlined,
            )),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: handleSaveSchedule,
            icon: const Icon(
              Icons.done,
              size: 24.0,
            ),
          ),
        ),
      ],
    );
  }
}
