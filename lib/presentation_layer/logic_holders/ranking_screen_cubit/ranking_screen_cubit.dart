import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/domain_layer/entities/user_rank.dart';
import 'package:half_grade/domain_layer/usecases/get_rank.dart';
part 'ranking_screen_state.dart';

class RankingScreenCubit extends Cubit<RankingScreenState> {
  RankingScreenCubit() : super(const RankingScreenLoading());

  void load(){
    emit(const RankingScreenLoading());
    final getRank = GetRank(repository: InjectionContainer.instance.get());
    getRank().then((value) {
      value.fold(
              (l){
                emit(RankingScreenFailure(error: l.message));
              },
              (r){
                emit(RankingScreenLoaded(topUsers: r));
              }
      );
    },);
  }
}
