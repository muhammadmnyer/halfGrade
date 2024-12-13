import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/domain_layer/entities/quiz_item.dart';
import 'package:half_grade/presentation_layer/logic_holders/quiz_screen_cubit/quiz_screen_cubit.dart';
import 'package:half_grade/presentation_layer/widgets/dialogs/dialog_base.dart';

class TimerWidget extends StatefulWidget {
  final int timeInMin;
  final int id;
  final Map<int,String> answers;
  final QuizItem quiz;

  const TimerWidget({
    super.key,
    required this.timeInMin,
    required this.quiz,
    required this.id,
    required this.answers
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int min;
  late int sec;

  @override
  void initState() {
    super.initState();
    min = widget.timeInMin - 1;
    sec = 59;

    Timer.periodic(
      const Duration(
          seconds: 1),
          (timer) {
        try {
          sec--;
          if (sec == 0) {
            if (min == 0) {
              timer.cancel();
              showDialog(
                context: context,
                builder: (context) =>
                const DialogBase(
                    child: Center(
                      child: Text('Time Over'),
                    )
                ),
              );
              BlocProvider.of<QuizScreenCubit>(
                  context)
                  .solveQuiz(
                    quiz: widget.quiz,
                    id: widget.id,
                    answers: widget.answers,
              );
            }
            sec = 59;
            min--;
          }
          setState(() {});
        } on FlutterError {
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text("$min : $sec");
  }
}