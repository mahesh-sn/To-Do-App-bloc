import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app_bloc/Model/TaskModel.dart';
import 'package:to_do_app_bloc/UI/AddNewTask.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(ToDoInitial()) {
    on<AddNewTaskEvent>((event, emit) {
      Task newTask = Task(taskContent: event.task, taskStatus: 0);
      List<Task> tasks = state.tasks;
      tasks.add(newTask);
      emit(AddNewTaskState(tasks));
    });
    on<UpdateTaskEvent>((event, emit) {
      // Task newTask = Task(taskContent: event.task, taskStatus: 0);
      List<Task> tasks = state.tasks;
      // tasks.add(newTask);
      emit(AddNewTaskState(tasks));
    })
    ;
  }
}
