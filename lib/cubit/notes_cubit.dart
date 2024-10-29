import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:note_taking_app/models/note.dart';
import 'package:note_taking_app/services/notes_services.dart';

part 'notes_state.dart';
part 'notes_cubit.freezed.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesServices _notesService;

  NotesCubit(this._notesService) : super(const NotesState.initial());

  Future<void> getNotes() async {
    emit(const NotesState.loading());

    try {
      final notes = await _notesService.fetchNotes();
      emit(NotesState.loaded(notes: notes));
    } catch (e) {
      emit(NotesState.error(message: e.toString()));
    }
  }
}
