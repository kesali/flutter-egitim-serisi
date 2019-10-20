import 'package:flutter/foundation.dart';
import 'package:provider_tracker/models/weight.dart';

class WeightState with ChangeNotifier {
  List<Weight> _weights = [
    Weight(value: 65, date: DateTime.utc(2019, 10, 4)),
    Weight(value: 67, date: DateTime.utc(2019, 10, 3)),
    Weight(value: 69, date: DateTime.utc(2019, 10, 2)),
    Weight(value: 68, date: DateTime.utc(2019, 10, 1)),
  ];

  List<Weight> get weights => _weights;

  Weight get currentWeight => _weights.first;

  add(Weight weight) {
    _weights.insert(0, weight);

    notifyListeners();
  }
}
