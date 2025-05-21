import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../models/todo.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _controller = TextEditingController();

  void _saveTodo() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final newTodo = Todo(name: text);
    await DatabaseHelper().insertTodo(newTodo);
    Navigator.pop(context); // Geri dön
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Görev")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Görev"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTodo,
              child: const Text("Kaydet"),
            ),
          ],
        ),
      ),
    );
  }
}
