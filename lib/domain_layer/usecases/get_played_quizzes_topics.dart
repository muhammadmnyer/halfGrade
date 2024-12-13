import 'package:dartz/dartz.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/repository.dart';

class GetPlayedQuizzesTopics{
  final Repository _repository;
  GetPlayedQuizzesTopics({required Repository repository}):_repository = repository;

  Future<Either<ServerFailure,List<Map<String,dynamic>>>> call({required List<int> ids})async{
    return _repository.getPlayedQuizzesTopics(ids: ids);
  }
}