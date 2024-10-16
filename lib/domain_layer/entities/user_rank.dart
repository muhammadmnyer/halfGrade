class UserRank{
  final String username;
  final String schoolName;
  final int points;

  const UserRank({
    required this.username,
    required this.schoolName,
    required this.points,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserRank &&
              username == other.username &&
              schoolName == other.schoolName &&
              points == other.points
  ;

  @override
  int get hashCode => 0;

}