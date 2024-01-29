part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

class NoteAddNoteEvent extends NoteEvent {
  final Note note;

  NoteAddNoteEvent({required this.note});
}

class NoteUpdateNoteEvent extends NoteEvent {
  final Note note;

  NoteUpdateNoteEvent({required this.note});
}

class NoteRemoveNoteEvent extends NoteEvent {
  final String id;

  NoteRemoveNoteEvent({required this.id});
}

class NoteFilterNoteEvent extends NoteEvent {
  final String text;

  NoteFilterNoteEvent({required this.text});
}
