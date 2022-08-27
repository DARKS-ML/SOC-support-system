import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/services.dart' as root_bundle;

import '../model/auth_log_model.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  late List<AuthLogModel> authData;
  late TooltipBehavior _tooltipBehavior;
  ChartSeriesController? _chartSeriesController;
  List<AuthLogModel> data = [];
  Timer? timer;
  int i = 40;

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

  void _updateDataSource(Timer timer, int i) async {
    data.add(authData[i]);
    log(data.length.toString());
    log(i.toString());
    if (data.length == 40) {
      data.removeAt(0);
      _chartSeriesController!.updateDataSource(
        addedDataIndexes: [data.length - 1],
        removedDataIndexes: [0],
      );
    } else {
      _chartSeriesController!.updateDataSource(
        addedDataIndexes: [data.length - 1],
      );
    }
  }

  @override
  void initState() {
    readLocalJsonAuthLog(filename: "");
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _updateDataSource(timer, i++);
    });
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
            int seriesIndex) {
          return Expanded(
            child: SizedBox(
              height: 120,
              width: 350,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date:${data.date.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Time:${data.time.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "IP:${data.ip.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: Text(
                        "Event:${data.event.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ]),
              ),
            ),
          );
        });

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
    readLocalJsonAuthLog(filename: "");
    final Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FloatingActionButton(
          onPressed: () => Navigator.pushReplacementNamed(
            context,
            '/dashboard',
          ),
          backgroundColor: Colors.white,
          elevation: 5,
          child: const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Container(
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
                  child: SfCartesianChart(
                    enableAxisAnimation: true,
                    tooltipBehavior: _tooltipBehavior,
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                        labelRotation: 45,
                        majorGridLines: const MajorGridLines(width: 0),
                        isVisible: true),
                    series: <LineSeries<AuthLogModel, String>>[
                      LineSeries<AuthLogModel, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        dataSource: data,
                        color: const Color.fromRGBO(192, 108, 132, 1),
                        xValueMapper: (AuthLogModel auth, _) => auth.time,
                        yValueMapper: (AuthLogModel auth, _) => auth.modZscore,
                      )
                    ],
                  ),
                ),
              ),
              // Container(
              //   height: height * 0.55,
              //   width: width,
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       boxShadow: const [
              //         BoxShadow(
              //           color: Colors.blue,
              //           offset: Offset(0.0, 1.0),
              //           blurRadius: 10.0,
              //         ),
              //       ],
              //       borderRadius: BorderRadius.circular(20)),
              //   child: FutureBuilder(
              //       future: readLocalJsonAuthLog(filename: ""),
              //       builder: (context, data) {
              //         if (data.hasError) {
              //           return Center(
              //             child: Text("Error::::${data.error}"),
              //           );
              //         } else if (data.hasData) {
              //           // authData = data.data as List<AuthLogModel>;

              //           return Padding(
              //             padding: const EdgeInsets.all(5.0),
              //             child: SfCartesianChart(
              //               title: ChartTitle(text: "Histogram Chart"),
              //               legend: Legend(isVisible: true),
              //               series: <ChartSeries>[
              //                 HistogramSeries<AuthLogModel, num>(
              //                     // dataLabelSettings:
              //                     //     const DataLabelSettings(
              //                     //         angle: 45, isVisible: true),
              //                     name: "Histogram",
              //                     dataSource: authData,
              //                     yValueMapper: (AuthLogModel auth, _) =>
              //                         auth.modZscore,
              //                     binInterval: 0,
              //                     showNormalDistributionCurve: true,
              //                     spacing: 0,
              //                     enableTooltip: true,
              //                     curveColor:
              //                         const Color.fromRGBO(192, 108, 132, 1),
              //                     borderWidth: 3),
              //               ],
              //             ),
              //           );
              //         } else {
              //           return const Center(
              //             child: SizedBox(
              //               height: 100,
              //               width: 100,
              //               child: LoadingIndicator(
              //                   indicatorType: Indicator.lineScalePulseOutRapid,

              //                   /// Required, The loading type of the widget
              //                   colors: [
              //                     Colors.black,
              //                     Colors.grey,
              //                     Colors.red,
              //                     Colors.green
              //                   ],

              //                   /// Optional, The color collections
              //                   strokeWidth: 2,

              //                   /// Optional, The stroke of the line, only applicable to widget which contains line
              //                   backgroundColor: Colors.transparent,

              //                   /// Optional, Background of the widget
              //                   pathBackgroundColor: Colors.black

              //                   /// Optional, the stroke backgroundColor
              //                   ),
              //             ),
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
        ),
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
