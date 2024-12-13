import 'package:half_grade/core/enums/level.dart';

class Question{
  final String question;
  final String a;
  final String b;
  final String c;
  final String d;
  final String correctAnswer;
  final String? explanation;
  final Level level;

  const Question({
    required this.question,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.correctAnswer,
    required this.explanation,
    required this.level,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Question &&
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