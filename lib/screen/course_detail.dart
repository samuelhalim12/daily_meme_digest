import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  final int id;
  CourseDetail(this.id);
  List<String> coursename = ["Tugas Akhir", "Emerging Technology", 'Big Data Analytics', 'Artificial Intelligence for Game', 'Internet of Things'];
  List<String> kp = ["KP -", "KP B", 'KP A', 'KP Z', 'KP A'];
  List<String> time = [
    "-", 'Senin 07.00-09.45', 'Selasa 15.45-18.30', 'Kamis 09.45-12.30', 'Selasa 09.45-12.30'
  ];
  List<String> room = ["-", 'TC 04.C', 'TB 01.09', 'TB 01.09', "TF 02.04"];
  List<String> sks = ["5 sks", '3 sks', '3 sks', '3 sks', "3 sks"];
  List<Widget> coursedetails() {
    List<Widget> temp = [];
    // int i = 0;

    Widget w = Card(
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
        child: new Container(
          child: Align(
            alignment: Alignment.center,
            child: new Text(
              kp[id-1],
              style: TextStyle(fontSize: 12),
            ),
          ),
        ));
    temp.add(w);
    w = Card(
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
        child: new Container(
          child: Align(
            alignment: Alignment.center,
            child: new Text(
              time[id-1],
              style: TextStyle(fontSize: 12),
            ),
          ),
        ));
    temp.add(w);
    w = Card(
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
        child: new Container(
          child: Align(
            alignment: Alignment.center,
            child: new Text(
              room[id-1],
              style: TextStyle(fontSize: 12),
            ),
          ),
        ));
    temp.add(w);
    w = Card(
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
        child: new Container(
          child: Align(
            alignment: Alignment.center,
            child: new Text(
              sks[id-1],
              style: TextStyle(fontSize: 12),
            ),
          ),
        ));
    temp.add(w);

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Detail"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Text(coursename[id-1]),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: coursedetails(),
            ),
          )
        ],
      )),
    );
  }
}
