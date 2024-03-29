import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dashboard.widget.dart';

IDSChart(
    {required BuildContext context,
    required String title,
    required Future future,
    required TooltipBehavior tooltipBehavior,
    required dynamic getLineChartSeries,
    required bool isPlay,
    required VoidCallback buttonFunction}) {
  final Size size = MediaQuery.of(context).size;
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Stack(
    children: [
      Container(
        height: height * 0.40,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.blue,
                offset: Offset(0.0, 1.0),
                blurRadius: 10.0,
              ),
            ],
            borderRadius: BorderRadius.circular(20)),

        // color: Colors.blue,
        child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  title: ChartTitle(text: title),
                  enableAxisAnimation: true,
                  tooltipBehavior: tooltipBehavior,
                  enableMultiSelection: true,
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                          text: "index",
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      labelRotation: 20,
                      majorGridLines: const MajorGridLines(width: 0),
                      isVisible: true),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(
                          text: "Probabilty",
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      plotBands: <PlotBand>[
                        PlotBand(
                            isVisible: true,
                            start: 0.7,
                            end: 0.7,
                            borderWidth: 2,
                            color: Colors.black),
                      ],
                      labelIntersectAction: AxisLabelIntersectAction.rotate45,
                      axisLine: const AxisLine(width: 0),
                      majorTickLines: const MajorTickLines(size: 10)),
                  series: getLineChartSeries,
                );
              } else {
                return GlobalWidget.loadingWidget(context: context);
              }
            }),
      ),
      Positioned(
          top: 10,
          right: width * 0.07,
          child: InkWell(
            onTap: buttonFunction,
            child: CircleAvatar(
              backgroundColor: (isPlay) ? Colors.red : Colors.blue,
              child: Icon(isPlay ? Icons.pause : Icons.play_arrow_outlined),
            ),
          ))
    ],
  );
}
