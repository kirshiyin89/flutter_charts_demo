import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_charts/piechart.dart';

import 'barchart.dart';
import 'dto.dart';

void main() {
  runApp(MyApp());
}

enum ChartType { PIE, BAR }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Charts Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Charts Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform =
      const MethodChannel('com.example.flutter.dart/flutter_chart');

  ChartType dropdownValue = ChartType.PIE;

  Future<List<LinearExpenses>> _getAsyncData() async {
    final Map result = await platform.invokeMethod("getData");
    List<LinearExpenses> data = List();
    result.forEach((k, v) => data.add(LinearExpenses(k, v)));
    data.sort((a, b) => a.compareByYear(b));
    return new Future.value(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chart selector'),
        ),
        body: Container(
          child: new Column(
            children: [
              new Container(
                height: 100.0,
                width: 200.0,
                alignment: Alignment.center,
                child: _createDropDown(context),
              ),
              new Container(
                  height: 200.0,
                  alignment: Alignment.center,
                  child: _createMyChart(dropdownValue)),
            ],
          ),
        ));
  }

  Widget _createDropDown(BuildContext context) {
    return DropdownButton<ChartType>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (ChartType newValue) {
          setState(() {
            dropdownValue = newValue;
            _createMyChart(dropdownValue);
          });
        },
        items: ChartType.values.map((ChartType classType) {
          return DropdownMenuItem<ChartType>(
              value: classType,
              child: Text(classType.toString().split("\.").last));
        }).toList());
  }

  Widget _createMyChart(ChartType chartType) {
    switch (chartType) {
      case ChartType.PIE:
        return new PieInsideLabelChart(_getAsyncData());
        break;
      case ChartType.BAR:
        return new SimpleBarChart(_getAsyncData());
        break;
      default:
        return new PieInsideLabelChart(_getAsyncData());
    }
  }

}
