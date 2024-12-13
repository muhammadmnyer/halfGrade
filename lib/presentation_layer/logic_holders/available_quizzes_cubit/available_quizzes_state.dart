part of 'available_quizzes_cubit.dart';

@immutable
sealed class AvailableQuizzesState {
  const AvailableQuizzesState();
}

final class AvailableQuizzesLoading extends AvailableQuizzesState {
  const AvailableQuizzesLoading();
}
final class AvailableQuizzesLoaded extends AvailableQuizzesState {
  final List<Map<String,dynamic>> metadata;
  const AvailableQuizzesLoaded({required this.metadata});
}
final class AvailableQuizzesFailure extends AvailableQuizzesState {
  final String error;
  const AvailableQuizzesFailure({required this.error});
}
