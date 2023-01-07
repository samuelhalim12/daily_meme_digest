import 'dart:convert';

import 'package:daily_meme_digest/class/meme.dart';
import 'package:daily_meme_digest/screen/detailmeme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _temp = 'waiting API respond…';
  List<Meme> memes = [];
  bool _like = false;
  // Icon _icon_like = new Icon(Icons.favorite_outline);

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  Future<String> fetchData() async {
    final response = await http.post(
      Uri.parse("https://ubaya.fun/flutter/160419077/getmycreation.php"),
    );

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
        // Mnegolah JSON menjadi object Dart (PopMovie)
        Map json = jsonDecode(value);
        for (var movie in json['data']) {
          Meme mov = Meme.fromJson(movie);
          memes.add(mov);
        }
        // _temp = movies[0].title;
        // _temp = value;
      });
    });
  }

  Widget DaftarMemes(popMovs) {
    if (popMovs != null) {
      return ListView.builder(
          itemCount: popMovs.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Card(
                elevation: 10,
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // SizedBox(
                    //   height: 50,
                    // ),
                    // SizedBox(
                    //   height: 14,
                    // ),
                    RepaintBoundary(
                      child: Stack(children: <Widget>[
                        Image.network(
                          memes[index].pic_url,
                          height: 300,
                          fit: BoxFit.fitHeight,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  memes[index].teks_atas.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26,
                                      shadows: <Shadow>[
                                        Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 3.0,
                                            color: Colors.black87),
                                        Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 8.0,
                                            color: Colors.black87)
                                      ]),
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  memes[index].teks_bawah.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26,
                                      shadows: <Shadow>[
                                        Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 3.0,
                                            color: Colors.black87),
                                        Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 3.0,
                                            color: Colors.black87)
                                      ]),
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: _like
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_outline),
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  _like = !_like;
                                });
                              },
                            )
                          ],
                        ),
                        Align(
                          child: Text(
                              memes[index].like_count.toString() + " likes"),
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                          child: Text("5" + " comments"),
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                          child: IconButton(
                            icon: new Icon(Icons.comment),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailMeme(memeID: memes[index].id),
                                ),
                              );
                            },
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    )
                  ],
                ));
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: DaftarMemes(memes),
          ),
        ],
      )
    ]));
  }
}
