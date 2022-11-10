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

  /// get all notes from
  Future<List<NoteModel>> getAllNotes() async {
    try {
      _listOfNotesProvider = await _noteService.fetchNotes();
      notifyListeners();

      return [];
    } catch (e) {
      debugPrint('$e');
    }

    return [];
  }

  ///
  List<NoteModel> updateNoteList(List<NoteModel> snapshotData) {
    _listOfNotesProvider = snapshotData;
    notifyListeners();

    return [];
  }
}
