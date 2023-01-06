import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Card(
              elevation: 10,
              margin: const EdgeInsets.all(10),
              child: Column(children: <Widget>[
                Stack(alignment: Alignment.topCenter, children: <Widget>[
                  Image.network(
                      "https://ubaya.fun/flutter/160419077/images/1.jpg"),
                  Text(
                    'Greetings, planet!',
                    style: TextStyle(
                      fontSize: 40,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.black,
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    'Greetings, planet!',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      ],
                    ),
                    Align(
                      child: Text("200" + " likes"),
                      alignment: Alignment.centerLeft,
                    ),
                    Align(
                      child: Icon(Icons.comment, color: Colors.blue),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                )
              ]))
        ],
      )),
    );
  }
}
