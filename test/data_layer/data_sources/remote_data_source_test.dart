

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/data_layer/data_sources/remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../fixtures/mocks/remote_data_source_test.mocks.dart';




@GenerateMocks([
  SupabaseClient,
  PostgrestFilterBuilder,
  GoTrueClient,
  SupabaseQueryBuilder,
  PostgrestTransformBuilder
])
@GenerateNiceMocks([MockSpec<AuthResponse>(),])
void main(){
  final MockSupabaseClient supabase = MockSupabaseClient();
  final MockPostgrestFilterBuilder<List<Map<String,dynamic>>> postgrestFilterBuilder = MockPostgrestFilterBuilder();
  final MockGoTrueClient goTrueClient = MockGoTrueClient();
  final MockSupabaseQueryBuilder supabaseQueryBuilder = MockSupabaseQueryBuilder();
  final RemoteDataSource remoteDataSource = RemoteDataSourceImpl(supabase: supabase);


  group('remote data source functionality tests', () {

    group('fetch quiz items', () {

      test('fetch quiz item by id test', () async {

        when(postgrestFilterBuilder.then(any, onError: anyNamed('onError')))
            .thenAnswer((Invocation invocation) async {
              (invocation.positionalArguments[0] as Function(List<Map<String, dynamic>>))([]);
              return null;
        });


        when(
            supabase.rpc<List<Map<String,dynamic>>>('get_exams_by_id',params: {'exam_id_param': 1})
        ).thenAnswer((realInvocation) => postgrestFilterBuilder );

        await remoteDataSource.fetchQuizItemById(id: 1);

        verify(supabase.rpc('get_exams_by_id',params: {'exam_id_param': 1}));

      },);

      test('fetch quiz items metadata', () async {

        when(postgrestFilterBuilder.then(any,onError: anyNamed('onError')))
            .thenAnswer((realInvocation) async{
              (realInvocation.positionalArguments[0])(<Map<String,dynamic>>[]);
        } ,);

        when(supabase.rpc(any,params: anyNamed('params')))
            .thenAnswer((realInvocation) => postgrestFilterBuilder,);

        await remoteDataSource.fetchQuizzesMetaData(topic: 'topic');
        verify(supabase.rpc('get_exams_metadata',params:{ 'topic_name' : 'topic'}));

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

    group('auth functionality', () {

      when(supabase.auth).thenReturn(goTrueClient);

      test('signUp functionality', ()async{


        when(goTrueClient.signUp(
            password: anyNamed('password'),
            data: anyNamed('data'),
            email: anyNamed('email'),
        ))
            .thenAnswer((realInvocation) async=> MockAuthResponse(),);

        await remoteDataSource.signUp(
            email: 'muhammadmnyer@gmail.com',
            password: 'password',
            username: 'username',
            schoolName: 'schoolName',
            city: 'city'
        );

        verify(
            goTrueClient.signUp(
                password: 'password',
                email: 'muhammadmnyer@gmail.com',
                data: {
                  "username":"username",
                  "school_name":"schoolName",
                  "city":"city"
                },
            )
        );

      });

      test('login functionality', ()async{

        when(goTrueClient.signInWithPassword(
            password: 'password',
            email: 'muhammadmnyer@gmail.com',
        )
        ).thenAnswer((realInvocation) async=> MockAuthResponse(),);

        await remoteDataSource.login(email: 'muhammadmnyer@gmail.com', password: 'password');

        verify(goTrueClient.signInWithPassword(
            password: 'password',
            email: 'muhammadmnyer@gmail.com'
        )
        );

      });

      test('logout functionality', ()async{

        await remoteDataSource.logout();

        verify(goTrueClient.signOut());

      });

      test('delete account functionality', ()async{

        when(goTrueClient.currentUser).thenReturn(
            const User(
                id: '1',
                appMetadata: {},
                userMetadata: {},
                aud: '',
                createdAt: ''
            )
        );
        when(supabase.from(any)).thenAnswer((realInvocation) => supabaseQueryBuilder);
        when(supabaseQueryBuilder.delete()).thenAnswer((realInvocation) => postgrestFilterBuilder);
        when(postgrestFilterBuilder.match(any)).thenAnswer((realInvocation)=>postgrestFilterBuilder);
        when(postgrestFilterBuilder.then(any,onError: anyNamed('onError'))).thenAnswer(
          (realInvocation) async{

            (realInvocation.positionalArguments[0] as Function(List<Map<String,dynamic>> value))([]);
            return null;
          } ,
        );

        await remoteDataSource.deleteAccount();

        verify(supabaseQueryBuilder.delete());
        verify(postgrestFilterBuilder.match({'id':'1'}));

      });

      test('reset password functionality', ()async{

        await remoteDataSource.resetPassword(email: 'muhammadmnyer@gmail.com');
        verify(goTrueClient.resetPasswordForEmail('muhammadmnyer@gmail.com'));
      });

      test("fetch user's metadata functionality", ()async{
        when(supabase.from(any))
            .thenAnswer((realInvocation) {
              debugPrint('will not be called in the verify function');
              return supabaseQueryBuilder;
            });
        when(supabaseQueryBuilder.select(any))
            .thenAnswer((realInvocation) => postgrestFilterBuilder);
        when(postgrestFilterBuilder.match(any))
            .thenAnswer((realInvocation) => postgrestFilterBuilder,);
        when(postgrestFilterBuilder.then(any,onError: anyNamed('onError')))
            .thenAnswer((realInvocation) async{
              realInvocation.positionalArguments[0](<Map<String,dynamic>>[]);
              return [];
            },);

        final response = await remoteDataSource.fetchCurrentUsersMetadata(uuid: 'uuid');
        /// the method call inside verify will only verify that the function was called,
        /// it will not replace it with the desired return type

        verify(supabase.from('users_info'));
        verify(supabaseQueryBuilder.select('*'));
        verify(postgrestFilterBuilder.match({'id':'uuid'}));
        expect(response, []);
        // verify(supabase.from('users_info').select('*').match({'id':'uuid'}));
      });

      test('update current user functionality', ()async{
        when(supabase.from(any)).thenAnswer((realInvocation) => supabaseQueryBuilder,);
        when(supabaseQueryBuilder.update(any)).thenAnswer((realInvocation) => postgrestFilterBuilder,);
        when(postgrestFilterBuilder.match(any)).thenAnswer((realInvocation) => postgrestFilterBuilder,);
        when(postgrestFilterBuilder.then(any,onError: anyNamed('onError')))
            .thenAnswer((realInvocation) async{
              return null;
            },);
        CurrentUser.initialize(points: 0, solvedExams: [], uuid: 'uuid',city: '',schoolName: '',username: '');
        remoteDataSource.updateCurrentUser(user: CurrentUser.instance!);
        verify(supabase.from('users_info'));
        verify(supabaseQueryBuilder.update(CurrentUser.instance!.toJson()));
        verify(postgrestFilterBuilder.match({'id':'uuid'}));

      });
    },);

    test('get rank functionality',()async{
      final MockPostgrestTransformBuilder<List<Map<String, dynamic>>> postgrestTransformBuilder =
          MockPostgrestTransformBuilder();
      when(postgrestTransformBuilder.limit(any)).thenAnswer((realInvocation) => postgrestTransformBuilder,);
      when(supabase.from(any)).thenAnswer((realInvocation) => supabaseQueryBuilder,);
      when(supabaseQueryBuilder.select(any)).thenAnswer((realInvocation) => postgrestFilterBuilder);
      when(postgrestFilterBuilder.order(any)).thenAnswer((realInvocation) => postgrestTransformBuilder,);
      /// the [postgrestTransformBuilder]'s then method is used because of the implements keyword
      /// in the generated code
      when(postgrestTransformBuilder.then(any,onError: anyNamed('onError')))
          .thenAnswer((realInvocation) async{
            realInvocation.positionalArguments[0](<Map<String,dynamic>>[]);
            return null;
      },);
      await remoteDataSource.getRank();
      verify(supabase.from('users_info'));
      verify(supabaseQueryBuilder.select('points, username, school_name'));
      verify(postgrestFilterBuilder.order('points'));
      verify(postgrestTransformBuilder.limit(100));
    });

    test('get played quizzes topics functionality',()async{

      when(supabase.rpc(any,params: anyNamed('params'))).thenAnswer((realInvocation) => postgrestFilterBuilder,);
      when(postgrestFilterBuilder.then(any, onError: anyNamed('onError')))
          .thenAnswer((realInvocation) async{
            (realInvocation.positionalArguments[0] as Function(List<Map<String, dynamic>>))([]);
            return null;
      },);

      await remoteDataSource.getPlayedQuizzesTopics(ids: []);
      verify(supabase.rpc('get_played_quizzes_topics',params: {'ids':[]}));
    });

  },);

}