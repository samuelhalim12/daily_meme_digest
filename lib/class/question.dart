import 'package:flutter/cupertino.dart';

class Question {
  String imgUrl;
  String narration;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String answer;

  Question(this.imgUrl, this.narration, this.optionA, this.optionB, this.optionC,
      this.optionD, this.answer);
}
