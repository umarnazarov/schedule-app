import 'package:flutter/material.dart';
import 'package:flutter_app/common/widgets/linear_gradient_decoration.dart';
import 'package:go_router/go_router.dart';

class Starter extends StatelessWidget {
  const Starter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: linearGradientDecoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "on.time",
                style: TextStyle(fontSize: 58.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 240,
                child: Text(
                  "Make yourself more on time",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.3),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 58, right: 58),
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed("home");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.only(top: 14, bottom: 14)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'START',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
