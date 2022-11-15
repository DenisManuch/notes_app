import 'package:flutter/material.dart';
import 'package:notes_app/core/models/task_model.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
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
  final _taskController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void _getTasks() {
    final _note = Provider.of<TaskProvider>(context).noteInfo;
    Provider.of<TaskProvider>(context, listen: false).getAllTaskById(_note);
  }

  void _onChangetTask(String value, int listIndex) {
    Provider.of<TaskProvider>(context, listen: false)
        .listOfTaskProvider[listIndex]
        .task = value;
  }

  @override
  Widget build(BuildContext context) {
    final List<TaskModel> _listOfTask =
        Provider.of<TaskProvider>(context).getTaskListProvider;

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _listOfTask.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: _listOfTask[index].check,
                checkColor: Theme.of(context).secondaryHeaderColor,
                activeColor: colorPallete[
                    Provider.of<TaskProvider>(context).noteInfo.colorNote],
                onChanged: (bool? value) {
                  Provider.of<TaskProvider>(context, listen: false).updateTask(
                    _listOfTask[index].id,
                    value ?? false,
                    index,
                  );
                },
                title: Expanded(
                  child: TextFormField(
                    onChanged: (value) => _onChangetTask(
                      value,
                      index,
                    ),
                    initialValue: _listOfTask[index].task,
                    style: TextStyle(
                      decoration: _listOfTask[index].check
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: _listOfTask[index].check
                          ? Theme.of(context)
                              .secondaryHeaderColor
                              .withOpacity(0.5)
                          : Theme.of(context).secondaryHeaderColor,
                    ),
                    minLines: 1,
                    maxLines: 100,
                    //controller: _contentController,
                    decoration: const InputDecoration.collapsed(
                      hintText: '',
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
