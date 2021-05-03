import 'package:attandanceregister/helper/helperfunctions.dart';
import 'package:attandanceregister/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attandanceregister/helper/constants.dart';
import 'dart:convert';

class Attandance extends StatefulWidget {
  @override
  _AttandanceState createState() => _AttandanceState();
}

class _AttandanceState extends State<Attandance> {
  bool isLoading = true;
  var students;
  var decodedToken;
  // getUserDetails() async {
  //   var token = await HelperFunctions.getSavedToken();
  //   print("*******************************");
  //   print(token);
  //   final url = "${Constants.ipAddress}/getuserinfo";
  //   http.Response response = await http.get(
  //     Uri.parse(url),
  //     headers: {
  //       "Content-Type": "application/json",
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     },
  //   );
  //   var responseBody = jsonDecode(response.body);
  //   print(responseBody['token']['email']);
  //   setState(() {
  //     decodedToken = responseBody['token'];
  //   });
  //   print("successfully decoded token");
  // }

  getStudents(int grade) async {
    print("getstudent called");
    final uri = "${Constants.ipAddress}/getstudents";
    var requestBody = {"grade": grade};
    http.Response response = await http.post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody));
    var responseBody = jsonDecode(response.body);
    setState(() {
      students = [
        ...responseBody['students'].map((value) {
          value['isPresent'] = true;
          return value;
        })
      ];
      isLoading = false;
    });
  }

  onSubmitHandler() async {
    print("submit called");
    var takenBy = await HelperFunctions.getUserName();
    print(takenBy);
    final uri = "${Constants.ipAddress}/postattendence";
    var requestBody = {
      // "takenBy": decodedToken['email'],
      "takenBy": takenBy,
      "date": DateTime.now().toString(),
      "students": students,
    };
    http.Response response = await http.post(Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody));
    var responseBody = jsonDecode(response.body);
    print(responseBody);
  }

  void initState() {
    super.initState();
    getStudents(16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("attendence register"),
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Center(
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
                          var tempArr = students;
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
                  }),
                  GestureDetector(
                    onTap: () {
                      onSubmitHandler();

                      // isLoading ? null : signMeIn();
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                          child: Text("Submit", style: mediumInputTextStyle())),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
