import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:daily_meme_digest/main.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:daily_meme_digest/class/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  int _hitung = 0;
  final int _WAKTU_MAX = 10;
  bool _isRunning = true;
  late Timer _timer;
// Data untuk quiz
  List<Question> _questions = [];
  int _questionNo = 0;
  int _score = 0;
  late final prefs;
  late String _top_user;
  late int _top_point;

  @override
  void initState() {
    super.initState();
    _hitung = _WAKTU_MAX;
    // Buat sebuah periodic timer
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (_isRunning) {
          _hitung--;
          if (_hitung < 0) {
            // Reset waktu
            _hitung = _WAKTU_MAX;

            // Majukan indeks pertanyaan
            _questionNo++;
            //Kalau pertanyaan sudah habis, berarti game over
            if (_questionNo == _questions.length) {
              gameOver();
            }
            //_timer.cancel();
            // _isRunning = false;
            // showDialog(
            //     context: context,
            //     builder: (BuildContext builder) => AlertDialog(
            //           title: const Text("Time's Up!"),
            //           content: const Text("Waktunya habis!"),
            //           actions: [
            //             TextButton(
            //                 onPressed: () => Navigator.pop(context, "OK"),
            //                 child: const Text("OK"))
            //           ],
            //         ));
          }
        }
      });
    });
    // _questions.add(Question(
    //     'https://static.republika.co.id/uploads/images/inpicture_slide/040385300-1599905210-595e0d7b6e158-spiderman-homeco.jpg',
    //     "The character above is",
    //     'Ironman',
    //     'Spiderman',
    //     'Thor',
    //     'Hulk Hogan',
    //     'Spiderman'));
    // _questions.add(Question(
    //     'https://upload.wikimedia.org/wikipedia/en/thumb/3/33/Patrick_Star.svg/330px-Patrick_Star.svg.png',
    //     "Who is the character above?",
    //     'Dipsy',
    //     'Patrick',
    //     'Laalaa',
    //     'Poo',
    //     'Patrick'));
    // _questions.add(Question(
    //     'https://i.pinimg.com/564x/f6/9e/a4/f69ea4170171e0dfabd6841a7c6158f2.jpg',
    //     "Who is the character above",
    //     'batman',
    //     'superman',
    //     'flash',
    //     'aquades',
    //     'flash'));
    // _questions.add(Question(
    //     'https://i.pinimg.com/564x/69/36/64/693664c728e81f418d815a2efef2c475.jpg',
    //     "The character above is playing in what anime?",
    //     'spy x family',
    //     'death note',
    //     'attack on titan',
    //     'one piece',
    //     'attack on titan'));
    // _questions.add(Question(
    //     'https://static.wikia.nocookie.net/p__/images/4/46/Rem_Vector.png/revision/latest/scale-to-width-down/222?cb=20190619040242&path-prefix=protagonist',
    //     "Who is the voice actor of the character above?",
    //     'Rie Takahashi',
    //     'Inori Minase',
    //     'Saori Hayami',
    //     'Natsumi Fujiwara',
    //     'Inori Minase'));
    // _questions.add(Question(
    //     'https://cdn.myanimelist.net/images/characters/4/457933.jpg',
    //     "Who is the character above",
    //     'Anya Forger',
    //     'Historia Reiss',
    //     'Yuuki Asuna',
    //     'Yukinoshita Yukino',
    //     'Anya Forger'));
    // _questions.add(Question(
    //   'https://occ-0-6711-64.1.nflxso.net/dnm/api/v6/9pS1daC2n6UGc3dUogvWIPMR_OU/AAAABb9ThqYQ5LQ4hFP2JQHv47WvRR16EU9UJ5eRCbnO3yv1yMyibI_AoEn46FWzHQ6W_8sT1fIAWcPUfLgiLx2sb9-etERrS7ICcPpKm4QiZfl-k70Ll4K01Bux.jpg?r=7e8',
    //     'What is the title of the anime based on the picture?',
    //     'Spirited Away',
    //     'Death Note',
    //     'Fullmetal Alchemist Brotherhood',
    //     'Gintama',
    //     'Death Note'));
    // _questions.add(Question(
    //     'https://media.suara.com/pictures/653x366/2021/03/03/56916-attack-on-titan.webp',
    //     "Who is the main character of the anime above?",
    //     'Mikasa Ackerman',
    //     'Eren Jaeger',
    //     'Armin Arlert',
    //     'Reiner Braun',
    //     'Eren Jaeger'));
    // _questions.add(Question(
    //     'https://cdn.myanimelist.net/images/anime/1839/122012.jpg',
    //     "Who is the main character of the anime above?",
    //     'Sano Manjirou',
    //     'Ryuuguji Ken',
    //     'Tachibana Hinata',
    //     'Hanagaki Takemichi',
    //     'Hanagaki Takemichi'));
    // _questions.add(Question(
    //     'https://cdn.myanimelist.net/images/anime/1935/127974.jpg',
    //     "Who is the main character of the anime above?",
    //     'Makise Kurisu',
    //     'Shiina Mayuri',
    //     'Amana Suzuha',
    //     'Okabe Rintarou',
    //     'Okabe Rintarou'));

    _questions.add(Question(
        'https://i.pravatar.cc/400?img=60',
        "Not a member of Avenger",
        'Ironman',
        'Spiderman',
        'Thor',
        'Hulk Hogan',
        'Hulk Hogan'));
    _questions.add(Question(
        'https://i.pravatar.cc/400?img=60',
        "Not a member of Teletubbies",
        'Dipsy',
        'Patrick',
        'Laalaa',
        'Poo',
        'Patrick'));
    _questions.add(Question(
        'https://i.pravatar.cc/400?img=60',
        "Not a member of justice league",
        'batman',
        'superman',
        'flash',
        'aquades',
        'aquades'));
    _top_point = 0;
    _top_user = "";

    checkHighScore();
  }

  @override
  void dispose() {
    _timer.cancel();
    _hitung = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
            // Text(formatTime(_hitung),
            //     style: const TextStyle(
            //       fontSize: 24,
            //     )),
            CircularPercentIndicator(
              radius: 100,
              lineWidth: 20,
              percent: 1 - _hitung / _WAKTU_MAX,
              center: Text(formatTime(_hitung),
                  style: const TextStyle(
                    fontSize: 24,
                  )),
              progressColor: Colors.red,
            ),
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width,
              lineHeight: 20,
              percent: 1 - _hitung / _WAKTU_MAX,
              center: Text(formatTime(_hitung),
                  style: const TextStyle(
                    fontSize: 24,
                  )),
              progressColor: Colors.red,
              backgroundColor: Colors.grey,
            ),
            //   ElevatedButton(
            //       onPressed: () {
            //         setState(() {
            //           _isRunning = !_isRunning;
            //         });
            //       },
            //       child: Text(_isRunning ? "Stop" : "Start")),
            //Soal
            Container(
              width: 400,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_questions[_questionNo].imgUrl),
                  fit: BoxFit.contain,
                ),
                border: Border.all(
                  color: Colors.indigo,
                  width: 10,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            Text(_questions[_questionNo].narration),
            //Jawaban
            TextButton(
                onPressed: () => cekJawaban(_questions[_questionNo].optionA),
                child: Text("A. " + _questions[_questionNo].optionA)),
            TextButton(
                onPressed: () => cekJawaban(_questions[_questionNo].optionB),
                child: Text("B. " + _questions[_questionNo].optionB)),
            TextButton(
                onPressed: () => cekJawaban(_questions[_questionNo].optionC),
                child: Text("C. " + _questions[_questionNo].optionC)),
            TextButton(
                onPressed: () => cekJawaban(_questions[_questionNo].optionD),
                child: Text("D. " + _questions[_questionNo].optionD)),
            Divider(height: 20),
            Text("Top score : " + _score.toString()),
            Divider(height: 20),
            Text("Top user :" + _top_point.toString() + _top_user)
          ])),
        ));
  }

  String formatTime(int waktu) {
    String jam = (waktu ~/ 3600).toString().padLeft(2, "0");
    String menit = ((waktu % 3600) ~/ 60).toString().padLeft(2, "0");
    String detik = (waktu % 60).toString().padLeft(2, "0");
    return "$jam:$menit:$detik";
  }

  void cekJawaban(String jawaban) {
    setState(() {
      if (jawaban == _questions[_questionNo].answer) {
        _score += 100;
      }
      _questionNo++;
      //Kondisi game over
      if (_questionNo == _questions.length) {
        gameOver();
      }
      _hitung = _WAKTU_MAX;
    });
  }

  Future<void> checkHighScore() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _top_user = prefs.getString("top_user") ?? '';
      _top_point = prefs.getInt("top_point") ?? 0;
    });
  }

  void gameOver() {
    _timer.cancel();
    _isRunning = false;
    _questionNo = 0;
    showDialog(
        context: context,
        builder: (BuildContext builder) => AlertDialog(
              title: const Text("Game Over!"),
              content: Text(
                  "Point anda adalah $_score! top Point : $_top_point . top User : $_top_user"),
              actions: [
                TextButton(
                    onPressed: () =>
                        {Navigator.pop(context, "OK"), Navigator.pop(context)},
                    child: const Text("OK"))
              ],
            ));
    if (_score > _top_point) {
      prefs.setString("top_user", activeuser);
      prefs.setInt("top_point", _score);
    }
  }
}
