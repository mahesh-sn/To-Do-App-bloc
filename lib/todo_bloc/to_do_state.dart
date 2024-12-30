part of 'to_do_bloc.dart';

@immutable
sealed class ToDoState {}

final class ToDoValueState extends ToDoState {
  List<Task> tasks = [];
  // DatabaseService databaseService
  ToDoValueState();

  List<Task> addTask(String task)  {
    tasks.add(Task(taskContent: task, taskStatus: 0));
    return tasks;
  }
}
