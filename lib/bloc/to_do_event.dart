part of 'to_do_bloc.dart';

@immutable
sealed class ToDoEvent {}

class AddNewTaskEvent extends ToDoEvent {
  String task;
  AddNewTaskEvent({required this.task});
}

class UpdateTaskEvent extends ToDoEvent {}
