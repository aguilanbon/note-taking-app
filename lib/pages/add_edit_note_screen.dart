import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/cubit/notes_cubit.dart';
import 'package:note_taking_app/models/note.dart';

class AddEditNoteScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  AddEditNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _contentController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final title = _titleController.text;
                      final content = _contentController.text;

                      if (title.isNotEmpty && content.isNotEmpty) {
                        final newNote = Note(
                          id: DateTime.now().toString(),
                          title: title,
                          content: content,
                        );
                        context.read<NotesCubit>().addNote(newNote);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Title and content cannot be empty')),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
