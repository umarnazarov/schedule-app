import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/widgets/app_bar.dart';
import 'package:flutter_app/screens/home/widgets/floating_buttons.dart';
import 'package:flutter_app/screens/home/widgets/home_body.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: const FloatingButtons(),
    );
  }
}
