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
      _listOfNotesProvider = await _noteService.fetchNotes()..sort(
          (x, y) => y.modifyTime.difference(x.modifyTime).inMilliseconds,
        );
      notifyListeners();
    }
  }

  

  ///
  List<NoteModel> updateNote(NoteModel noteInfo, int indexList) {
    _listOfNotesProvider[indexList] = noteInfo;
    notifyListeners();

    return [];
  }
}
