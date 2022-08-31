import 'dart:convert';

import 'package:flutter/material.dart';

import '../screens/details/auth.chart_details.screen.dart';
import '../services/auth_log_services.dart';

displayAuthLogPredictedResultWidget({required BuildContext context}) {
  final Size size = MediaQuery.of(context).size;
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Text(
            "${"auth".toUpperCase()} Previous Prediction",
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
              datasetname: "auth",
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              try {
                if (snapshot.hasData) {
                  final snapshotData = snapshot.data;
                  final decodeData = json.decode(snapshotData);
                  final datasetLength = decodeData.length;
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
                            final datasetPath =
                                decodeData[index]["path"].toString();
                            final String finalDatasetName = datasetPath
                                .split("dashboard/")[1]
                                .replaceAll(".json", "");
                            final filecreatedDateTime =
                                decodeData[index]["date"];
                            final filecreatedDate = decodeData[index]['date']
                                .toString()
                                .split(" ")[0];
                            bool isToday = filecreatedDate == todayDate;

                            final authDatasetFile =
                                datasetPath.replaceAll('\\', "/");
                            return ListTile(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AuthChartDetailsScreen(
                                      fileName: authDatasetFile,
                                    ),
                                  ),
                                );
                              },
                              title: Text(
                                // datasetPath,
                                finalDatasetName,
                                // textAlign: TextAlign.justify,
                              ),
                              subtitle: Text(filecreatedDateTime),
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
