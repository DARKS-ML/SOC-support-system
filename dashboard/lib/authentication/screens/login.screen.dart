import 'package:dashboard/authentication/screens/authentication.screen.dart';
import 'package:dashboard/config/responsive.dart';
import 'package:flutter/material.dart';

import '../widgets/authentication.widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsiveness.isDesktop(context);
    final double verticalPadding = isDesktop ? 20 : 10;
    final double horizontalPadding = isDesktop ? 20 : 10;
    final _size = MediaQuery.of(context).size;
    final sizebox = SizedBox(
      height: verticalPadding,
    );

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: _size.width / 20,
          vertical: verticalPadding,
        ),
        children: [
          sizebox,
          Center(
            child: Text(
              "Login \nTo\nDarks SoC System",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isDesktop ? 30 : 15,
              ),
            ),
          ),
          SizedBox(
            height: isDesktop ? 100 : 20,
          ),
          AuthWidgets.buildTextFormField(
            horizontalPadding: horizontalPadding,
            hintText: "UserName",
          ),
          sizebox,
          AuthWidgets.buildTextFormField(
            horizontalPadding: horizontalPadding,
            hintText: "Password",
          ),
          sizebox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AuthWidgets.buildButton(
                size: _size,
                text: "Login",
                onTap: () {
                  //Login code
                },
              ),
              AuthWidgets.buildButton(
                size: _size,
                text: "Register",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}