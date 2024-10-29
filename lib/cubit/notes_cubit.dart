import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/services/notes_services.dart';

part 'notes_state.dart';
part 'notes_cubit.freezed.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesServices _notesService;

  NotesCubit(this._notesService) : super(const NotesState.initial());

  /// Fetch initial mock data of notes from a mock api
  Future<void> getInitNotes() async {
    emit(const NotesState.loading());
    try {
      final notes = await _notesService.fetchNotes();
      emit(NotesState.loaded(notes: notes));
    } catch (e) {
      emit(NotesState.error(message: e.toString()));
    }
  }

  /// Fetch notes from localStorage cache
  Future<void> getNotesFromCache() async {
    emit(const NotesState.loading());

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final notes = await _notesService.fetchNotesFromCache();
      emit(NotesState.loaded(notes: notes));
    } catch (e) {
      emit(NotesState.error(message: e.toString()));
    }
  }

  /// Add note
  Future<void> addNote(Note note) async {
    emit(const NotesState.loading());
    try {
      final updatedNotesList = await _notesService.createOrUpdateNote(note);
      emit(NotesState.loaded(notes: updatedNotesList, didUpdate: false));
    } catch (e) {
      emit(NotesState.error(message: e.toString()));
    }
  }

  /// Fetch a single note
  Future<void> getNoteById(String id) async {
    emit(const NotesState.loading());
    try {
      final note = await _notesService.fetchNoteById(id);
      emit(NotesState.view(
        note: note!,
      ));
    } catch (e) {
      emit(NotesState.error(message: e.toString()));
    }
  }

  /// Update note
  Future<void> updateNote(Note note) async {
    emit(const NotesState.loading());
    try {
      final updatedNotesList = await _notesService.createOrUpdateNote(note);
      emit(NotesState.loaded(notes: updatedNotesList, didUpdate: true));
    } catch (e) {
      emit(NotesState.error(message: e.toString()));
    }
  }

  /// Delete note
  Future<void> deleteNote(String id) async {
    emit(const NotesState.loading());
    try {
      final updatedNotesList = await _notesService.deleteNote(id);
      emit(NotesState.loaded(notes: updatedNotesList));
    } catch (e) {
      emit(NotesState.error(message: e.toString()));
    }
  }
}
