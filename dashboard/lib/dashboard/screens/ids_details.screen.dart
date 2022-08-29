// import 'package:dashboard/dashboard/widgets/index.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class IDSDetailsScreen extends StatelessWidget {
//   const IDSDetailsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
//       floatingActionButton: GlobalWidget.displayBackButton(context: context),
//       body: Container(
//         // height: 200,
//         width: double.infinity,
//         color: Colors.red,
//         child: SingleChildScrollView(
//             child: Column(
//           children: [
//             Container(
//               height: 200,
//               color: Colors.green,
//               child: FutureBuilder(
//                 future: loadjsonData(),
//                 // initialData: InitialData,
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   if (snapshot.hasData) {
//                     return const Text("data");
//                   } else {
//                     return Text("${snapshot.data}");
//                   }
//                 },
//               ),
//               // child: ListView.builder(
//               //   scrollDirection: Axis.horizontal,
//               //   itemCount: 100,
//               //   itemBuilder: (BuildContext context, int index) {
//               //     return Column(
//               //       children: [
//               //         Container(
//               //           margin: const EdgeInsets.only(right: 10, bottom: 10),
//               //           color: Colors.yellow,
//               //           height: 50,
//               //           width: 20,
//               //         ),
//               //         RotatedBox(
//               //           quarterTurns: -1,
//               //           child: Text("data $index"),
//               //         )
//               //       ],
//               //     );
//               //   },
//               // ),
//             ),
//             Container(
//               height: 200,
//               color: Colors.pink,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 100,
//                 itemBuilder: (BuildContext context, int index) {
//                   return const Text("data");
//                 },
//               ),
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }

// loadjsonData() async {
//   final data = await rootBundle.loadString(
//     "Predicted Results/ids/ids_2022_08_28/Bot/json/Bot_2022_08_28.json",
//   );
//   return data;
// }
