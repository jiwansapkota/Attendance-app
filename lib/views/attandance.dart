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
  var students; 
  getStudents(String grade) async {
    final uri = "${Constants.ipAddress}/adduser";
    var requestBody = {grade: grade};
    http.Response response = await http.post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody));
    var responseBody = jsonDecode(response.body);
    if (responseBody) {
      setState(() {
        students = responseBody;
      });
    }
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("attendence register"),
      ),
      body: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text('Two-line ListTile'),
        subtitle: Text('Here is a second line'),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
