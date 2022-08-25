// class ChartDetailsScreen extends StatelessWidget {

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../model/auth_log_model.dart';
import '../../services/auth_log_services.dart';

class AuthChartDetailsScreen extends StatefulWidget {
  final String fileName;
  const AuthChartDetailsScreen({Key? key, required this.fileName})
      : super(key: key);

  @override
  State<AuthChartDetailsScreen> createState() => _AuthChartDetailsScreenState();
}

class _AuthChartDetailsScreenState extends State<AuthChartDetailsScreen> {
  late List<AuthLogModel> authData;
  late TooltipBehavior _tooltipBehavior;
  List<AuthLogModel> barData = [];

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
                    height: height * 0.50,
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
                        future: readJsonAuthLog(filename: widget.fileName),
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
                                    displayMode:
                                        SparkChartMarkerDisplayMode.all,
                                    shape: SparkChartMarkerShape.circle),
                                trackball: const SparkChartTrackball(
                                  activationMode: SparkChartActivationMode.tap,
                                  shouldAlwaysShow: true,
                                ),
                                // axisLineDashArray: const <double>[0, 0],
                                axisCrossesAt: 0,
                                axisLineColor: Colors.black,

                                // plotBand: const SparkChartPlotBand(
                                //     start: 7, end: 14, color: Colors.yellow),

                                xValueMapper: (int index) => authData[index].ip,
                                // Binding the y values
                                yValueMapper: (int index) =>
                                    authData[index].modZscore!,
                                // Assigning the number of data.
                                dataCount: 50,
                              ),
                            );
                          } else {
                            return const Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: LoadingIndicator(
                                    indicatorType:
                                        Indicator.lineScalePulseOutRapid,

                                    /// Required, The loading type of the widget
                                    colors: [
                                      Colors.black,
                                      Colors.grey,
                                      Colors.red,
                                      Colors.green
                                    ],

                                    /// Optional, The color collections
                                    strokeWidth: 2,

                                    /// Optional, The stroke of the line, only applicable to widget which contains line
                                    backgroundColor: Colors.transparent,

                                    /// Optional, Background of the widget
                                    pathBackgroundColor: Colors.black

                                    /// Optional, the stroke backgroundColor
                                    ),
                              ),
                            );
                          }
                        }),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: height * 0.45,
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
                  child: FutureBuilder(
                      future: readJsonAuthLog(filename: widget.fileName),
                      builder: (context, data) {
                        if (data.hasError) {
                          return Center(
                            child: Text("Error::::${data.error}"),
                          );
                        } else if (data.hasData) {
                          authData = data.data as List<AuthLogModel>;
                          for (var i = 0; i < 70; i++) {
                            barData.add(authData[i]);
                          }

                          log(authData.length.toString());
                          if (kDebugMode) {
                            print(authData[0].distance);
                          }

                          return Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: SfCartesianChart(
                              series: <ChartSeries>[
                                ColumnSeries<AuthLogModel, String>(
                                  dataSource: barData,
                                  xValueMapper: (AuthLogModel m, index) =>
                                      m.time,
                                  yValueMapper: (AuthLogModel m, index) =>
                                      m.label,
                                )
                              ],
                              primaryXAxis: CategoryAxis(
                                  labelRotation: 45,
                                  title: AxisTitle(text: "Time")),
                              primaryYAxis:
                                  NumericAxis(title: AxisTitle(text: "Label")),

                              tooltipBehavior: _tooltipBehavior,
                              // isTransposed: false,
                              enableAxisAnimation: true,
                            ),
                          );
                        } else {
                          return const Center(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: LoadingIndicator(
                                  indicatorType:
                                      Indicator.lineScalePulseOutRapid,

                                  /// Required, The loading type of the widget
                                  colors: [
                                    Colors.black,
                                    Colors.grey,
                                    Colors.red,
                                    Colors.green
                                  ],

                                  /// Optional, The color collections
                                  strokeWidth: 2,

                                  /// Optional, The stroke of the line, only applicable to widget which contains line
                                  backgroundColor: Colors.transparent,

                                  /// Optional, Background of the widget
                                  pathBackgroundColor: Colors.black

                                  /// Optional, the stroke backgroundColor
                                  ),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
