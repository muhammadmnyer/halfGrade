import 'package:dartz/dartz.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/repository.dart';

class UpdateCurrentUser{

  final Repository _repository;
  UpdateCurrentUser({required Repository repository}):_repository = repository;

  Future<Either<ServerFailure,void>> call({
    required CurrentUser user
})async{
    return _repository.updateCurrentUser(user: user);
  }
}