part of 'notes_cubit.dart';

@freezed
class NotesState with _$NotesState {
  const factory NotesState.initial() = _Initial;
  const factory NotesState.loading() = _Loading;
  const factory NotesState.loaded(
      {required List<Note> notes, bool? didUpdate}) = _Loaded;
  const factory NotesState.error({required String message}) = _Error;
  const factory NotesState.view({required Note? note}) = _View;
}
