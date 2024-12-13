import 'package:flutter/material.dart';

class QuizInfo extends InheritedWidget{
  final Map<int, String> answers = {};

  QuizInfo({super.key,required super.child});


  static QuizInfo of(BuildContext context)=> context.dependOnInheritedWidgetOfExactType<QuizInfo>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}


