import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

class NotificationScreen extends StatefulWidget {
  final String filePath;
  const NotificationScreen({Key? key, required this.filePath})
      : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // final String jsonSample = loadDataFromFile();
  bool toggle = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: loadDataFromFile(filePath: widget.filePath),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final snapshotData = snapshot.data;

              final jsonSample = "$snapshotData";
              var json = jsonDecode(jsonSample);
              final totalDataLength = json.length;
              int page1Data = totalDataLength > 20 ? 20 : json.length;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: toggle
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            JsonTable(
                              json,
                              showColumnToggle: true,
                              allowRowHighlight: true,
                              rowHighlightColor:
                                  Colors.yellow[500]!.withOpacity(0.7),
                              paginationRowCount: page1Data,
                              onRowSelect: (index, map) {},
                            ),
                          ],
                        )
                      : Center(
                          child: Text(getPrettyJSONString(jsonSample)),
                        ),
                ),
              );
            } else {
              return GlobalWidget.displayDialogWithLoadingIndicator(
                  isCenter: true);
            }
          }),
      // floatingActionButton: FloatingActionButton(
      //     child: const Icon(Icons.grid_on),
      //     onPressed: () {
      //       setState(
      //         () {
      //           toggle = !toggle;
      //         },
      //       );
      //     }),
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}

loadDataFromFile({required String filePath}) async {
  String path = filePath;
  // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
  File f = File(path);
  final input = await f.readAsString();

  return input;
}
