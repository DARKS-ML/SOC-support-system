import 'dart:async';
import 'dart:convert';
import 'package:dashboard/dashboard/screens/ids_anomaly.screen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../screens/notification.screen.dart';
import '../services/global.service.dart';

class GlobalWidget {
  static displayDashboardAppbar({
    required BuildContext context,
  }) {
    DateTime dateTime = DateTime.now();
    DateTime now = DateTime.now();
    final todayDate =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final size = MediaQuery.of(context).size;
    Timer.periodic(const Duration(seconds: 1), (timer) {});

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Soc DashBoard",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: size.width / 2.75,
          ),
          Text(
            "$todayDate ",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.black,
          child: IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => IDSAnomalySCreen(),
                ),
              );
              // String path =
              //     "Predicted Results/ids_notf_2022_09_02_group_by.json";
              // File f = File(path);
              // final input = await f.readAsString();
              // final groupbySource = json.decode(input);
              // final dd = groupbySource["source_ip"];
              // print(dd);

              // scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(
              Icons.notification_add,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            Widget _buildPopupDialog(BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Are You Sure ?",
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            "/login",
                          );
                        },
                        child: const Text(
                          "Log Out",
                        ),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            }

            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            );
          },
          child: const CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 30)
      ],
    );
  }

  static displayDialogWithLoadingIndicator({
    double height = 50,
    double width = 50,
    bool isCenter = false,
  }) {
    final loadingIndicator = SizedBox(
      height: height,
      width: width,
      child: const LoadingIndicator(
          indicatorType: Indicator.lineScalePulseOutRapid,

          /// Required, The loading type of the widget
          colors: [Colors.black, Colors.grey, Colors.red, Colors.green],

          /// Optional, The color collections
          strokeWidth: 2,

          /// Optional, The stroke of the line, only applicable to widget which contains line
          backgroundColor: Colors.transparent,

          /// Optional, Background of the widget
          pathBackgroundColor: Colors.black

          /// Optional, the stroke backgroundColor
          ),
    );
    if (isCenter) {
      return Center(
        child: loadingIndicator,
      );
    } else {
      return loadingIndicator;
    }
  }

  static displayBackButton(
      {required BuildContext context, double padding = 10}) {
    return Padding(
      padding: EdgeInsets.all(padding),
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
    );
  }

  static loadingWidget({required BuildContext context}) {
    return const Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: LoadingIndicator(
            indicatorType: Indicator.lineScalePulseOutRapid,

            /// Required, The loading type of the widget
            colors: [Colors.black, Colors.grey, Colors.red, Colors.green],

            /// Optional, The color collections
            strokeWidth: 2,

            /// Optional, The stroke of the line, only applicable to widget which contains line
            backgroundColor: Colors.transparent,

            /// Optional, Background of the widget
            pathBackgroundColor: Colors.black

            /// Optional, the stroke backgroundColor
            ),
      ),
    );
  }

  // notification sidebar
  static displayNotificationSideBar() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Notifications",
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
                                      .split("$notificationKeyName/")[0]
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
                                        "${notificationList[i].toString().split("$notificationKeyName/")[0].split(".")[0].split("_")[1].toUpperCase()} log Anomaly",
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
    );
  }

  static displaySnackbar(
      {required BuildContext context,
      String msg = 'Failed to load data',
      Color color = Colors.red}) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      width: 300,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// details page appbar
  static displayDetailsPageAppBar({
    required BuildContext context,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) {
    return AppBar(
      elevation: 1,
      leading: GlobalWidget.displayBackButton(context: context),
      backgroundColor: Colors.white,
      title: Text(
        "${"intrusion detection system".toUpperCase()} ",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.black,
          child: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(
              Icons.notification_add,
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }

  // ids details page notification lists
  static displayIdsDetailsPageDrawer() {
    return Drawer(
      child: SingleChildScrollView(
        // controller: controller,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Notification",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            FutureBuilder(
              builder: (context, snapshot) {
                try {
                  return Text("data");
                } catch (e) {
                  return GlobalWidget.loadingWidget(context: context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

loadIDSMultiClassModelAndPredict({
  required String jsonFilePath,
}) async {
  try {
    final response = await http.post(
      Uri.parse(
        "http://localhost:8000/api/v1/ids/multiclass/",
      ),
      body: jsonFilePath,
    );
  } catch (e) {
    rethrow;
  }
}
