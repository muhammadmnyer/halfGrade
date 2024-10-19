

import 'package:flutter_test/flutter_test.dart';
import 'package:half_grade/data_layer/data_sources/remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../fixtures/mocks/remote_data_source_test.mocks.dart';




@GenerateMocks([
  SupabaseClient,
  PostgrestFilterBuilder,
  GoTrueClient,
  SupabaseQueryBuilder
])
@GenerateNiceMocks([MockSpec<AuthResponse>()])
void main(){
  final MockSupabaseClient supabase = MockSupabaseClient();
  final MockPostgrestFilterBuilder<List<Map<String,dynamic>>> postgrestFilterBuilder = MockPostgrestFilterBuilder();
  final RemoteDataSource remoteDataSource = RemoteDataSourceImpl(supabase: supabase);
  final MockGoTrueClient goTrueClient = MockGoTrueClient();


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
        final MockSupabaseQueryBuilder supabaseQueryBuilder = MockSupabaseQueryBuilder();

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
    },);

  },);

}