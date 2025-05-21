class Todo {
  final int? id;
  final String name;

  Todo({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(id: map['id'], name: map['name']);
  }
}
