// class ChartDetailsScreen extends StatelessWidget {

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dashboard/dashboard/model/ids_model/FTPPatator_model.dart';
import 'package:dashboard/dashboard/model/ids_model/Heartbleed_model.dart';
import 'package:dashboard/dashboard/model/ids_model/Infiltration_model.dart';
import 'package:dashboard/dashboard/model/ids_model/PortScan_model.dart';
import 'package:dashboard/dashboard/model/ids_model/SSHPatator_model.dart';
import 'package:dashboard/dashboard/model/ids_model/Web_Attack_Sql_Injection_model.dart';
import 'package:dashboard/dashboard/model/ids_model/Web_Attack_XSS_benign_model.dart';
import 'package:dashboard/dashboard/model/ids_model/df_DDoS_benign_model.dart';
import 'package:dashboard/dashboard/model/ids_model/dos_GoldenEye_model.dart';
import 'package:dashboard/dashboard/model/ids_model/dos_Hulk_model.dart';
import 'package:dashboard/dashboard/model/ids_model/dos_SlowHttp_model.dart';
import 'package:dashboard/dashboard/model/ids_model/ids_bot_model.dart';
import 'package:dashboard/dashboard/screens/details/filter_csv.dart';
import 'package:dashboard/dashboard/widgets/ids_chart.dart';
import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/ids_model/Web_Attack_Brute_Force_model.dart';

class IDSChartDetailsScreen extends StatefulWidget {
  final String predictionBasePath;
  final String groupdfileName;
  final String botfileName;
  final String ddosName;
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
      required this.predictionBasePath,
      required this.groupdfileName,
      required this.botfileName,
      required this.ddosName,
      // required this.webAttackName,
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
  int botIndex = 0;
  int ddosIndex = 0;
  int goldenIndex = 0;
  int hulkIndex = 0;
  int slowhttpIndex = 0;
  int ftpIndex = 0;
  int heartIndex = 0;
  int infiltrationIndex = 0;
  int portScanIndex = 0;
  int sshIndex = 0;
  int webforceIndex = 0;
  int sqlIndex = 0;
  int webXssIndex = 0;
  List<IDSBotModel> chartData = [];
  List<IDSBotModel> liveBot = [];
  List<DDoSBenignModel> ddosData = [];
  List<DDoSBenignModel> liveDdosData = [];
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
  // ChartSeriesController? _chartSeriesController;
  late TooltipBehavior _tooltipBehavior1;
  late TooltipBehavior _tooltipBehavior2;
  late TooltipBehavior _tooltipBehavior3;
  late TooltipBehavior _tooltipBehavior4;
  late TooltipBehavior _tooltipBehavior5;
  late TooltipBehavior _tooltipBehavior6;
  late TooltipBehavior _tooltipBehavior7;
  late TooltipBehavior _tooltipBehavior8;
  late TooltipBehavior _tooltipBehavior9;
  late TooltipBehavior _tooltipBehavior10;
  late TooltipBehavior _tooltipBehavior11;
  late TooltipBehavior _tooltipBehavior12;
  late TooltipBehavior _tooltipBehavior13;

  Timer? timer;
  int data = 0;
  bool isPlay = true;
  void _updateDataSource(Timer timer) {
    if (isPlay) {
      liveBot = chartData.sublist(data + 40, (data + 40) + 40);
      liveDdosData = ddosData.sublist(data + 40, (data + 40) + 40);
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

  //Notification
  Future<String> loadNotification({required String filename}) async {
    try {
      String path = filename;
      File f = File(path);
      final input = await f.readAsString();

      return input;
    } catch (e) {
      rethrow;
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
    try {
      String path = filename;
      File f = File(path);
      final input = await f.readAsString();

      return input;
    } catch (e) {
      rethrow;
    }
  }

//ddos
  Future<String> loadDDosFromFile({required String filename}) async {
    String path = filename;
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

// Dos GoldenEye
  Future<String> loadGoldenFromFile({required String filename}) async {
    String path = filename;
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
    // loadIDSwebLog();
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
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDataSource(timer);
      isPlay
          ? setState(() {
              // plotIndex++;
            })
          : null;
    });
    _tooltipBehavior1 = hoverBot();
    _tooltipBehavior2 = hoverDdos();
    _tooltipBehavior3 = hoverGoldenEye();
    _tooltipBehavior4 = hoverHulk();
    _tooltipBehavior5 = hoverSlowHttp();
    _tooltipBehavior6 = hoverFTP();
    _tooltipBehavior7 = hoverHeartBleed();
    _tooltipBehavior8 = hoverInfiltration();
    _tooltipBehavior9 = hoverPortScan();
    _tooltipBehavior10 = hoverSSH();
    _tooltipBehavior11 = hoverWebForce();
    _tooltipBehavior12 = hoverWebSql();
    _tooltipBehavior13 = hoverWebXss();

    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: GlobalWidget.displayDetailsPageAppBar(
          context: context,
          file: widget.groupdfileName,
          predictionBasePath: widget.predictionBasePath,
        ),
        // endDrawer: GlobalWidget.displayIdsDetailsPageDrawer(context:  context),
        // floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        // floatingActionButton: ,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IDSChart(
                  context: context,
                  future: loadDataFromFile(filename: widget.botfileName),
                  tooltipBehavior: _tooltipBehavior1,
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
                  tooltipBehavior: _tooltipBehavior2,
                  getLineChartSeries: getDDosChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'Ddos Benign',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future: loadGoldenFromFile(filename: widget.goldenEyeName),
                  tooltipBehavior: _tooltipBehavior3,
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
                  tooltipBehavior: _tooltipBehavior4,
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
                  tooltipBehavior: _tooltipBehavior5,
                  getLineChartSeries: getSlowHttpChart(),
                  isPlay: isPlay,
                  buttonFunction: PausePlayButton,
                  title: 'Slowhttp',
                ),
                const SizedBox(
                  height: 10,
                ),
                IDSChart(
                  context: context,
                  future:
                      loadFtpPatatorFromFile(filename: widget.ftpPatatorName),
                  tooltipBehavior: _tooltipBehavior6,
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
                  tooltipBehavior: _tooltipBehavior7,
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
                  tooltipBehavior: _tooltipBehavior8,
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
                  tooltipBehavior: _tooltipBehavior9,
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
                  tooltipBehavior: _tooltipBehavior10,
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
                  tooltipBehavior: _tooltipBehavior11,
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
                  tooltipBehavior: _tooltipBehavior12,
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
                  tooltipBehavior: _tooltipBehavior13,
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
  List<LineSeries<IDSBotModel, int>> getBotChart() {
    return <LineSeries<IDSBotModel, int>>[
      LineSeries<IDSBotModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: liveBot,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (IDSBotModel bot, _) => botIndex++,
        yValueMapper: (IDSBotModel bot, _) => bot.botProbXgb,
        // animationDuration: 0,
      )
    ];
  }

//ddos
  List<LineSeries<DDoSBenignModel, int>> getDDosChart() {
    return <LineSeries<DDoSBenignModel, int>>[
      LineSeries<DDoSBenignModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: liveDdosData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (DDoSBenignModel bot, _) => ddosIndex++,
        yValueMapper: (DDoSBenignModel bot, _) => bot.dfDDoSBenignProbXgb,
        // animationDuration: 0,
      )
    ];
  }

  //Gloden EYE
  List<LineSeries<DoSGoldenEyeModel, int>> getGoldenEyeChart() {
    return <LineSeries<DoSGoldenEyeModel, int>>[
      LineSeries<DoSGoldenEyeModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: livedosGoldenData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (DoSGoldenEyeModel bot, _) => goldenIndex++,
        yValueMapper: (DoSGoldenEyeModel bot, _) => bot.doSGoldenEyeProbXgb,
        // animationDuration: 0,
      )
    ];
  }

  //DOS HUlk
  List<LineSeries<DoSHulkModel, int>> getHulkChart() {
    return <LineSeries<DoSHulkModel, int>>[
      LineSeries<DoSHulkModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: livedosHulkData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (DoSHulkModel bot, _) => hulkIndex++,
        yValueMapper: (DoSHulkModel bot, _) => bot.doSHulkProbXgb,
        // animationDuration: 0,
      )
    ];
  }

  //Slow Http
  List<LineSeries<DoSSlowhttptestModel, int>> getSlowHttpChart() {
    return <LineSeries<DoSSlowhttptestModel, int>>[
      LineSeries<DoSSlowhttptestModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: liveslowHttpData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (DoSSlowhttptestModel bot, _) => slowhttpIndex++,
        yValueMapper: (DoSSlowhttptestModel bot, _) =>
            bot.doSSlowhttptestProbXgb,
        // animationDuration: 0,
      )
    ];
  }

  //FTP PATATOR
  List<LineSeries<FTPPatatorModel, int>> getFtpPatatorChart() {
    return <LineSeries<FTPPatatorModel, int>>[
      LineSeries<FTPPatatorModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: liveftpPatatorData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (FTPPatatorModel bot, _) => ftpIndex++,
        yValueMapper: (FTPPatatorModel bot, _) => bot.fTPPatatorProbXgb,
        // animationDuration: 0,
      )
    ];
  }

  //Heartbleed
  List<LineSeries<HeartbleedModel, int>> getHeartbleedChart() {
    return <LineSeries<HeartbleedModel, int>>[
      LineSeries<HeartbleedModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: liveheartbleedData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (HeartbleedModel bot, _) => heartIndex++,
        yValueMapper: (HeartbleedModel bot, _) => bot.heartbleedProbXgb,
        // animationDuration: 0,
      )
    ];
  }

  //Infiltration
  List<LineSeries<InfiltrationModel, int>> getInfiltrationChart() {
    return <LineSeries<InfiltrationModel, int>>[
      LineSeries<InfiltrationModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: liveinfiltrationData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (InfiltrationModel bot, _) => infiltrationIndex++,
        yValueMapper: (InfiltrationModel bot, _) => bot.infiltrationProbXgb,
        // animationDuration: 0,
      )
    ];
  }

  //PortScan
  List<LineSeries<PortScanModel, int>> getPortScanChart() {
    return <LineSeries<PortScanModel, int>>[
      LineSeries<PortScanModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: liveportScanData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (PortScanModel bot, _) => portScanIndex++,
        yValueMapper: (PortScanModel bot, _) => bot.portScanProbXgb,
        // animationDuration: 0,
      )
    ];
  }

//SSH Patator
  List<LineSeries<SSHPatatorModel, int>> getsshPatatorChart() {
    return <LineSeries<SSHPatatorModel, int>>[
      LineSeries<SSHPatatorModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: livesshPatator,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (SSHPatatorModel bot, _) => sshIndex++,
        yValueMapper: (SSHPatatorModel bot, _) => bot.sSHPatatorProbXgb,
        // animationDuration: 0,
      )
    ];
  }

//Web Brute Force
  List<LineSeries<WebAttackBruteForceModel, int>> getwebBruteForceChart() {
    return <LineSeries<WebAttackBruteForceModel, int>>[
      LineSeries<WebAttackBruteForceModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: livewebBruteForceData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (WebAttackBruteForceModel bot, _) => webforceIndex++,
        yValueMapper: (WebAttackBruteForceModel bot, _) =>
            bot.webAttackBruteForceProbXgb,
        // animationDuration: 0,
      )
    ];
  }

//Sql Injection
  List<LineSeries<WebAttackSqlInjectionModel, int>> getsqlInjectionChart() {
    return <LineSeries<WebAttackSqlInjectionModel, int>>[
      LineSeries<WebAttackSqlInjectionModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: livesqlInjectionData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (WebAttackSqlInjectionModel bot, _) => sqlIndex++,
        yValueMapper: (WebAttackSqlInjectionModel bot, _) =>
            bot.webAttackSqlInjectionProbXgb,
        // animationDuration: 0,
      )
    ];
  }

//Web Xss
  List<LineSeries<WebAttackXSSbenignModel, int>> getwebXssChart() {
    return <LineSeries<WebAttackXSSbenignModel, int>>[
      LineSeries<WebAttackXSSbenignModel, int>(
        markerSettings: const MarkerSettings(
          isVisible: true,
        ),

        dataSource: livewebXssData,
        color: const Color.fromRGBO(192, 108, 132, 1),
        xValueMapper: (WebAttackXSSbenignModel bot, _) => webXssIndex++,
        yValueMapper: (WebAttackXSSbenignModel bot, _) =>
            bot.webAttackXSSBenignProbXgb,
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
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => CSVScreen(
                    title: "Bot Data List",
                    filePath: widget.botfileName,
                  ),
                ),
              );
            },
            child: SizedBox(
              height: 110,
              width: 270,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TimeStamp:${data.timestamp.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Source IP:${data.sourceIP.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Destination Ip:${data.destinationIP.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Probability:${data.botProbXgb.toString()}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverDdos() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 110,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.dfDDoSBenignProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverGoldenEye() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 110,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.doSGoldenEyeProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverHulk() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 110,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.doSHulkProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverSlowHttp() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 110,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.doSSlowhttptestProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverFTP() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 110,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.fTPPatatorProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverHeartBleed() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 100,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination IP:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.heartbleedProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverInfiltration() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 100,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.infiltrationProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverPortScan() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 110,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.portScanProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverSSH() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 110,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.sSHPatatorProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverWebForce() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 110,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.webAttackBruteForceProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverWebSql() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 110,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.webAttackSqlInjectionProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  TooltipBehavior hoverWebXss() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Expanded(
          child: SizedBox(
            height: 110,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TimeStamp:${data.timestamp.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Source IP:${data.sourceIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Destination Ip:${data.destinationIP.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Probability:${data.webAttackXSSBenignProbXgb.toString()}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
