import 'package:flutter/material.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/models/task_model.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
import 'package:provider/provider.dart';

///
class DetailScreen extends StatelessWidget {
  ///
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _noteInfo = Provider.of<TaskProvider>(context).noteInfo;

    return Scaffold(
      appBar: AppBar(title: Text(_noteInfo?.title ?? 'title')),
      body: Column(
        children: const <Widget>[
          Expanded(child: CheckBoxWidget()),
        ],
      ),
    );
  }
}

///
class CheckBoxWidget extends StatefulWidget {
  ///
  const CheckBoxWidget({super.key});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    final _noteId = Provider.of<TaskProvider>(context).noteInfo?.id ?? 0;

    return FutureBuilder<List<TaskModel>>(
      future: Provider.of<TaskProvider>(context, listen: false)
          .getAllTaskById(_noteId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<TaskProvider>(context).listOfTaskProvider =
              snapshot.data ?? [];
          final _taskList =
              Provider.of<TaskProvider>(context).getTaskListProvider;

          return ListView.builder(
            itemCount: _taskList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(_taskList[index].id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => setState(() {
                  debugPrint(''); // crutch
                }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    //color: colorPallete[_taskList[index].colorNote],
                    child: ListTile(
                      leading: _taskList[index].check
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                      //trailing: const Icon(Icons.arrow_forward_ios),
                      title: Text(
                        _taskList[index].task,
                        style: const TextStyle(fontSize: 25),
                      ),
                      //subtitle: Text(note.content ?? ''),
                      //onLongPress: () => _editNote(note),
                      onTap: () => debugPrint('ddd'),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}
