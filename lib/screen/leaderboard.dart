import 'dart:convert';

import 'package:daily_meme_digest/class/meme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class Leaderboard extends StatefulWidget {
  Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<Meme> memes = [];
  List<bool> privacy = [];
  @override
  void initState() {
    super.initState();
    bacaData();
  }

  Future<String> fetchData() async {
    final response = await http
        .post(Uri.parse("https://ubaya.fun/flutter/160419077/leaderboard.php"));

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
      });
    });
  }

  Widget DaftarMemes(popMovs) {
    if (popMovs != null) {
      return ListView.builder(
          itemCount: popMovs.length,
          itemBuilder: (BuildContext ctxt, int index) {
            if (memes[index].privacy! != 0) {
              return new Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(memes[index].prof_pic_url!),
                          ),
                          Text(memes[index].firstname!.replaceRange(
                                  3,
                                  memes[index].firstname!.length,
                                  "*" * (memes[index].firstname!.length - 3)) +
                              " " +
                              memes[index].lastname!.replaceRange(
                                  0,
                                  memes[index].lastname!.length,
                                  "*" * memes[index].lastname!.length)),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Text(memes[index].like_count!.toString() + " Likes")
                        ],
                      ),
                    ],
                  ));
            } else {
              return new Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage("https://ubaya.fun/blank.jpg"),
                          ),
                          Text(memes[index].firstname! +
                              " " +
                              memes[index].lastname!),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Text(memes[index].like_count!.toString() + " Likes")
                        ],
                      ),
                    ],
                  ));
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: DaftarMemes(memes),
          ),
        ],
      ),
    ));
  }
}
