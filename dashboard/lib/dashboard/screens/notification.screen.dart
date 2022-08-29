import 'dart:convert';
import 'dart:io';

import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

class NotificationScreen extends StatelessWidget {
  final String filePath;
  const NotificationScreen({Key? key, required this.filePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        // toolbarHeight: 0,
        title: const Text(
          "Anomaly Data List",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 1,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      // floatingActionButton: ,
      body: FutureBuilder(
          future: loadDataFromFile(filePath: filePath),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final snapshotData = snapshot.data;

              final jsonSample = "$snapshotData";
              var json = jsonDecode(jsonSample);
              final totalDataLength = json.length;
              int page1Data = totalDataLength > 20 ? 20 : json.length;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: JsonTable(
                  json,
                  showColumnToggle: true,
                  allowRowHighlight: true,
                  rowHighlightColor: Colors.yellow[500]!.withOpacity(0.7),
                  paginationRowCount: page1Data,
                  onRowSelect: (index, map) {},
                ),
              );
            } else {
              return GlobalWidget.displayDialogWithLoadingIndicator(
                  isCenter: true);
            }
          }),
    );
  }

  //   // String getPrettyJSONString(jsonObject) {
//   //   JsonEncoder encoder = const JsonEncoder.withIndent('  ');
//   //   String jsonString = encoder.convert(json.decode(jsonObject));
//   //   return jsonString;
//   // }
}

loadDataFromFile({required String filePath}) async {
  String path = filePath;
  // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
  File f = File(path);
  final input = await f.readAsString();

  return input;
}
