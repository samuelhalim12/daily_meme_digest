// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:daily_meme_digest/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../main.dart';

class MyCreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class CreateAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateAccountState();
  }
}

class _CreateAccountState extends State<CreateAccount> {
  late String _username;
  late String _user_password;
  late String _confirm_user_password;
  late String _error_regist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _username = "";
    _user_password = "";
    _confirm_user_password = "";
    _error_regist = "";
  }

  void doRegist() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/regist.php"),
        body: {
          'username': _username,
          'password': _user_password,
          'confirm_password': _confirm_user_password
        });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      } else {
        setState(() {
          _error_regist = "Password and Confirm Password not same!";
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
          title: Text('Create Account'),
        ),
        body: Container(
          height: 700,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              border: Border.all(width: 1),
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 20)]),
          child: Column(children: [
            Text("Daily Meme Digest"),
            Text("Create Account"),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  _username = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter username'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (value) {
                  _user_password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (value) {
                  _confirm_user_password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Repeat Password',
                    hintText: 'Repeat password'),
              ),
            ),
            if (_error_regist != "")
              Text(
                _error_regist,
                style: TextStyle(color: Colors.red),
              ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                      doRegist();
                    },
                    child: Text(
                      'Create Account',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ))
          ]),
        ));
  }
}
