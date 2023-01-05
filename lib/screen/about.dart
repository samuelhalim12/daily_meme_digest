import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  List<Widget> cats() {
    List<Widget> temp = [];
    int i = 0;
    while (i < 15) {
      Widget w = Image.network(
          "https://placekitten.com/120/120?image=" + i.toString());
      temp.add(w);
      i++;
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            color: Colors.yellow,
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.symmetric(vertical: 30),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          Container(
            color: Colors.cyan,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            height: 300,
            width: 300,
            child: Card(child: Text('Hello World!')),
          ),
          Container(
            width: 400,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/400?img=60'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.indigo,
                  width: 10,
                ),
                boxShadow: [BoxShadow(blurRadius: 30, color: Colors.black)],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
          ),
          Divider(
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('https://i.pravatar.cc/100?img=1'),
              Image.network('https://i.pravatar.cc/100?img=2'),
              Image.network('https://i.pravatar.cc/100?img=3'),
            ],
          ),
          Divider(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Image.network('https://i.pravatar.cc/100?img=4')),
                Image.network('https://i.pravatar.cc/100?img=5'),
                Image.network('https://i.pravatar.cc/100?img=6'),
                Image.network('https://i.pravatar.cc/100?img=7'),
                Image.network('https://i.pravatar.cc/100?img=8'),
                Image.network('https://i.pravatar.cc/100?img=9'),
              ],
            ),
          ),
          Divider(
            height: 30,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network("https://placekitten.com/420/320?image=12"),
              Image.asset("assets/images/missing.png")
            ],
          ),
          Container(
            height: 500,
            child: GridView.count(crossAxisCount: 4, children: cats()),
          ),
        ],
      )),
    );
  }
}
