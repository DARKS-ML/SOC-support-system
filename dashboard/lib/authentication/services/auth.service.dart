import 'package:flutter/material.dart';

class AuthService {
  static loginPage({required BuildContext context}) async {
    return Navigator.pushReplacementNamed(context, '/login');
  }

  static loginService({required BuildContext context}) async {
    return Navigator.pushReplacementNamed(context, '/dashboard');
  }

  static registerService({required BuildContext context}) async {
    return Navigator.pushReplacementNamed(context, '/dashboard');
  }
}
