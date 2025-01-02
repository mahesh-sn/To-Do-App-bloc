part of 'to_do_bloc.dart';

@immutable
sealed class ToDoEvent {}

class AddNewTaskEvent extends ToDoEvent {
  String task;
  AddNewTaskEvent({required this.task});
}

class UpdateTaskStatusEvent extends ToDoEvent {
  int taskId;
  int taskStatus;
  UpdateTaskStatusEvent({required this.taskId, required this.taskStatus});
}

class InitileTaskEvent extends ToDoEvent {
  InitileTaskEvent();
}
class SelectToDeleteEvent extends ToDoEvent {
  List<int> taskIds;
  SelectToDeleteEvent({required this.taskIds});
}
