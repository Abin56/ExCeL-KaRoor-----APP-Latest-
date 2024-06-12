import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeWorkGraphOfStd extends StatefulWidget {
  const HomeWorkGraphOfStd({
    super.key,
    required this.completed,
    required this.pending,
    // required this.total
  });

  final int completed;
  final int pending;
  //final int total;

  @override
  State<HomeWorkGraphOfStd> createState() => _HomeWorkGraphOfStdState();
}

class _HomeWorkGraphOfStdState extends State<HomeWorkGraphOfStd> {
  @override
  Widget build(BuildContext context) {
    double totalhomeworks = 10;
    // if (widGet.total != 0) {
    //   totalhomeworks = widget.completed * (100 / widGet.total);
    // }

    final List<ChartData> chartData = [
      ChartData('completed', widget.completed.toDouble(),
          const Color.fromARGB(255, 65, 125, 252)),
      ChartData('pending', widget.pending.toDouble(),
          const Color.fromARGB(255, 255, 0, 0)),
      // ChartData('Pending', widget.pending.toDouble(),
      //     const Color.fromARGB(255, 255, 251, 0))

      // ChartData('Jack', 34, const Color.fromRGBO(228, 0, 124, 1)),
      // ChartData('Others', 52, const Color.fromRGBO(255, 189, 57, 1))
    ];
    return SfCircularChart(
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            height:
                '100%', // Setting height and width for the circular chart annotation
            width: '100%',
            widget: PhysicalModel(
                shape: BoxShape.circle,
                elevation: 10,
                shadowColor: Colors.black,
                color: const Color.fromRGBO(230, 230, 230, 1),
                child: Container())),
        CircularChartAnnotation(
            widget: Text(totalhomeworks.roundToDouble().toString(),
                style: const TextStyle(color: Colors.black, fontSize: 23)))
      ],
      series: <DoughnutSeries<ChartData, String>>[
        DoughnutSeries<ChartData, String>(
          innerRadius: '50%',
          dataSource: chartData,
          animationDuration: 1,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (data, index) => data.color,
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class HomeWorkGraph extends StatelessWidget {
  const HomeWorkGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: cWhite,
      child: const HomeWorkGraphOfStd(
        pending: 5,
        completed: 15,
        //  total: 21,
      ),
    );
  }
}
