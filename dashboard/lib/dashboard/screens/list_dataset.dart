import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListDataSet extends StatelessWidget {
  const ListDataSet({Key? key}) : super(key: key);

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
            buildDataSetContainer(size: size, datasetName: "auth"),
            buildDataSetContainer(size: size, datasetName: "ids")
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
          return ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: datasetLength,
            itemBuilder: (context, index) {
              final datasetPath = decodeData[index]["path"].toString();
              final String finalDatasetName =
                  datasetPath.split("SOC-support-system/")[1];

              return ListTile(
                onTap: () {
                  final data = decodeData[index];
                  // final dataTosend = json.encode(data);
                  predictData(
                    dataTosend: data,
                    socType: socType,
                  );
                },
                title: Text(
                  finalDatasetName,
                  textAlign: TextAlign.justify,
                ),
                subtitle: Text(decodeData[index]["date"]),
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

predictData({
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
    log(response.body);
    return response.body;
  } catch (e) {
    rethrow;
  }
}
