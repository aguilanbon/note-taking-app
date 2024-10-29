import 'package:go_router/go_router.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/pages/add_edit_note_screen.dart';
import 'package:note_taking_app/pages/note_list_screen.dart';
import 'package:note_taking_app/pages/view_note_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => NotesListScreen(),
      ),
      GoRoute(
        path: '/note/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoteDetailScreen(id: id);
        },
      ),
      GoRoute(
        path: '/add-edit-note',
        builder: (context, state) {
          final note = state.extra as Note?;
          return AddEditNoteScreen(note: note);
        },
      ),
    ],
  );
}
