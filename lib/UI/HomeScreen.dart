import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_bloc/Model/TaskModel.dart';
import 'package:to_do_app_bloc/UI/AddNewTask.dart';
import 'package:to_do_app_bloc/bloc/to_do_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ToDoBloc>().add(InitileTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    print("App Started");
    final toDoBloc = context.read<ToDoBloc>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.grey,
          appBar: getAppBar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
            onPressed: () async {
              var task = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNewTask(),
                ),
              );
              if (task != null && task is String && task.isNotEmpty) {
                print("Task Came to UI- $task");
                toDoBloc.add(AddNewTaskEvent(task: task));
              }
            },
          ),
          body: BlocBuilder<ToDoBloc, ToDoState>(
            builder: (context, state) {
              final tasks = state.tasks;
              print("All tasks which came to UI \n- $tasks");
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  Task currentTask = tasks[index];
                  return Container(
                    color: currentTask.taskStatus==0 ? Colors.grey : Colors.green,
                    child: ListTile(
                      title: Text(currentTask.taskContent),
                      trailing: Checkbox(
                        value: currentTask.taskStatus == 1,
                        onChanged: (value) {
                          print("Value-$value");
                          context.read<ToDoBloc>().add(UpdateTaskStatusEvent(
                              taskId: currentTask.taskId,
                              taskStatus: currentTask.taskStatus == 1 ? 0 : 1));
                        },
                      ),
                    ),
                  );
                },
              );
            },
          )),
    );
  }

  ///This function will return the App Bar for the app
  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: Colors.cyanAccent,
      title: const Text("To-Do Application"),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
      ],
    );
  }
}
