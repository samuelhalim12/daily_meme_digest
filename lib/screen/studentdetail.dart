import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentDetail extends StatelessWidget{
  final int id;
  StudentDetail(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text("Student Detail"),
      ),
      body: Center(
        child: Image.network("https://i.pravatar.cc/300?img=[$id]"),
      )
    );
  }
}
