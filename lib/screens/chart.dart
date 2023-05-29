import 'package:bordeaux/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';




class Chart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Chart({Key? key}) : super(key: key);

  @override
  ChartState createState() => ChartState();
}

class ChartState extends State<Chart> {
  List<_SalesData> data = [
    _SalesData('May 04', 0),
    _SalesData('May 05', 01),
    _SalesData('May 06', 02),
    _SalesData('May 07', 01),
    _SalesData('May 08', 02)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),enableAxisAnimation: true,
              // Chart title

              // Enable legend

        title: ChartTitle(text: 'How much user drink',textStyle: TextStyle(color: AppColors.primary,fontSize: 12)),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                   color: AppColors.primary,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),

        ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}