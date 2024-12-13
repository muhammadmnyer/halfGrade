part of 'quiz_screen_cubit.dart';

@immutable
sealed class QuizScreenState {
  const QuizScreenState();
}

final class QuizScreenLoading extends QuizScreenState {
  const QuizScreenLoading();
}
final class QuizScreenLoaded extends QuizScreenState {
  final QuizItem quiz;
  const QuizScreenLoaded({required this.quiz});
}
final class QuizScreenNotFound extends QuizScreenState {
  const QuizScreenNotFound();
}
final class QuizScreenFailure extends QuizScreenState {
  final String error;
  const QuizScreenFailure({
    required this.error
});
}
final class QuizScreenSolved extends QuizScreenState{
  final QuizItem quiz;
  const QuizScreenSolved({required this.quiz});
}

