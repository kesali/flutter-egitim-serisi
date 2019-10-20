class Todo {
  String name;
  bool complete;

  static List<Todo> todos = [
    Todo('Go to school', false),
    Todo('Eat your lunch', true)
  ];

  Todo(this.name, this.complete);

  static add(String name) {
    todos.add(Todo(name, false));
  }

  toggle() {
    complete = !complete;
  }
}
