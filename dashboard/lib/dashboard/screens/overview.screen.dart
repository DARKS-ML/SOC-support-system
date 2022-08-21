import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OverViewScreen extends StatelessWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.all(6),
                  height: _size.height / 8,
                  width: _size.width / 4.5,
                  child: Text("Content ${i + 1}"),
                ),
            ],
          ),
          SizedBox(height: 40),
          SizedBox(height: 40),
          Text("Last Date  Overview"),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            height: _size.height / 3.5,
            color: Colors.green,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            height: _size.height / 3.5,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
