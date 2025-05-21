import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../models/todo.dart';

class DetailPage extends StatefulWidget {
  final Todo todo;

  const DetailPage({super.key, required this.todo});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.todo.name);
  }

  void _updateTodo() async {
    final updatedName = _controller.text.trim();
    if (updatedName.isEmpty) return;

    final updatedTodo = Todo(id: widget.todo.id, name: updatedName);
    await DatabaseHelper().updateTodo(updatedTodo);
    Navigator.pop(context); // Geri dön
  }

  void _deleteTodo() async {
    await DatabaseHelper().deleteTodo(widget.todo.id!);
    Navigator.pop(context); // Geri dön
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Görev Detayı")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Görev Adı"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateTodo,
              child: const Text("Güncelle"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _deleteTodo,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Sil"),
            ),
          ],
        ),
      ),
    );
  }
}
