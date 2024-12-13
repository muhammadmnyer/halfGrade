import 'package:dartz/dartz.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/errors/exceptions.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/data_layer/data_sources/remote_data_source.dart';
import 'package:half_grade/domain_layer/entities/quiz_item.dart';
import 'package:half_grade/domain_layer/entities/quiz_subject.dart';
import 'package:half_grade/domain_layer/entities/user_rank.dart';
import 'package:half_grade/domain_layer/repository.dart';

class RepositoryImpl implements Repository{

  final RemoteDataSource _remoteDataSource;
  RepositoryImpl({
    required RemoteDataSource remoteDataSource,
  }):_remoteDataSource = remoteDataSource;

  @override
  Future<Either<AuthFailure, void>> deleteAccount() async{
    try{
      await _remoteDataSource.deleteAccount();
      return const Right(null);
    } on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
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
  Future<Either<ServerFailure, List<UserRank>>> getRank() async {
    try{
      final response = await _remoteDataSource.getRank();
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<AuthFailure, void>> login({required String email,required String password}) async{
    try{
      await _remoteDataSource.login(email: email, password: password);
      return const Right(null);
    }on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<AuthFailure, void>> logout() async{
    try{
      await _remoteDataSource.logout();
      return const Right(null);
    } on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }
  }


  @override
  Future<Either<AuthFailure, void>> resetPassword({required String email}) async{
    try{
      await _remoteDataSource.resetPassword(email: email);
      return const Right(null);
    } on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signUp({
    required String email,
    required String password,
    required String username,
    required String schoolName,
    required String city
}) async{
    try{
      await _remoteDataSource.signUp(
          email: email,
          password: password,
          username: username,
          schoolName: schoolName,
          city: city
      );
      return const Right(null);
    } on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }
  }


  @override
  Future<Either<ServerFailure, QuizItem?>> fetchQuizItemById({required int id}) async{
    try{
      return Right(await _remoteDataSource.fetchQuizItemById(id: id));
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<ServerFailure, List<Map<String, dynamic>>>> fetchQuizzesMetaData({required String topic}) async {
    try{
      return Right(await _remoteDataSource.fetchQuizzesMetaData(topic: topic));
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<ServerFailure, List<Map<String, dynamic>>>> fetchCurrentUsersMetadata({required String uuid}) async {
    try{
      final response = await _remoteDataSource.fetchCurrentUsersMetadata(uuid: uuid);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<ServerFailure, void>> updateCurrentUser({required CurrentUser user}) async{
    try{
      await _remoteDataSource.updateCurrentUser(user: user);
      return const Right(null);
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<ServerFailure, List<Map<String, dynamic>>>> getPlayedQuizzesTopics({required List<int> ids}) async {
    try{
      final response = await _remoteDataSource.getPlayedQuizzesTopics(ids: ids);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }

  }
}