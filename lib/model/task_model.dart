class Task {
  int taskId;
  String taskContent;
  int taskStatus;

  Task(
      {required this.taskContent,
      required this.taskId,
      required this.taskStatus});
  @override
  String toString() {
    return "Task Id-$taskId   Task content-$taskContent   Task-status- $taskStatus";
  }
}
