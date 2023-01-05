import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:daily_meme_digest/class/pop_movie.dart';
import 'package:http/http.dart' as http;
import 'package:daily_meme_digest/screen/detailpop.dart';
import '../class/cart.dart';

class PopularMovie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopularMovieState();
  }
}

class _PopularMovieState extends State<PopularMovie> {
  String _temp = 'waiting API respond…';
  List<PopMovie> movies = [];
  String _txtcari = "";

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/get_movies.php"),
        body: {'cari': _txtcari});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    Future<String> data = fetchData();
    data.then((value) {
      setState(() {
        // Mnegolah JSON menjadi object Dart (PopMovie)
        Map json = jsonDecode(value);
        for (var movie in json['data']) {
          PopMovie mov = PopMovie.fromJson(movie);
          movies.add(mov);
        }
        // _temp = movies[0].title;
        // _temp = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Popular Movie')),
        body: ListView(children: [
          Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  labelText: 'Judul mengandung kata:',
                ),
                onFieldSubmitted: (value) {
                  _txtcari = value;
                  bacaData();
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: DaftarPopMovie(movies),
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: FutureBuilder(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DaftarPopMovie2(snapshot.data.toString());
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })),
            ],
          )
        ]));
  }

  // Widget DaftarPopMovie(popMovs) {
  //   if (popMovs != null) {
  //     return ListView.builder(
  //         itemCount: popMovs.length,
  //         itemBuilder: (BuildContext ctxt, int index) {
  //           return new Card(
  //               child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               ListTile(
  //                 leading: Icon(Icons.movie, size: 30),
  //                 title: Text(popMovs[index].title),
  //                 subtitle: Text(popMovs[index].overview),
  //               ),
  //             ],
  //           ));
  //         });
  //   } else {
  //     return CircularProgressIndicator();
  //   }
  // }

  final dbHelper = DatabaseHelper.instance;

  void addCart(movieid, title) async {
    Map<String, dynamic> row = {
      'movie_id': movieid,
      'title': title,
      'jumlah': 1
    };
    await dbHelper.addCart(row);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Sukses manambah barang')));
  }

  Widget DaftarPopMovie(popMovs) {
    if (popMovs != null) {
      return ListView.builder(
          itemCount: popMovs.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.movie, size: 30),
                    title: GestureDetector(
                        child: Text(movies[index].title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPop(movieID: movies[index].id),
                            ),
                          );
                        }),
                    // subtitle: Text(popMovs[index].overview),
                    subtitle: Column(children: [
                      Text(popMovs[index].overview),
                      ElevatedButton(
                          onPressed: () {
                            addCart(popMovs[index].id, popMovs[index].title);
                          },
                          child: Text("Add to cart"))
                    ])),
              ],
            ));
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget DaftarPopMovie2(data) {
    List<PopMovie> PMs2 = [];
    Map json = jsonDecode(data);
    for (var mov in json['data']) {
      PopMovie pm = PopMovie.fromJson(mov);
      PMs2.add(pm);
    }
    return ListView.builder(
        itemCount: PMs2.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.movie, size: 30),
                title: Text(PMs2[index].title),
                subtitle: Text(PMs2[index].overview),
              ),
            ],
          ));
        });
  }
//   Widget DaftarPopMovie2(String data) {
//     List<PopMovie> PMs2 = [];
//     Map json = jsonDecode(data);
//     for (var mov in json['data']) {
//       PopMovie pm = PopMovie.fromJson(mov);
//       PMs2.add(pm);
//     }
//     return ListView.builder(
//         itemCount: PMs2.length,
//         itemBuilder: (BuildContext ctxt, int index) {
//           return Card(
//               child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.movie, size: 30),
//                 title: Text(PMs2[index].title),
//                 subtitle: Text(PMs2[index].overview),
//               ),
//             ],
//           ));
//         });
//   }
}
