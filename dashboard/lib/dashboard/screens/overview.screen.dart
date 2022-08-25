import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Model/auth_log_model.dart';
import '../services/auth_log_services.dart';
import 'package:flutter/services.dart' as root_bundle;

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  List<AuthLogModel>? authData;
  late TooltipBehavior _tooltipBehavior;
  ChartSeriesController? _chartSeriesController;
  List<AuthLogModel> data = [];
  Timer? timer;
  int i = 20;

  Future<List<AuthLogModel>?> readLocalJsonAuthLog({
    required String filename,
  }) async {
    final jsondata = await root_bundle.rootBundle.loadString(
      // filename,
      'Predicted Results/Auth Log/json/auth_2022_08_23__10_25_08.json',
    );
    final list = json.decode(jsondata) as List<dynamic>;
    authData = list.map((e) => AuthLogModel.fromJson(e)).toList();
    return authData;
  }

  void _updateDataSource(Timer timer, int i) {
    // data.add(AuthLogModel(count, _getRandomInt(10, 100)));
    data.add(authData![i]);
    log(data.length.toString());
    log(i.toString());
    if (data.length == 40) {
      data.removeAt(0);
      _chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[data.length - 1],
        removedDataIndexes: <int>[0],
      );
    } else {
      _chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[data.length - 1],
      );
    }
  }

  @override
  void initState() {
    readLocalJsonAuthLog(filename: "");
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      _updateDataSource(timer, i++);
    });
    _tooltipBehavior = TooltipBehavior(enable: true);
    // _tooltipBehavior = TooltipBehavior(
    //     enable: true,
    //     builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
    //         int seriesIndex) {
    //       // log(data);
    //       // log(message)

    //       return SizedBox(
    //           height: 50,
    //           width: 100,
    //           child: InkWell(
    //               onTap: () {
    //                 // Navigator.push(
    //                 //   context,
    //                 //   MaterialPageRoute(
    //                 //     builder: (context) => const LoginPage(),
    //                 //   ),
    //                 // );
    //               },
    //               child: Text(
    //                 "$pointIndex",
    //                 style: const TextStyle(color: Colors.black),
    //               )));
    //     });
    // Future.delayed(const Duration(seconds: 1), () {
    //   setState(() {
    //     if (i < authData.length) {
    //       data.add(authData[i]);
    //     }
    //     return;
    //   });
    // });
    // log(data.length.toString());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    data.clear();
    _chartSeriesController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    readJsonAuthLog(filename: "");
    final Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SfCartesianChart(
              enableAxisAnimation: true,
              tooltipBehavior: _tooltipBehavior,
              plotAreaBorderWidth: 0,
              
              // primaryXAxis: CategoryAxis(
              //     // visibleMaximum: 10,
              //     // visibleMinimum: 7,
              //     labelPlacement: LabelPlacement.onTicks,
              //     interval: 1,
              //     name: 'primaryXAxis',
              //     axisLine: const AxisLine(width: 0, color: Colors.transparent),
              //     edgeLabelPlacement: EdgeLabelPlacement.shift,
              //     majorGridLines: const MajorGridLines(width: 0),
              //     axisLabelFormatter: (AxisLabelRenderDetails details) {
              //       if (details.axis.name == 'primaryXAxis') {
              //         return ChartAxisLabel(data[i].date, details.textStyle);
              //       }
              //       return ChartAxisLabel(details.text, details.textStyle);
              //     }),
              primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  isVisible: true),
              // primaryYAxis: NumericAxis(
              //     labelIntersectAction: AxisLabelIntersectAction.rotate45,
              //     axisLine: const AxisLine(width: 0),
              //     majorTickLines: const MajorTickLines(size: 0)),
              series: <LineSeries<AuthLogModel, int>>[
                LineSeries<AuthLogModel, int>(
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController = controller;
                  },
                  dataSource: data,
                  color: const Color.fromRGBO(192, 108, 132, 1),
                  xValueMapper: (AuthLogModel auth, _) => auth.label,
                  yValueMapper: (AuthLogModel auth, _) => auth.modZscore,
                  animationDuration: 0,
                )
              ]),
          // SizedBox(
          //   height: height * 0.80,
          //   width: width,
          //   // color: Colors.blue,
          //   child: FutureBuilder(
          //       future: readLocalJsonAuthLog(filename: ""),
          //       builder: (context, data) {
          //         if (data.hasError) {
          //           return Center(
          //             child: Text("Error::::${data.error}"),
          //           );
          //         } else if (data.hasData) {
          //           // authData = data.data as List<AuthLogModel>;
          //           // log(data.data.toString());

          //           log(authData!.length.toString());
          //           if (kDebugMode) {}

          //           return Padding(
          //               padding: const EdgeInsets.all(50.0),
          //               child: SfCartesianChart(
          //                   plotAreaBorderWidth: 0,
          //                   primaryXAxis: NumericAxis(
          //                       majorGridLines: const MajorGridLines(width: 0)),
          //                   primaryYAxis: NumericAxis(
          //                       axisLine: const AxisLine(width: 0),
          //                       majorTickLines: const MajorTickLines(size: 0)),
          //                   series: <LineSeries<AuthLogModel, int>>[
          //                     LineSeries<AuthLogModel, int>(
          //                       onRendererCreated:
          //                           (ChartSeriesController controller) {
          //                         _chartSeriesController = controller;
          //                       },
          //                       dataSource: authData!,
          //                       color: const Color.fromRGBO(192, 108, 132, 1),
          //                       xValueMapper: (AuthLogModel auth, _) =>
          //                           auth.label,
          //                       yValueMapper: (AuthLogModel auth, _) =>
          //                           auth.modZscore,
          //                       animationDuration: 0,
          //                     )
          //                   ]));
          //         } else {
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         }
          //       }),
          // ),

          const SizedBox(
            height: 10,
          ),
          // SizedBox(
          //   height: height * 0.80,
          //   width: width,
          //   // color: Colors.blue,
          //   child: FutureBuilder(
          //       future: readJsonAuthLog(filename: ""),
          //       builder: (context, data) {
          //         if (data.hasError) {
          //           return Center(
          //             child: Text("Error::::${data.error}"),
          //           );
          //         } else if (data.hasData) {
          //           authData = data.data as List<AuthLogModel>;

          //           log(authData.length.toString());
          //           if (kDebugMode) {
          //             print(authData[0].distance);
          //           }

          //           return Padding(
          //             padding: const EdgeInsets.all(50.0),
          //             child: SfSparkLineChart.custom(
          //               axisLineColor: Colors.red,
          //               color: Colors.black,
          //               marker: const SparkChartMarker(
          //                   displayMode: SparkChartMarkerDisplayMode.all,
          //                   shape: SparkChartMarkerShape.circle),
          //               trackball: const SparkChartTrackball(
          //                 activationMode: SparkChartActivationMode.tap,
          //                 shouldAlwaysShow: true,
          //               ),
          //               axisLineDashArray: const <double>[2, 2],
          //               axisCrossesAt: 0,

          //               plotBand: const SparkChartPlotBand(start: 3, end: 10),

          //               xValueMapper: (int index) => authData[i].date,
          //               // Binding the y values
          //               yValueMapper: (int index) => authData[i].modZscore!,
          //               // Assigning the number of data.
          //               dataCount: i,
          //               // labelDisplayMode: SparkChartLabelDisplayMode.low,
          //             ),
          //           );
          //         } else {
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         }
          //       }),
          // ),

          const SizedBox(
            height: 100,
          ),
          // SizedBox(
          //   height: height * 0.80,
          //   width: width,
          //   // color: Colors.blue,
          //   child: FutureBuilder(
          //       future: readJsonAuthLog(),
          //       builder: (context, data) {
          //         if (data.hasError) {
          //           return Center(
          //             child: Text("Error::::${data.error}"),
          //           );
          //         } else if (data.hasData) {
          //           authData = data.data as List<AuthLogModel>;

          //           log(authData.length.toString());
          //           if (kDebugMode) {
          //             print(authData[0].distance);
          //           }

          //           return Padding(
          //             padding: const EdgeInsets.all(50.0),
          //             child: SfCartesianChart(
          //               legend: Legend(isVisible: true),

          //               series: <ChartSeries>[
          //                 ColumnSeries<AuthLogModel, String>(
          //                   dataSource: authData,
          //                   xValueMapper: (AuthLogModel m, index) => m.time,
          //                   yValueMapper: (AuthLogModel m, index) => m.label,
          //                 )
          //               ],
          //               primaryXAxis:
          //                   CategoryAxis(title: AxisTitle(text: "label")),
          //               primaryYAxis:
          //                   NumericAxis(title: AxisTitle(text: "time")),

          //               tooltipBehavior: _tooltipBehavior,
          //               // isTransposed: false,
          //               // enableAxisAnimation: false,
          //             ),
          //           );
          //         } else {
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         }
          //       }),
          // ),
        ],
      ),
    );
  }

  // Future<void> updateDataSource(Timer timer) async {
  //   // authData.add(AuthLogModel(time++, (math.Random().nextInt(60) + 30)));
  //   log(authData[0].toString());
  //   authData.removeAt(0);
  //   _chartSeriesController.updateDataSource(
  //       addedDataIndex: authData.length - 1, removedDataIndex: 0);
  // }
}

// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

// import '../model/auth_log_model.dart';
// import '../services/auth_log_services.dart';

// class OverViewScreen extends StatefulWidget {
//   const OverViewScreen({Key? key}) : super(key: key);

//   @override
//   State<OverViewScreen> createState() => _OverViewScreenState();
// }

// class _OverViewScreenState extends State<OverViewScreen> {
//   late List<AuthLogModel> authData;
//   late TooltipBehavior _tooltipBehavior;

//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(
//         enable: true,
//         builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
//             int seriesIndex) {
//           // log(data);
//           // log(message)

//           return SizedBox(
//               height: 50,
//               width: 100,
//               child: InkWell(
//                   onTap: () {
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => const LoginPage(),
//                     //   ),
//                     // );
//                   },
//                   child: Text(
//                     "$pointIndex",
//                     style: const TextStyle(color: Colors.black),
//                   )));
//         });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: height * 0.80,
//             width: width,
//             // color: Colors.blue,
//             child: FutureBuilder(
//                 future: readJsonAuthLog(
//                   filename:
//                       "Predicted Results/Auth Log/json/auth_2022_08_23__09_53_13.json",
//                 ),
//                 builder: (context, data) {
//                   if (data.hasError) {
//                     return Center(
//                       child: Text("Error::::${data.error}"),
//                     );
//                   } else if (data.hasData) {
//                     authData = data.data as List<AuthLogModel>;

//                     log(authData.length.toString());
//                     if (kDebugMode) {
//                       print(authData[0].distance);
//                     }

//                     return Padding(
//                       padding: const EdgeInsets.all(50.0),
//                       child: SfSparkLineChart.custom(
//                         color: Colors.black,
//                         marker: const SparkChartMarker(
//                             displayMode: SparkChartMarkerDisplayMode.all,
//                             shape: SparkChartMarkerShape.circle),
//                         trackball: const SparkChartTrackball(
//                           activationMode: SparkChartActivationMode.tap,
//                           shouldAlwaysShow: true,
//                         ),
//                         axisLineDashArray: const <double>[0, 0],
//                         axisCrossesAt: 0.5,

//                         plotBand: const SparkChartPlotBand(start: 3, end: 10),

//                         xValueMapper: (int index) => authData[index].date,
//                         // Binding the y values
//                         yValueMapper: (int index) => authData[index].modZscore!,
//                         // Assigning the number of data.
//                         dataCount: 50,
//                       ),
//                     );
//                   } else {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
