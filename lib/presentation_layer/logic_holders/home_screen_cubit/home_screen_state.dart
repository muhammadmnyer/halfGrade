part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {
  const HomeScreenState();
}

final class HomeScreenLoading extends HomeScreenState {
  const HomeScreenLoading();
}

final class HomeScreenLoaded extends HomeScreenState {
  final List<QuizSubject> subjects;
  const HomeScreenLoaded({
    required this.subjects
});
}

final class HomeScreenFailure extends HomeScreenState {
  final String error;
  const HomeScreenFailure({
    required this.error
});
}
