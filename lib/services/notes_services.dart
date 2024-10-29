import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:note_taking_app/models/note.dart';

class NotesServices {
  static const baseURL =
      'https://my-json-server.typicode.com/aguilanbon/note-taking-app/notes';

  Future<List<Note>> fetchNotes() async {
    try {
      final response = await http.get(Uri.parse(baseURL));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data as List).map((json) => Note.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (e) {
      throw Exception('Failed to fetch notes: ${e.toString()}');
    }
  }
}
