import 'dart:convert';
import 'dart:io';

import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

class CSVScreen extends StatelessWidget {
  final String title;
  final String filePath;
  const CSVScreen({Key? key, required this.filePath, required this.title})
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
        title: Text(
          title,
          style: const TextStyle(
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
                  columns: [
                    JsonTableColumn("Timestamp"),
                    JsonTableColumn(" Destination Port"),
                    JsonTableColumn("Source IP"),
                    JsonTableColumn("Destination IP"),
                    JsonTableColumn("Bot_prob_xgb",
                        label: "Anomaly", valueBuilder: threat),
                    JsonTableColumn("Protocol"),
                  ],
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
}

String threat(value) {
  if (double.parse(value) >= 0.70) {
    return "Anomaly";
  } else {
    return "Fine";
  }
}

loadDataFromFile({required String filePath}) async {
  String path = filePath;
  File f = File(path);
  final input = await f.readAsString();

  return input;
}
