import 'package:flutter/material.dart';
import 'package:provider_tracker/models/weight.dart';

class WeightState with ChangeNotifier {
  List<Weight> _weights = [
    Weight(value: 65, time: DateTime.utc(2019, 10, 6)),
    Weight(value: 67, time: DateTime.utc(2019, 10, 5)),
    Weight(value: 68, time: DateTime.utc(2019, 10, 4))
  ];

  List<Weight> get weights => _weights;

  add(Weight weight) {
    _weights.insert(0, weight);
    notifyListeners();
  }
}
