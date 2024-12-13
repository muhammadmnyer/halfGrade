import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/responsiveness_calculation.dart';
import 'package:half_grade/main.dart';
import 'package:half_grade/presentation_layer/logic_holders/home_screen_cubit/home_screen_cubit.dart';
import 'package:half_grade/presentation_layer/widgets/dialogs/retry_dialog.dart';
import 'package:half_grade/presentation_layer/widgets/loading_indicator.dart';
import 'package:half_grade/presentation_layer/widgets/my_carousel_slider.dart';
import 'package:half_grade/presentation_layer/widgets/my_main_button.dart';
import 'package:half_grade/presentation_layer/widgets/views/quiz_subject_view.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeScreenCubit,HomeScreenState>(
        listener: (context, state) {
          if(state is HomeScreenFailure){
            retryDialog(
                context,
                errorMessage: state.error,
                retry: () => BlocProvider.of<HomeScreenCubit>(context).load(uuid: supabase.auth.currentUser!.id),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeScreenLoaded) {
            return RefreshIndicator(
              onRefresh: () async{
                BlocProvider.of<HomeScreenCubit>(context).load(uuid: supabase.auth.currentUser!.id);
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: responsivenessCalculation(context,16),
                          vertical: responsivenessCalculation(context, 40)
                      )
                      ,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'HalfGrade',
                                style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(CurrentUser.instance!.points.toString())
                            ],
                          ),
                          const SizedBox(height: 4,),
                          const Text(
                            'Challenge your friends and family with our Quiz app, let’s see who comes out on top as the ultimate quiz champion',
                            style: TextStyle(color: Colors.grey,fontSize: 16),
                          ),
                          SizedBox(height: responsivenessCalculation(context, 32),),
                          Row(
                            children: [
                              Image.asset(
                                'assets/trophy.png',
                                height: responsivenessCalculation(context, 45),
                                width: responsivenessCalculation(context, 45),
                              ),
                              const SizedBox(width: 12,),
                              const Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Points System',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    Text(
                                      'See how points are awarded and boost your score!',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12,),
                              Expanded(child: MyMainButton(label: 'show', onPressed: (){}))
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: responsivenessCalculation(context, 16),
                          bottom: responsivenessCalculation(context, 8)
                      ),
                      child: const Text(
                        'Quiz Picks🔥',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32
                        ),
                      ),
                    ),
                    MyCarouselSlider(
                        items: List<Widget>.generate(
                          state.subjects.length,
                              (index) => QuizSubjectView(
                            imageLink: state.subjects[index].imageUrl,
                            subjectName: state.subjects[index].name,
                            onTap: () => Navigator.of(context,rootNavigator: false).pushNamed(
                                'topics',
                                arguments: state.subjects[index].topics
                            ),
                          ),
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: responsivenessCalculation(context,16),
                          top: responsivenessCalculation(context, 8)
                      ),
                      child: const Text(
                        'Recently Played',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32
                        ),
                      ),
                    ),

                    ListView.separated(
                        padding: EdgeInsets.only(
                            top: responsivenessCalculation(context, 8),
                            left: responsivenessCalculation(context,16),
                            bottom: responsivenessCalculation(context, 100)
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Text('Revisit Quiz #${CurrentUser.instance!.solvedExams[
                                  CurrentUser.instance!.solvedExams.length - 1 - index
                                ]}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(flex: 1,),
                              IconButton(
                                onPressed: (){
                                  Share.share('https://muhammadmnyer.github.io/#/exam?id=${CurrentUser.instance!.solvedExams[CurrentUser.instance!.solvedExams.length - 1 - index]}');
                                },
                                icon: Icon(
                                    size: responsivenessCalculation(context, 32),
                                    Icons.share
                                ),
                              ),
                              const SizedBox(width: 4,),
                              IconButton(
                                onPressed: (){
                                  Navigator.of(context,rootNavigator: true)
                                      .pushNamed("/exam?id=${CurrentUser.instance!.solvedExams[CurrentUser.instance!.solvedExams.length - 1 - index]}");
                                },
                                icon: const Icon(
                                    size: 32,
                                    Icons.play_arrow
                                ),
                              ),
                              const SizedBox(width: 8,)
                            ],
                          );
                        },
                        shrinkWrap: true,

                        separatorBuilder: (context, index) => const SizedBox(height: 8,),
                        itemCount: (CurrentUser.instance!.solvedExams.length <= 3 ?
                                                    CurrentUser.instance!.solvedExams.length: 3 )
                    ),

                  ],
                ),
              ),
            );
          }
          return const LoadingIndicator();
        },
      )
    );
  }
}
