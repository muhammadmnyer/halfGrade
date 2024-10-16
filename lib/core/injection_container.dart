import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InjectionContainer{
  final _getIt = GetIt.instance;

  InjectionContainer._internal();

   static final InjectionContainer instance = InjectionContainer._internal();

  T get<T extends Object>()=> _getIt.get<T>();

   void initialize (){
     _getIt.registerSingleton(
         SupabaseClient(
             const String.fromEnvironment('supabase-url'),
             const String.fromEnvironment('supabase-anon-key')
         )
     );
   }
}