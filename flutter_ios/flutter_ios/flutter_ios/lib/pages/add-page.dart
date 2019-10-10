import 'package:flutter/cupertino.dart';
import 'package:flutter_ios/models/todo.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var todos = Todo.todos;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Container(
                child: GestureDetector(
                  onTap: () {
                    Todo.toggle(index);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                          width: 1.0, color: CupertinoColors.inactiveGray),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            todos[index].name,
                            style: TextStyle(
                                decoration: todos[index].complete
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          CupertinoSwitch(
                            onChanged: (bool value) {
                              Todo.toggle(index);
                              setState(() {});
                            },
                            value: todos[index].complete,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: todos.length,
            ),
          ),
          CupertinoTextField(
            controller: _textController,
            prefix: Icon(CupertinoIcons.book),
            suffix: CupertinoButton(
              child: Icon(CupertinoIcons.add_circled_solid),
              onPressed: () {
                Todo.add(_textController.text);
                _textController.clear();
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}
