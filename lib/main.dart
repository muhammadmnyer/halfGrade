
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/core/push_notifications/push_notifications.dart';
import 'package:half_grade/core/routes.dart';
import 'package:half_grade/core/themes.dart';
import 'package:half_grade/presentation_layer/logic_holders/auth_cubit/auth_cubit.dart';
import 'package:half_grade/presentation_layer/logic_holders/home_screen_cubit/home_screen_cubit.dart';
import 'package:half_grade/presentation_layer/logic_holders/ranking_screen_cubit/ranking_screen_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


late SupabaseClient supabase;

Future<void> main() async {
  await PushNotifications().init();
  await InjectionContainer.instance.initialize();
  supabase = InjectionContainer.instance.get();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => HomeScreenCubit()..load(uuid: supabase.auth.currentUser?.id),
        ),
        BlocProvider(create: (context) => RankingScreenCubit()..load(),)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AppPages.mainNavigator,
          theme: Themes.mainTheme,
          initialRoute: supabase.auth.currentUser == null ? 'login' : '/',
          onGenerateRoute: AppPages.mainNavigation,
          onGenerateInitialRoutes: AppPages.mainNavigatorOnGenerateInitialRoutes
      ),
    );
  }

}

