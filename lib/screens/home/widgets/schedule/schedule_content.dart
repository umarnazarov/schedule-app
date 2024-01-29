import 'package:flutter/material.dart';
import 'package:flutter_app/common/widgets/info-text.dart';
import 'package:flutter_app/providers/ScheduleBloc/schedule_bloc.dart';
import 'package:flutter_app/screens/home/widgets/app_calender.dart';
import 'package:flutter_app/screens/home/widgets/schedule/widgets/schedule_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleContent extends StatelessWidget {
  const ScheduleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCalender(),
        const SizedBox(height: 32),
        const Text(
          "Schedule",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 32),
        BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state.filteredScheduleList.isNotEmpty) {
              final filteredScheduleList = state.filteredScheduleList;
              return ScheduleList(
                schedules: filteredScheduleList,
              );
            } else {
              return const Center(
                child: InfoText(
                  text: "You did'nt have any schedules",
                ),
              );
            }
          },
        )
      ],
    );
  }
}
