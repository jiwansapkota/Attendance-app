import 'package:attandanceregister/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
  TextEditingController classInputController = new TextEditingController();
  TextEditingController subjectInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("attendence register"),
      ),
      body: Container(
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Text("Take attendance of class"),
                TextFormField(
                  controller: classInputController,
                  style: inputTextStyle(),
                  decoration: textFieldInputDecoration("Enter Class"),
                ),
                TextFormField(
                  controller: subjectInputController,
                  style: inputTextStyle(),
                  decoration: textFieldInputDecoration("Enter Class"),
                )
              ],
            )),
      ),
    );
  }
}
