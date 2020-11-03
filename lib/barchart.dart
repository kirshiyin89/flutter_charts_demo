import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';
import 'package:flutter_charts/util.dart';

import 'dto.dart';

class StackedBarChart extends StatelessWidget {
  final Future<List<LinearExpenses>> expenses;
  static const platform =
      const MethodChannel('com.example.flutter.dart/flutter_chart');

  StackedBarChart(this.expenses);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LinearExpenses>>(
        future: this.expenses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return charts.BarChart(
              prepareBarChart(snapshot.data),
              animate: true,
            );
          } else {
            return new Container();
          }
        });
  }
}
