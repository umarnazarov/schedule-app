import 'package:uuid/uuid.dart';

class Note {
  String id;
  String title;
  DateTime date;
  bool isPinned;

  Note({
    required this.title,
    required this.isPinned,
    String? id,
    DateTime? date,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now();

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      isPinned: json['isPinned'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'isPinned': isPinned,
    };
  }
}
