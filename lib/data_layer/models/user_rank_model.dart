import 'package:half_grade/domain_layer/entities/user_rank.dart';

class UserRankModel extends UserRank{
  const UserRankModel({
    required super.username,
    required super.schoolName,
    required super.points
  });

  factory UserRankModel.fromJson(Map<String,dynamic> json){
    return UserRankModel(
        username: json['username'],
        schoolName: json['school_name'],
        points: json['points']
    );
  }


}