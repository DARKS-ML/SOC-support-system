import 'package:dashboard/authentication/screens/authentication.screen.dart';
import 'package:flutter/material.dart';

import 'dashboard/screens/main/dashboard.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DARKS SoC System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: {
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/dashboard": (context) => DashBoardScreen(),
      },
    );
  }
}
