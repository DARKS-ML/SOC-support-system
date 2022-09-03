import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/auth.service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: size.height * 0.09,
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
              height: size.height * 0.65,
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
              child: Form(
                key: _formKey,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Welcome to Darks SOC",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            decorationColor: Colors.deepOrange,
                            letterSpacing: 1.5,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.015,
                            color: const Color(0xff007bff)),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        style: const TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          label: const Text("Username/Email"),
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
                      height: size.height * 0.05,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
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
                      height: size.height * 0.09,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await login(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((value) async {
                            if (value[0] == 200) {
                              AuthService.loginService(context: context);
                            } else {
                              final Size size = MediaQuery.of(context).size;
                              final snackBar = SnackBar(
                                // width: size.width / 2.5,
                                content: const Text(
                                  'Invalid credentials!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 25),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                margin: EdgeInsets.fromLTRB(
                                  size.width - size.width / 2.4,
                                  0,
                                  10,
                                  size.height / 1.17,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              emailController.clear();
                              passwordController.clear();
                            }
                          });
                        }
                      },
                      child: Container(
                        // width: size.width * 0.08,
                        // height: size.height * 0.08,
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.blue,
                              offset: Offset(0.0, 0.5),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "login",
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
                              child: Text("Don't have  an account? ")),
                          Flexible(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/register");
                                },
                                child: const Text("Register")),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "http://127.0.0.1:8000/auth/login/",
        ),
        body: {"email": email, "password": password},
      );

      final responseBody = [response.statusCode, response.body];
      log(responseBody.toString());
      return responseBody;
    } catch (e) {
      rethrow;
    }
  }

  Future register({
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "http://127.0.0.1:8000/auth/register/",
        ),
        body: {"email": "", "password": ""},
      );

      final responseBody = [response.statusCode, response.body];
      log(responseBody.toString());
      return responseBody;
    } catch (e) {
      rethrow;
    }
  }
}










// import 'dart:developer';

// import 'package:dashboard/authentication/services/auth.service.dart';
// import 'package:dashboard/config/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../widgets/authentication.widget.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final bool isDesktop = Responsiveness.isDesktop(context);
//     final double verticalPadding = isDesktop ? 20 : 10;
//     final double horizontalPadding = isDesktop ? 20 : 10;
//     final size = MediaQuery.of(context).size;
//     final sizebox = SizedBox(
//       height: verticalPadding,
//     );
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(toolbarHeight: 0),
//       body: ListView(
//         padding: EdgeInsets.symmetric(
//           horizontal: size.width / 20,
//           vertical: verticalPadding,
//         ),
//         children: [
//           sizebox,
//           Center(
//             child: Text(
//               "Login \nTo\nDarks SoC System",
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
//               horizontalPadding: horizontalPadding,
//               hintText: "Email",
//               textEditingController: emailController),
//           sizebox,
//           AuthWidgets.buildTextFormField(
//               horizontalPadding: horizontalPadding,
//               hintText: "Password",
//               textEditingController: passwordController),
//           sizebox,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               AuthWidgets.buildButton(
//                   size: size,
//                   text: "Login",
//                   onTap: () async {
//                     await login(
//                             email: emailController.text,
//                             password: passwordController.text)
//                         .then((value) async {
//                       if (value[0] == 200) {
//                         AuthService.loginService(context: context);
//                       } else {
//                         final Size size = MediaQuery.of(context).size;
//                         final snackBar = SnackBar(
//                           // width: size.width / 2.5,
//                           content: const Text(
//                             'invalid credentials!',
//                             textAlign: TextAlign.center,
//                           ),
//                           behavior: SnackBarBehavior.floating,
//                           backgroundColor: Colors.red,
//                           margin: EdgeInsets.fromLTRB(
//                             size.width - size.width / 2.4,
//                             0,
//                             10,
//                             size.height / 1.17,
//                           ),
//                         );
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                         emailController.clear();
//                         passwordController.clear();
//                       }
//                     });
//                   }),
//               AuthWidgets.buildButton(
//                 size: size,
//                 text: "Register",
//                 onTap: () {
//                   Navigator.pushNamed(context, "/register");
//                 },
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Future login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//           "http://127.0.0.1:8000/auth/login/",
//         ),
//         body: {"email": email, "password": password},
//       );

//       final responseBody = [response.statusCode, response.body];
//       log(responseBody.toString());
//       return responseBody;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future register({
//     required String email,
//     required String password,
//     required String phone,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//           "http://127.0.0.1:8000/auth/register/",
//         ),
//         body: {"email": "", "password": ""},
//       );

//       final responseBody = [response.statusCode, response.body];
//       log(responseBody.toString());
//       return responseBody;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
