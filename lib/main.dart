import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/router/router_config.dart';
import 'package:flutter_app/providers/ScheduleBloc/schedule_bloc.dart';
import 'package:flutter_app/providers/noteBloc/note_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          fontFamily: 'Montserrat',
        );

    final darkTheme = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      textTheme: newTextTheme,
    );
    return MultiBlocProvider(
        providers: [
          BlocProvider<ScheduleBloc>(
            create: (context) => ScheduleBloc(),
          ),
          BlocProvider<NoteBloc>(
            create: (context) => NoteBloc(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: darkTheme,
          routerConfig: router,
        ));
  }
}
