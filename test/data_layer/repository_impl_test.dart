
import 'package:flutter_test/flutter_test.dart';
import 'package:half_grade/core/errors/exceptions.dart';
import 'package:half_grade/core/errors/failures.dart';
import 'package:half_grade/data_layer/data_sources/local_data_source.dart';
import 'package:half_grade/data_layer/data_sources/remote_data_source.dart';
import 'package:half_grade/data_layer/models/quiz_item_model.dart';
import 'package:half_grade/data_layer/models/quiz_subject_model.dart';
import 'package:half_grade/data_layer/repository_impl.dart';
import 'package:half_grade/domain_layer/entities/quiz_item.dart';
import 'package:half_grade/domain_layer/entities/quiz_subject.dart';
import 'package:half_grade/domain_layer/repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../fixtures/mocks/repository_impl_test.mocks.dart';

@GenerateMocks([
  LocalDataSource,
  RemoteDataSourceImpl,
])
void main(){

  final MockRemoteDataSourceImpl remoteDataSourceImpl = MockRemoteDataSourceImpl();
  final MockLocalDataSource localDataSource = MockLocalDataSource();
  final Repository repository = RepositoryImpl(
      localDataSource: localDataSource,
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

          test('fetch quiz item success case',() async {

            when(remoteDataSourceImpl.fetchQuizItems(topic: anyNamed('topic')))
                .thenAnswer((realInvocation) async=> [quizItemModel] ,);

            final response = (await repository.fetchQuizItems(topic: "topic"))
                .fold((l) => l, (r) => r,);

            expect(response, const <QuizItem>[QuizItem(name: "name", timeInMin: 15, questions: [])]);

          },);

          test('fetch quiz item failure case', ()async{

            when(remoteDataSourceImpl.fetchQuizItems(topic: anyNamed('topic')))
                .thenThrow(const ServerException(message: "connection error"));

            final response = (await repository.fetchQuizItems(topic: 'topic'))
                .fold((l) => l, (r) => r,);

            expect(response, const ServerFailure(message: 'connection error'));
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


}


