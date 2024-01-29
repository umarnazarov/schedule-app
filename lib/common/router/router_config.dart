import 'package:flutter_app/common/models/note.dart';
import 'package:flutter_app/common/models/schedule.dart';
import 'package:flutter_app/screens/noteForm/note_form_screen.dart';
import 'package:flutter_app/screens/addSchedule/add_schedule.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/starter/starter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/common/router/router_names.dart';

GoRouter router = GoRouter(
  initialLocation: '/starter',
  routes: [
    GoRoute(
        name: RouterNames.home,
        path: '/main',
        builder: (context, state) => const Home(),
        routes: [
          GoRoute(
            name: RouterNames.addSchedule,
            path: 'add-schedule',
            builder: (context, state) => const AddSchedule(),
          ),
          GoRoute(
            name: RouterNames.updateSchedule,
            path: 'update-schedule',
            builder: (context, state) => AddSchedule(
              schedule: state.extra as Schedule,
            ),
          ),
          GoRoute(
            name: RouterNames.addNote,
            path: 'add-note',
            builder: (context, state) => const AddNote(),
          ),
          GoRoute(
            name: RouterNames.updateNote,
            path: 'update-note',
            builder: (context, state) => AddNote(note: state.extra as Note),
          ),
        ]),
    GoRoute(
      name: RouterNames.starter,
      path: '/starter',
      builder: (context, state) => const Starter(),
    ),
  ],
);
