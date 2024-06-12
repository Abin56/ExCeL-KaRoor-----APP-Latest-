import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssignmentProjectGraph extends StatelessWidget {
   const AssignmentProjectGraph({super.key});

@override
Widget build(BuildContext context) {
  return  SfCartesianChart(
        // Initialize category axis
        primaryXAxis:  CategoryAxis(),
       //  title:  ChartTitle(text: 'Half yearly analysis', textStyle: const TextStyle(fontSize: 12)),
        // axes: const [CategoryAxis(name: "Sales",)],
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            // Bind data source
            dataSource:  <SalesData>[
              SalesData('Jan', 35),
              SalesData('Feb', 28),
              SalesData('Mar', 34),
              SalesData('Apr', 32),
              SalesData('May', 40)
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales
          ),
           LineSeries<SalesData, String>(
            // Bind data source for purchase line
            dataSource: <SalesData>[
              SalesData('Jan', 20), // Replace with your purchase data
              SalesData('Feb', 25),
              SalesData('Mar', 18),
              SalesData('Apr', 30),
              SalesData('May', 22),
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            name: 'Purchase', // Series name for legend
          ),
        ],
      
    
  );
}


}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
