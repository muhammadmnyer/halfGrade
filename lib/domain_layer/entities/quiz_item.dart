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
}