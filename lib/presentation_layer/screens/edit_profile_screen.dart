import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/responsiveness_calculation.dart';
import 'package:half_grade/presentation_layer/logic_holders/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:half_grade/presentation_layer/widgets/dialogs/retry_dialog.dart';
import 'package:half_grade/presentation_layer/widgets/loading_indicator.dart';
import 'package:half_grade/presentation_layer/widgets/my_main_button.dart';
import 'package:half_grade/presentation_layer/widgets/my_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if(state is EditProfileFailure){
            retryDialog(
                context,
                errorMessage: state.error,
                retry: () => BlocProvider.of<EditProfileCubit>(context).updateProfile,
            );
          }
        },
        builder: (context, state) {
          if(state is EditProfileLoaded){
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: responsivenessCalculation(context, 16)),
                child: Column(
                  children: [
                    const ProfilePic(),
                    const Divider(),
                    Form(
                      child: Column(
                        children: [
                          UserInfoEditField(
                            text: "Username",
                            child: MyTextField(
                              hint: CurrentUser.instance!.username,
                              prefix: Icons.person_2,
                              controller: _usernameController,
                              validator: (p0) {
                                return null;
                              },
                            ),
                          ),
                          UserInfoEditField(
                            text: "School Name",
                            child: MyTextField(
                              hint: CurrentUser.instance!.schoolName,
                              prefix: Icons.school,
                              controller: _schoolNameController,
                              validator: (p0) {
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyMainButton(
                        label: 'Save Update',
                        onPressed: () {
                          if (_usernameController.text.isNotEmpty) {
                            CurrentUser.instance!.username =
                                _usernameController.text;
                          }
                          if (_schoolNameController.text.isNotEmpty) {
                            CurrentUser.instance!.schoolName =
                                _schoolNameController.text;
                          }
                          BlocProvider.of<EditProfileCubit>(context)
                              .updateProfile();
                          _usernameController.clear();
                          _schoolNameController.clear();
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    MyMainButton(
                        label: 'Update email/password', onPressed: () {}),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: MyMainButton(
                        label: 'Delete Account',
                        onPressed: () {},
                        backgroundColor: Colors.redAccent,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const LoadingIndicator();
        },
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(responsivenessCalculation(context, 16)),
      margin:  EdgeInsets.symmetric(vertical: responsivenessCalculation(context, 16)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: const CircleAvatar(
        backgroundColor: Colors.black,
        radius: 50,
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: 48,
        ),
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({
    super.key,
    required this.text,
    required this.child,
  });

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsivenessCalculation(context, 8)),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(text),
          ),
          Expanded(
            flex: 3,
            child: child,
          ),
        ],
      ),
    );
  }
}
