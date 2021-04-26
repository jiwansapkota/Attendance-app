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
  var students;
  getStudents(int grade) async {
    final uri = "${Constants.ipAddress}/getstudents";
    var requestBody = {"grade": grade};
    http.Response response = await http.post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody));
    var responseBody = jsonDecode(response.body);
    print('-------------------');
    print(responseBody["students"]);
    setState(() {
      students = [
        ...responseBody['students'].map((value) {
          value['isPresent'] = true;
          return value;
        })
      ];
    });
  }

  void initState() {
    super.initState();
    getStudents(16);
  }

  @override
  Widget build(BuildContext context) {
    // print(students);
    var token = HelperFunctions.getSavedToken();
    print(token);
    return Scaffold(
      appBar: AppBar(
        title: Text("attendence register"),
      ),
      body: Center(
        child: Column(
          children: [
            ...students.map((value) {
              print(value);
              // return Text("sth");
              return ListTile(
                leading: FlutterLogo(size: 56.0),
                title: Text(value['name']),
                // subtitle: Text('student of grade: ' + value['grade']),
                trailing: Switch(
                  value: value['isPresent'],
                  onChanged: (val) {
                    print(val);
                    var tempArr = students;
                    print('sdhfsdf++++++++++++++++++++++++++++++++++++');
                    print(value);
                    var myIndex = students.indexOf(value);
                    tempArr[myIndex]['isPresent'] = val;
                    setState(() {
                      students = tempArr;
                    });
                  },
                  activeTrackColor: Colors.yellow,
                  activeColor: Colors.orangeAccent,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
