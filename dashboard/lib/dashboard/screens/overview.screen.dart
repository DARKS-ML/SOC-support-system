import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

import '../services/global.service.dart';
import '../widgets/dashboard.widget.dart';
import 'package:http/http.dart' as http;

import 'notification.screen.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Auth Anomaly Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
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
                  final decodeSnapshotData = json.decode(encodeSnapshotData);
                  final notificationData = decodeSnapshotData[1];
                  final decodeNotificationData = json.decode(notificationData);
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
                      int keyForPlatform = 1;
                      if (Platform.isLinux) {
                        keyForPlatform = 1;
                      } else if (Platform.isWindows) {
                        keyForPlatform = 0;
                      }
                      return ExpansionTile(
                        title: Text(
                          "$notificationName Notification",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${(notificationList.length / 2).toString().replaceAll(".0", "")} of notification",
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
                                      .split("$notificationKeyName/")[
                                          keyForPlatform]
                                      .endsWith(".json")
                                  ? ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => NotificationScreen(
                                              filePath: notificationList[i]
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      title: Text(
                                        "${notificationList[i].toString().split("$notificationKeyName/")[keyForPlatform].split(".")[0].split("_")[1].toUpperCase()} log Anomaly",
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
                return Container(
                  margin: const EdgeInsets.only(top: 100),
                  alignment: Alignment.center,
                  child: const Center(
                    child: Text("No Notification yet!"),
                  ),
                );
              }
            },
          ),
        ],
      ),
    ));
  }
}
