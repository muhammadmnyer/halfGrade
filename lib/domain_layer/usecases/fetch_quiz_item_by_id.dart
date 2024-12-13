import 'package:dartz/dartz.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/entities/quiz_item.dart';
import 'package:half_grade/domain_layer/repository.dart';

class FetchQuizItemById{

  final Repository _repository;
  FetchQuizItemById({required Repository repository}):_repository = repository;

  Future<Either<ServerFailure, QuizItem?>> call({required int id})async{
    return _repository.fetchQuizItemById(id: id);
  }
}