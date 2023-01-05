import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:daily_meme_digest/main.dart';
import 'package:http/http.dart' as http;
import 'package:numberpicker/numberpicker.dart';

import '../class/genre.dart';
import '../class/pop_movie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'dart:typed_data';

class EditPopMovie extends StatefulWidget {
  int movie_id;
  EditPopMovie({Key? key, required this.movie_id}) : super(key: key);
  @override
  EditPopMovieState createState() {
    return EditPopMovieState();
  }
}

class EditPopMovieState extends State<EditPopMovie> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleCont = new TextEditingController();
  TextEditingController _homepageCont = new TextEditingController();
  TextEditingController _overviewCont = new TextEditingController();
  TextEditingController _releaseDate = new TextEditingController();
  int _runtime = 100;
  Widget comboGenre = const Text('tambah genre');
  File? _image, _imageProses;

  PopMovie pm = PopMovie(
      id: 0,
      title: '',
      overview: '',
      homepage: '',
      release_date: '',
      runtime: 0,
      genres: null);
  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/detailmovie.php"),
        body: {'id': widget.movie_id.toString()});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      pm = PopMovie.fromJson(json['data']);
      setState(() {
        _titleCont.text = pm.title;
        _homepageCont.text = pm.homepage;
        _overviewCont.text = pm.overview;
        _releaseDate.text = pm.release_date;
        _runtime = pm.runtime;
      });
    });
  }

  void submit() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun./flutter/160419077/updatemovie.php"),
        body: {
          'title': pm.title,
          'overview': pm.overview,
          'homepage': pm.homepage,
          'release_date': pm.release_date,
          'runtime': pm.runtime.toString(),
          'movie_id': widget.movie_id.toString()
        });
    // if (response.statusCode == 200) {
    //   print(response.body);
    //   Map json = jsonDecode(response.body);
    //   if (json['result'] == 'success') {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text('Sukses mengubah Data')));
    //   }
    // } else {
    //   throw Exception('Failed to read API');
    // }
    if (response.statusCode == 200) {
      print(response.body);
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sukses mengubah Data')));
        if (_imageProses == null) return;
        List<int> imageBytes = _imageProses!.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        final response2 = await http.post(
            Uri.parse(
                'https://ubaya.fun/flutter/160419077/uploadpopmovieposter.php'),
            body: {
              'movie_id': widget.movie_id.toString(),
              'image': base64Image,
            });
        if (response2.statusCode == 200) {
          if (!mounted) return;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response2.body)));
          Navigator.of(context).pop();
        }
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  // Future<List> daftarGenre() async {
  //   Map json;
  //   final response = await http.post(
  //       Uri.parse("https://ubaya.fun/flutter/160419077/genrelist.php"),
  //       body: {'movie_id': widget.movie_id.toString()});

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     json = jsonDecode(response.body);
  //     return json['data'];
  //   } else {
  //     throw Exception('Failed to read API');
  //   }
  // }

  Future<List> daftarGenre() async {
    Map json;
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/genrelist.php"),
        body: {'movie_id': widget.movie_id.toString()});
    if (response.statusCode == 200) {
      print(response.body);
      json = jsonDecode(response.body);
      return json['data'];
    } else {
      throw Exception('Failed to read API');
    }
  }

  // Widget comboGenre = Text("Tambah Genre");

  // void generateComboGenre() {
  //   List<Genre> genres;
  //   var data = daftarGenre();
  //   data.then((value) {
  //     genres = List<Genre>.from(value.map((i) {
  //       return Genre.fromJSON(i);
  //     }));
  //     comboGenre = DropdownButton(
  //         dropdownColor: Colors.grey[100],
  //         hint: Text("tambah genre"),
  //         isDense: false,
  //         items: genres.map((gen) {
  //           return DropdownMenuItem(
  //             child: Column(children: <Widget>[
  //               Text(gen.genre_name, overflow: TextOverflow.visible),
  //             ]),
  //             value: gen.genre_id,
  //           );
  //         }).toList(),
  //         onChanged: (value) {
  //           addGenre(value);
  //         });
  //   });
  // }

  // Widget comboGenre = Text('tambah genre');

  void generateComboGenre() {
    //widget function for city list
    List<Genre> genres;
    var data = daftarGenre();
    data.then((value) {
      genres = List<Genre>.from(value.map((i) {
        return Genre.fromJSON(i);
      }));
      comboGenre = DropdownButton(
          dropdownColor: Colors.grey[100],
          hint: Text("tambah genre"),
          isDense: false,
          items: genres.map((gen) {
            print(gen.genre_id.toString() + " " + gen.genre_name);
            return DropdownMenuItem(
              value: gen.genre_id.toString(),
              child: Column(children: <Widget>[
                Text(gen.genre_name, overflow: TextOverflow.visible),
              ]),
            );
          }).toList(),
          onChanged: (value) {
            //memnaggil fungsi menambah genre disini
            addGenre(value);
          });
    });
  }

  // void addGenre(genre_id) async {
  //   final response = await http
  //       .post(Uri.parse("https://ubaya.fun/flutter/160419077/addmoviegenre.php"), body: {
  //     'genre_id': genre_id.toString(),
  //     'movie_id': widget.movie_id.toString()
  //   });

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     Map json = jsonDecode(response.body);
  //     if (json['result'] == 'success') {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('Sukses menambah genre')));
  //       setState(() {
  //         bacaData();
  //       });
  //     }
  //   } else {
  //     throw Exception('Failed to read API');
  //   }
  // }

  void addGenre(genre_id) async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419077/addmoviegenre.php"),
        body: {
          'genre_id': genre_id.toString(),
          'movie_id': widget.movie_id.toString()
        });
    if (response.statusCode == 200) {
      print(response.body);
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sukses menambah genre')));
        setState(() {
          bacaData();
          generateComboGenre();
        });
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bacaData();

    setState(() {
      generateComboGenre();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Popular Movie"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    onChanged: (value) {
                      pm.title = value;
                    },
                    controller: _titleCont,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'judul harus diisi';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Website',
                    ),
                    onChanged: (value) {
                      pm.homepage = value;
                    },
                    controller: _homepageCont,
                    validator: (value) {
                      if (!Uri.parse(value!).isAbsolute) {
                        return 'alamat website salah';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Overview',
                    ),
                    onChanged: (value) {
                      pm.overview = value;
                    },
                    controller: _overviewCont,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 6,
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Release Date',
                        ),
                        controller: _releaseDate,
                      )),
                      ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2200))
                                .then((value) {
                              setState(() {
                                _releaseDate.text =
                                    value.toString().substring(0, 10);
                              });
                            });
                          },
                          child: Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.white,
                            size: 24.0,
                          ))
                    ],
                  )),
              NumberPicker(
                value: _runtime,
                axis: Axis.horizontal,
                minValue: 50,
                maxValue: 300,
                itemHeight: 30,
                itemWidth: 60,
                step: 1,
                onChanged: (value) => setState(() => _runtime = value),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Harap Isian diperbaiki')));
                    } else {
                      submit();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              Padding(padding: EdgeInsets.all(10), child: Text('Genre:')),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pm.genres!.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new Text(pm.genres![index]['genre_name']);
                        // return new Row(
                        //   children: [
                        //     Text(pm.genres![index]['genre_name']),
                        //     ElevatedButton(
                        //         onPressed: () async {
                        //           final response = await http.post(
                        //               Uri.parse(
                        //                   "https://ubaya.fun/flutter/160419077/deletegenre.php"),
                        //               body: {
                        //                 'movie_id': widget.movie_id.toString(),
                        //                 'genre_name': pm.genres![index]
                        //                         ['genre_name']
                        //                     .toString()
                        //               });
                        //           if (response.statusCode == 200) {
                        //             print(widget.movie_id.toString());
                        //             print(pm.genres![index]['genre_name']
                        //                 .toString());
                        //             Map json = jsonDecode(response.body);
                        //             if (json['result'] == 'success') {
                        //               ScaffoldMessenger.of(context)
                        //                   .showSnackBar(SnackBar(
                        //                       content: Text(
                        //                           'Sukses Menghapus Genre ' +
                        //                               pm.genres![index]
                        //                                       ['genre_name']
                        //                                   .toString())));
                        //             } else {
                        //               ScaffoldMessenger.of(context)
                        //                   .showSnackBar(SnackBar(
                        //                       content: Text(
                        //                           'Gagal Menghapus Data')));
                        //             }
                        //           } else {
                        //             throw Exception('Failed to read API');
                        //           }
                        //         },
                        //         child: Icon(
                        //           Icons.delete,
                        //           color: Colors.white,
                        //           size: 24.0,
                        //         )),
                        //   ],
                        // );
                      })),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: comboGenre),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                    onTap: () => _showPicker(context),
                    child: _imageProses != null
                        ? Image.file(_imageProses!)
                        : Image.network("https://ubaya.fun/blank.jpg")),
              ),
            ],
          ),
        ));
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    tileColor: Colors.white,
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Galeri'),
                    onTap: () {
                      _imgGaleri();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Kamera'),
                    onTap: () {
                      _imgKamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgGaleri() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 600,
        maxWidth: 600);
    if (image == null) return;
    setState(() {
      _imageProses = File(image.path);
    });
  }

  _imgKamera() async {
    final picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    if (image == null) return;
    //setState(() {
    _image = File(image.path);
    prosesFoto();
    //});
  }

  void prosesFoto() {
    Future<Directory?> extDir = getTemporaryDirectory();
    extDir.then((value) {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String filePath = '${value?.path}/$timestamp.jpg';
      _imageProses = File(filePath);
      img.Image? temp = img.decodeJpg(_image!.readAsBytesSync());
      img.Image temp2 = img.copyResize(temp!, width: 480, height: 640);
      img.drawString(temp2, img.arial_48, 4, 4, 'Kuliah Flutter',
          color: img.getColor(250, 100, 100));
      img.drawString(temp2, img.arial_24, 100, 120, timestamp.toString());
      img.drawString(temp2, img.arial_24, 120, 140, activeuser.toString());
      setState(() {
        _imageProses?.writeAsBytesSync(img.writeJpg(temp2));
      });
    });
  }
}
