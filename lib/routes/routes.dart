import 'package:note_taking_app/pages/add_edit_note_screen.dart';
import 'package:note_taking_app/pages/note_list_screen.dart';
import 'package:note_taking_app/pages/view_note_screen.dart';

class AppRoutes {
  static final routes = {
    '/notes': (context) => const NotesListScreen(),
    '/note': (context) => const NoteDetailScreen(),
    '/add-edit-note': (context) => const AddEditNoteScreen(),
  };
}
