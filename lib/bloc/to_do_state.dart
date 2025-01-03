part of 'to_do_bloc.dart';

@immutable
sealed class ToDoState {
  List<Task> tasks;
  ToDoState({required this.tasks});
}

class ToDoInitial extends ToDoState {
  ToDoInitial() : super(tasks: []);
}

class AddNewTaskState extends ToDoState {
  AddNewTaskState(List<Task> tasks) : super(tasks: tasks);
}

class UpdateTaskState extends ToDoState {
  UpdateTaskState(List<Task> tasks) : super(tasks: tasks);
}

class InitialTaskState extends ToDoState {
  InitialTaskState(List<Task> tasks) : super(tasks: tasks);
}

class SelectToDeleteState extends ToDoState {
  List<Task> tasks;
  SelectToDeleteState({required this.tasks}) : super(tasks: tasks);
}
