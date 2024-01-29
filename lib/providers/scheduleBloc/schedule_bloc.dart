import 'package:bloc/bloc.dart';
import 'package:flutter_app/common/models/schedule.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends HydratedBloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc()
      : super(
          ScheduleState(
            filteredScheduleList: [],
            scheduleList: [],
            selectedDay: DateTime.now(),
          ),
        ) {
    on<ScheduleAddScheduleEvent>(_onScheduleAddScheduleEvent);
    on<ScheduleUpdateScheduleEvent>(_onScheduleUpdateScheduleEvent);
    on<ScheduleSelectedDayEvent>(_onScheduleSelectedDayEvent);
    on<ScheduleEndScheduleEvent>(_onScheduleEndScheduleEvent);
    on<ScheduleFilterShedulesEvent>(_onScheduleFilterShedulesEvent);
  }

  void _onScheduleAddScheduleEvent(
    ScheduleAddScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) {
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(event.schedule.startTime);

    Map<String, List<Schedule>> newEntry = {
      formattedDate: [event.schedule]
    };

    List<Map<String, List<Schedule>>> updatedScheduleList =
        List.of(state.scheduleList);
    int index =
        updatedScheduleList.indexWhere((map) => map.containsKey(formattedDate));

    if (index != -1) {
      updatedScheduleList[index][formattedDate]!.add(event.schedule);
    } else {
      updatedScheduleList.add(newEntry);
    }

    updatedScheduleList.sort((a, b) {
      final aKey = a.keys.first;
      final bKey = b.keys.first;
      return aKey.compareTo(bKey);
    });

    emit(state.copyWith(scheduleList: updatedScheduleList));

    add(ScheduleFilterShedulesEvent(state.selectedDay));
  }

  void _onScheduleUpdateScheduleEvent(
    ScheduleUpdateScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) {
    List<Map<String, List<Schedule>>> updatedScheduleList =
        List.of(state.scheduleList);

    String changedDate =
        DateFormat('yyyy-MM-dd').format(event.schedule.startTime);

    for (var scheduleMap in updatedScheduleList) {
      scheduleMap.update(
        scheduleMap.keys.first,
        (schedules) => schedules
          ..removeWhere((schedule) => schedule.id == event.schedule.id),
      );
    }

    int index = updatedScheduleList
        .indexWhere((element) => element.containsKey(changedDate));

    if (index != -1) {
      List<Schedule> schedules = updatedScheduleList[index][changedDate]!;
      int scheduleIndex = schedules.indexWhere(
        (schedule) => schedule.id == event.schedule.id,
      );

      if (scheduleIndex != -1) {
        schedules[scheduleIndex] = event.schedule;

        if (schedules.isEmpty) {
          updatedScheduleList.removeAt(index);
        }
      } else {
        updatedScheduleList[index][changedDate]!.add(event.schedule);
      }
    } else {
      add(ScheduleAddScheduleEvent(event.schedule));
    }

    updatedScheduleList.removeWhere(
        (element) => element.values.every((schedules) => schedules.isEmpty));

    emit(state.copyWith(scheduleList: updatedScheduleList));
    add(ScheduleFilterShedulesEvent(event.schedule.startTime));
  }

  void _onScheduleSelectedDayEvent(
      ScheduleSelectedDayEvent event, Emitter<ScheduleState> emit) {
    emit(state.copyWith(selectedDay: event.day));
  }

  void _onScheduleEndScheduleEvent(
      ScheduleEndScheduleEvent event, Emitter<ScheduleState> emit) {
    String date = event.date;
    List<Map<String, List<Schedule>>> updatedScheduleList =
        List.of(state.scheduleList);

    int index = updatedScheduleList.indexWhere((map) => map.containsKey(date));

    if (index != -1) {
      updatedScheduleList[index][date]?.forEach((schedule) {
        if (schedule.id == event.id) {
          schedule.isDone = event.isDone;
          return;
        }
      });
    }

    emit(state.copyWith(scheduleList: updatedScheduleList));
  }

  void _onScheduleFilterShedulesEvent(
      ScheduleFilterShedulesEvent event, Emitter<ScheduleState> emit) {
    List<Map<String, List<Schedule>>> filteredSchedules = [];
    for (var scheduleMap in state.scheduleList) {
      scheduleMap.forEach((key, value) {
        String eventDate = DateFormat("yyyy-MM").format(event.date).toString();
        String keyDate =
            DateFormat("yyyy-MM").format(DateTime.parse(key)).toString();
        if (keyDate == eventDate) {
          filteredSchedules.add({key: value});
        }
      });
    }

    emit(state.copyWith(filteredScheduleList: filteredSchedules));
  }

  @override
  ScheduleState fromJson(Map<String, dynamic> json) {
    return ScheduleState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ScheduleState state) {
    return state.toJson();
  }
}
