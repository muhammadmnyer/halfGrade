import 'package:dartz/dartz.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/repository.dart';

class Login{
  final Repository _repository;

  const Login({
    required Repository repository,
  }):_repository = repository;

  Future<Either<AuthFailure,void>> call({
    required String email,
    required String password,
  }){
    return _repository.login(email: email, password: password);
  }

}