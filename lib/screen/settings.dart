import 'dart:convert';

import 'package:daily_meme_digest/class/meme.dart';
import 'package:daily_meme_digest/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'dart:typed_data';

class Settings extends StatefulWidget {
  int authorID;
  Settings({super.key, required this.authorID});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  TextEditingController _firstCont = new TextEditingController();
  TextEditingController _lastCont = new TextEditingController();

  Meme meme = Meme(author_id: 0, firstname: "", lastname: "", privacy: 0);

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/profile.php"),
        body: {'id': widget.authorID.toString()});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      meme = Meme.fromJson(json['data']);
      setState(() {
        _firstCont.text = meme.firstname.toString();
        _lastCont.text = meme.lastname.toString();
      });
    });
  }

  void changePrivacy() {}

  File? _image, _imageProses;
  bool isChecked = false;
  int privacy = 0;
  @override
  void initState() {
    super.initState();
    bacaData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://ubaya.fun/blank.jpg"),
                  ),
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                          primary: Colors.white,
                          backgroundColor: Color(0xFFF5F6F9),
                        ),
                        onPressed: () {},
                        child: Icon(Icons.add_a_photo),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(""),
            Text("Active since"),
            Text("Username"),
            TextFormField(
              decoration: InputDecoration(labelText: "First Name"),
              onChanged: (value) {
                meme.firstname = value;
              },
              controller: _firstCont,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'nama depan harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Last Name"),
              onChanged: (value) {
                meme.lastname = value;
              },
              controller: _lastCont,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'nama depan harus diisi';
                }
                return null;
              },
            ),
            Row(
              children: <Widget>[
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                        privacy = 1;
                      });
                    }),
                Text("Hide my name"),
              ],
            ),
            Divider(),
            ElevatedButton(onPressed: () {}, child: Text("Save Changes"))
          ],
        ));
  }
}
