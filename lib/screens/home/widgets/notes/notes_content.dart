import 'package:flutter/material.dart';
import 'package:flutter_app/common/models/note.dart';
import 'package:flutter_app/common/widgets/info-text.dart';
import 'package:flutter_app/providers/noteBloc/note_bloc.dart';
import 'package:flutter_app/screens/home/widgets/notes/widgets/note_item.dart';
import 'package:flutter_app/screens/home/widgets/notes/widgets/notes_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesContent extends StatelessWidget {
  const NotesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        const SizedBox(height: 24),
        const NotesSearch(),
        const SizedBox(height: 24),
        BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
          List<Note> noteList = state.noteFilteredList.isNotEmpty
              ? state.noteFilteredList
              : state.noteList;
          if (noteList.isEmpty) {
            return const Center(
              child: InfoText(
                text: "You did'nt have any notes",
              ),
            );
          }
          return Column(
            children: noteList.map((Note note) {
              return NoteItem(
                note: note,
                key: UniqueKey(),
              );
            }).toList(),
          );
        })
      ],
    ));
  }
}
