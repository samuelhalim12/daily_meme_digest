import 'package:flutter/material.dart';
import 'package:daily_meme_digest/screen/about.dart';
import 'package:daily_meme_digest/screen/add_recipe.dart';
import 'package:daily_meme_digest/screen/animasi.dart';
import 'package:daily_meme_digest/screen/basket.dart';
import 'package:daily_meme_digest/screen/history.dart';
import 'package:daily_meme_digest/screen/home.dart';
import 'package:daily_meme_digest/screen/leaderboard.dart';
import 'package:daily_meme_digest/screen/newpopmovie.dart';
import 'package:daily_meme_digest/screen/quiz.dart';
import 'package:daily_meme_digest/screen/search.dart';
import 'package:daily_meme_digest/screen/studentlist.dart';
import 'package:daily_meme_digest/screen/my_courses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_meme_digest/screen/popular_movie.dart';
import 'package:daily_meme_digest/screen/popularactor.dart';
import 'package:daily_meme_digest/screen/login.dart';
import 'package:daily_meme_digest/screen/viewcart.dart';

String activeuser = "";

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String userID = prefs.getString("user_id") ?? '';
  return userID;
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
        'about': (context) => About(),
        'basket': (context) => Basket(),
        'studentlist': (context) => StudentList(),
        'courselist': (context) => CourseList(),
        'add_recipe': (context) => AddRecipe(),
        'quiz': (context) => Quiz(),
        'leaderboard': (context) => Leaderboard(),
        'animasi': (context) => Animasi(),
        "popular_movies": (context) => PopularMovie(),
        "popular_actor": (context) => PopularActor(),
        'newpopmovie': (context) => NewPopMovie(),
        'shopingcart': (context) => ViewCart(),
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
  final List<Widget> _screens = [Home(), Search(), History()];
  final List<String> _title = ['Home', 'Search', 'History'];
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
        title: Text(_title[_currentIndex]),
      ),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: myDrawer(),
      persistentFooterButtons: <Widget>[
        ElevatedButton(
            onPressed: () {}, child: const Icon(Icons.skip_previous)),
        ElevatedButton(onPressed: () {}, child: const Icon(Icons.skip_next))
      ],
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
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "History",
            icon: Icon(Icons.history),
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
              accountName: Text("samuel"),
              accountEmail: Text("$activeuser"),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150"))),
          ListTile(
            title: new Text("Inbox"),
            leading: new Icon(Icons.inbox),
          ),
          ListTile(
            title: new Text("Popular Movies"),
            leading: new Icon(Icons.movie),
            onTap: () {
              Navigator.pushNamed(context, "popular_movies");
            },
          ),
          ListTile(
            title: new Text("New Popular Movies"),
            leading: new Icon(Icons.movie_creation),
            onTap: () {
              Navigator.pushNamed(context, "newpopmovie");
            },
          ),
          ListTile(
              title: Text("Shopping Cart"),
              leading: Icon(Icons.animation),
              onTap: () {
                Navigator.pushNamed(context, "shopingcart");
              }),
          ListTile(
            title: new Text("Popular Actor"),
            leading: new Icon(Icons.people),
            onTap: () {
              Navigator.pushNamed(context, "popular_actor");
            },
          ),
          ListTile(
            title: new Text("My Basket  "),
            leading: new Icon(Icons.shopping_basket),
            onTap: () {
              Navigator.pushNamed(context, "basket");
            },
          ),
          ListTile(
            title: new Text("Add Recipe"),
            leading: new Icon(Icons.add),
            onTap: () {
              Navigator.pushNamed(context, "add_recipe");
            },
          ),
          ListTile(
            title: Text("Promotions"),
            leading: Icon(Icons.sell),
          ),
          ListTile(
            title: const Text("About"),
            leading: const Icon(Icons.help),
            onTap: () {
              Navigator.pushNamed(context, "about");
            },
          ),
          ListTile(
            title: const Text("Student List"),
            leading: const Icon(Icons.list),
            onTap: () {
              Navigator.pushNamed(context, "studentlist");
            },
          ),
          ListTile(
            title: const Text("Course List"),
            leading: const Icon(Icons.list),
            onTap: () {
              Navigator.pushNamed(context, "courselist");
            },
          ),
          ListTile(
            title: const Text("Quiz"),
            leading: const Icon(Icons.quiz),
            onTap: () {
              Navigator.pushNamed(context, "quiz");
            },
          ),
          ListTile(
            title: const Text("Leaderboard"),
            leading: const Icon(Icons.leaderboard),
            onTap: () {
              Navigator.pushNamed(context, "leaderboard");
            },
          ),
          ListTile(
            title: const Text("Animation"),
            leading: const Icon(Icons.animation),
            onTap: () {
              Navigator.pushNamed(context, "animasi");
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
