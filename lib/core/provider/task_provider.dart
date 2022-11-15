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
  NoteModel noteInfo =
      NoteModel(0, 'title', 'content', DateTime.now(), DateTime.now(), 0);

  ///

  ///
  List<TaskModel> listOfTaskProvider = [];

  ///
  List<TaskModel> get getTaskListProvider => listOfTaskProvider;

  ///
  Future<List<TaskModel>> getAllTaskById(NoteModel note) async {
    try {
      noteInfo = note;
      print(note.id);
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
    bool checkValue,
    int taskIndex,
  ) async {
    try {
      listOfTaskProvider[taskIndex].check = checkValue;
      notifyListeners();
      await _taskService.checkTaskUpdate(taskId, checkValue);
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }
///
  void addNewTaskProvider(String taskText) {
    // listOfTaskProvider.add(
    //   TaskModel(0, '1', noteInfo.id, false),
    // );
    // notifyListeners();
    _taskService.createTask(taskText, noteInfo.id);
    notifyListeners();
    getAllTaskById(noteInfo);
    notifyListeners();
  }

  ///
  void upsertTasks() {
    _taskService.upsertTasks(listOfTaskProvider);
  }

  ///
  Future<void> deleteTask(int taskId) async {
    try {
      await _taskService.deleteTask(taskId);
      listOfTaskProvider = await _taskService.fetchTaskById(noteInfo.id);
      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  void loadListOfTasks(NoteModel noteInfoK, int listIndex) async {
    noteIndexProvider = 0;
    listOfTaskProvider.clear();
    try {
      noteIndexProvider = listIndex;
      noteInfo = noteInfoK;
      listOfTaskProvider = await _taskService.fetchTaskById(noteInfoK.id);
      notifyListeners();

      //return listOfTaskProvider;
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }
}
