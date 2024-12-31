import 'package:flutter/material.dart';

class AddNewTask extends StatelessWidget {
  String task = '';
  AddNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    print("New Screen Add New Task");
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyanAccent,),
        backgroundColor: Colors.grey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Enter the Task",textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "Enter the task"),
              onChanged: (value) {
                task = value;
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            MaterialButton(
              color: Colors.green,
              child: const Text("Add"),
              onPressed: () {
                print("Entered Task is- $task");
                Navigator.pop(context, task);
              },
            )
          ],
        ),
    );
  }
}
