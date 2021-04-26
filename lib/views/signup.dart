import 'dart:convert';
import 'package:attandanceregister/helper/constants.dart';
import 'package:attandanceregister/views/signIn.dart';
import 'package:attandanceregister/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUP extends StatefulWidget {
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  bool isLoading = false;
  bool emailExists = false;
  String msg = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController =
      new TextEditingController(text: "jiwan@gmail.com");
  TextEditingController passwordTextEditingController =
      new TextEditingController(text: "jiwan123");
  signMeUp() async {
    print("signUP clicked");
    setState(() {
      isLoading = true;
      emailExists = false;
    });
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
        print(responseBody);
        print(responseBody['msg']);
        setState(() {
          msg = responseBody['msg'];
        });
        if (responseBody['success']) {
          print(responseBody['success']);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn()));
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            emailExists = true;
            isLoading = false;
          });
        }
      } catch (err) {
        setState(() {
          isLoading = false;
        });
        print("error occurred ---------");
        print(err);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('validation failed');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body:
          // isLoading
          //     ? Container(
          //         child: Center(child: CircularProgressIndicator()),
          //       )
          //     :
          SingleChildScrollView(
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
                            ? emailExists
                                ? "Email already exists"
                                : null
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
                emailExists
                    ? Column(children: [
                        Text(msg, style: mediumInputTextStyle()),
                        SizedBox(
                          height: 16,
                        ),
                      ])
                    : SizedBox(),
                GestureDetector(
                  onTap: () {
                    isLoading ? null : signMeUp();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: isLoading
                        ? BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(30.0),
                          )
                        : BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xff007EF4),
                              const Color(0xff2A75BC),
                            ]),
                            borderRadius: BorderRadius.circular(30.0)),
                    child: Text(
                      isLoading ? "Signing Up..." : "Sign Up",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already have an account? ",
                      style: inputTextStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text(
                        "Sign In ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

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
