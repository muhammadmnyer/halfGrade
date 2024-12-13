import 'package:flutter/material.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/core/responsiveness_calculation.dart';
import 'package:half_grade/domain_layer/usecases/auth_usecases/logout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(responsivenessCalculation(context, 20)),
          child: Column(

            children: [
              const Text(
                  'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32
                ),
              ),
              SizedBox(height: responsivenessCalculation(context, 32),),
              Center(
                child: Container(
                  height: responsivenessCalculation(context, 140),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black
                      ),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15,
                          spreadRadius: 0

                        )
                      ]
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(responsivenessCalculation(context, 16)),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 4),
                            blurRadius: 15,
                          )
                        ]
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(height: responsivenessCalculation(context, 32),),
              Text(
                  CurrentUser.instance!.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black
                ),
              ),
              Text(
                CurrentUser.instance!.uuid,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                    color: Colors.grey
                ),
              ),
              Text(
                CurrentUser.instance!.schoolName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                    color: Colors.grey
                ),
              ),
              const SizedBox(height: 24,),
              InkWell(
                onTap: () {
                  Navigator.of(context,rootNavigator: false).pushNamed('played_quizzes');
                },
                child: const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.school,color: Colors.white,),
                    ),
                    SizedBox(width: 16,),
                    Text(style: TextStyle(fontSize: 18),'Played Quizzes'),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
              SizedBox(height: responsivenessCalculation(context, 24),),
              InkWell(
                onTap: () {
                  Navigator.of(context,rootNavigator: false).pushNamed('edit_profile');
                },
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.info,color: Colors.white,),
                    ),
                    SizedBox(width: responsivenessCalculation(context, 24),),
                    const Text(style: TextStyle(fontSize: 18),'Personal Information'),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
              SizedBox(height: responsivenessCalculation(context, 24),),
              InkWell(
                onTap: () async {
                  final logout = Logout(repository: InjectionContainer.instance.get());
                  // ignore: use_build_context_synchronously
                  Navigator.of(context,rootNavigator: true)
                      .pushNamedAndRemoveUntil('login', (route) => false,);
                  await logout();

                },
                child: const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.logout,color: Colors.white,),
                    ),
                    SizedBox(width: 16,),
                    Text(style: TextStyle(fontSize: 18),'Logout'),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
