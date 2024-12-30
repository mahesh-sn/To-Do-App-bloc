import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_bloc/UI/AddNewTask.dart';
import 'package:to_do_app_bloc/todo_bloc/to_do_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                  builder: ( context ) => AddNewTask(),
                ),
              );

              if (task != null && task is String && task.isNotEmpty) {
                print("Task Came to UI- $task");
                // toDoBloc.add(AddTaskEvent()); // Pass the task correctly
              }
            },
          ),
          body: BlocBuilder<ToDoBloc, ToDoState>(
            builder: (context, state) {
              final tasks = (state as ToDoValueState).tasks;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index].taskContent),
                    trailing: Checkbox(
                      value: tasks[index].taskStatus == 1,
                      onChanged: (value) {},
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
