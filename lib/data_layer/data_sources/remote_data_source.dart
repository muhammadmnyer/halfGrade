import 'package:half_grade/core/errors/exceptions.dart' as exceptions;
import 'package:half_grade/data_layer/models/quiz_item_model.dart';
import 'package:half_grade/data_layer/models/quiz_subject_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteDataSource{

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String schoolName,
    required String city
  });
  Future<void> login({required String email,required String password});
  Future<void> logout();
  Future<void> deleteAccount();
  Future<void> resetPassword({required String email});


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
      throw exceptions.ServerException(message: e.toString());
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
      throw exceptions.ServerException(message: e.toString());
    }
  }

  //TODO: create a trigger to delete from auth scheme
  //TODO: add verification before the delete
  @override
  Future<void> deleteAccount() async{
    try{
      await _supabase
          .from('users')
          .delete()
          .match({"id": _supabase.auth.currentUser!.id});
    }catch(e){
      print(e);
      throw exceptions.AuthException(message: e.toString());
    }
  }

  @override
  Future<void> login({required String email,required String password}) async{
    try{
      await _supabase.auth.signInWithPassword(
          password: password,
          email: email
      );
    }catch(e){
      print(e);
      throw exceptions.AuthException(message: e.toString());
    }
  }

  @override
  Future<void> logout() async{
    try{
      await _supabase.auth.signOut();
    }catch(e){
      throw exceptions.AuthException(message: e.toString());
    }
  }

  //TODO: implement backend functionality
  @override
  Future<void> resetPassword({required String email}) async{
    try{
      await _supabase.auth.resetPasswordForEmail(email);
    }catch (e){
      throw exceptions.AuthException(message: e.toString());
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String schoolName,
    required String city
}) async{
    try{
      await _supabase.auth.signUp(
        password: password,
        email: email,
        data: {
          "username":username,
          "school_name":schoolName,
          "city":city
        },
      );
    }catch(e){
      throw exceptions.AuthException(message: e.toString());
    }
  }


}