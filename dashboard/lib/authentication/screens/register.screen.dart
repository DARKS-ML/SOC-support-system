import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/auth.service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible = false;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: const Color(0x00000050),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "...",
              style: TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            const CircleAvatar(
              backgroundColor: Colors.black,
              child: Text(
                "SOC",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Container(
              height: size.height * 0.70,
              width: size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.blue,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create your account",
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        decorationColor: Colors.deepOrange,
                        letterSpacing: 1.5,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.015,
                        color: const Color(0xff007bff)),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: firstnameController,
                      style: const TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        label: const Text("First Name"),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: lastnameController,
                      style: const TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        label: const Text("Last Name"),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      style: const TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        label: const Text("Phone Number"),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      style: const TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        label: const Text("Email"),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.blue),
                      obscureText: !_passwordVisible,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                _passwordVisible = !_passwordVisible;
                              },
                            );
                          },
                        ),
                        label: const Text("Password"),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () async {
                      AuthService.registerService(context: context);

                      // await register(
                      //   firstname: firstnameController.text,
                      //   lastname: lastnameController.text,
                      //   phone: phoneController.text,
                      //   email: emailController.text,
                      //   password: passwordController.text,
                      // ).then((value) async {
                      //   if (value[0] == 200) {
                      //     AuthService.registerService(context: context);
                      //   } else {
                      //     final Size size = MediaQuery.of(context).size;
                      //     final snackBar = SnackBar(
                      //       // width: size.width / 2.5,
                      //       content: const Text(
                      //         'Invalid credentials!',
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(fontSize: 25),
                      //       ),
                      //       behavior: SnackBarBehavior.floating,
                      //       backgroundColor: Colors.red,
                      //       margin: EdgeInsets.fromLTRB(
                      //         size.width - size.width / 2.4,
                      //         0,
                      //         10,
                      //         size.height / 1.17,
                      //       ),
                      //     );
                      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //     emailController.clear();
                      //     passwordController.clear();
                      //   }
                      // });
                    },
                    child: Container(
                      // width: size.width * 0.08,
                      // height: size.height * 0.08,
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff007bff),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.5),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                            child: Text("Already have  an account? ")),
                        Flexible(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/login");
                              },
                              child: const Text("Login")),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future register({
    required String firstname,
    required String lastname,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "http://127.0.0.1:8000/auth/register/",
        ),
        body: {
          "firstname": firstname,
          "lastname": lastname,
          "phoneNo": phone,
          "email": email,
          "password": password
        },
      );

      final responseBody = [response.statusCode, response.body];
      log(responseBody.toString());
      return responseBody;
    } catch (e) {
      rethrow;
    }
  }
}





















// import 'package:dashboard/authentication/screens/authentication.screen.dart';
// import 'package:dashboard/config/responsive.dart';
// import 'package:flutter/material.dart';

// import '../services/auth.service.dart';
// import '../widgets/authentication.widget.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final bool isDesktop = Responsiveness.isDesktop(context);
//     final double verticalPadding = isDesktop ? 20 : 10;
//     final double horizontalPadding = isDesktop ? 20 : 10;
//     final _size = MediaQuery.of(context).size;
//     final sizebox = SizedBox(
//       height: verticalPadding,
//     );

//     return Scaffold(
//       appBar: AppBar(toolbarHeight: 0),
//       body: ListView(
//         padding: EdgeInsets.symmetric(
//           horizontal: _size.width / 20,
//           vertical: verticalPadding,
//         ),
//         children: [
//           sizebox,
//           Center(
//             child: Text(
//               "Register \nTo\nDarks SoC System",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: isDesktop ? 30 : 15,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: isDesktop ? 100 : 20,
//           ),
//           AuthWidgets.buildTextFormField(
//             horizontalPadding: horizontalPadding,
//             hintText: "UserName",
//           ),
//           sizebox,
//           AuthWidgets.buildTextFormField(
//             horizontalPadding: horizontalPadding,
//             hintText: "Phone No.",
//           ),
//           sizebox,
//           AuthWidgets.buildTextFormField(
//             horizontalPadding: horizontalPadding,
//             hintText: "Password",
//           ),
//           sizebox,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               AuthWidgets.buildButton(
//                 size: _size,
//                 text: "Login",
//                 onTap: () {
//                   Navigator.pushNamed(context, "/login");
//                 },
//               ),
//               AuthWidgets.buildButton(
//                 size: _size,
//                 text: "Register",
//                 onTap: () => AuthService.loginService(context: context),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
