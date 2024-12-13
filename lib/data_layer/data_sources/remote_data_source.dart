import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/errors/exceptions.dart' as exceptions;
import 'package:half_grade/data_layer/models/quiz_item_model.dart';
import 'package:half_grade/data_layer/models/quiz_subject_model.dart';
import 'package:half_grade/data_layer/models/user_rank_model.dart';
import 'package:half_grade/domain_layer/entities/user_rank.dart';
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
  Future<List<Map<String,dynamic>>> fetchCurrentUsersMetadata({required String uuid});


  Future<List<QuizSubjectModel>> fetchQuizSubjects();

  Future<void> updateCurrentUser({required CurrentUser user});

  Future<QuizItemModel?> fetchQuizItemById({required int id});
  Future<List<Map<String,dynamic>>> fetchQuizzesMetaData({required String topic});
  
  Future<List<UserRank>> getRank();

  Future<List<Map<String,dynamic>>> getPlayedQuizzesTopics({required List<int> ids});

}


class RemoteDataSourceImpl implements RemoteDataSource{

  final SupabaseClient _supabase;
  RemoteDataSourceImpl({required SupabaseClient supabase}):_supabase = supabase;

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

  @override
  Future<QuizItemModel?> fetchQuizItemById({required int id}) async{try{
      final response = await _supabase.rpc<List?>(
          'get_exams_by_id',
        params: {'exam_id_param':id}
      );

      if(response != null && response.isNotEmpty){
        return QuizItemModel.fromJson(response[0]);
      }
      return null;
    }catch(e){
      throw exceptions.ServerException(message: e.toString());
    }

  }

  @override
  Future<List<Map<String, dynamic>>> fetchQuizzesMetaData({required String topic}) async {
    try{
      final response =  await _supabase.rpc(
          'get_exams_metadata',
          params: {'topic_name':topic}
      );
      return List<Map<String,dynamic>>.from(response);
    }catch(e){
      throw exceptions.ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchCurrentUsersMetadata({required String uuid}) async {
    try{
      final response = await _supabase.from('users_info').select('*').match({'id':uuid});
      return response;
    }catch(e){
      throw exceptions.ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateCurrentUser({required CurrentUser user}) async{
    try{
      await _supabase
          .from('users_info')
          .update(user.toJson())
          .match({'id':user.uuid});
    }catch(e){
      throw exceptions.ServerException(message: e.toString());
    }
  }

  @override
  Future<List<UserRank>> getRank() async {
    try{
      final response = await _supabase.from('users_info')
          .select('points, username, school_name')
          .order('points',)
          .limit(100);
      return List<UserRank>.generate(
          response.length,
          (index) => UserRankModel.fromJson(response[index]),
      );
    }catch(e){
      throw exceptions.ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getPlayedQuizzesTopics({required List<int> ids}) async{
    try{
      final response = await _supabase.rpc('get_played_quizzes_topics',params: {'ids':ids});
      return List<Map<String,dynamic>>.from(response);
    }catch(e){
      throw exceptions.ServerException(message: e.toString());
    }

  }


}