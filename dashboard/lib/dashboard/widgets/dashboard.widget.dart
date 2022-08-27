import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class GlobalWidget {
  static displayDashboardAppbar() {
    return AppBar(
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
    );
  }

  static displayDialog({double height = 50, double width = 50}) {
    return SizedBox(
      height: height,
      width: width,
      child: const LoadingIndicator(
          indicatorType: Indicator.lineScalePulseOutRapid,

          /// Required, The loading type of the widget
          colors: [Colors.black, Colors.grey, Colors.red, Colors.green],

          /// Optional, The color collections
          strokeWidth: 2,

          /// Optional, The stroke of the line, only applicable to widget which contains line
          backgroundColor: Colors.transparent,

          /// Optional, Background of the widget
          pathBackgroundColor: Colors.black

          /// Optional, the stroke backgroundColor
          ),
    );
  }

  static displayBackButton({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(
          context,
          '/dashboard',
        ),
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
    );
  }
}
