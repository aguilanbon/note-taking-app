import 'package:flutter/material.dart';

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
        child: Column(
          children: [Text('sdsd')],
        ),
      ),
    );
  }
}
