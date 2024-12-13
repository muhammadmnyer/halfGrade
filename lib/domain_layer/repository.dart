import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/entities/quiz_item.dart';
import 'package:half_grade/domain_layer/entities/quiz_subject.dart';
import 'package:half_grade/domain_layer/entities/user_rank.dart';
import 'package:dartz/dartz.dart';


abstract class Repository{

  Future<Either<AuthFailure,void>> signUp({
    required String email,
    required String password,
    required String username,
    required String schoolName,
    required String city
  });
  Future<Either<AuthFailure,void>> login({required String email,required String password});
  Future<Either<AuthFailure,void>> logout();
  Future<Either<AuthFailure,void>> deleteAccount();
  Future<Either<AuthFailure,void>> resetPassword({required String email});
  Future<Either<ServerFailure,List<Map<String,dynamic>>>> fetchCurrentUsersMetadata({required String uuid});

  Future<Either<ServerFailure,List<QuizSubject>>> fetchQuizSubjects();
  Future<Either<ServerFailure,List<Map<String,dynamic>>>> fetchQuizzesMetaData({required String topic});
  Future<Either<ServerFailure,QuizItem?>> fetchQuizItemById({required int id});


  Future<Either<ServerFailure,void>> updateCurrentUser({required CurrentUser user});
  Future<Either<ServerFailure,List<UserRank>>> getRank();
  Future<Either<ServerFailure,List<Map<String,dynamic>>>> getPlayedQuizzesTopics({required List<int> ids});
}