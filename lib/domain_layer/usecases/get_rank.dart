import 'package:dartz/dartz.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/domain_layer/entities/user_rank.dart';
import 'package:half_grade/domain_layer/repository.dart';

class GetRank{

  final Repository _repository;

  GetRank({required Repository repository}):_repository = repository;

  Future<Either<ServerFailure,List<UserRank>>> call()async{
    return _repository.getRank();
  }
}