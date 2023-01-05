import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Leaderboard extends StatelessWidget {
  late String _top_user;
  late int _top_point;
  Future<void> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    _top_user = prefs.getString("top_user") ?? '';
    _top_point = prefs.getInt("top_point") ?? 0;
  }
  Leaderboard() {
    getScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Detail"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
            Text("Top score : " + _top_point.toString()),
            Divider(height: 20),
            Text("Top user :" + _top_user.toString())
        ],
      )),
    );
  }
}
