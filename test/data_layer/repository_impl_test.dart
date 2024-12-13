

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:half_grade/core/current_user.dart';
import 'package:half_grade/core/errors/exceptions.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/data_layer/data_sources/remote_data_source.dart';
import 'package:half_grade/data_layer/models/quiz_item_model.dart';
import 'package:half_grade/data_layer/models/quiz_subject_model.dart';
import 'package:half_grade/data_layer/repository_impl.dart';
import 'package:half_grade/domain_layer/entities/quiz_item.dart';
import 'package:half_grade/domain_layer/entities/quiz_subject.dart';
import 'package:half_grade/domain_layer/entities/user_rank.dart';
import 'package:half_grade/domain_layer/repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/mocks/repository_impl_test.mocks.dart';

@GenerateMocks([
  RemoteDataSourceImpl,
])
void main(){

  final MockRemoteDataSourceImpl remoteDataSourceImpl = MockRemoteDataSourceImpl();
  final Repository repository = RepositoryImpl(
      remoteDataSource: remoteDataSourceImpl
  );


  group(
      'quiz functionality tests',
      () {

        const QuizItemModel quizItemModel = QuizItemModel(
            name: "name",
            timeInMin: 15,
            questions: []
        );

        group('fetch quiz items tests', () {

          test('fetch quiz item by id success case',() async {

            when(remoteDataSourceImpl.fetchQuizItemById(id: anyNamed('id')))
                .thenAnswer((realInvocation) async=> quizItemModel ,);

            final response = (await repository.fetchQuizItemById(id: 1))
                .fold((l) => l, (r) => r,);

            expect(response, const QuizItem(name: "name", timeInMin: 15, questions: []));

          },);

          test('fetch quiz item by id failure case', ()async{

            when(remoteDataSourceImpl.fetchQuizItemById(id: anyNamed('id')))
                .thenThrow(const ServerException(message: "connection error"));

            final response = (await repository.fetchQuizItemById(id: 1))
                .fold((l) => l, (r) => r,);

            expect(response, const ServerFailure(message: 'connection error'));
          });

          test('fetch quiz items metadata success state', ()async{

            when(remoteDataSourceImpl.fetchQuizzesMetaData(topic: anyNamed('topic')))
                .thenAnswer((realInvocation) async=> [],);

            final response = (
                await repository.fetchQuizzesMetaData(topic: 'topic')
            ).fold(
                  (l) => l,
                  (r) => r,
            );

            expect(response, []);

          });

          test('fetch quiz items metadata failure state', ()async{

            when(remoteDataSourceImpl.fetchQuizzesMetaData(topic: anyNamed('topic')))
                .thenThrow(const ServerException(message: 'network error'));

            final response = (await repository.fetchQuizzesMetaData(topic: 'topic'))
             /*   .fold(
                  (l) => l,
                  (r) => r,
            )*/;
            expect(response, const Left(ServerFailure(message: 'network error')));
          });

        },);

        group('fetch quiz subjects tests', (){

          const QuizSubjectModel quizSubjectModel = QuizSubjectModel(name: 'name', imageUrl: 'imageUrl', topics: []);

          test('fetch quiz subjects success case', () async{
            when(remoteDataSourceImpl.fetchQuizSubjects())
                .thenAnswer((realInvocation) async=> [quizSubjectModel],);

            final response = (await repository.fetchQuizSubjects())
                .fold((l) => l, (r) => r,);

            expect(response, <QuizSubject>[const QuizSubject(name: 'name', imageUrl: 'imageUrl', topics: [])]);
          },);
          
          test('fetch quiz subjects failure case', () async{
            when(remoteDataSourceImpl.fetchQuizSubjects())
                .thenThrow(const ServerException(message: 'connection error'));
            
            final response = (await repository.fetchQuizSubjects())
                .fold((l) => l, (r) => r,);
            
            expect(response, const ServerFailure(message: 'connection error'));
          },);

        });

        },
  );

  group('auth functionality tests',() {
    
    group('signUp functionality tests', () {

      test('signUp success case', () async{

        when(remoteDataSourceImpl.signUp(
            email: 'muhammadmnyer@gmail.com',
            password: 'password',
            username: 'username',
            schoolName: 'schoolName',
            city: 'city'
        )
        ).thenAnswer((realInvocation) async{});

        final response = await repository.signUp(
            email: 'muhammadmnyer@gmail.com',
            password: 'password',
            username: 'username',
            schoolName: 'schoolName',
            city: 'city'
        );

        expect(response, const Right(null));

      },);

      test('signUp failure case', () async {

        when(remoteDataSourceImpl.signUp(
            email: 'muhammadmnyer@gmail.com',
            password: 'password',
            username: 'username',
            schoolName: 'schoolName',
            city: 'city')
        ).thenThrow(const AuthException(message: 'message'));

        final response = await repository.signUp(
            email: 'muhammadmnyer@gmail.com',
            password: 'password',
            username: 'username',
            schoolName: 'schoolName',
            city: 'city'
        );

        expect(response, const Left(AuthFailure(message: 'message')));
      },);

    },);
    
    group('login functionality tests', () {
      
      test('login functionality success case', () async{

        final response = await repository.login(email: 'muhammadmnyer@gmail.com', password: 'password');
        expect(response, const Right(null));
        verify(remoteDataSourceImpl.login(email: anyNamed('email'), password: 'password'));
      
        },);
      
      test('login functionality failure case', () async{

        when(remoteDataSourceImpl.login(email: 'muhammadmnyer@gmail.com', password: 'password'))
            .thenThrow(const AuthException(message: 'message'));

        final response = await repository.login(email: 'muhammadmnyer@gmail.com', password: 'password');

        expect(response, const Left(AuthFailure(message: 'message')));

      },);
      
    },);
    
    group('delete account functionality tests', () {
      
      test('delete account functionality success case', ()async{
        final response = await repository.deleteAccount();
        expect(response, const Right(null));
      });

      test('delete account functionality failure case', () async{

        when(
          remoteDataSourceImpl.deleteAccount()
        ).thenThrow(const AuthException(message: 'message'));
        final response = await repository.deleteAccount();
        expect(response, const Left(AuthFailure(message: 'message')));

      },);
      
    },);

    group('logout functionality tests', () {

      test('logout success case', ()async{
        final response = await repository.logout();
        expect(response, const Right(null));
      });

      test('logout failure case', ()async{
        when(remoteDataSourceImpl.logout())
            .thenThrow(const AuthException(message: 'message'));
        final response = await repository.logout();
        expect(response, const Left(AuthFailure(message: 'message')));
      });

    },);

    group('reset password functionality tests', () {

      test('reset password success case', ()async{
        final response = await repository.resetPassword(email: 'muhammadmnyer@gmail.com');
        expect(response, const Right(null));
      });

      test('reset password failure case', ()async{
        when(remoteDataSourceImpl.resetPassword(email: anyNamed('email')))
            .thenThrow(const AuthException(message: 'message'));
        final response = await repository.resetPassword(email: 'muhammadmnyer@gmail.com');
        expect(response, const Left(AuthFailure(message: 'message')));
      });

    },);

    group('fetch current user\'s metadata functionality tests', (){

      test("fetch current user's metadata success case", () async{

        when(remoteDataSourceImpl.fetchCurrentUsersMetadata(uuid: 'uuid'))
            .thenAnswer((realInvocation) async=> <Map<String,dynamic>>[],);

        final response = await repository.fetchCurrentUsersMetadata(uuid: 'uuid').then((value) {
          return value.fold((l) => l, (r) => r,);
        },);

        expect(response, <Map<String,dynamic>>[]);

      },);

      test("fetch current user's metadata failure case", ()async{

        when(remoteDataSourceImpl.fetchCurrentUsersMetadata(uuid: 'uuid'))
            .thenThrow( const ServerException(message: 'connection error'));
        final response = await repository.fetchCurrentUsersMetadata(uuid: 'uuid');
        expect(response, const Left(ServerFailure(message: 'connection error')));

      });

    });

    group('update current user functionality tests', (){

      test('update current user success case', () async {
        when(remoteDataSourceImpl.updateCurrentUser(user: anyNamed('user')))
            .thenAnswer((realInvocation) async{},);
        CurrentUser.initialize(
            points: 0,
            solvedExams: [],
            uuid: 'uuid',
            username: 'username',
            schoolName: 'schoolName',
            city: 'city'
        );
        final response = await repository.updateCurrentUser(user: CurrentUser.instance!);
        expect(response, const Right(null));
      },);
      test('update current user failure case', ()async{
        when(remoteDataSourceImpl.updateCurrentUser(user: anyNamed('user')))
            .thenThrow(const ServerException(message: 'message'));
        CurrentUser.instance = null;
        CurrentUser.initialize(
            points: 0,
            solvedExams: [],
            uuid: 'uuid',
            username: 'username',
            schoolName: 'schoolName',
            city: 'city'
        );
        final response = await repository.updateCurrentUser(user: CurrentUser.instance!);
        expect(response, const Left(ServerFailure(message: 'message')));
      });

    });
    
  },);

  group('get rank functionality tests', () {

    test('get rank success case', ()async{
      when(remoteDataSourceImpl.getRank()).thenAnswer((realInvocation) async{
        return [
          const UserRank(username: 'username', schoolName: 'schoolName', points: 10)
        ];
      },);
      final response = (await repository.getRank()).fold((l) => l, (r) => r,);
      expect(
          response,
          [
            const UserRank(username: 'username', schoolName: 'schoolName', points: 10)
          ]
      );
    });
    test('get rank failure case', () async {
      when(remoteDataSourceImpl.getRank()).thenThrow(
        const ServerException(message: 'message')
      );
      final response = await repository.getRank();
      expect(response, const Left(ServerFailure(message: 'message')));
    },);

  },);

  group('get played quizzes topics tests', (){


    test('get played quizzes topics success case', ()async{
      when(remoteDataSourceImpl.getPlayedQuizzesTopics(ids: anyNamed('ids')))
          .thenAnswer((realInvocation) async=> [],);
      final response = (await repository.getPlayedQuizzesTopics(ids: [])).fold((l) => l, (r) => r,);
      expect(response, []);
    });

    test('get played quizzes topics failure case', () async{
      when(remoteDataSourceImpl.getPlayedQuizzesTopics(ids: anyNamed('ids')))
          .thenThrow(const ServerException(message: 'message'));
      final response = (await repository.getPlayedQuizzesTopics(ids: []));
      expect(response, const Left(ServerFailure(message: 'message')));
    },);


  });


}


