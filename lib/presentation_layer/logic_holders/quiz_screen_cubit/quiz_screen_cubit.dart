import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/enums/level.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/domain_layer/entities/quiz_item.dart';
import 'package:half_grade/domain_layer/usecases/fetch_quiz_item_by_id.dart';
import 'package:half_grade/domain_layer/usecases/update_points.dart';


part 'quiz_screen_states.dart';

class QuizScreenCubit extends Cubit<QuizScreenState> {
  QuizScreenCubit() : super(const QuizScreenLoading());

  void load({
    required int id
})async{
    emit(const QuizScreenLoading());
    final fetchQuizItemById = FetchQuizItemById(repository: InjectionContainer.instance.get());
    fetchQuizItemById(id: id).then((value) {
      value.fold(
            (l) {
              emit(QuizScreenFailure(error: l.message));
            },
            (r) {
              if(r == null){
                emit(const QuizScreenNotFound());
              }
              else{
                emit(QuizScreenLoaded(quiz: r));
              }
            },
      );
    },);
  }

  void solveQuiz({required QuizItem quiz, required Map<int, String> answers, required int id}){
    int points = 0;
    if (!CurrentUser.instance!.solvedExams.contains(id)) {
      for (int i = 0; i < (state as QuizScreenLoaded).quiz.questions.length; i++) {
        if (answers[i + 1] == (state as QuizScreenLoaded).quiz.questions[i].correctAnswer) {
          switch ((state as QuizScreenLoaded).quiz.questions[i].level) {
            case Level.hard:
              points += 3;
              break;
            case Level.medium:
              points += 2;
              break;
            case Level.easy:
              points += 1;
              break;
            default:
              throw UnimplementedError();
          }
        }
      }
      CurrentUser.instance!.points += points;
      CurrentUser.instance!.solvedExams.add(id);
      updateCurrentUser(
          user: CurrentUser.instance!,
          quiz: (state as QuizScreenLoaded).quiz
      );
    }
    emit(QuizScreenSolved(quiz: quiz));
  }

  void updateCurrentUser({
    required CurrentUser user,
    required QuizItem quiz
  }){

    emit(const QuizScreenLoading());
    final updateCurrentUser = UpdateCurrentUser(repository: InjectionContainer.instance.get());
    updateCurrentUser(user: user)
        .then((value) {
      value.fold(
              (l) {
            emit(QuizScreenFailure(error: l.message));
          },
              (r){
            // emit(QuizScreenLoaded(quiz: quiz));
          }
      );
    },);
  }
}
