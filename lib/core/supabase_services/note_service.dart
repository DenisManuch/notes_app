import 'package:flutter/material.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

///
class NoteService {
  /// table name
  static const notes = 'notes';

  /// shortcut
  final supabase = Supabase.instance.client;

  /// Fetch all notes from supabase
  Future<List<NoteModel>> fetchNotes() async {
    try {
      final List<dynamic> respons = await supabase.from(notes).select('*');

      return respons.map((dynamic e) => toNote(e)).toList();
    } catch (e) {
      debugPrint('$e');
      
      return [];
    }
  }

  ///
  NoteModel toNote(dynamic result) {
    return NoteModel(
      int.parse(result['id'].toString()),
      result['title'].toString(),
      result['content'].toString(),
      DateTime.parse(result['create_time'].toString()),
      DateTime.parse(result['modify_time'].toString()),
      int.parse(result['color_note'].toString()),
    );
  }
}
