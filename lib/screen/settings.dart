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
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
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
                        child: Text("gss"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text("Nama"),
            Text("Active since"),
            Text("Username"),
            TextFormField(
              decoration: InputDecoration(labelText: "First Name"),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                        print(isChecked);
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
