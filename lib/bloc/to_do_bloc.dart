import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app_bloc/Model/task_model.dart';
import 'package:to_do_app_bloc/database_service/database_service.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  DatabaseService databaseService = DatabaseService.databaseService;

  ToDoBloc() : super(ToDoInitial()) {
    on<AddNewTaskEvent>((event, emit) async {
      int taskId = await databaseService.addNewTask(event.task) ?? 0;

      print("Task Id came from the Db - $taskId");
      if (taskId == 0) {
        print("An error occured while inserting the Data into Database");
      }
      Task newTask =
          Task(taskContent: event.task, taskStatus: 0, taskId: taskId);
      List<Task> tasks = state.tasks;

      tasks.add(newTask);
      emit(AddNewTaskState(tasks));
    });

    on<UpdateTaskStatusEvent>((event, emit) async {
      print("Called UpdateTaskStatusEvent");
      int taskId = event.taskId;
      int taskStatus = event.taskStatus;
      databaseService.updateTaskStatus(taskId, taskStatus);

      List<Task> tasks = await databaseService.getAllTasks();
      print("Tasks got from database after updating the status is: \n $tasks");
      emit(UpdateTaskState(tasks));
    });

    on<InitileTaskEvent>(
      (event, emit) async {
        List<Task> tasks = await databaseService.getAllTasks();
        print("Got tasks from DB as Initial Task Event- $tasks");
        emit(InitialTaskState(tasks));
      },
    );
    on<SelectToDeleteEvent>(
      (event, emit) async {
        List<Task> tasks = [];
        try {
          List<int> taskIds = event.taskIds;
          await databaseService.deleteAllTaskById(taskIds);
          print("Deleted all tasks with IDs- $taskIds");
          tasks = await databaseService.getAllTasks();
        } catch (e) {}
        emit(SelectToDeleteState(tasks: tasks));
      },
    );
  }
}
