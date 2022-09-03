import 'package:dashboard/dashboard/widgets/idslog.predicted.widget.dart';
import 'package:dashboard/dashboard/widgets/index.dart';
import 'package:flutter/material.dart';

import '../widgets/authlog.predicted.widget.dart';

class PreviousPredictResultScreen extends StatelessWidget {
  const PreviousPredictResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: GlobalWidget.displayDashboardAppbar(),
      body: SingleChildScrollView(
        child: Row(
          children: [
            displayAuthLogPredictedResultWidget(context: context),
            displayIdsLogPredictedResultWidget(context: context),
          ],
        ),
      ),
    );
  }
}
