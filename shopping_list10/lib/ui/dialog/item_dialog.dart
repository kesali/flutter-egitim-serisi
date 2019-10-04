import 'package:flutter/material.dart';

class ItemDialog extends StatefulWidget {
  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final _formKey = GlobalKey<FormState>();
  String _itemName;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Add your shopping item."),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: TextFormField(
                  maxLength: 50,
                  onSaved: (value) => _itemName = value,
                  autofocus: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "valdiation error";
                    }

                    return '';
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              FlatButton(
                child: Text("Add item to shopping list"),
                onPressed: _saveForm,
                color: Theme.of(context).accentColor,
              )
            ],
          ),
        )
      ],
    );
  }

  void _saveForm() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      Navigator.pop(context, _itemName);
    }
  }
}
