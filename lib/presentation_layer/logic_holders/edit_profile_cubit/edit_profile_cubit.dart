import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/domain_layer/usecases/update_points.dart';
import 'package:flutter/material.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {

  EditProfileCubit() : super(const EditProfileLoaded());

  void updateProfile(){
    emit(const EditProfileLoading());
    final updateUser = UpdateCurrentUser(
        repository: InjectionContainer.instance.get()
    );
    updateUser(user: CurrentUser.instance!)
        .then((value) {
          value.fold(
                  (l){
                    emit(EditProfileFailure(error: l.message));
                  },
                  (r){
                    emit(const EditProfileLoaded());
                  }
          );
        },);
  }

}
