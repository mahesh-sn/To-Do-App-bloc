import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app_bloc/Model/TaskModel.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(ToDoValueState()) {
    on<AddTaskEvent>((event, emit) {
      final currentState=state as ToDoValueState;
      emit(ToDoValueState());
    });
    on<InitilizeEvent>(
      (event, emit) {
        final currentState = state as ToDoValueState;
        // DatabaseServide databaseServide=DatabaseServide.databaseServide;
        // List<Task> tasks = databaseServide.getAllTasks();
        emit(ToDoValueState());
      },
    );
  }
}
