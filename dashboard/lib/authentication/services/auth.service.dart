import 'package:flutter/material.dart';

class AuthService {
  static loginService({required BuildContext context}) async {
    return Navigator.pushReplacementNamed(context, '/dashboard');
  }

  static registerService({required BuildContext context}) async {
    return Navigator.pushReplacementNamed(context, '/dashboard');
  }
}
