import 'package:flutter/material.dart';
import 'package:half_grade/core/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late SupabaseClient supabase;
void main() {
  runApp(const MyApp());
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

