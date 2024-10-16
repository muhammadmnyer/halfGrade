

import 'package:flutter_test/flutter_test.dart';
import 'package:half_grade/data_layer/data_sources/remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../fixtures/mocks/remote_data_source_test.mocks.dart';




@GenerateMocks([SupabaseClient,PostgrestFilterBuilder,])
void main(){
  final MockSupabaseClient supabase = MockSupabaseClient();
  final MockPostgrestFilterBuilder<List<Map<String,dynamic>>> postgrestFilterBuilder = MockPostgrestFilterBuilder();
  final RemoteDataSource remoteDataSource = RemoteDataSourceImpl(supabase: supabase);



  group('remote data source functionality tests', () {

    group('fetch quiz items', () {

      test('fetch quiz items test', () async {

        when(postgrestFilterBuilder.then(any, onError: anyNamed('onError')))
            .thenAnswer((Invocation invocation) async {
              (invocation.positionalArguments[0] as Function(List<Map<String, dynamic>>))([]);
              return null;
        });


        when(
            supabase.rpc<List<Map<String,dynamic>>>('get_exams_by_topic',params: {'topic_param': 'topic'})
        ).thenAnswer((realInvocation) => postgrestFilterBuilder );

        await remoteDataSource.fetchQuizItems(topic: 'topic');

        verify(supabase.rpc('get_exams_by_topic',params: {'topic_param': 'topic'}));

      },);

      test('fetch quiz subjects test', () async{

        when(postgrestFilterBuilder.then(any,onError: anyNamed('onError')))
            .thenAnswer((realInvocation) async{
              (realInvocation.positionalArguments[0] as Function(List<Map<String,dynamic>>))([]);
              return null;
            },);
        when(supabase.rpc('get_topics_details'))
            .thenAnswer((_) => postgrestFilterBuilder);

        await remoteDataSource.fetchQuizSubjects();

        verify(supabase.rpc('get_topics_details',));
      },);



    },);

  },);

}
