import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:daily_meme_digest/class/pop_actor.dart';
import 'package:http/http.dart' as http;

class PopularActor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopularActorState();
  }
}

class _PopularActorState extends State<PopularActor> {
  String _temp = 'waiting API respond…';
  List<PopActor> actors = [];
  Future<String> fetchData() async {
    final response = await http
        .get(Uri.https("ubaya.fun", '/flutter/160419077/actorlist.php'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    Future<String> data = fetchData();
    data.then((value) {
      setState(() {
        // Mnegolah JSON menjadi object Dart (PopActor)
        Map json = jsonDecode(value);
        for (var actor in json['data']) {
          PopActor act = PopActor.fromJson(actor);
          actors.add(act);
        }
        _temp = actors[0].person_name;
        // _temp = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Popular Actor')),
        body: ListView(children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: DaftarPopActor(actors),
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: FutureBuilder(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DaftarPopActor2(snapshot.data.toString());
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })),
            ],
          )
        ]));
  }

  Widget DaftarPopActor(popActs) {
    if (popActs != null) {
      return ListView.builder(
          itemCount: popActs.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.people, size: 30),
                  title: Text(popActs[index].person_name),
                ),
              ],
            ));
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget DaftarPopActor2(String data) {
    List<PopActor> PMs2 = [];
    Map json = jsonDecode(data);
    for (var act in json['data']) {
      PopActor pm = PopActor.fromJson(act);
      PMs2.add(pm);
    }
    return ListView.builder(
        itemCount: PMs2.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.people, size: 30),
                title: Text(PMs2[index].person_name),
              ),
            ],
          ));
        });
  }
}
