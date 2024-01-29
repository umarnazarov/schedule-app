import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeftRightText extends StatelessWidget {
  final String leftText;
  final dynamic rightText;
  final Function() callback;

  const LeftRightText({
    Key? key,
    required this.leftText,
    required this.rightText,
    required this.callback,
  }) : super(key: key);

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('E, d MMM y hh:mm a');
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            leftText,
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.3),
          ),
        ),
        GestureDetector(
          onTap: callback,
          child: Row(
            children: [
              Text(
                rightText is DateTime ? formatDateTime(rightText) : rightText,
                style: const TextStyle(
                  fontSize: 12.0,
                  letterSpacing: -0.3,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF828282),
                ),
              ),
              const Icon(
                Icons.arrow_right_outlined,
                color: Color(0xFF828282),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
