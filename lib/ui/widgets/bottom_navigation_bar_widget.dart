import 'package:flutter/material.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
import 'package:notes_app/ui/widgets/circle_widget.dart';
import 'package:provider/provider.dart';

import 'package:timeago/timeago.dart' as timeago;

///
class BottomNavigationBarWidget extends StatelessWidget {
  ///
  const BottomNavigationBarWidget({super.key});

  void _addNewTask(BuildContext context) {
    Provider.of<TaskProvider>(context, listen: false).addNewTaskProvider();
  }

  @override
  Widget build(BuildContext context) {
    final NoteModel _noteInfo =
        Provider.of<TaskProvider>(context, listen: false).noteInfo;

    return BottomAppBar(
      color: colorPallete[_noteInfo.colorNote],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Theme.of(context).secondaryHeaderColor,
            onPressed: () {
              _addNewTask(context);
            },
            icon: const Icon(Icons.add_box_outlined),
          ),
          IconButton(
            color: Theme.of(context).secondaryHeaderColor,
            onPressed: () {
              showModalBottomSheet<void>(
                backgroundColor: colorPallete[_noteInfo.colorNote],
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 150,
                    child: Column(
                      children: [
                        Expanded(child: CircleWidget(color: _noteInfo.colorNote, circleTap: 0))
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
              'Last changes: ${timeago.format(_noteInfo.modifyTime)}',
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
          IconButton(
            color: Theme.of(context).secondaryHeaderColor,
            onPressed: () {
              showModalBottomSheet<void>(
                backgroundColor: colorPallete[_noteInfo.colorNote],
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
