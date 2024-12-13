import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/domain_layer/entities/quiz_subject.dart';
import 'package:half_grade/domain_layer/usecases/fetch_current_user.dart';
import 'package:half_grade/domain_layer/usecases/fetch_quiz_subjects.dart';


part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenLoading());

  void load({required String? uuid}){
    if(uuid != null){
      emit(const HomeScreenLoading());
      final fetchQuizSubjects = FetchQuizSubjects(repository:InjectionContainer.instance.get());
      fetchQuizSubjects()
          .then((value) {
        value.fold(
              (failure) {
            emit(HomeScreenFailure(error: failure.message));
          },
              (subjects) {
              if (CurrentUser.instance == null) {
                final fetchCurrentUser = FetchCurrentUser(
                    repository: InjectionContainer.instance.get());
                fetchCurrentUser(uuid: uuid).then(
                  (value) {
                    value.fold((l) {
                      emit(HomeScreenFailure(error: l.message));
                    }, (r) {
                      emit(HomeScreenLoaded(subjects: subjects));
                    });
                  },
                );
              }
              else{
                emit(HomeScreenLoaded(subjects: subjects));
              }
            },);
      },);
    }
  }
}

