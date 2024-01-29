import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    title: const Text(
      "on.time",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    actions: [
      const Icon(
        Icons.notifications,
        size: 24.0,
        color: Colors.white,
      ),
      buildPopupMenuButton(),
    ],
  );
}

PopupMenuButton<String> buildPopupMenuButton() {
  return PopupMenuButton<String>(
    iconColor: Colors.white,
    iconSize: 24.0,
    padding: EdgeInsets.zero,
    onSelected: (String str) {},
    itemBuilder: (context) => <PopupMenuItem<String>>[
      const PopupMenuItem<String>(
        value: "1",
        child: Text("Settings"),
      ),
      const PopupMenuItem<String>(
        value: "3",
        child: Text("Rate us"),
      ),
    ],
  );
}
