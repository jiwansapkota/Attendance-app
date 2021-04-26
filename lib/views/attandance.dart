import 'package:attandanceregister/helper/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attandanceregister/helper/constants.dart';
import 'dart:convert';
import 'dart:async';

class Attandance extends StatefulWidget {
  @override
  _AttandanceState createState() => _AttandanceState();
}

class _AttandanceState extends State<Attandance> {
  Map<String, dynamic> students;
  Future<dynamic> getStudents(String grade) async {
    final uri = "${Constants.ipAddress}/getstudents";
    var requestBody = {grade: grade};
    http.Response response = await http.post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody));
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    setState(() {
      students = responseBody;
    });
  }

  void initState() {
    super.initState();
    getStudents("5");
  }

  @override
  Widget build(BuildContext context) {
    var token = HelperFunctions.getSavedToken();
    print(token);
    return Scaffold(
      appBar: AppBar(
        title: Text("attendence register"),
      ),
      body: Center(
        child: ListTile(
          leading: FlutterLogo(size: 56.0),
          title: Text('Two-line ListTile'),
          subtitle: Text('Here is a second line'),
          trailing: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
