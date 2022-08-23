// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

// import '../Model/auth_log_model.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   int count = 1;
//   late List<AuthLogModel> authData;
//   late List<Data> _chartData;
//   late List<AllData> chartData;

//   late TooltipBehavior _tooltipBehavior;
//   // AuthLogModel? model;

//   @override
//   void initState() {
//     chartData = fetchChartData();
//     _chartData = getChartData();

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

//   // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return SafeArea(
//       child: Scaffold(
//         // key: _scaffoldKey,

//         // backgroundColor: const Color(0x00000050),
//         drawer: const Drawer(),
//         // appBar: AppBar(
//         //   elevation: 10,
//         //   // backgroundColor: const Color.fromARGB(0, 0, 0, 0),
//         //   title: const Text(
//         //     "Dashboard",
//         //     style: TextStyle(fontSize: 30),
//         //   ),
//         //   actions: [
//         // Stack(
//         //   children: [
//         //     IconButton(
//         //       icon: const Icon(
//         //         Icons.notifications,
//         //         color: Colors.grey,
//         //         size: 30,
//         //       ),
//         //       onPressed: () {
//         //         Navigator.push(
//         //             context,
//         //             MaterialPageRoute(
//         //                 builder: (context) => const LoginPage()));
//         //       },
//         //     ),
//         //     if (count != 0)
//         //       Positioned(
//         //         right: 3,
//         //         top: 4,
//         //         child: Container(
//         //           padding: const EdgeInsets.all(2),
//         //           decoration: BoxDecoration(
//         //             color: Colors.red,
//         //             borderRadius: BorderRadius.circular(30),
//         //           ),
//         //           constraints: const BoxConstraints(
//         //             minWidth: 20,
//         //             minHeight: 20,
//         //           ),
//         //           child: const Text(
//         //             "0",
//         //             style: TextStyle(
//         //               color: Colors.white,
//         //               fontSize: 11,
//         //             ),
//         //             textAlign: TextAlign.center,
//         //           ),
//         //         ),
//         //       )
//         //     else
//         //       Container()
//         //       ],
//         //     ),
//         //     const SizedBox(
//         //       width: 50,
//         //     ),
//         //     const Icon(
//         //       Icons.person,
//         //       color: Color(0xff2c51a4),
//         //       size: 30,
//         //     ),
//         //     const SizedBox(
//         //       width: 50,
//         //     ),
//         //   ],
//         // ),
//         body: SingleChildScrollView(
//           primary: false,
//           padding: EdgeInsets.all(defaultPadding),
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               Header(),
//               const SizedBox(height: defaultPadding),
//               SizedBox(
//                 height: height * 0.80,
//                 width: width,
//                 // color: Colors.blue,
//                 child: FutureBuilder(
//                     future: readJsonAuthLog(),
//                     builder: (context, data) {
//                       if (data.hasError) {
//                         return Center(
//                           child: Text("Error::::${data.error}"),
//                         );
//                       } else if (data.hasData) {
//                         authData = data.data as List<AuthLogModel>;

//                         log(authData.length.toString());
//                         if (kDebugMode) {
//                           print(authData[0].distance);
//                         }

//                         return Padding(
//                           padding: const EdgeInsets.all(50.0),
//                           child: SfSparkLineChart.custom(
//                             color: Colors.black,
//                             marker: const SparkChartMarker(
//                                 displayMode: SparkChartMarkerDisplayMode.all,
//                                 shape: SparkChartMarkerShape.circle),
//                             trackball: const SparkChartTrackball(
//                               activationMode: SparkChartActivationMode.tap,
//                               shouldAlwaysShow: true,
//                             ),
//                             axisLineDashArray: const <double>[0, 0],
//                             axisCrossesAt: 0.5,

//                             plotBand:
//                                 const SparkChartPlotBand(start: 3, end: 10),

//                             xValueMapper: (int index) => authData[index].date,
//                             // Binding the y values
//                             yValueMapper: (int index) =>
//                                 authData[index].modZscore!,
//                             // Assigning the number of data.
//                             dataCount: 50,
//                           ),
//                         );
//                       } else {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                     }),
//               ),
//               const SizedBox(
//                 height: 100,
//               ),
//               SizedBox(
//                 height: height * 0.80,
//                 width: width,
//                 // color: Colors.blue,
//                 child: FutureBuilder(
//                     future: readJsonAuthLog(),
//                     builder: (context, data) {
//                       if (data.hasError) {
//                         return Center(
//                           child: Text("Error::::${data.error}"),
//                         );
//                       } else if (data.hasData) {
//                         authData = data.data as List<AuthLogModel>;

//                         log(authData.length.toString());
//                         if (kDebugMode) {
//                           print(authData[0].distance);
//                         }

//                         return Padding(
//                           padding: const EdgeInsets.all(50.0),
//                           child: SfCartesianChart(
//                             legend: Legend(isVisible: true),

//                             series: <ChartSeries>[
//                               ColumnSeries<AuthLogModel, String>(
//                                 dataSource: authData,
//                                 xValueMapper: (AuthLogModel m, index) => m.time,
//                                 yValueMapper: (AuthLogModel m, index) =>
//                                     m.label,
//                               )
//                             ],
//                             primaryXAxis:
//                                 CategoryAxis(title: AxisTitle(text: "label")),
//                             primaryYAxis:
//                                 NumericAxis(title: AxisTitle(text: "time")),

//                             tooltipBehavior: _tooltipBehavior,
//                             // isTransposed: false,
//                             // enableAxisAnimation: false,
//                           ),
//                         );
//                       } else {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                     }),
//               ),
              
              
//               Container(
//                 height: height * 0.40,
//                 width: width,
//                 color: Colors.blue,
//                 child: SfSparkLineChart(
//                   color: Colors.black,
//                   marker: const SparkChartMarker(
//                       displayMode: SparkChartMarkerDisplayMode.all,
//                       shape: SparkChartMarkerShape.square),
//                   trackball: const SparkChartTrackball(
//                     activationMode: SparkChartActivationMode.tap,
//                     shouldAlwaysShow: true,
//                   ),
//                   labelDisplayMode: SparkChartLabelDisplayMode.all,
//                   axisCrossesAt: 4,
//                   axisLineWidth: 2,
//                   negativePointColor: Colors.red,
//                   plotBand: const SparkChartPlotBand(start: 10, end: 13),
//                   // isInversed: false,

//                   axisLineDashArray: const <double>[2, 2],

//                   data: const [
//                     1,
//                     5,
//                     -6,
//                     0,
//                     1,
//                     -2,
//                     7,
//                     5,
//                     -6,
//                     0,
//                     1,
//                     15,
//                     5,
//                     5,
//                     -6,
//                     0,
//                     1,
//                     5,
//                     -6,
//                     0,
//                     1,
//                     -6,
//                     0,
//                     1,
//                     5,
//                     7,
//                     5,
//                     -6,
//                     8,
//                     0,
//                     1,
//                     5,
//                     5,
//                     -6,
//                     -6,
//                     0,
//                     1,
//                     -7,
//                     -4,
//                     -10,
//                     13,
//                     -6,
//                     7,
//                     5,
//                     11,
//                     5,
//                     3
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   // SfCartesianChart(
//                   //   series: <ChartSeries>[
//                   //     BarSeries<AuthLogModel, String>(
//                   //       dataSource: authData,
//                   //       xValueMapper: (AuthLogModel m, index) => m.date,
//                   //       yValueMapper: (AuthLogModel m, index) => m.label,
//                   //     )
//                   //   ],
//                   //   primaryXAxis: CategoryAxis(),

//                   //   tooltipBehavior: _tooltipBehavior,
//                   //   isTransposed: false,
//                   //   enableAxisAnimation: false,

//                   //   // series: <LineSeries<ThreatData, String>>[
//                   //   //   LineSeries<ThreatData, String>(
//                   //   //       // Bind data source
//                   //   //       dataSource: <ThreatData>[
//                   //   //         ThreatData('Jan', 35),
//                   //   //         ThreatData('Feb', 28),
//                   //   //         ThreatData('Mar', 34),
//                   //   //         ThreatData('Apr', 32),
//                   //   //         ThreatData('May', 40)
//                   //   //       ],
//                   //   //       xValueMapper: (ThreatData Threat, _) => Threat.year,
//                   //   //       yValueMapper: (ThreatData Threat, _) => Threat.Threat)
//                   //   // ],
//                   // ),
//                   SfCircularChart(
//                     title: ChartTitle(text: 'Theat vs normal'),
//                     legend: Legend(
//                       isVisible: true,
//                       overflowMode: LegendItemOverflowMode.wrap,
//                     ),
//                     tooltipBehavior: _tooltipBehavior,
//                     series: <CircularSeries>[
//                       RadialBarSeries<Data, String>(
//                         dataSource: _chartData,
//                         xValueMapper: (Data data, _) => data.type,
//                         yValueMapper: (Data data, _) => data.score,
//                         dataLabelSettings:
//                             const DataLabelSettings(isVisible: false),
//                         // enableTooltip: true,
//                         maximumValue: 4000,
//                       )
//                     ],
//                   ),
//                   SfCartesianChart(
//                     title: ChartTitle(text: 'all'),
//                     // legend: Legend(isVisible: true),
//                     tooltipBehavior: _tooltipBehavior,
//                     series: <ChartSeries>[
//                       StackedLine100Series<AllData, String>(
//                           dataSource: chartData,
//                           xValueMapper: (AllData exp, _) => exp.AllCategory,
//                           yValueMapper: (AllData exp, _) => exp.auth,
//                           name: 'firewall',
//                           markerSettings: const MarkerSettings(
//                             isVisible: true,
//                           )),
//                       StackedLine100Series<AllData, String>(
//                           dataSource: chartData,
//                           xValueMapper: (AllData exp, _) => exp.AllCategory,
//                           yValueMapper: (AllData exp, _) => exp.auth,
//                           name: 'logout',
//                           // onPointDoubleTap: ,
//                           markerSettings: const MarkerSettings(
//                             isVisible: true,
//                           )),
//                       StackedLine100Series<AllData, String>(
//                           dataSource: chartData,
//                           xValueMapper: (AllData exp, _) => exp.AllCategory,
//                           yValueMapper: (AllData exp, _) => exp.logout,
//                           name: 'login',
//                           markerSettings: const MarkerSettings(
//                             isVisible: true,
//                           )),
//                       StackedLine100Series<AllData, String>(
//                           dataSource: chartData,
//                           xValueMapper: (AllData exp, _) => exp.AllCategory,
//                           yValueMapper: (AllData exp, _) => exp.logon,
//                           name: 'Auth',
//                           markerSettings: const MarkerSettings(
//                             isVisible: true,
//                           )),
//                     ],
//                     primaryXAxis: CategoryAxis(),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ThreatData {
//   ThreatData(this.year, this.Threat);
//   final String year;
//   final double Threat;
// }

// List<Data> getChartData() {
//   final List<Data> chartData = [
//     Data('Threat', 160),
//     Data('Normal', 3490),
//   ];
//   return chartData;
// }

// class Data {
//   Data(this.type, this.score);
//   final String type;
//   final int score;
// }

// List<AllData> fetchChartData() {
//   final List<AllData> chartData = [
//     AllData('auth', 55, 40, 45, 48),
//     AllData('office', 33, 45, 54, 28),
//     AllData('home', 43, 23, 20, 34),
//     AllData('score', 32, 54, 23, 54),
//     AllData('Bos', 56, 18, 43, 55),
//     AllData('the', 23, 54, 33, 56),
//   ];
//   return chartData;
// }

// class AllData {
//   AllData(this.AllCategory, this.auth, this.firebase, this.logon, this.logout);
//   final String AllCategory;
//   final num firebase;
//   final num auth;
//   final num logon;
//   final num logout;
// }
