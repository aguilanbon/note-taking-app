import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/components/custom_appbar.dart';
import 'package:note_taking_app/cubit/notes_cubit.dart';
import 'package:note_taking_app/models/note.dart';

class AddEditNoteScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final Note? note;

  AddEditNoteScreen({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    if (note != null) {
      _titleController.text = note!.title;
      _contentController.text = note!.content;
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: note != null ? 'Edit Note' : 'New Note',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<NotesCubit, NotesState>(
            listener: (context, state) {
              state.maybeWhen(
                  loaded: (_, didUpdate) {
                    if (didUpdate != null) {
                      if (didUpdate) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Successfully updated note!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Successfully added note!')),
                        );
                        _titleController.clear();
                        _contentController.clear();
                      }
                    }
                  },
                  orElse: () {});
            },
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
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _contentController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    saveButtonBuilder(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  saveButtonBuilder() {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const CircularProgressIndicator.adaptive(),
          orElse: () {
            return SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  final title = _titleController.text;
                  final content = _contentController.text;
                  if (title.isNotEmpty && content.isNotEmpty) {
                    final newNote = note?.copyWith(
                          title: title,
                          content: content,
                        ) ??
                        Note(
                          id: DateTime.now().toString(),
                          title: title,
                          content: content,
                        );
                    if (note != null) {
                      if (note == newNote) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Nothing changed!')),
                        );
                      } else {
                        context.read<NotesCubit>().updateNote(newNote);
                      }
                    } else {
                      context.read<NotesCubit>().addNote(newNote);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Title and content cannot be empty')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Save'),
              ),
            );
          },
        );
      },
    );
  }
}
