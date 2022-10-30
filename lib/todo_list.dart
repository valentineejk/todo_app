import 'package:flutter/material.dart';
import 'package:todo_app/add_todo.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODOs'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          gotoAddPage();
        },
        label: Text("Add"),
      ),
    );
  }

  void gotoAddPage() {
    final route = MaterialPageRoute(builder: (context) => AddTodo());
    Navigator.push(context, route);
  }

  Future<void> fetchTodo() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final Response = await http.get(uri);
  }
}
