import 'package:dartz/dartz.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/entities/quiz_subject.dart';
import 'package:half_grade/domain_layer/repository.dart';

class FetchQuizSubjects{

  final Repository _repository;

  FetchQuizSubjects({required Repository repository}):_repository = repository;

  Future<Either<ServerFailure, List<QuizSubject>>> call()async{
    return _repository.fetchQuizSubjects();
  }
}