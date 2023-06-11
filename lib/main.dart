import 'package:cr4_lesson_12/todo_model.dart';
import 'package:cr4_lesson_12/todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoModel> _todos = [];

  _fetchTodos() async {
    final response =
        await Dio().get("https://jsonplaceholder.typicode.com/todos");

    final processedData = response.data as List<dynamic>;

    List<TodoModel> todos = processedData
        .map((json) => TodoModel(
              id: json['id'],
              userId: json['userId'],
              title: json['title'],
              completed: json['completed'],
            ))
        .toList();

    setState(() {
      _todos = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: _todos.isEmpty
              ? TextButton(
                  onPressed: _fetchTodos,
                  child: const Text(
                    'Fetch Data',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                )
              : SizedBox(
                  width: 700,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      return TodoWidget(
                        text: _todos[index].title,
                        completed: _todos[index].completed,
                        onChanged: (val) {
                          setState(() {
                            _todos[index].completed = val;
                          });
                        },
                        onDelete: () {
                          setState(() {
                            _todos.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
        ));
  }
}
