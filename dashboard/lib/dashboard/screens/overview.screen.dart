import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

import '../widgets/dashboard.widget.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
      body: SizedBox(
        width: size.width,
        height: double.infinity,
        child: FutureBuilder(
            future: loadDataFromFile(context: context, filePath: ""),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                try {
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
                } catch (e) {
                  return GlobalWidget.displayDialogWithLoadingIndicator(
                      isCenter: true);
                }
              } else {
                return GlobalWidget.displayDialogWithLoadingIndicator(
                    isCenter: true);
              }
            }),
      ),
    );
  }
}

loadDataFromFile(
    {required BuildContext context, required String filePath}) async {
  try {
    String path =
        "Predicted Results/Notification/notif_2022_08_31/auth_2022_08_31.json";
    // "/home/iamdpk/Project Work/SOC-support-system/dashboard/Predicted Results/ids/ids_2022_08_27/Bot/json/Bot_2022_08_27.json";
    File f = File(path);
    final input = await f.readAsString();

    return input;
  } catch (e) {
    GlobalWidget.displaySnackbar(context: context);
  }
}
