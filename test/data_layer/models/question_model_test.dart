import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:half_grade/core/enums/level.dart';
import 'package:half_grade/data_layer/models/question_model.dart';

void main(){
  test('question model fromJson', () {

    final json = jsonDecode(
        File('test/fixtures/models_as_json/question_model.json').readAsStringSync()
    );
    const expectedModel = QuestionModel(
        question: "a question",
        a: "first",
        b: "second",
        c: "third",
        d: "fourth",
        correctAnswer: "a",
        explanation: "explanation can be null",
        level: Level.hard
    );

    final questionModel = QuestionModel.fromJson(json);

    expect(questionModel, expectedModel);
  },);
}