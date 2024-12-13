part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {
  const EditProfileState();
}

final class EditProfileLoaded extends EditProfileState {
  const EditProfileLoaded();
}
final class EditProfileLoading extends EditProfileState {
  const EditProfileLoading();
}
final class EditProfileFailure extends EditProfileState {
  final String error;
  const EditProfileFailure({required this.error});
}
