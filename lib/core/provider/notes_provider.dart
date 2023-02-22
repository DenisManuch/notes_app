import 'package:flutter/cupertino.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/supabase_services/note_service.dart';

/// Notes Provider
class NotesProvider extends ChangeNotifier {
  ///
  final NoteService _noteService = NoteService();

  ///
  final TaskProvider _taskProvider = TaskProvider();

  ///
  List<NoteModel> _listOfNotesProvider = [];

  ///
  int noteIndexInList = 0;

  ///
  List<NoteModel> get getNotesProvider => _listOfNotesProvider;

  /// get all notes from supabase
  Future<void> getAllNotesFromSupabase() async {
    try {
      _listOfNotesProvider = await _noteService.fetchNotes()
        ..sort(
          (x, y) => y.id.compareTo(x.id),
        );
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  Future<void> updateNoteInSupabase(NoteModel note) async {
    try {
      await _noteService.updateNote(
        note.title,
        note.content,
        note.colorNote,
        note.id,
      );
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  Future<void> createNoteProvider(
    String title,
    String content,
    int color,
  ) async {
    if (title.trim().isEmpty) {
      debugPrint('Title is empty');
    } else {
      await _noteService.createNote(title.trim(), content.trim(), color);
      _listOfNotesProvider = await _noteService.fetchNotes()
        ..sort(
          (x, y) => y.modifyTime.difference(x.modifyTime).inMilliseconds,
        );
      notifyListeners();
    }
  }

  ///
  void deleteNote(int noteIndex) {
    _noteService.deleteNote(_listOfNotesProvider[noteIndex].id);
    _listOfNotesProvider.removeAt(noteIndex);
    notifyListeners();
    //getAllNotesFromSupabase();
    //notifyListeners();
  }

  ///
  void updateNoteColor(int index) {
    _listOfNotesProvider[noteIndexInList].colorNote = index;
    notifyListeners();
  }

  ///
  void updateNote(NoteModel noteInfo, int indexList) {
    _listOfNotesProvider[indexList] = noteInfo;
    notifyListeners();
  }

  ///
  void longPressForRemoveNote(int index) {
    notifyListeners();
  }
}
