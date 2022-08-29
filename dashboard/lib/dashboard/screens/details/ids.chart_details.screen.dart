// class ChartDetailsScreen extends StatelessWidget {

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dashboard/dashboard/model/ids_model/ids_bot_model.dart';
import 'package:dashboard/dashboard/widgets/ids_chart.dart';
import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/services.dart' show rootBundle;

class IDSChartDetailsScreen extends StatefulWidget {
  final String fileName;
  const IDSChartDetailsScreen({Key? key, required this.fileName})
      : super(key: key);

  @override
  State<IDSChartDetailsScreen> createState() => _IDSChartDetailsScreenState();
}

class _IDSChartDetailsScreenState extends State<IDSChartDetailsScreen> {
  List<IDSBotModel> chartData = [];
  List<IDSBotModel> liveBot = [];
  ChartSeriesController? _chartSeriesController;
  late TooltipBehavior _tooltipBehavior;
  Timer? timer;
  int data = 0;
  bool isPlay = true;
  void _updateDataSource(Timer timer) {
    if (isPlay) {
      log(chartData.length.toString());
      liveBot = chartData.sublist(data + 40, (data + 40) + 40);

      // livePlot.add(chartData[i]);
      log("length of liveplot dtata${liveBot.length}");
      log("i ko lethgth$data");
      if (liveBot.length == 40) {
        // livePlot.removeAt(0);
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[liveBot.length + 1],
          // removedDataIndexes: <int>[0],
        );
      } else {
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[liveBot.length - 1],
        );
      }
      data++;
    } else {
      liveBot = liveBot;
    }
  }

  Future loadIDSBotLog() async {
    final String jsonString =
        await getJsonFromAssets(filename: widget.fileName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      chartData.add(IDSBotModel.fromJson(i));
    }
  }

  Future<String> getJsonFromAssets({
    required String filename,
  }) async {
    return await rootBundle.loadString(
        // filename
        "Predicted Results/ids/ids_2022_08_28/Bot/json/Bot_2022_08_28.json");
  }

  void PausePlayButton() {
    setState(() {
      isPlay ? isPlay = false : isPlay = true;
    });
  }

  @override
  void initState() {
    loadIDSBotLog();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _updateDataSource(timer);
      isPlay ? setState(() {}) : null;
    });
    _tooltipBehavior = hoverBot();

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
        floatingActionButton: GlobalWidget.displayBackButton(context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: getJsonFromAssets(filename: ""),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getBotChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'IDS Bot',
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<LineSeries<IDSBotModel, String>> getBotChart() {
    return <LineSeries<IDSBotModel, String>>[
      LineSeries<IDSBotModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        onRendererCreated: (ChartSeriesController controller) {
          _chartSeriesController = controller;
        },
        dataSource: liveBot,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (IDSBotModel bot, _) => bot.destinationPort,
        yValueMapper: (IDSBotModel bot, _) => bot.bot == "Bot" ? 1 : -1,
        // animationDuration: 0,
      )
    ];
  }

  TooltipBehavior hoverBot() {
    return TooltipBehavior(
        enable: true,
        builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
            int seriesIndex) {
          return Expanded(
            child: SizedBox(
              height: 100,
              width: 300,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Timestamp:${data.timestamp.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Source Ip:${data.sourceIP.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          "Probability:${data.botProb.toString()}",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ),
            ),
          );
        });
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
