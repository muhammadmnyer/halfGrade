import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/entities/quiz_item.dart';
import 'package:half_grade/domain_layer/entities/quiz_subject.dart';
import 'package:half_grade/domain_layer/entities/user_rank.dart';
import 'package:dartz/dartz.dart';


abstract class Repository{

  Future<Either<ServerFailure,void>> signUp();
  Future<Either<ServerFailure,void>> login();
  Future<Either<ServerFailure,void>> logout();
  Future<Either<ServerFailure,void>> deleteAccount();
  Future<Either<ServerFailure,void>> resetPassword();

  Future<Either<ServerFailure,List<QuizSubject>>> fetchQuizSubjects();
  Future<Either<ServerFailure,List<QuizItem>>> fetchQuizItems({required String topic});

  Future<Either<ServerFailure,int>> fetchPoints();
  Future<Either<ServerFailure,void>> updatePoints();
  Future<Either<CacheFailure,int>> getCachedPoints();
  Future<Either<CacheFailure,void>> cachePoints();
  Future<Either<ServerFailure,List<UserRank>>> getRank();
}