import 'dart:convert';
import 'package:attandanceregister/helper/constants.dart';
import 'package:attandanceregister/views/attandance.dart';
import 'package:attandanceregister/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class SignUP extends StatefulWidget {
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  signMeIn() async {
    final uri = "${Constants.ipAddress}/adduser";
    if (formKey.currentState.validate()) {
      try {
        var requestBody = {
          "email": emailTextEditingController.text,
          "password": passwordTextEditingController.text
        };
        http.Response response = await http.post(Uri.parse(uri),
            headers: {"Content-Type": "application/json"},
            body: json.encode(requestBody));
        var responseBody = jsonDecode(response.body);
        if (responseBody.success) {
          print(responseBody.success);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Attandance()));
        } else {
          print(responseBody.msg);
        }
      } catch (err) {
        print("error occurred ---------");
        print(err);
      }
    } else {
      print('validation failed');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(children: [
                          TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "please provide a valid email";
                            },
                            controller: emailTextEditingController,
                            style: inputTextStyle(),
                            decoration: textFieldInputDecoration("email"),
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val.length > 6
                                  ? null
                                  : "please provide password 6+ character";
                            },
                            controller: passwordTextEditingController,
                            style: inputTextStyle(),
                            decoration: textFieldInputDecoration("password"),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   child: Container(
                      //       padding: EdgeInsets.symmetric(
                      //           vertical: 8, horizontal: 12),
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           // Navigator.push(
                      //           //     context,
                      //           //     MaterialPageRoute(
                      //           //         builder: (context) => ResetPassword()));
                      //         },
                      //         child: Text(
                      //           "forgot password?",
                      //           style: inputTextStyle(),
                      //         ),
                      //       )),
                      // ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          signMeIn();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC),
                              ]),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Text(
                            "Sign Up",
                            style: mediumInputTextStyle(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     width: MediaQuery.of(context).size.width,
                      //     padding: EdgeInsets.symmetric(vertical: 20),
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(30.0)),
                      //     child: Text(
                      //       "Sign In with Google",
                      //       style: TextStyle(
                      //         color: Colors.black87,
                      //         fontSize: 18.0,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       "don't have an account? ",
                      //       style: inputTextStyle(),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.pushReplacement(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => SignUP()));
                      //       },
                      //       child: Text(
                      //         "Register now ",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 17,
                      //           decoration: TextDecoration.underline,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
