import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/cubit/notes_cubit.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add-edit-note');
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: BlocBuilder<NotesCubit, NotesState>(
            builder: (context, state) {
              return state.when(
                initial: () {
                  context.read<NotesCubit>().getNotes();
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                loaded: (notes) {
                  return Text('loaded');
                },
                error: (message) => Text(message),
              );
            },
          ),
        ));
  }
}
