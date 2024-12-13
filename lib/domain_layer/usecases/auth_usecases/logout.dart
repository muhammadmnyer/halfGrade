import 'package:dartz/dartz.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/repository.dart';

class Logout{

  final Repository _repository;

  Logout({required Repository repository}):_repository = repository;

  Future<Either<AuthFailure,void>> call()async{
    return _repository.logout();
  }
}