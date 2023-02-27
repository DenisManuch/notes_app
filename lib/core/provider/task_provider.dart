import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/models/task_model.dart';
import 'package:notes_app/core/supabase_services/task_service.dart';

///
class TaskProvider extends ChangeNotifier {
  ///
  final TaskService _taskService = TaskService();

  ///
  int noteIdProvider = 0;

  ///
  int noteIndexProvider = 0;

  ///
  int taskIndexProvider = 0;

  ///
  bool loadingIndicator = false;

  ///
  bool _editButton = false;

  ///
  bool addTaskButton = true;

  ///
  NoteModel noteInfo =
      NoteModel(0, 'title', 'content', DateTime.now(), DateTime.now(), 0);

  ///

  ///
  List<TaskModel> listOfTaskProvider = [];

  ///
  bool get getEditButton => _editButton;

  ///
  List<TaskModel> get getTaskListProvider => listOfTaskProvider;

  ///
  Future<List<TaskModel>> getAllTaskById(NoteModel note) async {
    try {
      noteInfo = note;
      listOfTaskProvider = await _taskService.fetchTaskById(note.id);
      notifyListeners();

      return listOfTaskProvider;
    } catch (e) {
      debugPrint('$e');
    }

    return [];
  }

  ///
  Future<void> updateTask(
    int taskId,
    int taskIndex, {
    required bool checkValue,
  }) async {
    try {
      listOfTaskProvider[taskIndex].check = checkValue;
      notifyListeners();
      await _taskService.checkTaskUpdate(taskId, checkValue: checkValue);
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  void addNewTaskProvider() {
    // listOfTaskProvider.add(
    //   TaskModel(
    //     Random().nextInt(100) + 50,
    //     '',
    //     noteInfo.id,
    //     check: false,
    //   ),
    // );
    notifyListeners();
    _taskService.createTask('', noteInfo.id);
    //notifyListeners();
    getAllTaskById(noteInfo);
    //notifyListeners();
  }

  ///
  void upsertTasks() {
    _taskService.upsertTasks(listOfTaskProvider);
  }

  ///
  Future<void> deleteTask(int index) async {
    try {
      final int taskId = listOfTaskProvider[index].id;
      listOfTaskProvider.removeAt(index);
      notifyListeners();
      await _taskService.deleteTask(taskId);
      listOfTaskProvider.clear();
      listOfTaskProvider = await _taskService.fetchTaskById(noteInfo.id);
      // await Future<dynamic>.delayed(const Duration(milliseconds: 2000));
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  Future<void> loadListOfTasks(NoteModel noteInfoK, int listIndex) async {
    noteIndexProvider = 0;
    listOfTaskProvider.clear();
    //changeLoadingIndicator();
    loadingIndicator = true;
    notifyListeners();
    try {
      noteIndexProvider = listIndex;
      noteInfo = noteInfoK;
      listOfTaskProvider = await _taskService.fetchTaskById(noteInfoK.id);
      notifyListeners();
      loadingIndicator = false;
    } catch (e) {
      loadingIndicator = false;
      debugPrint('$e');
      notifyListeners();
    }
  }

  ///
  void updateNoteColor(int tapIndex) {
    noteInfo.colorNote = tapIndex;
    notifyListeners();
  }

  ///
  void changeLoadingIndicator({required bool load}) {
    loadingIndicator = load;
    notifyListeners();
  }

  ///
  AutoSizeText loadingIndicatorState(BuildContext context) {
    return loadingIndicator
        ? AutoSizeText(
            'Loading...',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          )
        : AutoSizeText(
            'Note App',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          );
  }

  ///
  Future<void> editTasksPress() async {
    // listOfTaskProvider = await _taskService.fetchTaskById(noteInfo.id);
    _editButton = !_editButton;
    notifyListeners();
  }

  ///
  void editTasksPressEnd() {
    _editButton = false;
    //notifyListeners();
  }

  ///
  void addNewTaskButton() {
    addNewTaskProvider();
    _editButton = true;
    addTaskButton = false;
    notifyListeners();
    Timer(
      const Duration(seconds: 6),
      () {
        addTaskButton = true;
        notifyListeners();
      },
    );
  }

  ///
  void updateTaskListIndex(int listIndex) {
    taskIndexProvider = listIndex;
    notifyListeners();
  }

  ///
  void setTaskListIndex() {
    taskIndexProvider = listOfTaskProvider.length + 1;
  }

  ///
  void lastTaskListIndex() {
    taskIndexProvider = listOfTaskProvider.length - 1;
    notifyListeners();
  }
}
