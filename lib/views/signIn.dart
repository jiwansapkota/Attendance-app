import 'dart:convert';
import 'package:attandanceregister/helper/constants.dart';
import 'package:attandanceregister/helper/helperfunctions.dart';
import 'package:attandanceregister/views/attendance.dart';
import 'package:attandanceregister/views/signup.dart';
import 'package:attandanceregister/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController =
      new TextEditingController(text: "jiwan@gmail.com");
  TextEditingController passwordTextEditingController =
      new TextEditingController(text: "jiwan123");

  //turned out to be unnecessary step to do
  //To exteact userdetails from token with header authorization
  getUserDetails(token) async {
    print("*******************************");
    print(token);
    final url = "${Constants.ipAddress}/getuserinfo";
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    var responseBody = jsonDecode(response.body);
    print(responseBody['token']['email']);
    HelperFunctions.saveUserName(responseBody['token']['email']);
    print("here IT is ______________________--------------");
    print(await HelperFunctions.getUserName());
    print("successfully decoded token");
  }

  signMeIn() async {
    setState(() {
      isLoading = true;
    });
    print("signIn clicked");
    final uri = "${Constants.ipAddress}/authenticate";
    if (formKey.currentState.validate()) {
      try {
        var requestBody = {
          "email": emailTextEditingController.text,
          "password": passwordTextEditingController.text
        };
        http.Response response = await http.post(uri,
            headers: {"Content-Type": "application/json"},
            body: json.encode(requestBody));
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          HelperFunctions.saveToken(responseBody['token']);
          HelperFunctions.saveUserName(emailTextEditingController.text);
          HelperFunctions.saveIsloggedStatus(true);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Attandance()));
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (err) {
        print("error occurred ---------");
        print(err);
        setState(() {
          isLoading = false;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
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
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          isLoading ? null : signMeIn();
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
                              isLoading ? "Signing In..." : "Sign In",
                              style: mediumInputTextStyle(),
                            )),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "don't have an account? ",
                            style: inputTextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUP()));
                            },
                            child: Text(
                              "Register now ",
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
