import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tracker/screens/weight_page.dart';
import 'package:provider_tracker/state/weight_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Provider Tracker Demo',
        home: WeightPage(),
      ),
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider(builder: (context) => WeightState())
      ],
    );
  }
}
