import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/responsiveness_calculation.dart';
import 'package:half_grade/core/validate.dart';
import 'package:half_grade/presentation_layer/logic_holders/auth_cubit/auth_cubit.dart';
import 'package:half_grade/presentation_layer/widgets/loading_indicator.dart';
import 'package:half_grade/presentation_layer/widgets/my_drop_down.dart';
import 'package:half_grade/presentation_layer/widgets/my_main_button.dart';
import 'package:half_grade/presentation_layer/widgets/my_text_button.dart';
import 'package:half_grade/presentation_layer/widgets/my_text_field.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();
  late String? city;
  final GlobalKey<FormState> _validatingKey = GlobalKey<FormState>();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit,AuthState>(
        builder: (context, state) {
          if(state is AuthLoading){
            return const LoadingIndicator();
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: responsivenessCalculation(context, 60)),
            child: Form(
              key: _validatingKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Spacer(flex: 2,),
                  const Text(
                    "Signup",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Create your account and take the adventure",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 18,),
                  BlocBuilder<AuthCubit,AuthState>(
                      builder: (context, state) {
                        if(state is AuthFailed){
                          return Text(
                              state.error.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red.withOpacity(0.8)),
                          );
                        }
                        return const SizedBox();
                      },
                  ),
                  MyTextField(
                    hint: "Username",
                    prefix: Icons.person,
                    controller: _usernameController,
                    validator: Validate.emptinessValidation,
                  ),
                  const SizedBox(height: 10),

                  MyTextField(
                      hint: "School Name",
                      prefix: Icons.school,
                      controller: _schoolNameController,
                      validator: Validate.emptinessValidation
                  ),

                  const SizedBox(height: 10),
                  MyDropDown(
                    hint: 'City',
                    validator: Validate.emptinessValidation,
                    icon: Icons.not_listed_location_rounded,
                    values: const ['Aleppo','Damascus','Lattakia','Tartous','Hama','Homs'],
                    onChanged: (value) {
                      city = value;
                    },
                  ),



                  const SizedBox(height: 10),

                  MyTextField(
                      hint: "Email",
                      prefix: Icons.email,
                      controller: _emailController,
                      validator: Validate.emailValidation
                  ),

                  const SizedBox(height: 10),

                  MyTextField(
                    hint: "Password",
                    prefix: Icons.password,
                    controller: _passwordController,
                    validator: Validate.passwordValidation,
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  MyTextField(
                      hint: "Confirm Password",
                      prefix: Icons.password,
                      obscureText: true,
                      controller: _passwordConfirmationController,
                      validator: (value) {
                        return Validate.passwordConfirmationValidation(value, _passwordController.text);
                      }
                  ),

                  const SizedBox(height: 10,),
                  MyMainButton(
                    label: "Signup",
                    onPressed: () {

                      if(_validatingKey.currentState!.validate()){
                        BlocProvider.of<AuthCubit>(context).signup(
                            context,
                            email: _emailController.text,
                            password: _passwordController.text,
                            schoolName: _schoolNameController.text,
                            city: city!,
                            username: _usernameController.text
                        );
                      }

                    },
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an account?  "),
                      MyTextButton(
                        text: 'Login',
                        onPressed: () => Navigator.of(context,rootNavigator: true).pushNamed('login'),
                        isBold: true,)
                    ],
                  ),
                  const Spacer(flex: 3,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
