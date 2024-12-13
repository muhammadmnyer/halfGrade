import 'package:half_grade/data_layer/models/question_model.dart';
import 'package:half_grade/domain_layer/entities/quiz_item.dart';

class QuizItemModel extends QuizItem{
  const QuizItemModel({
      required super.name,
      required super.timeInMin,
      required super.questions
  });


  factory QuizItemModel.fromJson(Map<String,dynamic> json){
    return QuizItemModel(
        name: json['exam_info']['name'],
        timeInMin: json['exam_info']['time_in_min'],
        questions: (json['exam_info']['questions_info'] as List)
            .map((e) {
              return QuestionModel.fromJson(e);
            },)
            .toList()
    );
  }
}