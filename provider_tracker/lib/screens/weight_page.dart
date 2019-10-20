import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:provider_tracker/models/weight.dart';
import 'package:provider_tracker/state/weight_state.dart';

class WeightPage extends StatelessWidget {
  const WeightPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Weight tracker"),
      ),
      body: Consumer<WeightState>(builder: (context, state, a) {
        var weights = state.weights;

        return Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Current Weight: "),
                        Text(
                          state.currentWeight.value.toString() + " kg",
                          textScaleFactor: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var weight = weights[index];
                  return ListTile(
                    title: Text(
                      "${weight.date.day}.${weight.date.month}.${weight.date.year}",
                      textScaleFactor: 0.9,
                    ),
                    trailing: Text(
                      weight.value.toString() + " kg",
                      textScaleFactor: 2.0,
                    ),
                  );
                },
                itemCount: state.weights.length,
              ),
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var state = Provider.of<WeightState>(context, listen: false);
          var result =
              await _showAddWeightDialog(context, state.currentWeight.value);

          if (result != null && result > 0) {
            state.add(Weight(value: result, date: DateTime.now()));
          }
        },
      ),
    ));
  }

  Future<double> _showAddWeightDialog(
      BuildContext context, double currentWeight) async {
    return await showDialog<double>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.decimal(
            minValue: 1,
            maxValue: 200,
            title: Text("Add your new weight"),
            initialDoubleValue: currentWeight, //weights.first.value,
          );
        });
  }
}
