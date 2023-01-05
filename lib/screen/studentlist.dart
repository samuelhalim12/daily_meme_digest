import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:daily_meme_digest/screen/studentdetail.dart';

class StudentList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title :const Text("Student List"),
      ),
      body: Column(
        children: [
          const Text("This is Student List"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetail(1)));
            }
          , child: const Text("Student 1")),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetail(2)));
            }
          , child: const Text("Student 2")),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetail(3)));
            }
          , child: const Text("Student 3")),
        ],
      )
    );
  }
}
