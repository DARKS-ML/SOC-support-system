import 'package:flutter/material.dart';

class IDSChartScreenDetails extends StatelessWidget {
  const IDSChartScreenDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
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
      ),
      body: const Text("IDS CHART SCREEN"),
    );
  }
}
