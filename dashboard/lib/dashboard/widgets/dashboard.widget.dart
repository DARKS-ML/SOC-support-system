import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class GlobalWidget {
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
}
