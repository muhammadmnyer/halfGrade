import 'package:half_grade/domain_layer/entities/user_rank.dart';

class UserRankModel extends UserRank{
  UserRankModel({
    required super.username,
    required super.schoolName,
    required super.points
  });

  factory UserRankModel.fromJson(Map<String,dynamic> json){
    return UserRankModel(
        username: json['username'],
        schoolName: json['schoolName'],
        points: json['points']
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRankModel &&
      username == other.username &&
      schoolName == other.schoolName &&
      points == other.points
  ;

  @override
  int get hashCode => 0;
}