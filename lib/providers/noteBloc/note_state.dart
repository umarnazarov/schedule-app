part of 'note_bloc.dart';

@immutable
class NoteState {
  final List<Note> noteList;
  final List<Note> noteFilteredList;
  final DateTime date;

  NoteState({
    this.noteList = const [],
    DateTime? date,
    this.noteFilteredList = const [],
  }) : date = date ?? DateTime.now();

  NoteState copyWith({
    List<Note>? noteList,
    DateTime? date,
    List<Note>? noteFilteredList,
  }) {
    return NoteState(
      noteList: noteList ?? this.noteList,
      noteFilteredList: noteFilteredList ?? this.noteFilteredList,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noteList': noteList.map((note) => note.toJson()).toList(),
      'date': date.toIso8601String(),
    };
  }

  factory NoteState.fromJson(Map<String, dynamic> json) {
    final List<dynamic> notesJson = json['noteList'] ?? [];
    final notes = notesJson.map((noteJson) => Note.fromJson(noteJson)).toList();

    return NoteState(
      noteList: notes,
      date: DateTime.parse(json['date']),
    );
  }
}
