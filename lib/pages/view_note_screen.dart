import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/cubit/notes_cubit.dart';

class NoteDetailScreen extends StatelessWidget {
  final String id;

  const NoteDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesCubit>().getNoteById(id);
    });
    return Scaffold(
      body: BlocBuilder<NotesCubit, NotesState>(
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
            loaded: (_, note, __) {
              if (note != null) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note.title,
                          style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(height: 8),
                      Text(note.content),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('Note not found.'));
              }
            },
            error: (message) => Center(
              child: Text(message),
            ),
          );
        },
      ),
    );
  }
}
