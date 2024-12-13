part of 'played_quizzes_cubit.dart';

@immutable
sealed class PlayedQuizzesState {
  const PlayedQuizzesState();
}

final class PlayedQuizzesLoading extends PlayedQuizzesState {
  const PlayedQuizzesLoading();
}
final class PlayedQuizzesLoaded extends PlayedQuizzesState {
  final Map<String,List<int>> groupedByTopics = {};
  PlayedQuizzesLoaded({required List<Map<String,dynamic>> quizzes}){
    for (var item in quizzes) {
      final String topic = item['topic'];
      final examId = item['exam_id'];
      if (!groupedByTopics.containsKey(topic)) {
        groupedByTopics[topic] = [];
      }
      groupedByTopics[topic]!.add(examId);
    }
  }
}
final class PlayedQuizzesFailure extends PlayedQuizzesState {
  final String error;
  const PlayedQuizzesFailure({required this.error});
}
