import 'package:flutter/foundation.dart';
import 'package:half_grade/domain_layer/entities/question.dart';

class QuizItem{
  final String name;
  final int timeInMin;
  final List<Question> questions;
  const QuizItem({
    required this.name,
    required this.timeInMin,
    required this.questions
});

  @override
  bool operator ==(Object other) {
    return other is QuizItem &&
        name == other.name &&
        timeInMin == other.timeInMin &&
        listEquals(questions, other.questions);
  }

  @override
  int get hashCode => 0;

}