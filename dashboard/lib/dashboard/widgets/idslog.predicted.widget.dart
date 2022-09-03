import 'dart:convert';

import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';

import '../screens/details/ids.chart_details.screen.dart';
import '../services/auth_log_services.dart';

displayIdsLogPredictedResultWidget({required BuildContext context}) {
  final Size size = MediaQuery.of(context).size;
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Text(
            "${"ids".toUpperCase()} Previous Prediction",
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
          child: FutureBuilder(
            future: DashBoardService.getPreviousPredictedResult(
              datasetname: "ids",
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              try {
                if (snapshot.hasData) {
                  final snapshotData = snapshot.data;
                  final decodeData = json.decode(snapshotData);
                  final idsData = decodeData["data"]["ids"];
                  final datasetLength = idsData.length;
                  final predictionBasePath = decodeData['files'][0]
                      .toString()
                      .split("Predicted Results")[0];
                  DateTime now = DateTime.now();
                  final todayDate =
                      "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
                  return datasetLength <= 0
                      ? const Center(
                          child: Text(
                            "No Previous Prediction\n yet!",
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: datasetLength,
                          itemBuilder: (context, index) {
                            final keysName = idsData[index]
                                .keys
                                .toString()
                                .replaceAll("(", "")
                                .replaceAll(")", "")
                                .toString();
                            bool isToday = todayDate == keysName;

                            final groupByFile =
                                "Predicted Results/ids/$keysName/GropBy/json/GropBy_$keysName.json";

                            final botFile =
                                "Predicted Results/ids/$keysName/Bot/json/Bot_$keysName.json";
                            final ddosBenignFile =
                                "Predicted Results/ids/$keysName/df_DDoS_benign/json/df_DDoS_benign_$keysName.json";
                            // final webAttackFile =
                            //     "Predicted Results/ids/$keysName/df_Web_Attack/json/df_Web_Attack_$keysName.json";

                            final dosGlodenFile =
                                "Predicted Results/ids/$keysName/DoS_GoldenEye/json/DoS_GoldenEye_$keysName.json";
                            final dosHulkFile =
                                "Predicted Results/ids/$keysName/DoS_Hulk/json/DoS_Hulk_$keysName.json";
                            final slowHttpFile =
                                "Predicted Results/ids/$keysName/DoS_Slowhttptest/json/DoS_Slowhttptest_$keysName.json";
                            final ftpPatatorFile =
                                "Predicted Results/ids/$keysName/FTPPatator/json/FTPPatator_$keysName.json";
                            final heartbleedFile =
                                "Predicted Results/ids/$keysName/Heartbleed/json/Heartbleed_$keysName.json";
                            final infiltrationfile =
                                "Predicted Results/ids/$keysName/Infiltration/json/Infiltration_$keysName.json";
                            final portScanFile =
                                "Predicted Results/ids/$keysName/PortScan/json/PortScan_$keysName.json";

                            final sshPatatorFile =
                                "Predicted Results/ids/$keysName/SSHPatator/json/SSHPatator_$keysName.json";

                            final bruteForceFile =
                                "Predicted Results/ids/$keysName/Web_Attack_Brute_Force/json/Web_Attack_Brute_Force_$keysName.json";

                            final sqlInjection =
                                "Predicted Results/ids/$keysName/Web_Attack_Sql_Injection/json/Web_Attack_Sql_Injection_$keysName.json";
                            final webXssfile =
                                "Predicted Results/ids/$keysName/Web_Attack_XSS_benign/json/Web_Attack_XSS_benign_$keysName.json";

                            return ListTile(
                              onTap: () async {
                                // log(idsData[0][keys1][2][key2][0]["json"]
                                //     .toString());
                                // log(idsData[keys1].toString());

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
                              },
                              title: Text("$keysName : Prediction Result"),
                              // subtitle: Text('$keysName'),
                              trailing: isToday
                                  ? const Icon(Icons.circle,
                                      size: 10, color: Colors.black)
                                  : null,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } catch (e) {
                return const Center(
                  child: Text(
                    "No Previous Prediction\n yet!",
                    textAlign: TextAlign.center,
                  ),
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}
