import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:note_taking_app/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesServices {
  static const baseURL =
      'https://my-json-server.typicode.com/aguilanbon/note-taking-app/notes';
  static const cacheKey = 'notes_cache';

  Future<List<Note>> fetchNotes() async {
    try {
      final response = await http.get(Uri.parse(baseURL));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        jsonDecode(response.body);
        final notes =
            (data as List).map((json) => Note.fromJson(json)).toList();
        _cacheNotes(notes);
        return notes;
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (e) {
      throw Exception('Failed to fetch notes: ${e.toString()}');
    }
  }

  Future<List<Note>> fetchNotesFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);
    if (cachedData != null) {
      final List<dynamic> decodedData = jsonDecode(cachedData);
      return decodedData.map((json) => Note.fromJson(json)).toList();
    }
    return [];
  }

  Future<Note?> fetchNoteById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);
    if (cachedData != null) {
      final List<dynamic> decodedData = jsonDecode(cachedData);
      final note = decodedData.firstWhere((element) => element['id'] == id,
          orElse: () => null);
      if (note != null) {
        return Note.fromJson(note);
      }
    }
    return null;
  }

  Future<List<Note>> createOrUpdateNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);
    if (cachedData != null) {
      final List<dynamic> decodedData = jsonDecode(cachedData);
      final List<Note> notes =
          decodedData.map((json) => Note.fromJson(json)).toList();

      final index = notes.indexWhere((element) => element.id == note.id);
      if (index != -1) {
        notes[index] = note;
      } else {
        notes.add(note);
      }

      prefs.setString(cacheKey, jsonEncode(notes));
      return notes;
    } else {
      prefs.setString(cacheKey, jsonEncode([note]));
      return [note];
    }
  }

  Future<List<Note>> deleteNote(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);
    if (cachedData != null) {
      final List<dynamic> decodedData = jsonDecode(cachedData);
      final List<Note> notes =
          decodedData.map((json) => Note.fromJson(json)).toList();

      notes.removeWhere((element) => element.id == id);

      prefs.setString(cacheKey, jsonEncode(notes));
      return notes;
    } else {
      return [];
    }
  }

  Future<void> _cacheNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(cacheKey, jsonEncode(notes));
  }
}
