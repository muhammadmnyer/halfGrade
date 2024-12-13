import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/domain_layer/usecases/get_played_quizzes_topics.dart';


part 'played_quizzes_state.dart';

class PlayedQuizzesCubit extends Cubit<PlayedQuizzesState> {
  PlayedQuizzesCubit() : super(const PlayedQuizzesLoading());

  void load(){
    final getPlayedQuizzesTopics = GetPlayedQuizzesTopics(repository: InjectionContainer.instance.get());
    getPlayedQuizzesTopics(ids: CurrentUser.instance!.solvedExams)
        .then((value) {
          value.fold(
                  (l){
                    emit(PlayedQuizzesFailure(error: l.message));
                  },
                  (r){
                    emit(PlayedQuizzesLoaded(quizzes: r));
                  });
        },);
  }
}
