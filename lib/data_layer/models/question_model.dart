import 'package:half_grade/core/enums/level.dart';
import 'package:half_grade/domain_layer/entities/question.dart';

class QuestionModel extends Question{
  QuestionModel({
    required super.question,
    required super.a,
    required super.b,
    required super.c,
    required super.d,
    required super.correctAnswer,
    required super.explanation,
    required super.level
  });

  factory QuestionModel.fromJson(Map<String,dynamic> json){
    return QuestionModel(
        question: json['question'],
        a: json['a'],
        b: json['b'],
        c: json['c'],
        d: json['d'],
        correctAnswer: json['correct_answer'],
        explanation: json['explanation'],
        level: Level.fromString(json['level'])
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionModel &&
          question == other.question &&
          a == other.a &&
          b == other.b &&
          c == other.c &&
          d == other.d &&
          correctAnswer == other.correctAnswer &&
          explanation == other.explanation &&
          level == other.level;

  @override
  int get hashCode => 0;
}