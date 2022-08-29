import 'dart:convert';
import 'dart:developer';

import 'package:dashboard/dashboard/screens/details/auth.chart_details.screen.dart';
import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';

import '../services/auth_log_services.dart';
import 'details/ids.chart_details.screen.dart';

class ListDataSetScreen extends StatelessWidget {
  const ListDataSetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Soc DashBoard",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              onPressed: () {
                displayDialog(
                  context: context,
                  actions: [],
                  child: GlobalWidget.displayDialog(),
                  widget: const Text(""),
                );
              },
              icon: const Icon(
                Icons.notification_add,
                color: Colors.yellow,
              ),
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(
            backgroundColor: Colors.black,
          ),
          const SizedBox(width: 30)
        ],
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
                    child: const Center(
                      child: LoadingIndicator(
                          indicatorType: Indicator.lineScalePulseOutRapid,

                          /// Required, The loading type of the widget
                          colors: [
                            Colors.black,
                            Colors.grey,
                            Colors.red,
                            Colors.green
                          ],

                          /// Optional, The color collections
                          strokeWidth: 2,

                          /// Optional, The stroke of the line, only applicable to widget which contains line
                          backgroundColor: Colors.transparent,

                          /// Optional, Background of the widget
                          pathBackgroundColor: Colors.black

                          /// Optional, the stroke backgroundColor
                          ),
                    ),
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
                        DashBoardService.getPrevousPredictedResult(
                          datasetname: "ids",
                        ).then((value) {
                          DateTime now = DateTime.now();
                          final todayDate =
                              "${now.year.toString()}_${now.month.toString().padLeft(2, '0')}_${now.day.toString().padLeft(2, '0')}";
                          log("Response data ${json.decode(value).runtimeType}");
                          log(value.runtimeType.toString());
                          final decodeData = json.decode(value);
                          final idsData = decodeData["data"]["ids"];
                          final datasetLength = idsData.length;

                          if (datasetLength != 1) {
                            if (idsData.keysName == "ids_$todayDate") {
                              log("success ids_$todayDate");
                            }
                          } else {
                            final botDtata = idsData["ids_$todayDate"][0];
                            log("Bot Datta$botDtata");
                          }
                          log(todayDate.toString());
                        });

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const IDSChartScreenDetails(),
                          ),
                        );
                      } else {
                        final Size size = MediaQuery.of(context).size;
                        final snackBar = SnackBar(
                          // width: size.width / 2.5,
                          content: const Text(
                            'Not Not Supported \n 😥!',
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
            child: GlobalWidget.displayDialog(),
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

Future predictData({
  required dataTosend,
  required String socType,
}) async {
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
