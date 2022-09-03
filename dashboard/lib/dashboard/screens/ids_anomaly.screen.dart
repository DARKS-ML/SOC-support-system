import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:http/http.dart' as http;

import '../widgets/dashboard.widget.dart';

class IDSAnomalySCreen extends StatefulWidget {
  String fileName;
  IDSAnomalySCreen({Key? key, required this.fileName}) : super(key: key);

  @override
  State<IDSAnomalySCreen> createState() => _IDSAnomalySCreenState();
}

class _IDSAnomalySCreenState extends State<IDSAnomalySCreen> {
  bool isSourceIp = false;
  bool isDescIp = false;
  bool isSourcePort = false;
  String defaultAnomalyJson = "";
  // "C:/Users/HIMAL PAUDEL/Documents/Project III/SOC-support-system/dashboard/Predicted Results/ids/test_all/GropBy/json/GropBy_test_all.json";
  String sourceIpJson =
      "C:/Users/HIMAL PAUDEL/Documents/Project III/SOC-support-system/dashboard/Predicted Results/Groupby/group_by_source_ip.json";
  String descIpJson =
      "C:/Users/HIMAL PAUDEL/Documents/Project III/SOC-support-system/dashboard/Predicted Results/Groupby/group_by_desc_ip.json";
  String sourcePortIpJson =
      "C:/Users/HIMAL PAUDEL/Documents/Project III/SOC-support-system/dashboard/Predicted Results/Groupby/group_by_source_port.json";
  String providePath = '';
  // "C:/Users/HIMAL PAUDEL/Documents/Project III/SOC-support-system/dashboard/Predicted Results/ids/test_all/GropBy/json/GropBy_test_all.json";

  @override
  void initState() {
    defaultAnomalyJson =
        "C:/Users/HIMAL PAUDEL/Documents/Project III/SOC-support-system/dashboard/${widget.fileName}";
    providePath =
        "C:/Users/HIMAL PAUDEL/Documents/Project III/SOC-support-system/dashboard/${widget.fileName}";
    groupByService(filePath: widget.fileName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSourceIp = !isSourceIp;
                      isDescIp = false;
                      isSourcePort = false;
                      providePath =
                          isSourceIp ? sourceIpJson : defaultAnomalyJson;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSourceIp ? Colors.green : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Text("Group By Source Ip"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSourceIp = false;
                      isDescIp = !isDescIp;
                      isSourcePort = false;
                      providePath = isDescIp ? descIpJson : defaultAnomalyJson;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDescIp ? Colors.green : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Text("Group By Destination Ip"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSourceIp = false;
                      isDescIp = false;
                      isSourcePort = !isSourcePort;
                      providePath =
                          isSourcePort ? sourcePortIpJson : defaultAnomalyJson;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSourcePort ? Colors.green : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Text("Group By Source Port"),
                  ),
                ),
              ],
            ),
            FutureBuilder(
                future: loadDataFromFile(
                  filePath: providePath,
                ),
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
          ],
        ),
      ),
    );
  }
}

groupByService({required String filePath}) async {
  try {
    final path = filePath.replaceAll("json", "csv");
    final response = await http.get(Uri.parse(
        "http://localhost:8000/api/v1/ids/groupby/?csv_path=C:/Users/HIMAL PAUDEL/Documents/Project III/SOC-support-system/dashboard/$path"));
    if (response.statusCode == 200) {
      // log(response.body);
      return response.body;
    }
    log(path);
  } catch (e) {
    rethrow;
  }
}

// load multi class predicted data
loadDataFromFile({required String filePath}) async {
  String path = filePath;
  File f = File(path);
  // log("Message aayo$path");
  final input = await f.readAsString();

  return input;
}
