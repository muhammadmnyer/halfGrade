import 'package:dartz/dartz.dart';
import 'package:half_grade/core/errors/exceptions.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/data_layer/data_sources/local_data_source.dart';
import 'package:half_grade/data_layer/data_sources/remote_data_source.dart';
import 'package:half_grade/domain_layer/entities/quiz_item.dart';
import 'package:half_grade/domain_layer/entities/quiz_subject.dart';
import 'package:half_grade/domain_layer/entities/user_rank.dart';
import 'package:half_grade/domain_layer/repository.dart';

class RepositoryImpl implements Repository{

  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  RepositoryImpl({
    required LocalDataSource localDataSource,
    required RemoteDataSource remoteDataSource,
  }):_remoteDataSource = remoteDataSource,_localDataSource = localDataSource;

  @override
  Future<Either<CacheFailure, void>> cachePoints() {
    // TODO: implement cachePoints
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, void>> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, int>> fetchPoints() {
    // TODO: implement fetchPoints
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, List<QuizItem>>> fetchQuizItems({required String topic}) async{
    try{
      return Right(await _remoteDataSource.fetchQuizItems(topic: topic));
    } on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<ServerFailure, List<QuizSubject>>> fetchQuizSubjects() async{
    try{
      return Right(await _remoteDataSource.fetchQuizSubjects());
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }

  }

  @override
  Future<Either<CacheFailure, int>> getCachedPoints() {
    // TODO: implement getCachedPoints
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, List<UserRank>>> getRank() {
    // TODO: implement getRank
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, void>> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }


  @override
  Future<Either<ServerFailure, void>> resetPassword() {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, void>> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerFailure, void>> updatePoints() {
    // TODO: implement updatePoints
    throw UnimplementedError();
  }
}