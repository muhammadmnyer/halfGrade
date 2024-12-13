import 'package:dartz/dartz.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/repository.dart';

class FetchCurrentUser{
  final Repository _repository;
  FetchCurrentUser({required Repository repository}):_repository = repository;

  Future<Either<ServerFailure,void>> call({required String uuid}){
    return _repository.fetchCurrentUsersMetadata(uuid: uuid)
        .then((value) {
          return value.fold(
                (l) {
                  return Left(l);
                },
                (r) {
                  CurrentUser.initialize(
                      city: r[0]['city'],
                      schoolName: r[0]['school_name'],
                      username: r[0]['username'],
                      points: r[0]['points'],
                      solvedExams: List<int>.from(r[0]['solved_exams']),
                      uuid: r[0]['id']
                  );
                  return const Right(null);
                },
          );
        },);
  }
}