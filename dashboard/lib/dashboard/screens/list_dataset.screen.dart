import 'dart:convert';
import 'dart:developer';

import 'package:dashboard/dashboard/screens/details/auth.chart_details.screen.dart';
import 'package:dashboard/dashboard/screens/notification.screen.dart';
import 'package:dashboard/dashboard/services/global.service.dart';
import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/auth_log_services.dart';
import 'details/ids.chart_details.screen.dart';

class ListDataSetScreen extends StatelessWidget {
  const ListDataSetScreen({Key? key}) : super(key: key);
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Colors.white,
      // appBar: GlobalWidget.displayDashboardAppbar(scaffoldKey: _scaffoldKey),
      endDrawer: Drawer(
        elevation: 16.0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: GlobalalService.notification(),
                builder: (context, snapshot) {
                  final loadingIndicator =
                      GlobalWidget.displayDialogWithLoadingIndicator(
                    isCenter: true,
                  );
                  try {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final snapshotData = snapshot.data;
                      final encodeSnapshotData = json.encode(snapshotData);
                      final decodeSnapshotData =
                          json.decode(encodeSnapshotData);
                      final notificationData = decodeSnapshotData[1];
                      final decodeNotificationData =
                          json.decode(notificationData);
                      final notification =
                          decodeNotificationData['data']["Notification"];

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: notification.length,
                        itemBuilder: (BuildContext context, int index) {
                          final notificationDateIndex = notification[index];
                          final notificationDate = notificationDateIndex.keys;
                          final lengthOfNotification = notification[0];
                          final notificationKeyName = notificationDate
                              .toString()
                              .replaceAll("(", "")
                              .replaceAll(")", "");
                          final notificationName = notificationKeyName
                              .toString()
                              .replaceAll("notif_", "")
                              .replaceAll("_", "-");
                          final notificationList =
                              notification[index][notificationKeyName];
                          return ExpansionTile(
                            title: Text(
                              "$notificationName Notification",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${notificationList.length} of notification",
                              style: const TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Colors.grey,
                              ),
                            ),
                            children: [
                              for (int i = 0; i < notificationList.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: notificationList[i]
                                          .toString()
                                          .split("$notificationKeyName/")[1]
                                          .endsWith(".json")
                                      ? ListTile(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    NotificationScreen(
                                                  filePath: notificationList[i]
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          title: Text(
                                            "${notificationList[i].toString().split("$notificationKeyName/")[1].split(".")[0].split("_")[0].toUpperCase()} log Anomaly",
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15,
                                            color: Colors.red,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                            ],
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return loadingIndicator;
                    } else {
                      return const Center(
                        child: Text("No Notification yet!"),
                      );
                    }
                  } catch (e) {
                    return loadingIndicator;
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Flexible(
                child: buildDataSetContainer(size: size, datasetName: "auth")),
            Flexible(
                child: buildDataSetContainer(size: size, datasetName: "ids")),
          ],
        ),
      ),
    );
  }
}

// fetch dataset from the api
getDataSet({required String datasetname}) async {
  try {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/v1/$datasetname/dataset/"),
    );
    return response.body;
  } catch (e) {
    rethrow;
  }
}

// futurebuilder widget to list all dataset files name using listviewbuiler with listtile
fetchDataFromAPi({required Future future, required String socType}) {
  return FutureBuilder(
    future: future,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      try {
        if (snapshot.hasData) {
          final snapshotData = snapshot.data;
          final decodeData = json.decode(snapshotData);
          final datasetLength = decodeData.length;
          DateTime now = DateTime.now();
          final todayDate =
              "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
          return ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: datasetLength,
            itemBuilder: (context, index) {
              final datasetPath = decodeData[index]["path"].toString();
              final String finalDatasetName =
                  datasetPath.split("SOC-support-system/")[1];
              final filecreatedDateTime = decodeData[index]["date"];
              final filecreatedDate =
                  decodeData[index]['date'].toString().split(" ")[0];
              bool isToday = filecreatedDate == todayDate;
              return ListTile(
                onTap: () async {
                  displayDialog(
                    barrierDismissible: false,
                    context: context,
                    actions: [],
                    child: GlobalWidget.loadingWidget(context: context),
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Processing...."),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/dashboard');
                          },
                          child: const Icon(
                            Icons.clear,
                          ),
                        ),
                      ],
                    ),
                  );
                  final data = decodeData[index];
                  await predictData(
                    dataTosend: data,
                    socType: socType,
                  ).then((value) async {
                    if (value[0] == 200) {
                      if (socType == "auth") {
                        final filename = value[1];
                        final jsonDecodedData = json.decode(filename);
                        final jsonFileNameOrigin =
                            jsonDecodedData['json_path'].toString();
                        final jsonPathName =
                            jsonFileNameOrigin.split("dashboard/")[1];

                        // Navigator.pop(context);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AuthChartDetailsScreen(
                              fileName: jsonPathName,
                            ),
                          ),
                        );
                      } else if (socType == "ids") {
                        log("Your are in ids");
                        DashBoardService.getPreviousPredictedResult(
                          datasetname: "ids",
                        ).then((value) async {
                          DateTime now = DateTime.now();
                          final todayDate =
                              "${now.year.toString()}_${now.month.toString().padLeft(2, '0')}_${now.day.toString().padLeft(2, '0')}";
                          log("Response data ${json.decode(value).runtimeType}");

                          // Predicted Results/ids/ids_2022_08_28/df_Web_Attack/json/df_Web_Attack_2022_08_28.json
                          // Predicted Results/ids/ids_2022_08_28/DoS_GoldenEye/json/DoS_GoldenEye_2022_08_28.json
                          // Predicted Results/ids/ids_2022_08_28/DoS_Hulk/json/DoS_Hulk_2022_08_28.json
                          // Predicted Results/ids/ids_2022_08_28/DoS_Slowhttptest/json/DoS_Slowhttptest_2022_08_28.json
                          // Predicted Results/ids/ids_2022_08_28/FTPPatator/json/FTPPatator_2022_08_28.json
                          // Predicted Results/ids/ids_2022_08_28/Heartbleed/json/Heartbleed_2022_08_28.json
                          // Predicted Results/ids/ids_2022_08_28/Infiltration/json/Infiltration_2022_08_28.json
                          // Predicted Results/ids/ids_2022_08_28/PortScan/json/PortScan_2022_08_28.json
                          //Predicted Results/ids/ids_2022_08_28/SSHPatator/json/SSHPatator_2022_08_28.json
                          //Predicted Results/ids/ids_2022_08_28/Web_Attack_Brute_Force/json/Web_Attack_Brute_Force_2022_08_28.json
                          //Predicted Results/ids/ids_2022_08_28/Web_Attack_Sql_Injection/json/Web_Attack_Sql_Injection_2022_08_28.json
                          // Predicted Results/ids/ids_2022_08_28/Web_Attack_XSS_benign/json/Web_Attack_XSS_benign_2022_08_28.json

                          final botFile =
                              "Predicted Results/ids/ids_$todayDate/Bot/json/Bot_$todayDate.json";
                          final ddosBenignFile =
                              "Predicted Results/ids/ids_$todayDate/df_DDoS_benign/json/df_DDoS_benign_$todayDate.json";
                          final webAttackFile =
                              "Predicted Results/ids/ids_$todayDate/df_Web_Attack/json/df_Web_Attack_$todayDate.json";

                          final dosGlodenFile =
                              "Predicted Results/ids/ids_$todayDate/DoS_GoldenEye/json/DoS_GoldenEye_$todayDate.json";
                          final dosHulkFile =
                              "Predicted Results/ids/ids_$todayDate/DoS_Hulk/json/DoS_Hulk_$todayDate.json";
                          final slowHttpFile =
                              "Predicted Results/ids/ids_$todayDate/DoS_Slowhttptest/json/DoS_Slowhttptest_$todayDate.json";
                          final ftpPatatorFile =
                              "Predicted Results/ids/ids_$todayDate/FTPPatator/json/FTPPatator_$todayDate.json";
                          final heartbleedFile =
                              "Predicted Results/ids/ids_$todayDate/Heartbleed/json/Heartbleed_$todayDate.json";
                          final infiltrationfile =
                              "Predicted Results/ids/ids_$todayDate/Infiltration/json/Infiltration_$todayDate.json";
                          final portScanFile =
                              "Predicted Results/ids/ids_$todayDate/PortScan/json/PortScan_$todayDate.json";

                          final sshPatatorFile =
                              "Predicted Results/ids/ids_$todayDate/SSHPatator/json/SSHPatator_$todayDate.json";

                          final bruteForceFile =
                              "Predicted Results/ids/ids_$todayDate/Web_Attack_Brute_Force/json/Web_Attack_Brute_Force_$todayDate.json";

                          final sqlInjection =
                              "Predicted Results/ids/ids_$todayDate/Web_Attack_Sql_Injection/json/Web_Attack_Sql_Injection_$todayDate.json";
                          final webXssfile =
                              "Predicted Results/ids/ids_$todayDate/Web_Attack_XSS_benign/json/Web_Attack_XSS_benign_$todayDate.json";

                          // log(value.runtimeType.toString());
                          // final decodeData = json.decode(value);
                          // final idsData = decodeData["files"];
                          // int datasetLength = idsData.length;

                          // log(idsData[0].toString());
                          // for (var i = 0; i < datasetLength; i++) {
                          //   final botfile = idsData[index]
                          //       .toString()
                          //       .split("ids_2022_08_28")[1];
                          //   log("Bot File is $botfile");
                          // }

                          // if (datasetLength != 1) {
                          //   idsData.forEach((key) {
                          //     if ("${key.keys}" == "(ids_$todayDate)") {
                          //       final bot = key.values
                          //           .toString()
                          //           .replaceAll('(', '')
                          //           .replaceAll(')', '');

                          //       log("length${bot.length}");
                          //     }
                          //   });
                          // } else {
                          //   final botDtata = idsData["ids_$todayDate"][0];
                          //   log("Bot Datta$botDtata");
                          // }
                          // log(todayDate.toString());

                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => IDSChartDetailsScreen(
                                botfileName: botFile,
                                ddosName: ddosBenignFile,
                                webAttackName: webAttackFile,
                                goldenEyeName: dosGlodenFile,
                                hulkName: dosHulkFile,
                                slowHttpName: slowHttpFile,
                                ftpPatatorName: ftpPatatorFile,
                                heartBleedName: heartbleedFile,
                                infiltrationName: infiltrationfile,
                                portScanName: portScanFile,
                                sshPatatorName: sshPatatorFile,
                                webBruteForceName: bruteForceFile,
                                webSqlInjectionName: sqlInjection,
                                webXSSName: webXssfile,
                              ),
                            ),
                          );
                        });
                      } else {
                        final Size size = MediaQuery.of(context).size;
                        final snackBar = SnackBar(
                          // width: size.width / 2.5,
                          content: const Text(
                            'Not Not Supported /n 😥!',
                            textAlign: TextAlign.center,
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          margin: EdgeInsets.fromLTRB(
                            size.width - size.width / 2.4,
                            0,
                            10,
                            size.height / 1.17,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      Navigator.pop(context);
                      final Size size = MediaQuery.of(context).size;
                      final snackBar = SnackBar(
                        // width: size.width / 2.5,
                        content: const Text('Only Select .log file'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.fromLTRB(
                          size.width - size.width / 2.4,
                          0,
                          10,
                          size.height / 1.17,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
                title: Text(
                  finalDatasetName,
                  textAlign: TextAlign.justify,
                ),
                subtitle: Text(filecreatedDateTime),
                trailing: isToday
                    ? const Icon(Icons.circle, size: 10, color: Colors.black)
                    : null,
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        } else {
          return Center(
            child: GlobalWidget.displayDialogWithLoadingIndicator(),
          );
        }
      } catch (e) {
        rethrow;
      }
    },
  );
}

// raw dataset outer container contain data set name and container
buildDataSetContainer({required Size size, required String datasetName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Text(
          "${datasetName.toUpperCase()} Raw Dataset",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        width: size.width / 2.2,
        height: size.height / 3,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(4),
        ),
        child: fetchDataFromAPi(
          future: getDataSet(datasetname: datasetName),
          socType: datasetName,
        ),
      ),
    ],
  );
}

// ////////////////////////////////////////////

//PREDICTION//

// ///////////////////////////////////////////

Future predictData({required dataTosend, required String socType}) async {
  try {
    final response = await http.post(
      Uri.parse(
        "http://127.0.0.1:8000/api/v1/$socType/predict/",
      ),
      body: dataTosend,
    );

    final responseBody = [response.statusCode, response.body];
    log(responseBody.toString());
    return responseBody;
  } catch (e) {
    rethrow;
  }
}

// Future IDSJson() async {
//   try {
//     final response = await http.get(Uri.parse(
//       "http://127.0.0.1:8000/api/v1/ids/previous/",
//     ));
//     log(response.statusCode.toString());

//     if (response.statusCode == 200) {
//       var responseData = json.decode(response.body);
//       return responseData;
//     }
//   } catch (e) {
//     rethrow;
//   }
// }

displayDialog({
  required BuildContext context,
  required Widget widget,
  // required String contentText,
  required Widget child,
  required List<Widget> actions,
  bool barrierDismissible = true,
}) {
  return showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: widget,
        content: child,
        actions: actions,
      );
    },
  );
}
