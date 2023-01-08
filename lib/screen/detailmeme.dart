import 'dart:convert';

import 'package:daily_meme_digest/class/meme.dart';
import 'package:daily_meme_digest/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailMeme extends StatefulWidget {
  int memeID;

  DetailMeme({super.key, required this.memeID});

  @override
  State<DetailMeme> createState() => _DetailMemeState();
}

class _DetailMemeState extends State<DetailMeme> {
  TextEditingController commentCont = TextEditingController();
  String _coment = "";
  bool _like = false;
  List<Meme> memes = [];
  @override
  void initState() {
    super.initState();
    bacaData();
  }

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/detailmeme.php"),
        body: {'id': widget.memeID.toString()});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      for (var movie in json['data']) {
        Meme mov = Meme.fromJson(movie);
        memes.add(mov);
      }
      // _pa = PopActor.fromJson(json['data']);
      setState(() {});
    });
  }

  void postComment() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/postComment.php"),
        body: {
          'user_id': author_id.toString(),
          'content': _coment,
          'meme_id': widget.memeID.toString()
        });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  Widget tampilData() {
    if (memes == null) {
      return const CircularProgressIndicator();
    } else {
      return Column(children: [
        Card(
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
                      memes[0].pic_url,
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
                              memes[0].teks_atas.toUpperCase(),
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
                              memes[0].teks_bawah.toUpperCase(),
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
                    Text(memes[0].like_count.toString() + " likes"),
                  ],
                ),
              ],
            )),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: memes.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new Card(
                elevation: 10,
                margin: const EdgeInsets.all(10),
                child: Text(memes[index].firstname!.toString() +
                    ' ' +
                    memes[index].lastname!.toString() +
                    ' ' +
                    memes[index].comment_date!.toString() +
                    ' ' +
                    memes[index].content.toString()),
              );
            }),
        ListTile(
          title: TextFormField(
            controller: commentCont,
            onChanged: (value) {
              _coment = value;
            },
          ),
          trailing: OutlinedButton(
            onPressed: () {
              postComment();
            },
            child: Text("Post"),
          ),
        )
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meme Detail'),
        ),
        body: ListView(children: <Widget>[tampilData()]));
  }
}
