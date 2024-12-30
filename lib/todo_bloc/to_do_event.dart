part of 'to_do_bloc.dart';

@immutable
sealed class ToDoEvent {}

class AddTaskEvent extends ToDoEvent {}

class UpdateTaskEvent extends ToDoEvent {}

class DeleteTaskEvent extends ToDoEvent {}

class InitilizeEvent extends ToDoEvent {}
