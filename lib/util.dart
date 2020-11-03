import 'dto.dart';
import 'package:charts_flutter/flutter.dart' as charts;

List<charts.Series> preparePieChart(List<LinearExpenses> data) {
  return [
    new charts.Series<LinearExpenses, int>(
        id: 'Expenses',
        domainFn: (LinearExpenses expenses, _) => expenses.year,
        measureFn: (LinearExpenses expenses, _) => expenses.expense,
        data: data,
        labelAccessorFn: (LinearExpenses row, _) =>
            '${row.year}: ${row.expense}')
  ];
}

List<charts.Series<LinearExpenses, String>> prepareBarChart(
    List<LinearExpenses> data) {
  return [
    new charts.Series<LinearExpenses, String>(
        id: 'Expenses',
        domainFn: (LinearExpenses expenses, _) => expenses.year.toString(),
        measureFn: (LinearExpenses expenses, _) => expenses.expense,
        data: data)
  ];
}
