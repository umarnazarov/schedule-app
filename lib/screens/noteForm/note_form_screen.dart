import 'package:flutter/material.dart';
import 'package:flutter_app/common/models/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/providers/noteBloc/note_bloc.dart';

class AddNote extends StatefulWidget {
  final Note? note;
  const AddNote({Key? key, this.note}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late bool _isPinned;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _isPinned = widget.note!.isPinned;
    } else {
      _titleController = TextEditingController(text: "");
      _isPinned = false;
    }
  }

  void handleTextPin() {
    setState(() {
      _isPinned = !_isPinned;
    });
  }

  void handleSave() {
    final scheduleBloc = context.read<NoteBloc>();
    Note newNote = Note(title: _titleController.text, isPinned: _isPinned);
    scheduleBloc.add(NoteAddNoteEvent(note: newNote));
    Navigator.of(context).pop();
  }

  void handleUpdateSave() {
    final scheduleBloc = context.read<NoteBloc>();
    Note updatedNote = Note(
      id: widget.note!.id,
      title: _titleController.text,
      isPinned: _isPinned,
    );
    scheduleBloc.add(NoteUpdateNoteEvent(note: updatedNote));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Transform.rotate(
            angle: 3.14 / 4,
            child: IconButton(
              onPressed: handleTextPin,
              icon: _isPinned
                  ? const Icon(Icons.push_pin)
                  : const Icon(Icons.push_pin_outlined),
            ),
          ),
          BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
            return Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () =>
                    widget.note != null ? handleUpdateSave() : handleSave(),
                icon: const Icon(
                  size: 24.0,
                  Icons.check,
                ),
              ),
            );
          }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        color: const Color(0xFF7E64FF),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Title",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                ),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: "Your text",
                  ),
                  scrollPadding: const EdgeInsets.all(20.0),
                  keyboardType: TextInputType.multiline,
                  maxLines: 99999,
                  autofocus: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
