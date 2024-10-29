import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/cubit/notes_cubit.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesCubit>().getNotesFromCache();
    });
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go('/add-edit-note');
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: BlocBuilder<NotesCubit, NotesState>(
            builder: (context, state) {
              return state.when(
                initial: () {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                loaded: (notes, _, __) {
                  if (notes.isEmpty) {
                    return const Center(
                      child: Text(
                        'No notes yet\nTap + to add a new note',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<NotesCubit>().getNotesFromCache();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(
                              note.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              note.content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      context.go('/add-edit-note', extra: note);
                                    }),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Show confirmation dialog before deleting
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Delete Note'),
                                        content: const Text(
                                            'Are you sure you want to delete this note?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Navigator.pop(context);
                                              // context
                                              //     .read<NotesCubit>()
                                              //     .deleteNote(note.id);
                                            },
                                            child: const Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              context.go('/note/${note.id}');
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (message) => Text(message),
              );
            },
          ),
        ));
  }
}
