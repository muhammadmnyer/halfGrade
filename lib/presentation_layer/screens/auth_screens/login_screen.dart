import 'package:flutter/material.dart';
import 'package:half_grade/core/responsiveness_calculation.dart';
import 'package:half_grade/core/validate.dart';
import 'package:half_grade/presentation_layer/logic_holders/auth_cubit/auth_cubit.dart';
import 'package:half_grade/presentation_layer/widgets/loading_indicator.dart';
import 'package:half_grade/presentation_layer/widgets/my_main_button.dart';
import 'package:half_grade/presentation_layer/widgets/my_text_button.dart';
import 'package:half_grade/presentation_layer/widgets/my_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _validationKey = GlobalKey();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit,AuthState>(
          builder: (context, state) {
            if(state is AuthLoading) {
              return const LoadingIndicator();
          }
          return Padding(
              padding: EdgeInsets.all(responsivenessCalculation(context, 20)),
              child: Form(
                key: _validationKey,
                child: Column(

                  children: [
                    const Spacer(),
                    const Text(
                      "Welcome Back",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const Text("Enter your credential to login"),
                    const Spacer(),
                    BlocBuilder<AuthCubit,AuthState>(
                      builder: (BuildContext context, AuthState state) {
                        if(state is AuthFailed){
                          return Padding(
                            padding: EdgeInsets.only(bottom: responsivenessCalculation(context, 8)),
                            child: Text(
                                state.error.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red.withOpacity(0.8)),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    MyTextField(
                        hint: 'Email',
                        prefix: Icons.person,
                        controller: _emailController,
                        validator: Validate.emailValidation
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                        hint: 'Password',
                        obscureText: true,
                        prefix: Icons.password,
                        controller: _passwordController,
                        validator: Validate.passwordValidation
                    ),
                    const SizedBox(height: 10),
                    MyMainButton(
                      label: 'Login',
                      onPressed: () => _login(context),
                    ),
                    const SizedBox(height: 12,),
                    MyTextButton(
                      text: 'Forgot password?',
                      onPressed: () {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?  "),
                        MyTextButton(
                          text: 'Signup',
                          isBold: true,
                          onPressed: () => Navigator.of(context).pushNamed('signup'),
                        )
                      ],
                    ),
                    const Spacer(flex: 2,),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }

  void _login(BuildContext context){
    if(_validationKey.currentState!.validate()){
      BlocProvider.of<AuthCubit>(context).login(
          context,
          email: _emailController.text,
          password: _passwordController.text
      );
    }
  }
}