import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

import '../widgets/dashboard.widget.dart';
import 'package:http/http.dart' as http;

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalWidget.displayNotificationSideBar(),
    );
  }
}
