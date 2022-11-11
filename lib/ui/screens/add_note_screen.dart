import 'package:flutter/material.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/provider/notes_provider.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
import 'package:notes_app/ui/widgets/circle_widget.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

///
class AddNoteScreen extends StatefulWidget {
  ///
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();

  final _contentController = TextEditingController();
  NoteModel? noteInfo;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveNote() async {
    final _title = _titleController.text;
    final _content = _contentController.text;
    await context
        .read<NotesProvider>()
        .createNoteProvider(_title, _content, 0);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLength: 100,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                controller: _titleController,
                //validator: (value) => _validator(value!),
                decoration: const InputDecoration(
                  counterStyle: TextStyle(color: Colors.white),
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLength: 100,
                maxLines: 5,
                minLines: 1,
                style: const TextStyle(color: Colors.white),
                controller: _contentController,
                decoration: const InputDecoration(
                  counterStyle: TextStyle(color: Colors.white),
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colorPallete.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //setState(() => _colorTap = index);
                    },
                    child: CircleWidget(
                      color: index,
                      circleTap: 5,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveNote(),
        child: const Text('Save'),
      ),
    );
  }
}
