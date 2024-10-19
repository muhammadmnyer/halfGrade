import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/domain_layer/entities/quiz_subject.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuizSubjectModel extends QuizSubject{
  const QuizSubjectModel({
    required super.name,
    required super.imageUrl,
    required super.topics
  });

  factory QuizSubjectModel.fromJson(Map<String,dynamic> json){
    return QuizSubjectModel(
        name: json['subject']['subject_name'],
        imageUrl: InjectionContainer.instance.get<SupabaseClient>()
            .storage.from(
            json['subject']['image_path']['bucket_id']
        ).getPublicUrl(json['subject']['image_path']['file_name']),
        topics: List<String>.from(json['topics'])
    );
  }


}