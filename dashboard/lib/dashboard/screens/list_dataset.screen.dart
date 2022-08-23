import 'dart:convert';
import 'dart:developer';

import 'package:dashboard/dashboard/screens/chart_details.auth.screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
              onPressed: () {},
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
                  final data = decodeData[index];
                  // final dataTosend = json.encode(data);
                  await predictData(
                    dataTosend: data,
                    socType: socType,
                  ).then((value) async {
                    if (value[0] == 200) {
                      final filename = value[1];
                      final jsonDecodedData = json.decode(filename);
                      final jsonFileNameOrigin =
                          jsonDecodedData['json_path'].toString();
                      final jsonPathName =
                          jsonFileNameOrigin.split("dashboard/")[1];
                      print("ddddd $jsonPathName");

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChartDetailsScreen(
                            fileName: jsonPathName,
                          ),
                        ),
                      );
                    } else {
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
                    ? Icon(Icons.circle, size: 10, color: Colors.black)
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
