import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/todo.dart';
import 'add_todo.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final data = await DatabaseHelper().getTodos();
    setState(() {
      todos = data;
    });
  }

  void _goToAddTodo() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodoPage()),
    );
    _loadTodos(); // Geri dönünce listeyi yenile
  }

  void _goToDetail(Todo todo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(todo: todo)),
    );
    _loadTodos(); // Güncelleme/silme sonrası yenile
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yapılacaklar")),
      body: todos.isEmpty
          ? const Center(child: Text("Henüz görev yok."))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(todo.name),
                    onTap: () => _goToDetail(todo),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
