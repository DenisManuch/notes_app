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
  final _titleController = TextEditingController();

  final _contentController = TextEditingController();

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
    _initialTitleAndContent(_noteInfo.title, _noteInfo.content ?? '');

    

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
                          print(
                              Provider.of<TaskProvider>(context, listen: false)
                                  .listOfTaskProvider);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                      IconButton(
                        onPressed: () {},
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
                      maxLines: 5,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
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
                      maxLines: 100,
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


///
// class CheckBoxWidget extends StatefulWidget {
//   ///
//   const CheckBoxWidget({super.key});

//   @override
//   State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
// }

// class _CheckBoxWidgetState extends State<CheckBoxWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final _noteId = Provider.of<TaskProvider>(context).noteInfo?.id ?? 0;

//     return FutureBuilder<List<TaskModel>>(
//       future: Provider.of<TaskProvider>(context, listen: false)
//           .getAllTaskById(_noteId),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           Provider.of<TaskProvider>(context).listOfTaskProvider =
//               snapshot.data ?? [];
//           final _taskList =
//               Provider.of<TaskProvider>(context).getTaskListProvider;

//           return ListView.builder(
//             itemCount: _taskList.length,
//             itemBuilder: (context, index) {
//               return Dismissible(
//                 key: ValueKey(_taskList[index].id),
//                 direction: DismissDirection.endToStart,
//                 onDismissed: (_) => setState(() {
//                   debugPrint(''); // crutch
//                 }),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     //color: colorPallete[_taskList[index].colorNote],
//                     child: ListTile(
//                       leading: _taskList[index].check
//                           ? const Icon(Icons.check_box)
//                           : const Icon(Icons.check_box_outline_blank),
//                       //trailing: const Icon(Icons.arrow_forward_ios),
//                       title: Text(
//                         _taskList[index].task,
//                         style: const TextStyle(fontSize: 25),
//                       ),
//                       //subtitle: Text(note.content ?? ''),
//                       //onLongPress: () => _editNote(note),
//                       onTap: () => debugPrint('ddd'),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }

//         return const Center(
//           child: CircularProgressIndicator(
//             color: Colors.black,
//             backgroundColor: Colors.white,
//           ),
//         );
//       },
//     );
//   }
// }
