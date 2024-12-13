import 'package:dartz/dartz.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/repository.dart';

class SignUp{

  final Repository _repository;
  SignUp({required Repository repository}):_repository = repository;

  Future<Either<AuthFailure,void>> call({
    required String email,
    required String password,
    required String username,
    required String schoolName,
    required String city
}){
    return _repository.signUp(
        email: email,
        password: password,
        username: username,
        schoolName: schoolName,
        city: city
    );
  }
}