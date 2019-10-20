// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tracker/screens/weight_page.dart';
import 'package:provider_tracker/state/weight_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            builder: (BuildContext context) => WeightState()),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        home: WeightPage(),
      ),
    );
  }
}
