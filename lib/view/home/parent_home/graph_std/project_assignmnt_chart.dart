import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';

void main() {
  runApp(const StdProjectAndAssignmnetGraph());
}

class StdProjectAndAssignmnetGraph extends StatelessWidget {
  const StdProjectAndAssignmnetGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: 250,
        color: cWhite,
        child: const SplineChartOfStd(),
      ),
    );
  }
}

class SplineChartOfStd extends StatelessWidget {
  const SplineChartOfStd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // SplineChart(
          //   values: {
          //     0: 10,
          //     15: 30,
          //     60: 40,
          //     44: 50,
          //   },
          //   //values: {0:10, 7.69 :52, 15.38 :74, 23.08 :1464, 30.77 :942, 38.46 :2433, 46.15 :2379, 53.85 :3820, 61.54 :2750, 69.23 :2739, 76.92 :3057, 84.62 :1598, 92.31 :1450,100:630},
          //   //values: {0.0: 583.0, 50.0: 972.0, 100.0: 910.0},
          //   verticalLineEnabled: false,
          //   verticalLinePosition: 90.0,
          //   verticalLineStrokeWidth: 2.0,
          //   verticalLineText: "Your score",
          //   drawCircles: true,
          //   circleRadius: 4,
          //   width: 200,
          //   height: 400,
          // ),
        ],
      ),
    );
  }
}
