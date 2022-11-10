///
class NoteModel {
  ///
  final int id;

  ///
  String title;

  ///
  String? content;

  ///
  final DateTime createTime;

  ///
  DateTime modifyTime;

  ///
  int colorNote;

  ///
  NoteModel(
    this.id,
    this.title,
    this.content,
    this.createTime,
    this.modifyTime,
    this.colorNote,
  );

  @override
  String toString() {
    return ''' Note{id: $id, title: $title, content: $content, createTime: $createTime, modifyTime: $modifyTime, color_note: $colorNote,} ''';
  }
}
