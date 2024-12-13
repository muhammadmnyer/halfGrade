import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:half_grade/data_layer/models/user_rank_model.dart';

void main(){

  test('user rank model test', () {

    final json = jsonDecode(
        File('test/fixtures/models_as_json/user_rank_model.json').readAsStringSync()
    );
    const expectedModel = UserRankModel(
        username: "myName",
        schoolName: "mySchool",
        points: 50
    );

    final userRankModel = UserRankModel.fromJson(json);

    expect(userRankModel, expectedModel);
  },);
}