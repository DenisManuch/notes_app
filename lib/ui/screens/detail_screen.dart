import 'package:flutter/material.dart';
import 'package:notes_app/core/provider/notes_provider.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
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
  final _noteProvider = Provider.of<NotesProvider>;
  final _taskProvider = Provider.of<TaskProvider>;
  final _titleController = TextEditingController();

  final _contentController = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    //_checkAuth();
    _taskProvider(context, listen: false).editTasksPressEnd();
    _noteProvider(context, listen: false).getAllNotesFromSupabase();
    _taskProvider(context, listen: false).setTaskListIndex();
  }

  @override
  void deactivate() {
    deactivateScreen();
    super.deactivate();
  }

  void deactivateScreen() {
    _noteProvider(context, listen: false)
        .updateNoteInSupabase(_taskProvider(context, listen: false).noteInfo);
  }

  // Future<void> _checkAuth() async {
  //   final bool _checkVar =
  //       await Provider.of<AuthProvider>(context, listen: false).checkAuth();
  //   if (_checkVar) {
  //     if (mounted) {
  //       return Navigator.pushAndRemoveUntil<void>(
  //         context,
  //         MaterialPageRoute<void>(
  //           builder: (BuildContext context) => const LoginScreen(),
  //         ),
  //         ModalRoute.withName('/login'),
  //       );
  //     }
  //   }
  // }

  void _initialTitleAndContent(String title, String content) {
    _titleController.text = title;
    _contentController.text = content;
  }

  void _onChangetTitle(String title) {
    final _note = _taskProvider(context, listen: false).noteInfo;
    final _index = _taskProvider(context, listen: false).noteIndexProvider;
    _note.title = title.trim();
    _noteProvider(context, listen: false).updateNote(_note, _index);
  }

  void _onChangetContent(String content) {
    final _note = _taskProvider(context, listen: false).noteInfo;
    final _index = _taskProvider(context, listen: false).noteIndexProvider;
    _note.content = content.trim();
    _noteProvider(context, listen: false).updateNote(_note, _index);
  }

  @override
  Widget build(BuildContext context) {
    final _noteInfo = _taskProvider(context).noteInfo;
    _initialTitleAndContent(_noteInfo.title, _noteInfo.content);

    return Scaffold(
      backgroundColor: colorPallete[_noteInfo.colorNote],
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _noteProvider(context, listen: false)
                        .updateNoteInSupabase(_noteInfo);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                const EditButtonWidget(),
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      enabled: _taskProvider(context).getEditButton,
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
                      enabled: _taskProvider(context).getEditButton,
                      onChanged: (value) =>
                          _onChangetContent(_contentController.text),
                      minLines: 1,
                      maxLines: maxLengthK,
                      controller: _contentController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Add description',
                      ),
                    ),
                  ),
                  const Expanded(child: CheckBoxWidget()),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      AddNewTaskWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
class EditButtonWidget extends StatelessWidget {
  ///
  const EditButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const _noteProvider = Provider.of<NotesProvider>;
    const _taskProvider = Provider.of<TaskProvider>;

    return _taskProvider(context).getEditButton
        ? IconButton(
            onPressed: () {
              _taskProvider(context, listen: false).upsertTasks();
              _taskProvider(context, listen: false).editTasksPress();
              _noteProvider(context, listen: false).updateNoteInSupabase(
                _taskProvider(context, listen: false).noteInfo,
              );
            },
            icon: const Icon(Icons.check),
          )
        : IconButton(
            onPressed: () {
              _taskProvider(context, listen: false).editTasksPress();
            },
            icon: const Icon(Icons.edit),
          );
  }
}

///
class AddNewTaskWidget extends StatelessWidget {
  ///
  const AddNewTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.of<TaskProvider>(context).addTaskButton
        ? TextButton.icon(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .addNewTaskButton();
              Provider.of<TaskProvider>(context, listen: false)
                  .lastTaskListIndex();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            label: const Text(
              'add new task',
              style: TextStyle(color: Colors.black),
            ),
          )
        : const SizedBox();
  }
}
