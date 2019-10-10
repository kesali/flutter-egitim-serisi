class Todo {
  String name;
  bool complete;

  static List<Todo> todos = [
    Todo('Goto school', false),
    Todo('Eat food', true)
  ];

  Todo(this.name, this.complete);

  static add(String name) {
    todos.add(Todo(name, false));
  }

  static toggle(int index) {
    todos[index].complete = !todos[index].complete;
  }
}
