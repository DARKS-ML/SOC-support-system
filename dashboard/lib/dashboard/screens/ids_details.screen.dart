import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';

class IDSDetailsScreen extends StatelessWidget {
  const IDSDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: GlobalWidget.displayBackButton(context: context),
      body: Container(
        // height: 200,
        width: double.infinity,
        color: Colors.red,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.green,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Text("data");
                },
              ),
            ),
            Container(
              height: 200,
              color: Colors.pink,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Text("data");
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
