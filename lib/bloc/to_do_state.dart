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
