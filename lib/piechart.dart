import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dto.dart';
import 'util.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final Future<List<LinearExpenses>> expenses;
  static const platform =
      const MethodChannel('com.example.flutter.dart/flutter_chart');

  PieOutsideLabelChart(this.expenses);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LinearExpenses>>(
        future: this.expenses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return charts.PieChart(preparePieChart(snapshot.data),
                animate: true,
                defaultRenderer: new charts.ArcRendererConfig(
                    arcRendererDecorators: [
                      new charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.inside)
                    ]));
          } else {
            return new Container();
          }
        });
  }
}