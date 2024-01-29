import 'package:flutter/material.dart';
import 'package:flutter_app/common/router/router_names.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = const TextStyle(
      fontSize: 12,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w600,
    );

    return SpeedDial(
      backgroundColor: const Color(0xFF7e64ff),
      overlayColor: const Color(0xff36364a),
      icon: Icons.add,
      activeIcon: Icons.close,
      spaceBetweenChildren: 24,
      animatedIconTheme: const IconThemeData(size: 22.0),
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.calendar_month_outlined),
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFF7E64FF),
            label: "Schedule",
            labelStyle: labelStyle,
            labelBackgroundColor: Colors.transparent,
            onTap: () => context.goNamed(RouterNames.addSchedule)),
        SpeedDialChild(
          child: const Icon(Icons.note),
          shape: const CircleBorder(),
          backgroundColor: const Color(0xFF7E64FF),
          label: "Note",
          labelStyle: labelStyle,
          labelBackgroundColor: Colors.transparent,
          onTap: () => context.goNamed(RouterNames.addNote),
        ),
      ],
    );
  }
}
