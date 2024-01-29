import 'package:flutter/material.dart';
import 'package:flutter_app/providers/noteBloc/note_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesSearch extends StatelessWidget {
  const NotesSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        context.read<NoteBloc>().add(NoteFilterNoteEvent(text: text));
      },
      style: const TextStyle(color: Colors.black),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
        hintText: 'Search Note',
        hintStyle: TextStyle(fontSize: 16.0, color: Color(0xFF828282)),
        filled: true,
        focusColor: Colors.white,
        fillColor: Color(0xFFCCC2FE),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xFF272430),
        ),
      ),
    );
  }
}
