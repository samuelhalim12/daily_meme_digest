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

void main() {
  // runApp(MyApp());
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
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        'Home': (context) => Home(),
        'MyCreation': (context) => MyCreation(),
        'LeaderBoard': (context) => Leaderboard(),
        'Settings': (context) => Settings(),
        'creatememe': (context) => CreateMeme(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Home(),
    MyCreation(),
    Leaderboard(),
    Settings()
  ];
  Runes smileEmoji = Runes('\u{1F60A}');
  Runes angryEmoji = Runes('\u{1F620}');
  String? emoji;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      emoji = '';
      for (int i = 1; i <= _counter; i++) {
        if (i % 5 == 0) {
          emoji = '$emoji' + String.fromCharCodes(angryEmoji);
        } else {
          emoji = '$emoji' + String.fromCharCodes(smileEmoji);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Daily Meme Digest"),
      ),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.pushNamed(
              context,
              "creatememe"
            );
          },
        tooltip: 'New Meme',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: myDrawer(),
      bottomNavigationBar: myBottomNavBar(),
    );
  }

  Center myBody(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          // Text(
          //   for (int i = 0; i < $_counter; i++;) {
          //     String.fromCharCodes(smileEmoji);
          //   }
          // ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: emoji, // emoji characters
                  style: TextStyle(
                    fontFamily: 'EmojiOne',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
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
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150"))),
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
  main();
}

// class MyLogin extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Login(),
//     );
//   }
// }

// class Login extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _LoginState();
//   }
// }

// class _LoginState extends State<Login> {
//   String _userID = "";
//   void doLogin() async {
//     //later, we use web service here to check the user id and password
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("user_id", _userID);
//     main();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Login'),
//         ),
//         body: Container(
//           height: 300,
//           margin: EdgeInsets.all(20),
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(30)),
//               border: Border.all(width: 1),
//               color: Colors.white,
//               boxShadow: [BoxShadow(blurRadius: 20)]),
//           child: Column(children: [
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: TextField(
//                 onChanged: (value) {
//                   _userID = value;
//                 },
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                     hintText: 'Enter valid email id as abc@gmail.com'),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(10),
//               //padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                     hintText: 'Enter secure password'),
//               ),
//             ),
//             Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Container(
//                   height: 50,
//                   width: 300,
//                   decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(20)),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       doLogin();
//                     },
//                     child: Text(
//                       'Login',
//                       style: TextStyle(color: Colors.white, fontSize: 25),
//                     ),
//                   ),
//                 )),
//           ]),
//         ));
//   }
// }
