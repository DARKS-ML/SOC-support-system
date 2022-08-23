import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../model/auth_log_model.dart';
import '../services/auth_log_services.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  late List<AuthLogModel> authData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
            int seriesIndex) {
          // log(data);
          // log(message)

          return SizedBox(
              height: 50,
              width: 100,
              child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const LoginPage(),
                    //   ),
                    // );
                  },
                  child: Text(
                    "$pointIndex",
                    style: const TextStyle(color: Colors.black),
                  )));
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.80,
            width: width,
            // color: Colors.blue,
            child: FutureBuilder(
                future: readJsonAuthLog(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(
                      child: Text("Error::::${data.error}"),
                    );
                  } else if (data.hasData) {
                    authData = data.data as List<AuthLogModel>;

                    log(authData.length.toString());
                    if (kDebugMode) {
                      print(authData[0].distance);
                    }

                    return Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: SfSparkLineChart.custom(
                        color: Colors.black,
                        marker: const SparkChartMarker(
                            displayMode: SparkChartMarkerDisplayMode.all,
                            shape: SparkChartMarkerShape.circle),
                        trackball: const SparkChartTrackball(
                          activationMode: SparkChartActivationMode.tap,
                          shouldAlwaysShow: true,
                        ),
                        axisLineDashArray: const <double>[0, 0],
                        axisCrossesAt: 0.5,

                        plotBand: const SparkChartPlotBand(start: 3, end: 10),

                        xValueMapper: (int index) => authData[index].date,
                        // Binding the y values
                        yValueMapper: (int index) => authData[index].modZscore!,
                        // Assigning the number of data.
                        dataCount: 50,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
