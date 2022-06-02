import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0x00000050),
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
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: size.height * 0.10,
            ),
            Container(
              height: size.height * 0.65,
              width: size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.blue,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: size.width * 0.025, color: Colors.white54),
                  ),
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextField(
                      // controller: ,
                      style: const TextStyle(color: Colors.blue),

                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        label: const Text("Username"),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        labelStyle: const TextStyle(
                            color: Colors.green,
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
                    child: TextField(
                      // controller: ,
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
                            color: Colors.green,
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
                  Container(
                    width: size.width * 0.08,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
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
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
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
}
