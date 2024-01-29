import 'package:flutter/material.dart';
import 'package:flutter_app/common/models/note.dart';
import 'package:flutter_app/common/router/router_names.dart';
import 'package:flutter_app/providers/noteBloc/note_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Dismissible(
          direction: DismissDirection.endToStart,
          background: Card(
            color: Colors.red[300],
            child:
                const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.delete),
              )
            ]),
          ),
          key: Key(note.id),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              final noteBloc = context.read<NoteBloc>();
              noteBloc.add(NoteRemoveNoteEvent(id: note.id));
            }
          },
          child: GestureDetector(
            onTap: () {
              context.goNamed(RouterNames.updateNote, extra: note);
            },
            child: Card(
              color: const Color(0xFF7E64FF),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy').format(note.date),
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Transform.rotate(
                            angle: 3.14 / 4,
                            child: note.isPinned
                                ? const Icon(
                                    Icons.push_pin,
                                    size: 12,
                                  )
                                : const Icon(
                                    Icons.push_pin_outlined,
                                    size: 12,
                                  ),
                          )
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
