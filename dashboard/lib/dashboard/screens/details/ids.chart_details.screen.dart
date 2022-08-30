// class ChartDetailsScreen extends StatelessWidget {

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dashboard/dashboard/model/ids_model/FTPPatator_model.dart';
import 'package:dashboard/dashboard/model/ids_model/Heartbleed_model.dart';
import 'package:dashboard/dashboard/model/ids_model/Infiltration_model.dart';
import 'package:dashboard/dashboard/model/ids_model/PortScan_model.dart';
import 'package:dashboard/dashboard/model/ids_model/SSHPatator_model.dart';
import 'package:dashboard/dashboard/model/ids_model/Web_Attack_Sql_Injection_model.dart';
import 'package:dashboard/dashboard/model/ids_model/Web_Attack_XSS_benign_model.dart';
import 'package:dashboard/dashboard/model/ids_model/df_DDoS_benign_model.dart';
import 'package:dashboard/dashboard/model/ids_model/df_Web_Attack_model.dart';
import 'package:dashboard/dashboard/model/ids_model/dos_GoldenEye_model.dart';
import 'package:dashboard/dashboard/model/ids_model/dos_Hulk_model.dart';
import 'package:dashboard/dashboard/model/ids_model/dos_SlowHttp_model.dart';
import 'package:dashboard/dashboard/model/ids_model/ids_bot_model.dart';
import 'package:dashboard/dashboard/widgets/ids_chart.dart';
import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/ids_model/Web_Attack_Brute_Force_model.dart';

class IDSChartDetailsScreen extends StatefulWidget {
  final String botfileName;
  final String ddosName;
  final String webAttackName;
  final String goldenEyeName;
  final String hulkName;
  final String slowHttpName;
  final String ftpPatatorName;
  final String heartBleedName;
  final String infiltrationName;
  final String portScanName;
  final String sshPatatorName;
  final String webBruteForceName;
  final String webSqlInjectionName;
  final String webXSSName;

  const IDSChartDetailsScreen(
      {Key? key,
      required this.botfileName,
      required this.ddosName,
      required this.webAttackName,
      required this.goldenEyeName,
      required this.hulkName,
      required this.slowHttpName,
      required this.ftpPatatorName,
      required this.heartBleedName,
      required this.infiltrationName,
      required this.portScanName,
      required this.sshPatatorName,
      required this.webBruteForceName,
      required this.webSqlInjectionName,
      required this.webXSSName})
      : super(key: key);

  @override
  State<IDSChartDetailsScreen> createState() => _IDSChartDetailsScreenState();
}

class _IDSChartDetailsScreenState extends State<IDSChartDetailsScreen> {
  List<IDSBotModel> chartData = [];
  List<IDSBotModel> liveBot = [];
  List<DDoSBenignModel> ddosData = [];
  List<DDoSBenignModel> liveDdosData = [];
  List<WebAttackModel> webAttackData = [];
  List<WebAttackModel> livewebAttackData = [];
  List<DoSGoldenEyeModel> dosGoldenData = [];
  List<DoSGoldenEyeModel> livedosGoldenData = [];
  List<DoSHulkModel> dosHulkData = [];
  List<DoSHulkModel> livedosHulkData = [];
  List<DoSSlowhttptestModel> slowHttpData = [];
  List<DoSSlowhttptestModel> liveslowHttpData = [];
  List<FTPPatatorModel> ftpPatatorData = [];
  List<FTPPatatorModel> liveftpPatatorData = [];
  List<HeartbleedModel> heartbleedData = [];
  List<HeartbleedModel> liveheartbleedData = [];
  List<InfiltrationModel> infiltrationData = [];
  List<InfiltrationModel> liveinfiltrationData = [];
  List<PortScanModel> portScanData = [];
  List<PortScanModel> liveportScanData = [];
  List<SSHPatatorModel> sshPatatorData = [];
  List<SSHPatatorModel> livesshPatator = [];
  List<WebAttackBruteForceModel> webBruteForceData = [];
  List<WebAttackBruteForceModel> livewebBruteForceData = [];
  List<WebAttackSqlInjectionModel> sqlInjectionData = [];
  List<WebAttackSqlInjectionModel> livesqlInjectionData = [];
  List<WebAttackXSSbenignModel> webXssData = [];
  List<WebAttackXSSbenignModel> livewebXssData = [];
  ChartSeriesController? _chartSeriesController;
  late TooltipBehavior _tooltipBehavior;
  Timer? timer;
  int data = 0;
  bool isPlay = true;
  void _updateDataSource(Timer timer) {
    if (isPlay) {
      // log(chartData.length.toString());
      liveBot = chartData.sublist(data + 40, (data + 40) + 40);
      liveDdosData = ddosData.sublist(data + 40, (data + 40) + 40);
      livewebAttackData = webAttackData.sublist(data + 40, (data + 40) + 40);
      livedosGoldenData = dosGoldenData.sublist(data + 40, (data + 40) + 40);
      livedosHulkData = dosHulkData.sublist(data + 40, (data + 40) + 40);
      liveslowHttpData = slowHttpData.sublist(data + 40, (data + 40) + 40);
      liveftpPatatorData = ftpPatatorData.sublist(data + 40, (data + 40) + 40);
      liveheartbleedData = heartbleedData.sublist(data + 40, (data + 40) + 40);
      liveinfiltrationData =
          infiltrationData.sublist(data + 40, (data + 40) + 40);
      liveportScanData = portScanData.sublist(data + 40, (data + 40) + 40);
      livesshPatator = sshPatatorData.sublist(data + 40, (data + 40) + 40);
      livewebBruteForceData =
          webBruteForceData.sublist(data + 40, (data + 40) + 40);
      livesqlInjectionData =
          sqlInjectionData.sublist(data + 40, (data + 40) + 40);
      livewebXssData = webXssData.sublist(data + 40, (data + 40) + 40);

      log("ddos${livewebBruteForceData.length}");

      // livePlot.add(chartData[i]);
      // log("length of liveplot dtata${liveBot.length}");
      // log("i ko lethgth$data");
      // if (liveBot.length == 40) {
      //   // livePlot.removeAt(0);
      //   _chartSeriesController?.updateDataSource(
      //     addedDataIndexes: <int>[liveBot.length + 1],
      //     // removedDataIndexes: <int>[0],
      //   );
      // } else {
      //   _chartSeriesController?.updateDataSource(
      //     addedDataIndexes: <int>[liveBot.length - 1],
      //   );
      // }
      data++;
    } else {
      liveBot = liveBot;
    }
  }

//Bot
  Future loadIDSBotLog() async {
    final String jsonString =
        await loadDataFromFile(filename: widget.botfileName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      chartData.add(IDSBotModel.fromJson(i));
    }
  }

  Future<String> loadDataFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

//ddos
  Future<String> loadDDosFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSDDOSLog() async {
    final String jsonString = await loadDDosFromFile(filename: widget.ddosName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      ddosData.add(DDoSBenignModel.fromJson(i));
    }
  }
  //web attack

  Future<String> loadWebFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSwebLog() async {
    final String jsonString =
        await loadWebFromFile(filename: widget.webAttackName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      webAttackData.add(WebAttackModel.fromJson(i));
    }
  }

// Dos GoldenEye
  Future<String> loadGoldenFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSGlodenLog() async {
    final String jsonString =
        await loadGoldenFromFile(filename: widget.goldenEyeName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      dosGoldenData.add(DoSGoldenEyeModel.fromJson(i));
    }
  }
//Dos Hulk

  Future<String> loadHulkFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSHulkLog() async {
    final String jsonString = await loadHulkFromFile(filename: widget.hulkName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      dosHulkData.add(DoSHulkModel.fromJson(i));
    }
  }

//Slow Http
  Future<String> loadSlowHttpFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSSLowHttpLog() async {
    final String jsonString =
        await loadSlowHttpFromFile(filename: widget.slowHttpName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      slowHttpData.add(DoSSlowhttptestModel.fromJson(i));
    }
  }
  //FTP Patator

  Future<String> loadFtpPatatorFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSSFTPLog() async {
    final String jsonString =
        await loadFtpPatatorFromFile(filename: widget.ftpPatatorName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      ftpPatatorData.add(FTPPatatorModel.fromJson(i));
    }
  }
//Heart Bleed

  Future<String> loadHeartbleedFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSHeartbleedLog() async {
    final String jsonString =
        await loadHeartbleedFromFile(filename: widget.heartBleedName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      heartbleedData.add(HeartbleedModel.fromJson(i));
    }
  }

  //Infiltration
  Future<String> loadinfiltrationFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSinfiltrationLog() async {
    final String jsonString =
        await loadinfiltrationFromFile(filename: widget.infiltrationName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      infiltrationData.add(InfiltrationModel.fromJson(i));
    }
  }

  //PortScan
  Future<String> loadPortScanFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSPortScanLog() async {
    final String jsonString =
        await loadPortScanFromFile(filename: widget.portScanName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      portScanData.add(PortScanModel.fromJson(i));
    }
  }

  //ssh Patator
  Future<String> loadsshPatatorFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSsshPatatorLog() async {
    final String jsonString =
        await loadsshPatatorFromFile(filename: widget.sshPatatorName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      sshPatatorData.add(SSHPatatorModel.fromJson(i));
    }
  }

  //Web Attack Brute Force
  Future<String> loadBruteForceFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSBruteForceLog() async {
    final String jsonString =
        await loadBruteForceFromFile(filename: widget.webBruteForceName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      webBruteForceData.add(WebAttackBruteForceModel.fromJson(i));
    }
  }

//Sql Injection
  Future<String> loadSqlInjectionFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSSqlInjectionLog() async {
    final String jsonString =
        await loadSqlInjectionFromFile(filename: widget.webSqlInjectionName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      sqlInjectionData.add(WebAttackSqlInjectionModel.fromJson(i));
    }
  }

//Web Xss
  Future<String> loadWebXssFromFile({required String filename}) async {
    String path = filename;
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  }

  Future loadIDSWebXssLog() async {
    final String jsonString =
        await loadWebXssFromFile(filename: widget.webXSSName);
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      webXssData.add(WebAttackXSSbenignModel.fromJson(i));
    }
  }

  void PausePlayButton() {
    setState(() {
      isPlay ? isPlay = false : isPlay = true;
    });
  }

  @override
  void initState() {
    loadIDSBotLog();
    loadIDSDDOSLog();
    loadIDSwebLog();
    loadIDSGlodenLog();
    loadIDSHulkLog();
    loadIDSSLowHttpLog();
    loadIDSSFTPLog();
    loadIDSHeartbleedLog();
    loadIDSinfiltrationLog();
    loadIDSPortScanLog();
    loadIDSsshPatatorLog();
    loadIDSBruteForceLog();
    loadIDSSqlInjectionLog();
    loadIDSWebXssLog();
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
                  future: loadDataFromFile(filename: widget.botfileName),
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
                  future: loadDDosFromFile(filename: widget.ddosName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getDDosChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'DDOs Benign',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: loadWebFromFile(filename: widget.webAttackName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getWebAttackChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'Web Attack',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: loadGoldenFromFile(filename: widget.goldenEyeName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getGoldenEyeChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'Golden EYE',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: loadHulkFromFile(filename: widget.hulkName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getHulkChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'DDOS HULK',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: loadSlowHttpFromFile(filename: widget.slowHttpName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getSlowHttpChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'Slow HT',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future:
                      loadFtpPatatorFromFile(filename: widget.ftpPatatorName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getFtpPatatorChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'FTP Patator',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future:
                      loadHeartbleedFromFile(filename: widget.heartBleedName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getHeartbleedChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'HeartBleed',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: loadinfiltrationFromFile(
                      filename: widget.infiltrationName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getInfiltrationChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'Infiltration',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: loadPortScanFromFile(filename: widget.portScanName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getPortScanChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'PortScan',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future:
                      loadsshPatatorFromFile(filename: widget.sshPatatorName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getsshPatatorChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'SSH Patator',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: loadBruteForceFromFile(
                      filename: widget.webBruteForceName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getwebBruteForceChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'Web Brute Force',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: loadSqlInjectionFromFile(
                      filename: widget.webSqlInjectionName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getsqlInjectionChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'Sql Injection',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: loadWebXssFromFile(filename: widget.webXSSName),
                  tooltipBehavior: _tooltipBehavior,
                  getLineChartSeries: getwebXssChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'Web Attack Xss ',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //bot
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
        xValueMapper: (IDSBotModel bot, _) => bot.timestamp,
        yValueMapper: (IDSBotModel bot, _) => bot.bot == "Bot" ? 1 : -1,
        // animationDuration: 0,
      )
    ];
  }

//ddos
  List<LineSeries<DDoSBenignModel, String>> getDDosChart() {
    return <LineSeries<DDoSBenignModel, String>>[
      LineSeries<DDoSBenignModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: liveDdosData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (DDoSBenignModel bot, _) => bot.timestamp,
        yValueMapper: (DDoSBenignModel bot, _) =>
            bot.dfDDoSBenign == "DDoS" ? 1 : -1,
        // animationDuration: 0,
      )
    ];
  }

//web attack
  List<LineSeries<WebAttackModel, String>> getWebAttackChart() {
    return <LineSeries<WebAttackModel, String>>[
      LineSeries<WebAttackModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: livewebAttackData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (WebAttackModel bot, _) => bot.timestamp,
        yValueMapper: (WebAttackModel bot, _) =>
            bot.dfWebAttack == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

  //Gloden EYE
  List<LineSeries<DoSGoldenEyeModel, String>> getGoldenEyeChart() {
    return <LineSeries<DoSGoldenEyeModel, String>>[
      LineSeries<DoSGoldenEyeModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: livedosGoldenData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (DoSGoldenEyeModel bot, _) => bot.timestamp,
        yValueMapper: (DoSGoldenEyeModel bot, _) =>
            bot.doSGoldenEye == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

  //DOS HUlk
  List<LineSeries<DoSHulkModel, String>> getHulkChart() {
    return <LineSeries<DoSHulkModel, String>>[
      LineSeries<DoSHulkModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: livedosHulkData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (DoSHulkModel bot, _) => bot.timestamp,
        yValueMapper: (DoSHulkModel bot, _) => bot.doSHulk == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

  //Slow Http

  List<LineSeries<DoSSlowhttptestModel, String>> getSlowHttpChart() {
    return <LineSeries<DoSSlowhttptestModel, String>>[
      LineSeries<DoSSlowhttptestModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: liveslowHttpData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (DoSSlowhttptestModel bot, _) => bot.timestamp,
        yValueMapper: (DoSSlowhttptestModel bot, _) =>
            bot.doSSlowhttptest == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

  //FTP PATATOR
  List<LineSeries<FTPPatatorModel, String>> getFtpPatatorChart() {
    return <LineSeries<FTPPatatorModel, String>>[
      LineSeries<FTPPatatorModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: liveftpPatatorData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (FTPPatatorModel bot, _) => bot.timestamp,
        yValueMapper: (FTPPatatorModel bot, _) =>
            bot.fTPPatator == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

  //Heartbleed
  List<LineSeries<HeartbleedModel, String>> getHeartbleedChart() {
    return <LineSeries<HeartbleedModel, String>>[
      LineSeries<HeartbleedModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: liveheartbleedData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (HeartbleedModel bot, _) => bot.timestamp,
        yValueMapper: (HeartbleedModel bot, _) =>
            bot.heartbleed == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

  //Infiltration
  List<LineSeries<InfiltrationModel, String>> getInfiltrationChart() {
    return <LineSeries<InfiltrationModel, String>>[
      LineSeries<InfiltrationModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: liveinfiltrationData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (InfiltrationModel bot, _) => bot.timestamp,
        yValueMapper: (InfiltrationModel bot, _) =>
            bot.infiltration == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

  //PortScan
  List<LineSeries<PortScanModel, String>> getPortScanChart() {
    return <LineSeries<PortScanModel, String>>[
      LineSeries<PortScanModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: liveportScanData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (PortScanModel bot, _) => bot.timestamp,
        yValueMapper: (PortScanModel bot, _) =>
            bot.portScan == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

//SSH Patator
  List<LineSeries<SSHPatatorModel, String>> getsshPatatorChart() {
    return <LineSeries<SSHPatatorModel, String>>[
      LineSeries<SSHPatatorModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: livesshPatator,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (SSHPatatorModel bot, _) => bot.timestamp,
        yValueMapper: (SSHPatatorModel bot, _) =>
            bot.sSHPatator == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

//Web Brute Force
  List<LineSeries<WebAttackBruteForceModel, String>> getwebBruteForceChart() {
    return <LineSeries<WebAttackBruteForceModel, String>>[
      LineSeries<WebAttackBruteForceModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: livewebBruteForceData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (WebAttackBruteForceModel bot, _) => bot.timestamp,
        yValueMapper: (WebAttackBruteForceModel bot, _) =>
            bot.webAttackBruteForce == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

//Sql Injection
  List<LineSeries<WebAttackSqlInjectionModel, String>> getsqlInjectionChart() {
    return <LineSeries<WebAttackSqlInjectionModel, String>>[
      LineSeries<WebAttackSqlInjectionModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: livesqlInjectionData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (WebAttackSqlInjectionModel bot, _) => bot.timestamp,
        yValueMapper: (WebAttackSqlInjectionModel bot, _) =>
            bot.webAttackSqlInjection == "BENIGN" ? -1 : 1,
        // animationDuration: 0,
      )
    ];
  }

//Web Xss
  List<LineSeries<WebAttackXSSbenignModel, String>> getwebXssChart() {
    return <LineSeries<WebAttackXSSbenignModel, String>>[
      LineSeries<WebAttackXSSbenignModel, String>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        // onRendererCreated: (ChartSeriesController controller) {
        //   _chartSeriesController = controller;
        // },
        dataSource: livewebXssData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (WebAttackXSSbenignModel bot, _) => bot.timestamp,
        yValueMapper: (WebAttackXSSbenignModel bot, _) =>
            bot.webAttackXSSBenign == "BENIGN" ? -1 : 1,
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
