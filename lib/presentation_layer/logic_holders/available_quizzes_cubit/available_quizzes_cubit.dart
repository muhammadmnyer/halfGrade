import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/domain_layer/usecases/fetch_quizzes_metadata.dart';
import 'package:flutter/material.dart';
part 'available_quizzes_state.dart';

class AvailableQuizzesCubit extends Cubit<AvailableQuizzesState> {
  AvailableQuizzesCubit() : super(const AvailableQuizzesLoading());

  void load({required String topic}){
    emit(const AvailableQuizzesLoading());
    final fetchQuizzesMetadata = FetchQuizzesMetadata(
        repository: InjectionContainer.instance.get()
    );
    fetchQuizzesMetadata(topic: topic).
    then((value) {
      value.fold(
              (l){
                emit(AvailableQuizzesFailure(error: l.message));
              },
              (r){
                emit(AvailableQuizzesLoaded(metadata: r));
              }
      );
    },);
  }
}
