import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:daily_meme_digest/class/meme.dart';
import 'package:daily_meme_digest/screen/mycreation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreateMeme extends StatefulWidget {
  const CreateMeme({super.key});

  @override
  State<CreateMeme> createState() => _CreateMemeState();
}

class _CreateMemeState extends State<CreateMeme> {
  final _formKey = GlobalKey<FormState>();
  String topText = "";
  String botText = "";
  String urlPic = "https://ubaya.fun/blank.jpg";
  @override
  void initState() {
    super.initState();
  }

  TextEditingController _pic_url = new TextEditingController();
  TextEditingController _teks_atas = new TextEditingController();
  TextEditingController _teks_bawah = new TextEditingController();
  late String error_submit;
  Meme meme = Meme(
      id: 0,
      pic_url: '',
      teks_atas: '',
      teks_bawah: '',
      author_id: '',
      like_count: 0);
  Future<String> checkId() async {
    final prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString("id_user") ?? '';
    return userID;
  }

  void onSubmit() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/creatememe.php"),
        body: {
          'pic_url': _pic_url,
          'teks_atas': _teks_atas,
          'teks_bawah': _teks_bawah,
          'author_id': checkId()
        });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyCreation(),
          ),
        );
      } else {
        setState(() {
          error_submit = "Semua TextBox harus diisi!";
        });
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Your Meme"),
      ),
      body: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Text("preview"),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 14,
            ),
            RepaintBoundary(
              key: _formKey,
              child: Stack(children: <Widget>[
                Image.network(
                  urlPic,
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
                          topText.toUpperCase(),
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
                          botText.toUpperCase(),
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
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'image URL',
                  ),
                  onChanged: (value) {
                    setState(() {
                      urlPic = value;
                    });
                  },
                  controller: _pic_url,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'URL gambar harus diisi!';
                    }
                    return null;
                  },
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Top Text',
                  ),
                  onChanged: (value) {
                    setState(() {
                      topText = value;
                    });
                  },
                  controller: _teks_atas,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Teks atas harus diisi!';
                    }
                    return null;
                  },
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Bottom Text',
                  ),
                  onChanged: (value) {
                    setState(() {
                      botText = value;
                    });
                  },
                  controller: _teks_bawah,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Teks bawah harus diisi!';
                    }
                    return null;
                  },
                )),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ])),
    );
  }
}
