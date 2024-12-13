import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:half_grade/core/enums/level.dart';
import 'package:half_grade/data_layer/models/question_model.dart';
import 'package:half_grade/data_layer/models/quiz_item_model.dart';

void main(){
  test('quiz item model test', (){
    final json = jsonDecode(
        File('test/fixtures/models_as_json/quiz_item_model.json').readAsStringSync()
    );
    const expectedModel = QuizItemModel(
        name: "a name",
        timeInMin: 90,
        questions: [
          QuestionModel(
              question: "a test question 1",
              a: "4",
              b: "5",
              c: "6",
              d: "7",
              correctAnswer: "a",
              explanation: null,
              level: Level.hard
          ),
          QuestionModel(
              question: "a test question 2",
              a: "8",
              b: "9",
              c: "10",
              d: "11",
              correctAnswer: "b",
              explanation: "testing",
              level: Level.medium
          ),
        ]
    );

    final quizItemModel = QuizItemModel.fromJson(json);

    expect(quizItemModel, expectedModel);
  });
}