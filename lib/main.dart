import 'package:daily_meme_digest/screen/create_meme.dart';
import 'package:flutter/material.dart';
import 'package:daily_meme_digest/screen/home.dart';
import 'package:daily_meme_digest/screen/leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_meme_digest/screen/mycreation.dart';
import 'package:daily_meme_digest/screen/login.dart';
import 'package:daily_meme_digest/screen/settings.dart';

String name = "";
String activeuser = "";
int author_id = 0;
String prof_pic_url = "";

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String userID = prefs.getString("user_id") ?? '';
  return userID;
}

Future<String> checkName() async {
  final prefs = await SharedPreferences.getInstance();
  String full_name = prefs.getString("full_name") ?? '';
  return full_name;
}

Future<int> checkId() async {
  final prefs = await SharedPreferences.getInstance();
  int userID = prefs.getInt("id_user") ?? 0;
  return userID;
}

Future<String> checkURL() async {
  final prefs = await SharedPreferences.getInstance();
  String pic_url = prefs.getString("prof_pic_url") ?? '';
  return pic_url;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    if (result == '')
      runApp(MyLogin());
    else {
      activeuser = result;
      runApp(MyApp());
    }
  });
  checkName().then((String result) {
    if (result == '')
      runApp(MyLogin());
    else {
      name = result;
      runApp(MyApp());
    }
  });
  checkId().then((int result) {
    author_id = result;
  });
  checkURL().then((String result) {
    prof_pic_url = result;
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Meme Digest',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyHomePage(title: 'Daily Meme Digest'),
      routes: {
        'Home': (context) => Home(),
        'MyCreation': (context) => MyCreation(
              authorID: author_id,
            ),
        'LeaderBoard': (context) => Leaderboard(),
        'Settings': (context) => Settings(
              authorID: author_id,
            ),
        'creatememe': (context) => CreateMeme(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Home(),
    MyCreation(
      authorID: author_id,
    ),
    Leaderboard(),
    Settings(
      authorID: author_id,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Meme Digest"),
      ),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "creatememe");
        },
        tooltip: 'New Meme',
        child: Icon(Icons.add),
      ),
      drawer: myDrawer(),
      bottomNavigationBar: myBottomNavBar(),
    );
  }

  BottomNavigationBar myBottomNavBar() {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.teal,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "My Creation",
            icon: Icon(Icons.emoji_emotions_outlined),
          ),
          BottomNavigationBarItem(
            label: "Leaderboard",
            icon: Icon(Icons.leaderboard),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Icons.settings),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        });
  }

  Drawer myDrawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("$name"),
              accountEmail: Text("$activeuser"),
              currentAccountPicture:
                  CircleAvatar(backgroundImage: NetworkImage("$prof_pic_url"))),
          ListTile(
            title: new Text("Home"),
            leading: new Icon(Icons.home),
            onTap: () {
              // Navigator.pushNamed(context, "Home");
              setState(() {
                _currentIndex = 0;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: new Text("My Creation"),
            leading: new Icon(Icons.emoji_emotions_outlined),
            onTap: () {
              // Navigator.pushNamed(context, "MyCreation");
              setState(() {
                _currentIndex = 1;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: new Text("LeaderBoard"),
            leading: new Icon(Icons.leaderboard),
            onTap: () {
              // Navigator.pushNamed(context, "LeaderBoard");
              setState(() {
                _currentIndex = 2;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: new Text("Settings"),
            leading: new Icon(Icons.settings),
            onTap: () {
              Navigator.pushNamed(context, "Settings");
              // setState(() {
              //   _currentIndex = 3;
              // });
            },
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.logout),
            onTap: () {
              doLogout();
            },
          ),
        ],
      ),
    );
  }
}

void doLogout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("user_id");
  prefs.remove("full_name");
  prefs.remove("id_user");
  prefs.remove('prof_pic_url');
  main();
}
