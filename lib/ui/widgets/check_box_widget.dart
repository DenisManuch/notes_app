import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/models/task_model.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:provider/provider.dart';

///
class CheckBoxWidget extends StatefulWidget {
  ///
  const CheckBoxWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBoxWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<TaskModel> _listOfTask =
        Provider.of<TaskProvider>(context).getTaskListProvider;

    return ListView.builder(
      itemCount: _listOfTask.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Expanded(
                child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: _listOfTask[index].check,
              onChanged: (bool? value) {
                Provider.of<TaskProvider>(context, listen: false).updateTask(
                  _listOfTask[index].id,
                  value ?? false,
                  _listOfTask[index].noteId,
                );
              },
              title: AutoSizeText(
                _listOfTask[index].task,
                maxLines: 1,
              ),
            ),)
          ],
        );
      },
    );
  }
}
