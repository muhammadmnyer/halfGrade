import 'package:half_grade/core/errors/exceptions.dart';
import 'package:half_grade/data_layer/models/quiz_item_model.dart';
import 'package:half_grade/data_layer/models/quiz_subject_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteDataSource{

  Future<List<QuizSubjectModel>> fetchQuizSubjects();
  Future<List<QuizItemModel>> fetchQuizItems({required String topic});

}


class RemoteDataSourceImpl implements RemoteDataSource{

  final SupabaseClient _supabase;
  RemoteDataSourceImpl({required SupabaseClient supabase}):_supabase = supabase;

  @override
  Future<List<QuizItemModel>> fetchQuizItems({required String topic}) async {
    try{
      final response = await _supabase.rpc<List<Map<String,dynamic>>>(
        'get_exams_by_topic',
        params: {'topic_param': topic},  // Pass the topic as a parameter
      );
      return response.map(
        (e) => QuizItemModel.fromJson(e),
      ).toList();

    }catch(e){
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<QuizSubjectModel>> fetchQuizSubjects() async {
    try{
      final response = await _supabase
          .rpc<List<Map<String,dynamic>>>('get_topics_details',);
      return response.map(
        (e) => QuizSubjectModel.fromJson(e),
      ).toList();
    }catch(e){
      print(e);
      throw ServerException(message: e.toString());
    }
  }


}