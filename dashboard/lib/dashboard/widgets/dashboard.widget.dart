import 'dart:async';
import 'dart:convert';

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
            onPressed: () {
              // scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(
              Icons.notification_add,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20),
        const CircleAvatar(
          backgroundColor: Colors.black,
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

  static displayBackButton({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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
      {required BuildContext context, String msg = 'Failed to load data'}) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      backgroundColor: (Colors.red),
      behavior: SnackBarBehavior.floating,
      width: 300,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
