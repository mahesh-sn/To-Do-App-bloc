class Task {
  String taskContent;
  int taskStatus;

  Task(
      {required this.taskContent,
      required this.taskStatus});
  @override
  String toString() {
    return "Task content- $taskContent    Task-status- $taskStatus";
  }
}
