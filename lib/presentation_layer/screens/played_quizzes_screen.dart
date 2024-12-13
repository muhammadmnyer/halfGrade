import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/responsiveness_calculation.dart';
import 'package:half_grade/presentation_layer/logic_holders/played_quizzes_screen/played_quizzes_cubit.dart';
import 'package:half_grade/presentation_layer/widgets/loading_indicator.dart';
import 'package:share_plus/share_plus.dart';

class PlayedQuizzesScreen extends StatelessWidget {
  const PlayedQuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<PlayedQuizzesCubit, PlayedQuizzesState>(
          listener: (context, state) {

            if(state is PlayedQuizzesFailure){
              // TODO: implement error handling
            }
          },
          builder: (context, state) {
            if (state is PlayedQuizzesLoaded) {
              return SafeArea(
                child: ListView.separated(
                  padding: EdgeInsets.only(
                      top: responsivenessCalculation(context, 8),
                      left: responsivenessCalculation(context, 16),
                      bottom: responsivenessCalculation(context, 100)),
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          state.groupedByTopics.keys.toList()[index],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Text(
                                      'Revisit Quiz #${CurrentUser.instance!.solvedExams[CurrentUser.instance!.solvedExams.length - 1 - index]}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Share.share(
                                            'https://muhammadmnyer.github.io/#/exam?id=${CurrentUser.instance!.solvedExams[CurrentUser.instance!.solvedExams.length - 1 - index]}');
                                      },
                                      icon: const Icon(size: 32, Icons.share),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context, rootNavigator: true).pushNamed(
                                            "/exam?id=${CurrentUser.instance!.solvedExams[CurrentUser.instance!.solvedExams.length - 1 - index]}");
                                      },
                                      icon: const Icon(size: 32, Icons.play_arrow),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    )
                                  ],
                                );
                              },
                            itemCount: state.groupedByTopics.values.toList()[index].length,

                          )


                    ],
                  ),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemCount: state.groupedByTopics.length,
                ),
              );
            }

            return const LoadingIndicator();
          },
    ));
  }
}
