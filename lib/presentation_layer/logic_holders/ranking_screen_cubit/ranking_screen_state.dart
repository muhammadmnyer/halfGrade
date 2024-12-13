part of 'ranking_screen_cubit.dart';

@immutable
sealed class RankingScreenState {
  const RankingScreenState();
}

final class RankingScreenLoading extends RankingScreenState {
  const RankingScreenLoading();
}
final class RankingScreenLoaded extends RankingScreenState {
  final List<UserRank> topUsers;
  const RankingScreenLoaded({required this.topUsers});
}
final class RankingScreenFailure extends RankingScreenState {
  final String error;
  const RankingScreenFailure({required this.error});
}
