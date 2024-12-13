import 'package:dartz/dartz.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/repository.dart';

class FetchQuizzesMetadata{
  final Repository _repository;

  FetchQuizzesMetadata({required Repository repository}):_repository = repository;

  Future<Either<ServerFailure,List<Map<String,dynamic>>>> call({required String topic}){
    return _repository.fetchQuizzesMetaData(topic: topic);
  }
}