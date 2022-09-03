import 'dart:convert';
import 'dart:developer';

import 'package:dashboard/dashboard/screens/details/auth.chart_details.screen.dart';
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
                        const Text("Processing....\n"),
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
                  log("message$data");
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
                          final folderName = finalDatasetName
                              .split("Dataset/ids/")[1]
                              .split(".csv")[0];
                          final valueDecode = json.decode(value);
                          // print("value is sss ${}");
                          final predictionBasePath = valueDecode['files'][0]
                              .toString()
                              .split("Predicted Results")[0];

                          // DateTime now = DateTime.now();
                          // final todayDate =
                          //     "${now.year.toString()}_${now.month.toString().padLeft(2, '0')}_${now.day.toString().padLeft(2, '0')}";
                          // log("Response data ${json.decode(value).runtimeType}");

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
                          final groupByFile =
                              "Predicted Results/ids/$folderName/GropBy/json/GropBy_$folderName.json";
                          final botFile =
                              "Predicted Results/ids/$folderName/Bot/json/Bot_$folderName.json";
                          final ddosBenignFile =
                              "Predicted Results/ids/$folderName/df_DDoS_benign/json/df_DDoS_benign_$folderName.json";
                          // final webAttackFile =
                          //     "Predicted Results/ids/$folderName/df_Web_Attack/json/df_Web_Attack_$folderName.json";

                          final dosGlodenFile =
                              "Predicted Results/ids/$folderName/DoS_GoldenEye/json/DoS_GoldenEye_$folderName.json";
                          final dosHulkFile =
                              "Predicted Results/ids/$folderName/DoS_Hulk/json/DoS_Hulk_$folderName.json";
                          final slowHttpFile =
                              "Predicted Results/ids/$folderName/DoS_Slowhttptest/json/DoS_Slowhttptest_$folderName.json";
                          final ftpPatatorFile =
                              "Predicted Results/ids/$folderName/FTPPatator/json/FTPPatator_$folderName.json";
                          final heartbleedFile =
                              "Predicted Results/ids/$folderName/Heartbleed/json/Heartbleed_$folderName.json";
                          final infiltrationfile =
                              "Predicted Results/ids/$folderName/Infiltration/json/Infiltration_$folderName.json";
                          final portScanFile =
                              "Predicted Results/ids/$folderName/PortScan/json/PortScan_$folderName.json";

                          final sshPatatorFile =
                              "Predicted Results/ids/$folderName/SSHPatator/json/SSHPatator_$folderName.json";

                          final bruteForceFile =
                              "Predicted Results/ids/$folderName/Web_Attack_Brute_Force/json/Web_Attack_Brute_Force_$folderName.json";

                          final sqlInjection =
                              "Predicted Results/ids/$folderName/Web_Attack_Sql_Injection/json/Web_Attack_Sql_Injection_$folderName.json";
                          final webXssfile =
                              "Predicted Results/ids/$folderName/Web_Attack_XSS_benign/json/Web_Attack_XSS_benign_$folderName.json";

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
                          // log(bruteForceFile);
                          // log(webXssfile);

                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => IDSChartDetailsScreen(
                                predictionBasePath: predictionBasePath,
                                botfileName: botFile,
                                ddosName: ddosBenignFile,
                                // webAttackName: webAttackFile,
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
                                groupdfileName: groupByFile,
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
