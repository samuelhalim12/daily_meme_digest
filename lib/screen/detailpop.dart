import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:daily_meme_digest/class/pop_movie.dart';
import 'package:daily_meme_digest/class/pop_actor.dart';
import 'package:flutter/services.dart';
import 'package:daily_meme_digest/screen/popular_movie.dart';
import 'package:daily_meme_digest/screen/editpopmovie.dart';

class DetailPop extends StatefulWidget {
  int movieID;
  DetailPop({super.key, required this.movieID});
  @override
  State<StatefulWidget> createState() {
    return _DetailPopState();
  }
}

class _DetailPopState extends State<DetailPop> {
  PopMovie? _pm;

  // PopActor? _pa;
  @override
  void initState() {
    super.initState();
    bacaData();
  }

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/detailmovie.php"),
        body: {'id': widget.movieID.toString()});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  void deleteData() async {
    showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to delete this?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => MyApp(),
              //     ));

              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                SystemNavigator.pop();
              }
            },
            //return false when click on "NO"
            child: Text('NO'),
          ),
          ElevatedButton(
            onPressed: () async {
              final response = await http.post(
                  Uri.parse(
                      "https://ubaya.fun/flutter/160419077/deletemovie.php"),
                  body: {'movie_id': widget.movieID.toString()});
              if (response.statusCode == 200) {
                Map json = jsonDecode(response.body);
                if (json['result'] == 'success') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sukses Menghapus Data')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal Menghapus Data')));
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PopularMovie(),
                    ));
              } else {
                throw Exception('Failed to read API');
              }
            },
            //return true when click on "Yes"
            child: Text('YES'),
          ),
        ],
      ),
    );
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      _pm = PopMovie.fromJson(json['data']);
      // _pa = PopActor.fromJson(json['data']);
      setState(() {});
    });
  }

  Widget tampilData() {
    if (_pm == null) {
      return const CircularProgressIndicator();
    } else {
      return Card(
          elevation: 10,
          margin: const EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Text(_pm!.title, style: const TextStyle(fontSize: 25)),
            Image.network(
                "https://ubaya.fun/flutter/160419077/images/${widget.movieID}.jpg"),
            Padding(
                padding: const EdgeInsets.all(10),
                child:
                    Text(_pm!.overview, style: const TextStyle(fontSize: 15))),
            Padding(padding: EdgeInsets.all(10), child: Text("Genre:")),
            Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _pm?.genres?.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Text(_pm?.genres?[index]['genre_name']);
                    })),
            Padding(padding: EdgeInsets.all(10), child: Text("Actor/Actress:")),
            Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _pm?.casts?.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Text(_pm?.casts?[index]['person_name'] +
                          " as " +
                          _pm?.casts?[index]['character_name']);
                    })),
            Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    deleteData();
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text('Edit'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditPopMovie(movie_id: widget.movieID),
                      ),
                    );
                  },
                )),
          ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail of Popular Movie'),
        ),
        body: ListView(children: <Widget>[tampilData()]));
  }
}
