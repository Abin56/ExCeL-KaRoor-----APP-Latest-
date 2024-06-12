import 'package:flutter/material.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AttendancegraphS extends StatelessWidget {
  const AttendancegraphS({super.key,  required this.presentPercentage});

  final double presentPercentage;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
        radiusFactor: 0.9,
        minimum: 0,
        maximum: 100,
        showLabels: false,
        showTicks: false,
        interval: 8,
        ticksPosition: ElementsPosition.inside,
        tickOffset: 10,
        majorTickStyle: const MajorTickStyle(color: Colors.red, length: 0.5),
        minorTickStyle: const MinorTickStyle(color: Colors.white),
        axisLineStyle: const AxisLineStyle(
          thickness: 0.3,
          cornerStyle: CornerStyle.bothFlat,
          color: Color.fromARGB(255, 137, 238, 140),
          thicknessUnit: GaugeSizeUnit.factor,
        ),
        pointers:  <GaugePointer>[
          RangePointer(
            color: Colors.blue,
            value: presentPercentage,
            cornerStyle: CornerStyle.endCurve,
            width: 0.3,
            sizeUnit: GaugeSizeUnit.factor,
          ),
        ],
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
            axisValue: presentPercentage,
            positionFactor: 0.2,
            widget: Column(
              children: [
                Text(
                  '${100-presentPercentage.round()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue, // Text color for present percentage
                  ),
                ),
                const Text(
                  'Absent',
                  style: TextStyle(
                    color: Colors.blue, // Text color for 'Present'
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ]);
  }
}

class ATP extends StatelessWidget {
  const ATP({super.key,  required this.presentPercentage});

  final double presentPercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: cWhite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AttendancegraphS(presentPercentage: presentPercentage),
          const Indicator(), // Add the Indicator widget
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({super.key, });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IndicatorItem(color: Colors.green, text: 'Absent'), // Customize as needed
            IndicatorItem(color: Colors.red, text: 'Present'), // Customize as needed
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class IndicatorItem extends StatelessWidget {
  final Color color;
  final String text;

  const IndicatorItem({super.key,  required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 12),
        ),
      ],
    );
  }
}
