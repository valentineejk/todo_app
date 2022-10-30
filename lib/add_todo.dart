import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descsController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: "title",
            ),
          ),
          TextFormField(
            controller: _descsController,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            minLines: 5,
            decoration: InputDecoration(
              hintText: "description",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              submitData();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void submitData() async {
    //get data
    final title = _titleController.text;
    final desc = _descsController.text;
    final body = {
      "title": title,
      "description": desc,
      "is_completed": false,
    };
    final headers = {"Content-Type": "application/json"};

    //submit data
    final url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final res = await http.post(uri, body: jsonEncode(body), headers: headers);

    //success or fail
    switch (res.statusCode) {
      case 201:
        print(res.body);
        showMessage("created");
        _titleController.text = "";
        _descsController.text = "";
        break;
      case 401:
        showMessage("Error");
        print(res.body);

        break;
      default:
        showMessage("network issues");
    }
  }

  void showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.teal,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
