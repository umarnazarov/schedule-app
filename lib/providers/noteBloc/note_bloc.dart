import 'package:bloc/bloc.dart';
import 'package:flutter_app/common/models/note.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends HydratedBloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteState()) {
    on<NoteAddNoteEvent>(_onNoteAddNoteEvent);
    on<NoteUpdateNoteEvent>(_onNoteUpdateNoteEvent);
    on<NoteRemoveNoteEvent>(_onNoteRemoveNoteEvent);
    on<NoteFilterNoteEvent>(_onNoteFilterNoteEvent);
  }

  _onNoteAddNoteEvent(NoteAddNoteEvent event, Emitter<NoteState> emit) {
    List<Note> updatedNotes = List.of(state.noteList);
    if (event.note.isPinned) {
      updatedNotes = [event.note, ...updatedNotes];
    } else {
      updatedNotes.add(event.note);
    }
    emit(state.copyWith(noteList: updatedNotes));
  }

  _onNoteUpdateNoteEvent(NoteUpdateNoteEvent event, Emitter<NoteState> emit) {
    List<Note> updatedNotes = List.of(state.noteList);
    final index = updatedNotes.indexWhere((note) => note.id == event.note.id);

    if (index != -1) {
      updatedNotes[index].title = event.note.title;
      updatedNotes[index].isPinned = event.note.isPinned;

      updatedNotes.removeAt(index);

      final insertionIndex = event.note.isPinned ? 0 : updatedNotes.length;

      updatedNotes.insert(insertionIndex, event.note);

      emit(state.copyWith(noteList: updatedNotes));
    }
  }

  _onNoteRemoveNoteEvent(NoteRemoveNoteEvent event, Emitter<NoteState> emit) {
    List<Note> updatedNotes = List.of(state.noteList)
      ..removeWhere((note) => note.id == event.id);
    emit(state.copyWith(noteList: updatedNotes));
  }

  _onNoteFilterNoteEvent(NoteFilterNoteEvent event, Emitter<NoteState> emit) {
    List<Note> filteredNotes;

    filteredNotes = state.noteList
        .where((Note note) => note.title.contains(event.text))
        .toList();

    emit(state.copyWith(noteFilteredList: filteredNotes));
  }

  @override
  NoteState? fromJson(Map<String, dynamic> json) {
    return NoteState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NoteState state) {
    return state.toJson();
  }
}
