import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/data_layer/models/quiz_subject_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  test('quiz subject model test', (){
    InjectionContainer.instance.initialize();
    SharedPreferences.setMockInitialValues({});
    final json = jsonDecode(
        File('test/fixtures/models_as_json/quiz_subject_model.json').readAsStringSync()
    );
    const expectedModel = QuizSubjectModel(
        name: "subject",
        imageUrl: "${const String.fromEnvironment('supabase-url')}/storage/v1/object/public/cover_images/testing/ui.png",
        topics: ["first topic", "second topic"]
    );

    final quizSubjectModel = QuizSubjectModel.fromJson(json);

    expect(quizSubjectModel, expectedModel);
  });
}