import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/services.dart' as root_bundle;

import '../model/auth_model/auth_log_model.dart';

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
      'Predicted Results/Auth Log/json/auth_2022_08_23__12_48_10.json',
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
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
