import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
  }

  void _onChangetTask(String value, int listIndex) {
    Provider.of<TaskProvider>(context, listen: false)
        .listOfTaskProvider[listIndex]
        .task = value;
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: Provider.of<TaskProvider>(context).getTaskListProvider.length,
      itemBuilder: (BuildContext context, int index) {
        final TextEditingController _controller = TextEditingController(
        text: Provider.of<TaskProvider>(context, listen: false)
            .getTaskListProvider[index]
            .task,
      );

        return Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: Provider.of<TaskProvider>(context)
                    .getTaskListProvider[index]
                    .check,
                checkColor: Theme.of(context).secondaryHeaderColor,
                activeColor: colorPallete[
                    Provider.of<TaskProvider>(context).noteInfo.colorNote],
                onChanged: (bool? value) {
                  context.read<TaskProvider>().updateTask(
                        Provider.of<TaskProvider>(context, listen: false)
                            .listOfTaskProvider[index]
                            .id,
                        checkValue: value ?? false,
                        index,
                      );
                },
                title: TextField(
                  keyboardType: TextInputType.name,
                  controller: _controller,
                  maxLength: 500,
                  autofocus: true,
                  enabled: Provider.of<TaskProvider>(context).getEditButton,
                  onTap: () {
                    Provider.of<TaskProvider>(context, listen: false)
                        .updateTaskListIndex(index);
                  },
                  onChanged: (value) => _onChangetTask(
                    _controller.text,
                    index,
                  ),
                  style: TextStyle(
                    decoration: Provider.of<TaskProvider>(context)
                            .getTaskListProvider[index]
                            .check
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: Provider.of<TaskProvider>(context)
                            .getTaskListProvider[index]
                            .check
                        ? Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(opacityK)
                        : Theme.of(context).secondaryHeaderColor,
                  ),
                  minLines: 1,
                  maxLines: maxLinesDescriptionK,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                    counterText: '',
                  ),
                ),
              ),
            ),
            Column(
              children: [
                if (Provider.of<TaskProvider>(context).taskIndexProvider ==
                    index) ...[
                  ButtonDeleteTaskWidget(taskIndex: index),
                ]
              ],
            ),
          ],
        );
      },
    );
  }
}

///
class ButtonDeleteTaskWidget extends StatelessWidget {
  ///
  final int taskIndex;

  ///
  const ButtonDeleteTaskWidget({super.key, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    return Provider.of<TaskProvider>(context).getEditButton
        ? IconButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .deleteTask(taskIndex);
            },
            icon: const Icon(Icons.clear),
          )
        : const SizedBox(
            width: 45,
          );
  }
}
