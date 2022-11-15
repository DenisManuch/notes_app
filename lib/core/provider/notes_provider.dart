import 'package:flutter/cupertino.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/supabase_services/note_service.dart';

/// Notes Provider
class NotesProvider extends ChangeNotifier {
  ///
  final NoteService _noteService = NoteService();

  ///
  List<NoteModel> _listOfNotesProvider = [];

  ///
  List<NoteModel> get getNotesProvider => _listOfNotesProvider;

  /// get all notes from supabase
  Future<List<NoteModel>> getAllNotesFromSupabase() async {
    try {
      _listOfNotesProvider = await _noteService.fetchNotes()
        ..sort(
          (x, y) => y.modifyTime.difference(x.modifyTime).inMilliseconds,
        );
      notifyListeners();

      return [];
    } catch (e) {
      debugPrint('$e');
    }

    return [];
  }

  ///
  Future<void> updateNoteInSupabase(NoteModel note) async {
    try {
      await _noteService.updateNote(
        note.title,
        note.content ?? '',
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
      //return null;
      debugPrint('Title is empty');
    } else {
      await _noteService.createNote(title.trim(), content.trim(), color);
      _listOfNotesProvider = await _noteService.fetchNotes()
        ..sort(
          (x, y) => y.id.compareTo(x.id),
        );
      notifyListeners();
    }
  }

  ///
  void deleteNote(int noteIndex) {
    _listOfNotesProvider.removeAt(noteIndex);
    notifyListeners();
    _noteService.deleteNote(_listOfNotesProvider[noteIndex].id);
    getAllNotesFromSupabase();
    notifyListeners();
  }

  ///
  void updateNote(NoteModel noteInfo, int indexList) {
    _listOfNotesProvider[indexList] = noteInfo;
    notifyListeners();
  }
}
