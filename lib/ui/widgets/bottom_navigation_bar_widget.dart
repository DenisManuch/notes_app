import 'package:flutter/material.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
import 'package:notes_app/ui/widgets/circle_widget.dart';
import 'package:provider/provider.dart';

import 'package:timeago/timeago.dart' as timeago;

///
class BottomNavigationBarWidget extends StatelessWidget {
  ///
  const BottomNavigationBarWidget({super.key});

  // void _addNewTask(BuildContext context) {
  //   Provider.of<TaskProvider>(context, listen: false).addNewTaskProvider();
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    // final NoteModel _noteInfo =
    //     Provider.of<TaskProvider>(context, listen: false).noteInfo;
    final _inputFormTask = GlobalKey<FormState>();

    //   void _checkInputText(String taskStr) {
    //   if (taskStr.isEmpty) {
    //     return _showSnackBar('Please, enter some text');
    //   }
    //   Services.of(context).notesService.createTask(
    //         taskStr,
    //         Provider.of<ProviderData>(context, listen: false).getNoteInfo?.id ??
    //             0,
    //       );
    //   Future.delayed(const Duration(milliseconds: 200), () {
    //     setState(() {
    //       debugPrint(''); // crutch
    //     });
    //   });
    //   Navigator.of(context).pop();
    // }
    ///
    void _addNewTask(String task) {
      Provider.of<TaskProvider>(context, listen: false)
          .addNewTaskProvider(task);
      Navigator.of(context).pop();
    }

    Future _inputDialog(BuildContext context) async {
      String taskStr = '';

      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('New task'),
            content: Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        key: _inputFormTask,
                        maxLines: 2,
                        minLines: 1,
                        maxLength: 100,
                        autofocus: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Print new task',
                        ),
                        onChanged: (value) {
                          taskStr = value.trim();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Done'),
                onPressed: () => _addNewTask(taskStr),
              ),
            ],
          );
        },
      );
    }

    return BottomAppBar(
      color: colorPallete[provider.noteInfo.colorNote],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Theme.of(context).secondaryHeaderColor,
            onPressed: () {
              //_addNewTask(context);
              _inputDialog(context);
            },
            icon: const Icon(Icons.add_box_outlined),
          ),
          IconButton(
            color: Theme.of(context).secondaryHeaderColor,
            onPressed: () {
              showModalBottomSheet<void>(
                backgroundColor: colorPallete[provider.noteInfo.colorNote],
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 150,
                    child: Column(
                      children: const [
                        Expanded(
                          child: CircleWidget(),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.palette_outlined),
          ),
          Expanded(
            child: Text(
              'Last changes: ${timeago.format(provider.noteInfo.modifyTime)}',
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
          IconButton(
            color: Theme.of(context).secondaryHeaderColor,
            onPressed: () {
              showModalBottomSheet<void>(
                backgroundColor: colorPallete[provider.noteInfo.colorNote],
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 150,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {},
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.note_alt_outlined,
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'Edit note',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.photo_outlined,
                                  color: Theme.of(context)
                                      .secondaryHeaderColor
                                      .withOpacity(0.5),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'Add image',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .secondaryHeaderColor
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          //onTap: () => _removeAllTask(),
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'Delete note',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.more_vert_outlined),
          )
        ],
      ),
    );
  }
}
