import 'package:flutter/cupertino.dart';

class ReusableCupertinoSegmentedControl extends StatefulWidget {
  final Map<int, Widget> children;
  final Map<int, Widget> content;
  final int initialSegment;
  final Function(int)? onValueChanged;

  const ReusableCupertinoSegmentedControl({
    Key? key,
    required this.children,
    required this.content,
    this.initialSegment = 0,
    this.onValueChanged,
  }) : super(key: key);

  @override
  State<ReusableCupertinoSegmentedControl> createState() =>
      _ReusableCupertinoSegmentedControlState();
}

class _ReusableCupertinoSegmentedControlState
    extends State<ReusableCupertinoSegmentedControl> {
  late int currentSegment;

  @override
  void initState() {
    super.initState();
    currentSegment = widget.initialSegment;
  }

  void onValueChanged(int? newValue) {
    setState(() {
      currentSegment = newValue!;
      widget.onValueChanged?.call(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    const segmentedControlMaxWidth = 500.0;

    return SafeArea(
      child: ListView(
        children: [
          const SizedBox(height: 16),
          SizedBox(
            width: segmentedControlMaxWidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 58, right: 58, top: 20),
              child: CupertinoSlidingSegmentedControl<int>(
                children: widget.children,
                onValueChanged: onValueChanged,
                groupValue: currentSegment,
                thumbColor: const Color(0xFF272430),
                backgroundColor: const Color(0xFF3C1F7B),
                padding: const EdgeInsets.all(4.0),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: SingleChildScrollView(child: widget.content[currentSegment]),
          ),
        ],
      ),
    );
  }
}
