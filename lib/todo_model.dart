class TodoModel {
  late int id;
  late int userId;
  late String title;
  late bool completed;

  TodoModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });
}
