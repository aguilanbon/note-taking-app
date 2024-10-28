import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/cubit/notes_cubit.dart';
import 'package:note_taking_app/pages/note_list_screen.dart';
import 'package:note_taking_app/routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      home: BlocProvider<NotesCubit>(
        create: (context) => NotesCubit(),
        child: const NotesListScreen(),
      ),
    );
  }
}
