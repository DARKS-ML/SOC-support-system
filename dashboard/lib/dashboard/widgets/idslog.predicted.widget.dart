import 'dart:convert';

import 'package:dashboard/dashboard/screens/details/ids.chart_details.screen.dart';
import 'package:flutter/material.dart';

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
            future: DashBoardService.getPrevousPredictedResult(
              datasetname: "ids",
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              try {
                if (snapshot.hasData) {
                  final snapshotData = snapshot.data;
                  final decodeData = json.decode(snapshotData);
                  final idsData = decodeData["data"]["ids"];
                  final datasetLength = idsData.length;
                  DateTime now = DateTime.now();
                  final todayDate =
                      "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
                  return 1 <= 0
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
                                .replaceAll(
                                  ")",
                                  "",
                                )
                                .replaceAll(
                                  "ids_",
                                  "",
                                )
                                .replaceAll(
                                  "_",
                                  "-",
                                );
                            bool isToday = todayDate == keysName;

                            return ListTile(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const IDSChartDetailsScreen(
                                            fileName: "",
                                          )),
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
                rethrow;
              }
            },
          ),
        ),
      ],
    ),
  );
}
