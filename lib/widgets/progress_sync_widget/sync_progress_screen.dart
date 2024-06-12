import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel_karoor/view/colors/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgressDialog extends StatelessWidget {
  final RxDouble progressValue;

  const ProgressDialog({super.key, required this.progressValue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => SizedBox(
          height: 300,
          width: 300,
          child: SfRadialGauge(
              backgroundColor: Colors.transparent,
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  radiusFactor: 0.8,
                  axisLineStyle: const AxisLineStyle(
                      cornerStyle: CornerStyle.bothFlat,
                      color: Colors.black12,
                      dashArray: [10, 8],
                      thickness: 32),
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0.1,
                      widget: Text(
                        '${(progressValue * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: progressValue * 100,
                      dashArray: const [10, 8],
                      cornerStyle: CornerStyle.bothFlat,
                      width: 32,
                      sizeUnit: GaugeSizeUnit.logicalPixel,
                      color:adminePrimayColor,
                    ),
                    MarkerPointer(
                        value: progressValue * 100,
                        color: const Color(0xFFEE0979))
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
