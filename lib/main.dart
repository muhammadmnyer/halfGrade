import 'package:flutter/material.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/core/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late SupabaseClient supabase;

Future<void> main() async {
  runApp(const MyApp());

  InjectionContainer.instance.initialize();
  supabase = InjectionContainer.instance.get();
  await supabase.auth.signInWithPassword(password: 'Mnyer1000@@',email: 'muhammadmnyer@gmail.com',);
  supabase.from('topics').select('*, subjects(*)').then(
    (value) {
      //print(value);
    },
  );

  supabase
      .rpc('get_topics_details',).then((value) {
        //print(value);
      },);

  supabase.rpc(
    'get_exams_by_topic',
    params: {'topic_param': 'احتمالات'},  // Pass the topic as a parameter
  ).then((value){
     print(value);
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return BottomNavBarHolder(screen: child!,);
      },
      initialRoute: '/',
      onGenerateRoute: AppPages.bottomNavigationBarGenerateRoute,
    );
  }
}

