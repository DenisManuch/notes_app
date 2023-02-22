import 'package:flutter/material.dart';
import 'package:notes_app/core/provider/notes_provider.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
import 'package:provider/provider.dart';

///
class CircleWidget extends StatelessWidget {
  ///

  ///
  const CircleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteColor = Provider.of<TaskProvider>(context).noteInfo.colorNote;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: colorPallete.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Provider.of<TaskProvider>(context, listen: false)
                .updateNoteColor(index);
            Provider.of<NotesProvider>(context, listen: false)
                .updateNoteColor(index);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: circleK,
              height: circleK,
              decoration: BoxDecoration(
                color: colorPallete[index],
                shape: BoxShape.circle,
                border: Border.all(width: circleBorderK, color: Colors.black38),
              ),
              child: index == noteColor ? const Icon(Icons.done) : null,
            ),
          ),
        );
      },
    );
  }
}
