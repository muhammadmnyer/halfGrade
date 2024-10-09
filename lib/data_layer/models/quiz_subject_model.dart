import 'package:flutter/foundation.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/domain_layer/entities/quiz_subject.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuizSubjectModel extends QuizSubject{
  QuizSubjectModel({
    required super.name,
    required super.imageUrl,
    required super.topics
  });

  factory QuizSubjectModel.fromJson(Map<String,dynamic> json){
    return QuizSubjectModel(
        name: json['subject']['subject_name'],
        imageUrl: InjectionContainer.instance.get<SupabaseClient>()
            .storage.from('cover_images').getPublicUrl('testing/ui.png'),
        topics: List<String>.from(json['topics'])
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizSubjectModel &&
      name == other.name &&
      imageUrl == other.imageUrl &&
      listEquals(topics, other.topics)
  ;

  @override
  int get hashCode => 0;
}