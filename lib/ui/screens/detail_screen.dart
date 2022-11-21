import 'package:flutter/material.dart';
import 'package:notes_app/core/provider/auth_provider.dart';
import 'package:notes_app/core/provider/notes_provider.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
import 'package:notes_app/ui/screens/login_screen.dart';
import 'package:notes_app/ui/widgets/bottom_navigation_bar_widget.dart';
import 'package:notes_app/ui/widgets/check_box_widget.dart';
import 'package:provider/provider.dart';

///
class DetailScreen extends StatefulWidget {
  ///
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _titleController = TextEditingController();

  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }



  Future<void> _checkAuth() async {
    final bool _checkVar =
        await Provider.of<AuthProvider>(context, listen: false).checkAuth();
    if (_checkVar) {
      if (mounted) {
        return Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LoginScreen(),
          ),
          ModalRoute.withName('/login'),
        );
      }
    }
  }

  void _initialTitleAndContent(String title, String content) {
    _titleController.text = title;
    _contentController.text = content;
  }

  void _onChangetTitle(String title) {
    final _note = Provider.of<TaskProvider>(context, listen: false).noteInfo;
    final _index =
        Provider.of<TaskProvider>(context, listen: false).noteIndexProvider;
    _note.title = title.trim();
    Provider.of<NotesProvider>(context, listen: false)
        .updateNote(_note, _index);
  }

  void _onChangetContent(String content) {
    final _note = Provider.of<TaskProvider>(context, listen: false).noteInfo;
    final _index =
        Provider.of<TaskProvider>(context, listen: false).noteIndexProvider;
    _note.content = content.trim();
    Provider.of<NotesProvider>(context, listen: false)
        .updateNote(_note, _index);
  }

  @override
  Widget build(BuildContext context) {
    final _noteInfo = Provider.of<TaskProvider>(context).noteInfo;
    _initialTitleAndContent(_noteInfo.title, _noteInfo.content);

    return Scaffold(
      backgroundColor: colorPallete[_noteInfo.colorNote],
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Provider.of<NotesProvider>(context, listen: false)
                              .updateNoteInSupabase(_noteInfo);
                          Provider.of<NotesProvider>(context, listen: false)
                              .getAllNotesFromSupabase();
                          Provider.of<TaskProvider>(context, listen: false)
                              .upsertTasks();
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                      IconButton(
                        onPressed: () {
                          debugPrint('Edit button');
                        },
                        icon: const Icon(Icons.edit),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) =>
                          _onChangetTitle(_titleController.text),
                      minLines: 1,
                      maxLines: maxLinesK,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _titleController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Title',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) => _onChangetContent(value),
                      initialValue: _noteInfo.content,
                      minLines: 1,
                      maxLines: maxLengthK,
                      //controller: _contentController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Content',
                      ),
                    ),
                  ),
                  const Expanded(child: CheckBoxWidget()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
