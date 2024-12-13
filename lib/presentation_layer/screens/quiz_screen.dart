import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/quiz_info.dart';
import 'package:half_grade/presentation_layer/logic_holders/quiz_screen_cubit/quiz_screen_cubit.dart';
import 'package:half_grade/presentation_layer/widgets/dialogs/retry_dialog.dart';
import 'package:half_grade/presentation_layer/widgets/loading_indicator.dart';
import 'package:half_grade/presentation_layer/widgets/my_main_button.dart';
import 'package:half_grade/presentation_layer/widgets/not_found_screen.dart';
import 'package:half_grade/presentation_layer/widgets/timer_widget.dart';
import 'package:half_grade/presentation_layer/widgets/views/quiz_question_view.dart';
import 'package:half_grade/presentation_layer/widgets/views/quiz_solved_question_view.dart';

class QuizScreen extends StatefulWidget {
  final int id;

  const QuizScreen({super.key, required this.id});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Map<int, String> answers = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuizScreenCubit>(context).load(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<QuizScreenCubit,QuizScreenState>(
        listener: (context, state) {
          if(state is QuizScreenFailure){
            retryDialog(
                context,
                errorMessage: state.error,
                retry: ()=> BlocProvider.of<QuizScreenCubit>(context).load(id: widget.id)
            );
          }
        },
        builder: (context, state) {
          if (state is QuizScreenNotFound) {
            return const NotFoundScreen();
          }

          else if (state is QuizScreenLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  TimerWidget(
                    timeInMin: state.quiz.timeInMin,
                    quiz: state.quiz,
                    id: widget.id,
                    answers: QuizInfo.of(context).answers,
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          if (index == state.quiz.questions.length) {
                            return MyMainButton(
                              label: 'calculate',
                              onPressed: () {
                                BlocProvider.of<QuizScreenCubit>(context)
                                    .solveQuiz(
                                    quiz: state.quiz,
                                    answers: QuizInfo.of(context).answers,
                                    id: widget.id
                                );
                              },
                            );
                          }
                          return QuizQuestionView(
                              question: state.quiz.questions[index].question,
                              a: state.quiz.questions[index].a,
                              b: state.quiz.questions[index].b,
                              c: state.quiz.questions[index].c,
                              d: state.quiz.questions[index].d,
                              answersRef: QuizInfo.of(context).answers,
                              indexKey: index + 1
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        itemCount:
                        state.quiz.questions.length + 1),
                  ),
                ],
              ),
            );
          }

          else if (state is QuizScreenSolved) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return QuizSolvedQuestionView(
                      question: state.quiz.questions[index].question,
                      correctAnswer: state.quiz.questions[index].correctAnswer,
                      a: state.quiz.questions[index].a,
                      b: state.quiz.questions[index].b,
                      c: state.quiz.questions[index].c,
                      d: state.quiz.questions[index].d,
                      explanation: state.quiz.questions[index].explanation,
                      selectedAnswer: QuizInfo.of(context).answers[index + 1]
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8,),
                itemCount: state.quiz.questions.length);
          }

          return const LoadingIndicator();
        },
      )
    );
  }

  // void calculatePoints(QuizScreenLoaded state, BuildContext context) {
  //   if (!CurrentUser.instance!.solvedExams.contains(widget.id)) {
  //     for (int i = 0; i < state.quiz.questions.length; i++) {
  //       if (answers[i + 1] == state.quiz.questions[i].correctAnswer) {
  //         switch (state.quiz.questions[i].level) {
  //           case Level.hard:
  //             points += 3;
  //             break;
  //           case Level.medium:
  //             points += 2;
  //             break;
  //           case Level.easy:
  //             points += 1;
  //             break;
  //           default:
  //             throw UnimplementedError();
  //         }
  //       }
  //     }
  //     CurrentUser.instance!.points += points;
  //     CurrentUser.instance!.solvedExams.add(widget.id);
  //     BlocProvider.of<QuizScreenCubit>(context)
  //         .updateCurrentUser(
  //         user: CurrentUser.instance!,
  //         quiz: state.quiz
  //     );
  //   }
  //   else {
  //     BlocProvider.of<QuizScreenCubit>(
  //         context)
  //         .examSolved((state).quiz);
  //   }
  // }
}


