import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/locator.dart';
import 'package:whatsapp_clone/viewmodels/sign_in_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController =
        TextEditingController();

    return ChangeNotifierProvider(
      create: (BuildContext context) => getIt<SignInModel>(),
      child: Consumer<SignInModel>(
        builder: (context, model, widget) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Sign In to Whatsapp Clone"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: model.busy
                    ? CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('User Name'),
                          TextField(
                            controller: _textEditingController,
                          ),
                          model.busy
                              ? CircularProgressIndicator()
                              : RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    'Sing In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async => await model
                                      .signIn(_textEditingController.text),
                                )
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
