import 'package:get_it/get_it.dart';
import 'package:half_grade/data_layer/data_sources/remote_data_source.dart';
import 'package:half_grade/data_layer/repository_impl.dart';
import 'package:half_grade/domain_layer/repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InjectionContainer{
  final _getIt = GetIt.instance;

  InjectionContainer._internal();

   static final InjectionContainer instance = InjectionContainer._internal();

  T get<T extends Object>()=> _getIt.get<T>();

  Future<void> _initializeSupabase()async{
    await Supabase.initialize(
      url: const String.fromEnvironment('supabase-url'),
      anonKey: const String.fromEnvironment('supabase-anon-key'),
    );
  }

   Future<void> initialize ()async{
      await _initializeSupabase();
     _getIt.registerSingleton(Supabase.instance.client);
     _getIt.registerSingleton(RemoteDataSourceImpl(supabase: _getIt.get()) as RemoteDataSource);
     _getIt.registerSingleton(RepositoryImpl(
         remoteDataSource: _getIt.get()
     ) as Repository);
   }
}