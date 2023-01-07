import 'dart:convert';

import 'package:daily_meme_digest/class/meme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class DetailMeme extends StatefulWidget {
  int memeID;

  DetailMeme({super.key, required this.memeID});

  @override
  State<DetailMeme> createState() => _DetailMemeState();
}

class _DetailMemeState extends State<DetailMeme> {
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

  Widget tampilData() {
    if (memes == null) {
      return const CircularProgressIndicator();
    } else {
      return 
      Column(
        children: [
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
                    child: Text(memes[0].like_count.toString() + " likes"),
                    alignment: Alignment.centerLeft,
                  )
                ],
              ),
              Text(memes[0].firstname!.toString()),
              Text(memes[0].lastname!.toString()),
              Text(memes[0].comment_date!.toString()),
              Text(memes[0].content!.toString()),
            ],
          )),
          // ListView.builder(
          // itemCount: memes.length,
          // itemBuilder: (BuildContext ctxt, int index) {
          //   return new Card(
          //       elevation: 10,
          //       margin: const EdgeInsets.all(5),
          //         child: Text('a' 
          //         //  + memes[index].firstname!.toString() + ' ' + memes[index].lastname!.toString() + ' ' 
          //         // + memes[index].comment_date!.toString() + ' ' 
          //         // + memes[index].content.toString()
          //         ),
          //       );
          // }),
          ]
        );
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
