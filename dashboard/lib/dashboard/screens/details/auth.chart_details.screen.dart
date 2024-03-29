// class ChartDetailsScreen extends StatelessWidget {

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/auth_model/auth_log_model.dart';

class AuthChartDetailsScreen extends StatefulWidget {
  final String fileName;
  const AuthChartDetailsScreen({Key? key, required this.fileName})
      : super(key: key);

  @override
  State<AuthChartDetailsScreen> createState() => _AuthChartDetailsScreenState();
}

class _AuthChartDetailsScreenState extends State<AuthChartDetailsScreen> {
  List<AuthLogModel> chartData = [];
  List<AuthLogModel> livePlot = [];
  ChartSeriesController? _chartSeriesController;
  late TooltipBehavior _tooltipBehavior;

  Timer? timer;
  int data = 0;
  bool isPlay = true;
  void _updateDataSource(Timer timer) {
    if (isPlay) {
      log(chartData.length.toString());
      livePlot = chartData.sublist(data + 50, (data + 50) + 50);

      // livePlot.add(chartData[i]);
      log("length of liveplot dtata${livePlot.length}");
      log("i ko lethgth$data");
      if (livePlot.length == 50) {
        // livePlot.removeAt(0);
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[livePlot.length + 1],
          // removedDataIndexes: <int>[0],
        );
      } else {
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[livePlot.length - 1],
        );
      }
      data++;
    } else {
      livePlot = livePlot;
    }
  }

  Future loadAuthLog() async {
    final String jsonString =
        await getJsonFromAssets(filename: widget.fileName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      chartData.add(AuthLogModel.fromJson(i));
    }
  }

  Future<String> getJsonFromAssets({required String filename}) async {
    String path = filename;
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  // Future<String> getJsonFromAssets({
  //   required String filename,
  // }) async {
  //   return await rootBundle.loadString(filename);
  // }

  @override
  void initState() {
    log("File name${widget.fileName}");
    loadAuthLog();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDataSource(timer);
      isPlay ?  setState(() {}) : null;
    });
    _tooltipBehavior = onLiveHover();

    super.initState();
  }

  TooltipBehavior onLiveHover() {
    return TooltipBehavior(
        enable: true,
        builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
            int seriesIndex) {
          return Expanded(
            child: SizedBox(
              height: 150,
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
                      Text(
                        "ModZScore:${data.modZscore.toString()}",
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
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton: GlobalWidget.displayBackButton(context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
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
                            future:
                                getJsonFromAssets(filename: widget.fileName),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SfCartesianChart(
                                  title:
                                      ChartTitle(text: "Timestamp Vs Distance"),
                                  enableAxisAnimation: true,
                                  tooltipBehavior: _tooltipBehavior,
                                  enableMultiSelection: true,
                                  plotAreaBorderWidth: 0,
                                  primaryXAxis: CategoryAxis(
                                      title: AxisTitle(
                                          text: "Timestamp",
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      labelRotation: 70,
                                      majorGridLines:
                                          const MajorGridLines(width: 0),
                                      isVisible: true),
                                  primaryYAxis: NumericAxis(
                                      title: AxisTitle(
                                          text: "Distance",
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      plotBands: <PlotBand>[
                                        PlotBand(
                                            isVisible: true,
                                            start: 3,
                                            end: 3.1,
                                            color: Colors.red),
                                      ],
                                      labelIntersectAction:
                                          AxisLabelIntersectAction.rotate45,
                                      axisLine: const AxisLine(width: 0),
                                      majorTickLines:
                                          const MajorTickLines(size: 10)),
                                  series: <LineSeries<AuthLogModel, String>>[
                                    LineSeries<AuthLogModel, String>(
                                      markerSettings: const MarkerSettings(
                                        isVisible: true,
                                      ),

                                      onRendererCreated:
                                          (ChartSeriesController controller) {
                                        _chartSeriesController = controller;
                                      },
                                      dataSource: livePlot,
                                      color: const Color.fromRGBO(
                                          192, 108, 132, 1),
                                      xValueMapper: (AuthLogModel auth, _) =>
                                          auth.time,
                                      yValueMapper: (AuthLogModel auth, _) =>
                                          auth.distance,
                                      // animationDuration: 0,
                                    )
                                  ],
                                );
                              } else {
                                return GlobalWidget.loadingWidget(
                                    context: context);
                              }
                            }),
                      ),
                    ),
                    Positioned(
                        top: 10,
                        right: width * 0.07,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isPlay ? isPlay = false : isPlay = true;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                (isPlay) ? Colors.red : Colors.blue,
                            child: Icon(isPlay
                                ? Icons.pause
                                : Icons.play_arrow_outlined),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: height * 0.48,
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
                      future: getJsonFromAssets(filename: widget.fileName),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SfCartesianChart(
                            title: ChartTitle(text: "Histogram Chart"),
                            legend: Legend(isVisible: true),
                            primaryXAxis: CategoryAxis(
                              title: AxisTitle(
                                text: "Label",
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              isVisible: true,
                            ),
                            primaryYAxis: CategoryAxis(
                              title: AxisTitle(
                                text: "Count",
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            series: <ChartSeries>[
                              HistogramSeries<AuthLogModel, num>(
                                  dataLabelSettings: const DataLabelSettings(
                                      angle: 45, isVisible: true),
                                  name: "Histogram",
                                  dataSource: chartData,
                                  yValueMapper: (AuthLogModel auth, _) =>
                                      auth.label,
                                  binInterval: 1,
                                  // showNormalDistributionCurve: true,
                                  spacing: 0,
                                  // animationDelay: ,
                                  enableTooltip: true,
                                  curveColor:
                                      const Color.fromRGBO(192, 108, 132, 1),
                                  borderWidth: 3),
                            ],
                          );
                        } else {
                          return GlobalWidget.loadingWidget(context: context);
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

  // void updateBarData() {
  //   int start = click;
  //   log("click $start");
  //   if (start < (authData.length) / 2 + 1) {
  //     if (start == 0) {
  //       barData = authData.sublist(start, start + 50);
  //       click++;
  //     } else {
  //       barData = authData.sublist(start + 49, (start + 49) + 50);
  //       click = start + 50;
  //     }
  //   } else {
  //     log("data out of range");
  //   }
  //   log("length of plotted data ${barData.length}");
  // }

}
